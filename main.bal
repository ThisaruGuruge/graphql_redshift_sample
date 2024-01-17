import ballerina/graphql;
import ballerina/io;
import ballerina/sql;
import ballerinax/aws.redshift;
import ballerinax/aws.redshift.driver as _;

// Connection Configurations
configurable string jdbcUrl = ?;
configurable string user = ?;
configurable string password = ?;

final redshift:Client db = check new (jdbcUrl, user, password);

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
