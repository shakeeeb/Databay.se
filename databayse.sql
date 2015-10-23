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
  CopiesSold INTEGER DEFAULT 0,
  AmountInStock INTEGER DEFAULT 0,
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
  IsManager TINYINT(1) DEFAULT 0,
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
  CurrentHighBid DECIMAL(8,2),
  OpeningDate DATE,
  OpeningTime TIME,
  ClosingDate DATE,
  ClosingTime TIME,
  Reserve DECIMAL(8,2), # The lowest amount a seller will accept for an item
  Increment DECIMAL(8,2), # The lowest amount a bid can increase
  isComplete TINYINT(1) DEFAULT 0,
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
  BidID INTEGER AUTO_INCREMENT,
  AuctionID INTEGER,
  CustomerID CHAR(32),
  Bid DECIMAL(8,2),
  MaxBid DECIMAL(8,2),
  BidDate DATE,
  BidTime TIME,
  PRIMARY KEY(BidID), #IF MULTIPLE BIDS HAPPEN AT THE SAME TIME THERE IS A CONFLICT BECAUSE THEY ARE NOT UNIQUE
  FOREIGN KEY(AuctionID) REFERENCES Auction(AuctionID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

/*******************************************************************************
Post: represents all auctions that have ended
*******************************************************************************/
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

/*******************************************************************************
THESE NEXT FEW PROCEDURES ARE FOR ADDING EDITING AND REMOVING EMPLOYEES
*******************************************************************************/
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

# THIS MAKES SURE THERE ARENT ANY DUPLICATES IN THE TABLE
DECLARE itemCount INTEGER;
SELECT COUNT(Name) INTO itemCount
FROM Item
WHERE itemName LIKE Name AND itemType LIKE Type AND itemYear = Year;

IF itemCount = 0 THEN
  insert into DATABAYSE.Item(Name, Type, Year, AmountInStock)
  values(itemName, itemType, itemYear, itemAmountInStock);
ELSE
  UPDATE Item SET AmountInStock = AmountInStock + itemAmountInStock WHERE itemName LIKE Name;
END IF;

End
$$

CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER, IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
BEGIN
insert into DATABAYSE.Auction(SellerID, ItemID, EmployeeID, OpeningBid, OpeningDate, OpeningTime, ClosingDate, ClosingTime, Reserve, Increment)
  values(Lower(seller_id), item_id, employee_id, opening_bid, CURRENT_DATE(), CURRENT_TIME() , DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY), CURRENT_TIME, reserve, (opening_bid/8)
    );
End
$$

CREATE PROCEDURE promoteToManager(IN empl_SSN CHAR(14))
BEGIN
UPDATE Employee SET isManager = 1 WHERE SSN = empl_SSN;
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
SELECT E.*
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

  UPDATE Auction SET ClosingBid = 17.38 WHERE AuctionID = auctionID; #TODO remove this is just for testing revenues
  UPDATE Auction SET isComplete = 1 WHERE AuctionID = auctionID; #TODO remove

End
$$

CREATE PROCEDURE endAuction(IN auctionID INTEGER)
BEGIN

# SET AUCTION BOOLEAN TO TRUE
# SET ClosingBid TODO: doesn't work yet
UPDATE Auction
SET isComplete = 1 AND ClosingBid = CurrentHighBid
WHERE AuctionID = auctionID;
# SET ITEM COPIESSOLD ++
# SET AMOUNTINSTOCK --
# SET CUSTOMER ITEMS SOLD ++
# SET CUSTOMER ITEMSPURCHAESED ++
END
$$

# Selects the revenue from a particular item
CREATE PROCEDURE getRevenueByItem(IN itemName Char(20))
BEGIN
  SELECT SUM(A.ClosingBid)
  FROM Auction A, Item I
  WHERE I.Name = itemName AND I.ItemID = A.ItemID AND A.isComplete = 1;
End $$

# Selects the revenue from a particular type of item
CREATE PROCEDURE getRevenueByType(IN itemType Char(12))
BEGIN
  SELECT SUM(A.ClosingBid)
  FROM Auction A, Item I
  WHERE I.Type = itemType AND I.ItemID = A.ItemID AND A.isComplete = 1;
End $$

# Selects the revenue from a particular type of customer
CREATE PROCEDURE getRevenueByCustomer(IN customerName Char(32))
BEGIN
  SELECT SUM(A.ClosingBid)
  FROM Auction A, Customer C
  WHERE C.CustomerID = customerName AND C.CustomerID = A.SellerID AND A.isComplete = 1;
