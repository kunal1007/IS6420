--Robinhood Data Tables
--Yo you can edit it online

--blah blah blah
DROP TABLE IF EXISTS Listed_on;
DROP TABLE IF EXISTS Exchange;
DROP TABLE IF EXISTS Moving_price;
DROP TABLE IF EXISTS Crypto;
DROP TABLE IF EXISTS Mutual_fund;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS ETF;
DROP TABLE IF EXISTS Security_header;
DROP TABLE IF EXISTS Order_header;
DROP TABLE IF EXISTS Investment_account;
DROP TABLE IF EXISTS External_bank_account;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (Customer_ID INTEGER NOT NULL,
Customer_name VARCHAR (50) NOT NULL,
SSN CHAR(11) NOT NULL,
Phone_number VARCHAR(12),
Email_address VARCHAR(200),
Address_line_1 VARCHAR (200),
City VARCHAR (100),
State_province VARCHAR (2),
Postal_code VARCHAR (5),
Country VARCHAR(50),
Citizenship VARCHAR(50),
DOB DATE,
PRIMARY KEY (customer_id));

CREATE TABLE External_bank_account (External_Account_ID INTEGER NOT NULL,
External_account_number VARCHAR(30) NOT NULL,
External_routing_number VARCHAR(9) NOT NULL,
Customer_ID INTEGER,
PRIMARY KEY (External_Account_ID),
CONSTRAINT External_bank_account_fkey_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID));

CREATE TABLE Investment_account (Account_number INTEGER NOT NULL,
Balance MONEY,
Premium_account BOOLEAN,
Customer_ID INTEGER,
PRIMARY KEY (Account_number),
CONSTRAINT Investment_account_fkey_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID));

CREATE TABLE Order_header (Order_ID INTEGER NOT NULL,
Order_time TIME,
Quantity INTEGER,
Customer_ID INTEGER,
PRIMARY KEY (Order_ID),
CONSTRAINT Order_header_fkey_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID));

CREATE TABLE Security_header (Ticker_ID VARCHAR(20) NOT NULL,
Security_name VARCHAR (30),
Account_number INTEGER,
Order_ID INTEGER,
Killswitch BOOLEAN,
PRIMARY KEY (Ticker_ID),
CONSTRAINT Security_header_fkey_Account_number FOREIGN KEY (Account_number) REFERENCES Investment_account (Account_number),
CONSTRAINT Security_header_fkey_Order_ID FOREIGN KEY (Order_ID) REFERENCES Order_header (Order_ID));

CREATE TABLE ETF (E_Ticker_ID VARCHAR(4) NOT NULL,
PRIMARY KEY (E_Ticker_ID),
CONSTRAINT ETF_pkey_E_Ticker_ID FOREIGN KEY (E_Ticker_ID) REFERENCES Security_header (Ticker_ID));

CREATE TABLE Stock (S_Ticker_ID VARCHAR(20) NOT NULL,
PRIMARY KEY (S_Ticker_ID),
CONSTRAINT Stock_pkey_S_Ticker_ID FOREIGN KEY (S_Ticker_ID) REFERENCES Security_header (Ticker_ID));

CREATE TABLE Mutual_fund (M_Ticker_ID VARCHAR(20) NOT NULL,
PRIMARY KEY (M_Ticker_ID),
CONSTRAINT Mutual_fund_pkey_M_Ticker_ID FOREIGN KEY (M_Ticker_ID) REFERENCES Security_header (Ticker_ID));

CREATE TABLE Crypto (C_Ticker_ID VARCHAR(20) NOT NULL,
PRIMARY KEY (C_Ticker_ID),
CONSTRAINT Crypto_pkey_C_Ticker_ID FOREIGN KEY (C_Ticker_ID) REFERENCES Security_header (Ticker_ID));

CREATE TABLE Moving_price (Timeprice_ID VARCHAR (30) NOT NULL,
Price_timestamp TIME,
Ask_price MONEY,
Bid_price MONEY,
Trade_volume NUMERIC,
Ticker_ID VARCHAR(4),
PRIMARY KEY (Timeprice_ID, Ticker_ID),
CONSTRAINT Moving_price_pkey_Ticker_ID FOREIGN KEY (Ticker_ID) REFERENCES Security_header (Ticker_ID));

CREATE TABLE Exchange (Exchange_ID VARCHAR(30) NOT NULL,
Exchange_name VARCHAR(50),
Currency VARCHAR(3),
Market_Open TIME,
Market_Close TIME,
PRIMARY KEY (Exchange_ID));

CREATE TABLE Listed_on (
Ticker_ID VARCHAR(4) NOT NULL,
Exchange_ID VARCHAR(30) NOT NULL,
PRIMARY KEY (Ticker_ID, Exchange_ID),
CONSTRAINT Listed_on_pkey_Ticker_ID FOREIGN KEY (Ticker_ID) REFERENCES Security_header (Ticker_ID),
CONSTRAINT Listed_on_pkey_Exchange_ID FOREIGN KEY (Exchange_ID) REFERENCES Exchange (Exchange_ID));
