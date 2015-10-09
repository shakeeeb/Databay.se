drop database if exists DATABAYSE;
create database DATABAYSE;
use DATABAYSE;

/*******************************************************************************
Customer: represents customer who buys or sells an item
*******************************************************************************/
CREATE TABLE Customer (
  FirstName CHAR(32) NOT NULL,
  LastName CHAR(32) NOT NULL,
  Address CHAR(128),
  City CHAR(32),
  Zipcode INTEGER,
  Telephone CHAR(20),
  CreditCard INTEGER NOT NULL,
  Email CHAR(128),
  ItemsSold INTEGER,
  ItemsPurchased INTEGER,
  Rating INTEGER,
  CustomerID CHAR(24),
  PRIMARY KEY(CustomerID)
  /*FOREIGN KEY(CustomerID) REFERENCES Auction(buyerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY(CustomerID) REFERENCES Auction(sellerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION*/

/* Rating cannot be negative */
/*
CREATE ASSERTION PositiveRating
   CHECK(NOT EXISTS(SELECT * FROM Customer WHERE Rating < 0))

/* Item sold and items bought cannot be negative */
/*CREATE ASSERTION PositiveItemsBought
  CHECK(NOT EXISTS(SELECT * FROM ItemsPurchased WHERE Rating < 0))

CREATE ASSERTION PositiveItemsSold
  CHECK(NOT EXISTS(SELECT * FROM ItemsSold WHERE Rating<0))*/

)


/******************************************************************************
/* Rating is a domain
*****************************************************************************
CREATE DOMAIN RATINGS INTEGER()
  CHECK(VALUE IN(1, 2, 3, 4, 5))*/


/*******************************************************************************
Employee: represents employee overseeing transaction
*******************************************************************************/
CREATE TABLE Employee(
SSID INTEGER,
FirstName CHAR(64) NOT NULL,
LastName CHAR(64) NOT NULL,
Address CHAR(128),
City CHAR(64),
ZipCode INTEGER,
Telephone CHAR(20),
StartDate INTEGER,
HourlyRate FLOAT NOT NULL,
EmployeeID INTEGER,
PRIMARY KEY(EmployeeID)
)
/*they can’t be payed negative numbers*/
/*CREATE ASSERTION PositivePay
	CHECK(NOT EXISTS(SELECT * FROM Employee WHERE HourlyRate > 0))
)*/


/*******************************************************************************
Item: represents an item to be sold in an online action
*******************************************************************************/
/*
CREATE TABLE Item (
  Id INT(10),
  Name CHAR(20) NOT NULL,
  Type TYPES,
  Year INTEGER,
  CopiesSold INTEGER,
  AmountInStock INTEGER,
  PRIMARY KEY(Id))

# there can't be more items sold than available
/*CREATE ASSERTION PositiveStock
  CHECK(NOT EXISTS(SELECT * FROM Item WHERE AmountInStock < 0))
*/
/*******************************************************************************
Auction: represents an online auction
*******************************************************************************/
/*CREATE TABLE Auction (
  Id INTEGER,
  ItemId INTEGER,
  SellerId INTEGER,
  BuyerId, INTEGER,
  OpeningBid FLOAT,
  ClosingBid FLOAT,
  CurrentBid FLOAT,
  CurrentHighBid FLOAT,
  OpeningDate INTEGER,
  OpeningTime INTEGER,
  ClosingDate INTEGER,
  ClosingTime INTEGER,
  Reserve FLOAT, # The lowest amount a seller will accept for an item
  Increment FLOAT, # The lowest amount a bid can increase from one bid
  EmployeeId INTEGER,
  PRIMARY KEY(Id),
  FOREIGN KEY(ItemId) REFERENCES Item(Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY(BuyerId) REFERENCES Customer(Id)
    ON DELETE NO ACTION

  FOREIGN KEY(SellerId) REFERENCES Customer(Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, # only one seller
  FOREIGN KEY(EmployeeId) REFERENCES Employee(Id))
    ON DELETE NO ACTION)

# an auction can't begin before it ends
/*CREATE ASSERTION BeginsBeforeEnding
  CHECK(NOT EXISTS(SELECT * FROM Auction WHERE OpeningDate > ClosingDate))*/

# auction transactions can't be negative
# note: can be replaced by declaring each variable with 'NON NEGATIVE' but didn’t see in textbook
/*CREATE ASSERTION NoNegativeBids
  CHECK(NOT EXISTS(SELECT * FROM Auction WHERE OpeningBid < 0
    AND ClosingBid < 0 AND CurrentBid < 0 AND CurrentHighBid < 0
    AND Reserve < 0, AND INCREMENT < 0))*/

/*YOU CAN’T AUCTION SOMETHING TO YOURSELF*/
/*CREATE ASSERTION BuyerIsNotSeller
	CHECK(NOT EXISTS(SELECT * FROM Auction WHERE BuyerId = SellerId))*/

/* BID CANNOT BE LOWER THAN THE CURRENT BID */
/*
CREATE TRIGGER NoLowerBids BEFORE UPDATE ON Auction
FOR EACH ROW
BEGIN
		IF NEW.CurrentBid > CurrentBid THEN
			SET CurrentBid = NEW.CurrentBid;
		END IF;
END;*/

/*******************************************************************************
TYPES: represents the different categories of an item
******************************************************************************
CREATE DOMAIN TYPES CHAR(10)
  CHECK(VALUE IN('Art', 'Books', 'Electronics', 'Fashion', 'Home', 'Sports',
    'Toys', 'Other'))*/