End $$

CREATE PROCEDURE getRepSales(IN empl_id INTEGER)
BEGIN
  SELECT E.FirstName, E.LastName, I.Name, A.AuctionID, A.ClosingBid
  FROM Auction A, Employee E, Item I
  WHERE E.EmployeeID = empl_id AND I.ItemID = A.ItemID AND A.isComplete = 1;
END $$

CREATE PROCEDURE addBid(IN auctID INTEGER, IN custID CHAR(32),
IN newBid DECIMAL(8,2), IN newMaxBid DECIMAL(8,2))
BEGIN
  INSERT INTO  DATABAYSE.Bid(AuctionID, CustomerID, Bid, MaxBid, BidDate, BidTime)
    values(auctID, custID, newBid, newMaxBid, CURRENT_DATE(), CURRENT_TIME());
END $$

CREATE PROCEDURE getBidHistory(IN custID CHAR(32), IN auctID INTEGER)
BEGIN
#TODO are we supposed to show all bids or just bids from one customer
  SELECT B.Bid, B.MaxBid, B.BidDate, B.BidTime
  FROM Bid B
  WHERE B.CustomerID = custID AND B.AuctionID = auctID;
END $$

#TODO CHECK THAT YOU ARE SELECTING ALL THE NECESSARY AUCTION DATA FOR THESE PROCEDURES
CREATE PROCEDURE getPastAuctions(IN custID CHAR(32))
BEGIN
#TODO are we supposed to include being a seller as participant
  SELECT I.Name, A.AuctionID, A.isComplete
  FROM Bid B, Auction A, Item I
  Where (B.CustomerID = custID AND B.AuctionID = A.AuctionID) OR A.SellerID = custID
  AND A.ItemID = I.ItemID
  GROUP BY A.AuctionID;
END $$

CREATE PROCEDURE itemsSoldBy(IN custID CHAR(32))
BEGIN
  SELECT I.Name, A.AuctionID, A.isComplete
  FROM  Auction A, Item I
  Where A.SellerID = custID AND A.ItemID = I.ItemID
  GROUP BY A.AuctionID;
END $$

CREATE PROCEDURE itemsAvailableByType(IN itemType CHAR(32))
BEGIN
  SELECT I.Name, A.AuctionID, A.SellerID, A.OpeningDate, A.OpeningTime,
  A.ClosingDate, A.ClosingTime
  FROM  Auction A, Item I
  Where I.Type = itemType AND A.ItemID = I.ItemID AND A.isComplete = 0
  GROUP BY A.AuctionID;
END $$

CREATE PROCEDURE itemsAvailableByKeyword(IN itemName CHAR(32))
BEGIN
  SELECT I.Name, A.AuctionID, A.SellerID, A.OpeningDate, A.OpeningTime,
  A.ClosingDate, A.ClosingTime
  FROM  Auction A, Item I
  Where INSTR(I.Name, itemName) > 0 AND I.ItemID AND A.isComplete = 0 #INSTR() returns the number of characters that match between two strings
  GROUP BY A.AuctionID;

END $$

/* TODO fix this
CREATE TRIGGER check_Auction_Over BEFORE UPDATE ON Auction
     FOR EACH ROW
     BEGIN
         IF TIMEDIFF(CURRENT_TIME, ClosingTime) >= 0 THEN# >= ClosingTime OR CURRENT_DATE >= ClosingDate THEN
             call getRevenueByItem('test'); # END auctions
         END IF;
     END $$
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
  FROM Item I, Auction A, Customer C
  WHERE A.isComplete = 1 AND A.SellerID = C.CustomerID 
  GROUP BY C.CustomerID;

# Produce a mailing list of customers
CREATE VIEW DATABAYSE.customerMailingList(LastName, FirstName, Address, City, State, ZipCode) AS
  SELECT C.LastName, C.FirstName, C.Address, C.City, C.State, C.ZipCode
  FROM Customer C;

CREATE VIEW DATABAYSE.itemsSold(Name, Type, Year, CopiesSold) AS
  SELECT I.Name, I.Type, I.Year, SUM(I.CopiesSold)
  FROM Item I
  GROUP BY I.Name, I.Type;

CREATE VIEW DATABAYSE.bestSellersList(Name, Type, Year, CopiesSold) AS
  SELECT *
  FROM itemsSold
  ORDER BY CopiesSold DESC LIMIT 10; # DESC: descending order
