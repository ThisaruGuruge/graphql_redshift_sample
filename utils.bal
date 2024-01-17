import ballerina/graphql;
import ballerina/sql;

function transform(DbSale dbSale) returns Sale {
    decimal? commission = dbSale.COMMISSION;
    string? name = ();
    string? firstName = dbSale.FIRSTNAME;
    string? lastName = dbSale.LASTNAME;
    if firstName is string {
        name = firstName;
    }
    if lastName is string {
        if name is string {
            name = name + " " + lastName;
        } else {
            name = lastName;
        }
    }
    return {
        id: dbSale.SALESID,
        seller: {
            id: dbSale.SELLERID,
            username: dbSale.USERNAME,
            name,
            city: dbSale.CITY,
            state: dbSale.STATE,
            email: dbSale.EMAIL,
            phone: dbSale.PHONE
        },
        date: {
            id: dbSale.DATEID,
            calDate: dbSale.CALDATE,
            day: dbSale.DAY,
            week: dbSale.WEEK,
            month: dbSale.MONTH,
            qtr: dbSale.QTR,
            year: dbSale.YEAR,
            holiday: dbSale.HOLIDAY
        },
        qtySold: dbSale.QTYSOLD,
        pricePaid: dbSale.PRICEPAID,
        commission,
        saleTime: dbSale.SALETIME
    };
}

isolated function buildUserFields(graphql:Field[] subfields) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery fieldsQuery = ``;
    int i = 0;
    foreach graphql:Field subfield in subfields {
        match subfield.getName() {
            "id" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `USERID`);
            }
            "username" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `USERNAME`);
            }
            "name" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `FIRSTNAME, LASTNAME`);
            }
            "city" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `CITY`);
            }
            "state" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `STATE`);
            }
            "email" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `EMAIL`);
            }
            "phone" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `PHONE`);
            }
        }
        i = i + 1;
        if i < subfields.length() {
            fieldsQuery = sql:queryConcat(fieldsQuery, `, `);
        }
    }
    return fieldsQuery;
}

isolated function buildDateFields(graphql:Field[] subfields) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery fieldsQuery = ``;
    int i = 0;
    foreach graphql:Field subfield in subfields {
        match subfield.getName() {
            "id" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `DATEID`);
            }
            "calDate" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `CALDATE`);
            }
            "day" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `DAY`);
            }
            "week" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `WEEK`);
            }
            "month" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `MONTH`);
            }
            "qtr" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `QTR`);
            }
            "year" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `YEAR`);
            }
            "holiday" => {
                fieldsQuery = sql:queryConcat(fieldsQuery, `HOLIDAY`);
            }
        }
        i = i + 1;
        if i < subfields.length() {
            fieldsQuery = sql:queryConcat(fieldsQuery, `, `);
        }
    }
    return fieldsQuery;
}

isolated function buildSaleQuery(graphql:Field 'field, int id) returns sql:ParameterizedQuery {
    sql:ParameterizedQuery selectQuery = `SELECT `;
    sql:ParameterizedQuery fromQuery = ` FROM Sales `;
    sql:ParameterizedQuery whereQuery = `WHERE SALESID = ${id} `;
    graphql:Field[]? subfields = 'field.getSubfields();
    if subfields is () {
        return ``;
    }
    int i = 0;
    foreach graphql:Field subfield in subfields {
        match subfield.getName() {
            "id" => {
                selectQuery = sql:queryConcat(selectQuery, `SALESID`);
            }
            "seller" => {
                fromQuery = sql:queryConcat(fromQuery, `, Users `);
                graphql:Field[]? userSubfields = subfield.getSubfields();
                if userSubfields is () {
                    panic error("Invalid state - User subfields cannot be empty");
                }
                selectQuery = sql:queryConcat(selectQuery, buildUserFields(userSubfields));
                whereQuery = sql:queryConcat(whereQuery, ` AND Sales.SELLERID = Users.USERID`);
            }
            "date" => {
                fromQuery = sql:queryConcat(fromQuery, `, Date `);
                graphql:Field[]? dateSubfields = subfield.getSubfields();
                if dateSubfields is () {
                    panic error("Invalid state - Date subfields cannot be empty");
                }
                selectQuery = sql:queryConcat(selectQuery, buildDateFields(dateSubfields));
                whereQuery = sql:queryConcat(whereQuery, ` AND Sales.DATEID = Date.DATEID`);
            }
            "qtySold" => {
                selectQuery = sql:queryConcat(selectQuery, `QTYSOLD`);
            }
            "pricePaid" => {
                selectQuery = sql:queryConcat(selectQuery, `PRICEPAID`);
            }
            "commission" => {
                selectQuery = sql:queryConcat(selectQuery, `COMMISSION`);
            }
            "saleTime" => {
                selectQuery = sql:queryConcat(selectQuery, `SALETIME`);
            }
        }
        i = i + 1;
        if i < subfields.length() {
            selectQuery = sql:queryConcat(selectQuery, `, `);
        }
    }
    return sql:queryConcat(selectQuery, fromQuery, whereQuery);
}
