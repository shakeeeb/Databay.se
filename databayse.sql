drop database if exists DATABAYSE;
create database DATABAYSE;
use DATABAYSE;

/*******************************************************************************
Item: represents an item to be sold in an online action
******************************************************************************/
CREATE TABLE Item (
  ItemID INTEGER AUTO_INCREMENT,
  Name CHAR(20) NOT NULL,
  Type CHAR(12),
  Year INTEGER,
  CopiesSold INTEGER,
  AmountInStock INTEGER,
  PRIMARY KEY(ItemID));

/*******************************************************************************
Customer: represents a customer who buys or sells an item
*******************************************************************************/
CREATE TABLE Customer (
  CustomerID CHAR(32),
  FirstName CHAR(32) NOT NULL,
  LastName CHAR(32) NOT NULL,
  Address CHAR(128) NOT NULL,
  City CHAR(32) NOT NULL,
  State CHAR(2) NOT NULL,
  Zipcode INTEGER NOT NULL,
  Telephone CHAR(20) NOT NULL,
  CreditCard CHAR(20) NOT NULL,
  Email CHAR(128) NOT NULL,
  ItemsSold INTEGER DEFAULT 0,
  ItemsPurchased INTEGER DEFAULT 0,
  Rating INTEGER DEFAULT 1,
  PRIMARY KEY(CustomerID));

/*******************************************************************************
Employee: represents employee overseeing transaction
*******************************************************************************/
CREATE TABLE Employee (
  EmployeeID INTEGER AUTO_INCREMENT,
  SSID INTEGER,
  FirstName CHAR(32) NOT NULL,
  LastName CHAR(32) NOT NULL,
  Address CHAR(128) NOT NULL,
  City CHAR(32) NOT NULL,
  State CHAR(2) NOT NULL,
  ZipCode INTEGER NOT NULL,
  Telephone CHAR(20),
  StartDate DATE,
  HourlyRate FLOAT NOT NULL,
  PRIMARY KEY(EmployeeID));

/*******************************************************************************
Auction: represents an online auction
*******************************************************************************/
CREATE TABLE Auction (
  AuctionID INTEGER AUTO_INCREMENT,
  ItemID INTEGER,
  SellerID CHAR(32),
  BuyerID CHAR(32),
  EmployeeID INTEGER,
  OpeningBid DECIMAL(8,2),
  ClosingBid DECIMAL(8,2),
  CurrentBid DECIMAL(8,2),
  CurrentHighBid DECIMAL(8,2),
  OpeningDate DATE,
  OpeningTime TIME,
  ClosingDate DATE,
  ClosingTime TIME,
  Reserve DECIMAL(8,2), # The lowest amount a seller will accept for an item
  Increment DECIMAL(8,2), # The lowest amount a bid can increase
  PRIMARY KEY(AuctionID),
  FOREIGN KEY(ItemID) REFERENCES Item(ItemID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY(BuyerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(SellerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, # only one seller
  FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
  ON DELETE NO ACTION);

DELIMITER $$
/*******************************************************************************
ADDS A NEW CUSTOMER TO THE CUSTOMER TABLE
# TODO: because customerID is based on the users first name if two users have
the same name the second user should use a unique number. Ex: bob, bob_2, bob_3
*******************************************************************************/
CREATE PROCEDURE addCustomer(IN cust_fn CHAR(32), IN cust_ln CHAR(32),
IN cust_addr CHAR(128), IN cust_city CHAR(32), IN cust_state CHAR(2), IN cust_zip
INTEGER, IN cust_tel CHAR(20), IN cust_email CHAR(128), IN cust_cc CHAR(20))
BEGIN
insert into DATABAYSE.Customer(CustomerID, FirstName, LastName, Address, City,
  State, ZipCode, Telephone, Email, CreditCard)
  values(Lower(cust_fn), cust_fn, cust_ln, cust_addr, cust_city , cust_state, cust_zip,
    cust_tel, cust_email, cust_cc);
End
$$
DELIMITER ;

/*******************************************************************************
TODO: figure out a way to make domains since they don't exist in mysql, also a
way to define constants like name CHAR(20) might be useful
TYPES: represents the different categories of an item
******************************************************************************
CREATE DOMAIN TYPES CHAR(10)
  CHECK(VALUE IN('Art', 'Books', 'Electronics', 'Fashion', 'Home', 'Sports',
    'Toys', 'Other'))*/
