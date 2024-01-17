import ballerina/graphql;
import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable DbConfig dbConfig = ?;

final mysql:Client db = check new (
    dbConfig.host,
    dbConfig.user,
    dbConfig.password,
    dbConfig.database,
    dbConfig.port
);

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}
service on new graphql:Listener(9090) {
    resource function get sale(graphql:Field 'field, @graphql:ID int id) returns Sale|error {
        sql:ParameterizedQuery query = buildSaleQuery('field, id);
        io:println("Query: ", query);
        DbSale|error dbSale = db->queryRow(query);
        if dbSale is error {
            return error(string `Failed to retrieve the sale data for the sale id "${id}"`);
        }
        return transform(dbSale);
    }
}
