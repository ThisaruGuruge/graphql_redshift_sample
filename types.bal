import ballerina/graphql;

type User record {
    @graphql:ID readonly int id?;
    string username?;
    string name?;
    string city?;
    string state?;
    string email?;
    string phone?;
};

type Date record {
    @graphql:ID readonly int id?;
    string calDate?;
    string day?;
    int week?;
    string month?;
    string qtr?;
    int year?;
    boolean holiday?;
};

type Sale record {
    @graphql:ID readonly int id?;
    User seller?;
    Date date?;
    int qtySold?;
    decimal pricePaid?;
    decimal commission?;
    string saleTime?;
};

type DbSale record {|
    readonly int SALESID?;
    readonly int SELLERID?;
    string USERNAME?;
    string FIRSTNAME?;
    string LASTNAME?;
    string CITY?;
    string STATE?;
    string EMAIL?;
    string PHONE?;
    readonly int DATEID?;
    string CALDATE?;
    string DAY?;
    int WEEK?;
    string MONTH?;
    string QTR?;
    int YEAR?;
    boolean HOLIDAY?;
    int QTYSOLD?;
    decimal PRICEPAID?;
    decimal COMMISSION?;
    string SALETIME?;
|};

type DbConfig record {|
    string host;
    string user;
    string password;
    string database;
    int port;
|};
