/*******************************************************************************
* CSE 305: Fall 2015 Online Auction Project
* Team: Databay.se
* Members: Miu ki Yip, Terrell Mack, Shakeeb Saleh
*******************************************************************************/
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
  SSN CHAR(14),
  FirstName CHAR(32) NOT NULL,
  LastName CHAR(32) NOT NULL,
  Address CHAR(128) NOT NULL,
  City CHAR(32) NOT NULL,
  State CHAR(2) NOT NULL,
  ZipCode INTEGER NOT NULL,
  Telephone CHAR(20),
  StartDate DATE,
  HourlyRate INTEGER NOT NULL,
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
    ON UPDATE CASCADE,
  FOREIGN KEY(BuyerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(SellerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, # only one seller
  FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
  ON DELETE SET NULL); #TODO check if this is OK

/*******************************************************************************
Bid: represents an auction bid
*******************************************************************************/
CREATE TABLE Bid (
  AuctionID INTEGER,
  CustomerID CHAR(32),
  BidDate DATE,
  BidTime TIME,
  PRIMARY KEY(AuctionID, CustomerID, BidDate, BidTime),
  FOREIGN KEY(AuctionID) REFERENCES Auction(AuctionID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE Post (
  AuctionID INTEGER,
  CustomerID CHAR(32),
  PostDate DATE,
  PostTime TIME,
  ExpireDate DATE,
  ExpireTime TIME,
  PRIMARY KEY(AuctionID, CustomerID),
  FOREIGN KEY(AuctionID) REFERENCES Auction(AuctionID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

DELIMITER $$
/*******************************************************************************
ADDS A NEW CUSTOMER TO THE CUSTOMER TABLE
TODO: because customerID is based on the users first name if two users have
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

CREATE PROCEDURE addEmployee(IN empl_ssn CHAR(14), IN empl_fn CHAR(32), IN empl_ln CHAR(32),
IN empl_addr CHAR(128), IN empl_city CHAR(32), IN empl_state CHAR(2), IN empl_zip
INTEGER, IN empl_tel CHAR(20), IN empl_sd DATE, IN empl_hr INTEGER)
BEGIN
insert into DATABAYSE.Employee(SSN, FirstName, LastName, Address, City,
  State, ZipCode, Telephone, StartDate, HourlyRate)
  values(empl_ssn, empl_fn, empl_ln, empl_addr, empl_city , empl_state, empl_zip,
    empl_tel,empl_sd,empl_hr);
End
$$

CREATE PROCEDURE editEmployee(IN emplID INTEGER, IN empl_fn CHAR(32), IN empl_ln CHAR(32),
IN empl_addr CHAR(128), IN empl_city CHAR(32), IN empl_state CHAR(2), IN empl_zip
INTEGER, IN empl_tel CHAR(20), IN empl_hr INTEGER)
BEGIN
 UPDATE Employee
 SET FirstName = empl_fn, LastName = empl_ln, Address = empl_addr, City = empl_city,
 State = empl_state, ZipCode = empl_zip, Telephone = empl_tel, HourlyRate = empl_hr
 WHERE EmployeeID = emplID;
End
$$

CREATE PROCEDURE deleteEmployee(In emplID INTEGER)
BEGIN
  DELETE FROM Employee WHERE EmployeeID = emplID;
End
$$

CREATE PROCEDURE addItem(IN itemName CHAR(20), IN itemType CHAR(12), IN itemYear INTEGER, IN itemAmountInStock INTEGER)
BEGIN
insert into DATABAYSE.Item(Name, Type, Year, AmountInStock)
  values(itemName, itemType, itemYear, itemAmountInStock);

End
$$

CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER, IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
BEGIN
insert into DATABAYSE.Auction(SellerID, ItemID, EmployeeID, OpeningBid, OpeningDate, OpeningTime, ClosingDate, ClosingTime, Reserve, Increment)
  values(Lower(seller_id), item_id, employee_id, opening_bid, CURRENT_DATE(), CURRENT_TIME() , DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY), CURRENT_TIME, reserve, (opening_bid/8)
    );
End
$$


CREATE PROCEDURE getMonthlySalesReport(in Month INTEGER)
BEGIN
SELECT I.Name, SUM(A.ClosingBid)
FROM Item I, Auction A
WHERE MONTH(A.ClosingDate) = Month AND I.ItemID = A.ItemID
GROUP BY I.Name, I.Type;
End
$$

CREATE PROCEDURE getBestCustomerRep()
BEGIN
SELECT E.* #E.*
FROM employeeRevenue RV
  JOIN Employee E
  ON E.EmployeeID = RV.ID
ORDER BY RV.Total DESC
LIMIT 1;
End
$$

CREATE PROCEDURE addPost(IN auctionID INTEGER, IN customerID CHAR(32), IN postDate DATE, IN postTime Time, IN expireDate Date, IN expireTime Time)
BEGIN
insert into DATABAYSE.Post(AuctionID, CustomerID, PostDate, PostTime, ExpireDate, ExpireTime)
  values(auctionID, customerID, postDate, postTime, expireDate, expireTime);

End
$$

/*




*/


DELIMITER ;

/* Produce a comprehensive listing of all items  */
/* TODO: More than one variable name for the group by section?! */
CREATE VIEW DATABAYSE.viewAllItems (Name, Type, Year, CopiesSold, AmountInStock) AS
  SELECT Name, Type, Year, CopiesSold, AmountInStock
  FROM Item I
  GROUP BY Name;

/*produce a list of employees by total revenue*/
  CREATE VIEW DATABAYSE.employeeRevenue(ID, Total) AS
  SELECT E.EmployeeID, SUM(A.ClosingBid)
  FROM Auction A, Employee E
  WHERE A.EmployeeID = E.EmployeeID
  GROUP BY E.EmployeeID;



/* Produce a list of sales by item name */
CREATE VIEW DATABAYSE.salesByItemName(Name, TotalCopiesSold, TotalClosingBids) AS
  SELECT I.Name, SUM(I.CopiesSold), SUM(A.ClosingBid)
  FROM Post P, Item I, Auction A
  #WHERE A.ItemId = I.ItemId AND P.AuctionID = A.AuctionID
  GROUP BY I.Name;

  /* Produce a list of sales by customer name */
CREATE VIEW DATABAYSE.salesByCustomerName(CustomerName, TotalCopiesSold, TotalClosingBids) AS
  SELECT C.CustomerID, SUM(I.CopiesSold), SUM(A.ClosingBid)
  FROM Post P, Item I, Auction A, Customer C
  #WHERE A.ItemId = I.ItemId AND P.AuctionID = A.AuctionID
  #

    #LOOK OVER HERE. WE NEED TO MODIFY THIS LOGIC.
  #

  GROUP BY C.CustomerID;

/*
CREATE TABLE Post (
  AuctionID INTEGER,
  CustomerID CHAR(32),
  PostDate DATE,
  PostTime TIME,
  ExpireDate DATE,
  ExpireTime TIME,
  PRIMARY KEY(AuctionID, CustomerID),
  FOREIGN KEY(AuctionID) REFERENCES Auction(AuctionID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

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
    ON UPDATE CASCADE,
  FOREIGN KEY(BuyerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(SellerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, # only one seller
  FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
  ON DELETE NO ACTION);
>>>>>>> 476f798c165b2db1d9159157d7d82ac54584c137

CREATE TABLE Item (
  ItemID INTEGER AUTO_INCREMENT,
  Name CHAR(20) NOT NULL,
  Type CHAR(12),
  Year INTEGER,
  CopiesSold INTEGER,
  AmountInStock INTEGER,
  PRIMARY KEY(ItemID));
*/
/*******************************************************************************
TODO: figure out a way to make domains since they don't exist in mysql, also a
way to define constants like name CHAR(20) might be useful
TYPES: represents the different categories of an item
******************************************************************************
CREATE DOMAIN TYPES CHAR(10)
  CHECK(VALUE IN('Art', 'Books', 'Electronics', 'Fashion', 'Home', 'Sports',
    'Toys', 'Other'))*/
