DROP TABLE IF EXISTS crypto;
DROP TABLE IF EXISTS mutual_fund;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS etf;
DROP TABLE IF EXISTS exchange;
DROP TABLE IF EXISTS listed_on;
DROP TABLE IF EXISTS moving_price;
DROP TABLE IF EXISTS securities;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS investment_account;
DROP TABLE IF EXISTS external_bank_account;
DROP TABLE IF EXISTS customer;
--this is just a teeeeest.
--blah blah blah
CREATE TABLE customer (
	customer_id INTEGER NOT NULL,
	SSN VARCHAR (9),
	phone_number VARCHAR(11),
	email_address VARCHAR (60),
	country VARCHAR (25),
	citizenship VARCHAR (25), --need this?
	residential_address VARCHAR (100), --split out to address table?
	dob DATE,
	first_name VARCHAR (100),
	PRIMARY KEY (customer_id)
);

CREATE TABLE external_bank_account (
	external_account_id INTEGER NOT NULL,
	account_number INTEGER,
	routing_number INTEGER,
	customer_id INTEGER,
	PRIMARY KEY (external_account_id),
	CONSTRAINT eba_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id)	
);

CREATE TABLE investment_account (
	account_id INTEGER NOT NULL,
	balance MONEY,
	premium_account BOOLEAN,
	standard_account BOOLEAN,
	customer_id INTEGER,
	PRIMARY KEY (account_id),
	CONSTRAINT ia_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id)	
);

CREATE TABLE orders (
	order_id INTEGER NOT NULL,
	order_time TIMESTAMP,
	quantity INTEGER,
	customer_id INTEGER,
	PRIMARY KEY (order_id),
	CONSTRAINT o_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

CREATE TABLE securities (
	ticker_id INTEGER NOT NULL,
	security_name VARCHAR (40),
	order_id INTEGER,
	account_id INTEGER,
	PRIMARY KEY (ticker_id),
	CONSTRAINT s_account_id FOREIGN KEY (account_id) REFERENCES investment_account (account_id),
	CONSTRAINT s_order_id FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

CREATE TABLE moving_price (
	
);

CREATE TABLE listed_on ();
CREATE TABLE exchange ();
CREATE TABLE etf ();
CREATE TABLE stock ();
CREATE TABLE mutual_fund ();
CREATE TABLE crypto ();












