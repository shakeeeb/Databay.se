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
  Password CHAR(32),
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
  Password Char(32),
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
  isComplete TINYINT(1) DEFAULT -1, #-1 for unnapproved, 0 for active, 1 for complete
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

DELIMITER $$
/*******************************************************************************
THESE NEXT FEW PROCEDURES ARE FOR ADDING EDITING AND REMOVING EMPLOYEES.
*******************************************************************************/
# 3.1.a: Add Employee
CREATE PROCEDURE addEmployee(IN empl_ssn CHAR(14), IN empl_fn CHAR(32), IN empl_ln CHAR(32),
IN empl_addr CHAR(128), IN empl_city CHAR(32), IN empl_state CHAR(2), IN empl_zip
INTEGER, IN empl_tel CHAR(20), IN empl_sd DATE, IN empl_hr INTEGER, IN empl_pass CHAR(32))
BEGIN
insert into DATABAYSE.Employee(SSN, FirstName, LastName, Address, City,
  State, ZipCode, Telephone, StartDate, HourlyRate, Password)
  values(empl_ssn, empl_fn, empl_ln, empl_addr, empl_city , empl_state, empl_zip,
    empl_tel,empl_sd,empl_hr, empl_pass);
End $$

# 3.1.a: Edit Employee
CREATE PROCEDURE editEmployee(IN empl_ssn CHAR(14), IN empl_fn CHAR(32), IN empl_ln CHAR(32),
IN empl_addr CHAR(128), IN empl_city CHAR(32), IN empl_state CHAR(2), IN empl_zip
INTEGER, IN empl_tel CHAR(20), IN empl_hr INTEGER, IN empl_pass CHAR(32))
BEGIN
 UPDATE Employee
 SET FirstName = empl_fn, LastName = empl_ln, Address = empl_addr, City = empl_city,
 State = empl_state, ZipCode = empl_zip, Telephone = empl_tel, HourlyRate = empl_hr,
 Password = empl_pass
 WHERE SSN = empl_ssn;
End $$

# 3.1.a: Delete Employee
CREATE PROCEDURE deleteEmployee(IN empl_ssn CHAR(14))
BEGIN
  DELETE FROM Employee WHERE SSN = empl_ssn;
End $$

# 3.1.b: Get Monthly Sales Report
CREATE PROCEDURE getMonthlySalesReport(IN Month INTEGER)
BEGIN
  SELECT I.Name, SUM(A.ClosingBid)
  FROM Item I, Auction A
  WHERE MONTH(A.ClosingDate) = Month AND I.ItemID = A.ItemID
  GROUP BY I.Name, I.Type;
End $$

# 3.1.e Selects the revenue from a particular item
CREATE PROCEDURE getRevenueByItem(IN itemName Char(20))
BEGIN
  SELECT SUM(A.ClosingBid)
  FROM Auction A, Item I
  WHERE I.Name = itemName AND I.ItemID = A.ItemID AND A.isComplete = 1;
End $$

# 3.1.e Selects the revenue from a particular type of item type
CREATE PROCEDURE getRevenueByType(IN itemType Char(12))
BEGIN
  SELECT SUM(A.ClosingBid)
  FROM Auction A, Item I
  WHERE I.Type = itemType AND I.ItemID = A.ItemID AND A.isComplete = 1;
End $$

# 3.1.e Selects the revenue from a particular type of customer
CREATE PROCEDURE getRevenueByCustomer(IN customerName Char(32))
BEGIN
  SELECT SUM(A.ClosingBid)
  FROM Auction A, Customer C
  WHERE C.CustomerID = customerName AND C.CustomerID = A.SellerID AND A.isComplete = 1;
End $$

/*3.1.f get the customer representative who generated the most revenue*/
CREATE PROCEDURE getBestCustomerRep()
BEGIN
SELECT E.*
FROM employeeRevenue RV
  JOIN Employee E
  ON E.EmployeeID = RV.ID
ORDER BY RV.Total DESC
LIMIT 1;
End $$

/*3.1.f get the customer representative who generated the most revenue*/
CREATE PROCEDURE getLowestCustomerRep()
BEGIN
SELECT E.*
FROM employeeRevenue RV
  JOIN Employee E
  ON E.EmployeeID = RV.ID
ORDER BY RV.Total
LIMIT 1;
End $$

/*3.1.g.1 the customer who generated the most revenue by buying things*/
CREATE PROCEDURE getBestBuyer()
BEGIN
SELECT C.*
FROM BuyersWhoSpentBank CV
  JOIN Customer C
  ON CV.BuyerID = C.CustomerID
ORDER BY CV.Total DESC
LIMIT 1;
End
$$

/*3.1.g.2 the customer who generated the most revenue by selling things*/
CREATE PROCEDURE getBestMerchant()
BEGIN
SELECT C.*
FROM SellersWhoMadeBank CV
  JOIN Customer C
  ON CV.SellerID = C.CustomerID
ORDER BY CV.Total DESC
LIMIT 1;
End
$$

/*3.2.a a customer representative should be able to record a sale*/
CREATE PROCEDURE endAuction(IN auctID INTEGER)
BEGIN

DECLARE currentBid DECIMAL(8,2);
DECLARE meetsReserve DECIMAL(8,2);

SELECT Reserve INTO meetsReserve
FROM Auction
WHERE AuctionID = auctID;

SELECT CurrentHighBid INTO currentBid
FROM Auction
WHERE AuctionID = auctID;

IF currentBid >= meetsReserve THEN

UPDATE Item I, Auction A
SET I.CopiesSold = I.CopiesSold + 1 #AND I.AmountInStock = I.AmountInStock - 1
WHERE A.AuctionID = auctID AND A.ItemID = I.ItemID;


UPDATE Item I, Auction A
SET I.AmountInStock = I.AmountInStock - 1
WHERE A.AuctionID = auctID AND A.ItemID = I.ItemID;

UPDATE Auction A
SET A.ClosingBid = CurrentHighBid
WHERE A.AuctionID = auctID;

UPDATE Customer C, Auction A
SET C.ItemsSold = C.ItemsSold + 1
Where C.CustomerID = A.SellerID;

UPDATE Customer C, Auction A
SET C.ItemsPurchased = C.ItemsPurchased + 1
Where C.CustomerID = A.BuyerID;

ELSE
select "Reserve not met";
END IF;

UPDATE Auction
SET isComplete = 1 #AND ClosingBid = CurrentHighBid
WHERE AuctionID = auctID;

END $$

/*******************************************************************************
3.2.b.1 ADDS A NEW CUSTOMER TO THE CUSTOMER TABLE
TODO: because customerID is based on the users first name if two users have
the same name the second user should use a unique number. Ex: bob, bob_2, bob_3
*******************************************************************************/
CREATE PROCEDURE addCustomer(IN cust_fn CHAR(32), IN cust_ln CHAR(32),
IN cust_addr CHAR(128), IN cust_city CHAR(32), IN cust_state CHAR(2), IN cust_zip
INTEGER, IN cust_tel CHAR(20), IN cust_email CHAR(128), IN cust_cc CHAR(20), IN cust_pass CHAR(32))
BEGIN
insert into DATABAYSE.Customer(CustomerID, FirstName, LastName, Address, City,
  State, ZipCode, Telephone, Email, CreditCard, Password)
  values(Lower(cust_fn), cust_fn, cust_ln, cust_addr, cust_city, cust_state, cust_zip,
    cust_tel, cust_email, cust_cc, cust_pass);
End $$

/*******************************************************************************
3.2.b.2 EDITS A CUSTOMER IN THE CUSTOMER TABLE
TODO: because customerID is based on the users first name if two users have
the same name the second user should use a unique number. Ex: bob, bob_2, bob_3
*******************************************************************************/
CREATE PROCEDURE editCustomer(IN cust_fn CHAR(32), IN cust_ln CHAR(32),
IN cust_addr CHAR(128), IN cust_city CHAR(32), IN cust_state CHAR(2), IN cust_zip
INTEGER, IN cust_tel CHAR(20), IN cust_email CHAR(128), IN cust_cc CHAR(20), IN cust_items INTEGER,
IN cust_bought INTEGER, IN cust_rating INTEGER, IN cust_pass CHAR(32))
BEGIN
UPDATE Customer
  SET CustomerID = Lower(cust_fn), FirstName = cust_fn, LastName = cust_ln, Address = cust_addr, City = cust_city,
  State = cust_state, ZipCode = cust_zip, Telephone = cust_tel, Email = cust_email, CreditCard = cust_cc,
  ItemsPurchased = cust_bought, ItemsSold = cust_items, Rating = cust_rating, Passord = cust_pass
  WHERE CustomerID = cust_fn;
End $$

# 3.2.b.2: Delete Customer
CREATE PROCEDURE deleteCustomer(In cust_fn CHAR(32))
BEGIN
  DELETE FROM Customer WHERE CustomerID = cust_fn;
End $$

# 3.2.d + 3.3.g Produce a list of item suggestions for a given customer (based on that customer's past purchases)
CREATE PROCEDURE getSuggestionsByType(IN customerID CHAR(32))
BEGIN
SELECT I.*
FROM getTypesForSuggestion S, Item I
WHERE S.Type = I.Type AND S.CustomerID = customerID;
End
$$

# 3.3.a A bid history for each auction
CREATE PROCEDURE getBidHistory(IN auctID INTEGER)
BEGIN
#TODO are we supposed to show all bids or just bids from one customer
  SELECT B.Bid, B.MaxBid, B.CustomerID, B.BidDate, B.BidTime
  FROM Bid B
  WHERE B.AuctionID = auctID;
END $$

#TODO CHECK THAT YOU ARE SELECTING ALL THE NECESSARY AUCTION DATA FOR THESE PROCEDURES
# 3.3.b History of past auctions a customer has taken part in
CREATE PROCEDURE getPastAuctions(IN custID CHAR(32))
BEGIN
#TODO are we supposed to include being a seller as participant
  SELECT I.Name, A.AuctionID, A.isComplete
  FROM Bid B, Auction A, Item I
  Where (B.CustomerID = custID AND B.AuctionID = A.AuctionID) OR A.SellerID = custID
  AND A.ItemID = I.ItemID
  GROUP BY A.AuctionID;
END $$

# Auctions that need to be approved
CREATE PROCEDURE getUpcomingAuctions(IN custID CHAR(32))
BEGIN
#TODO are we supposed to include being a seller as participant
  SELECT A.*
  FROM Auction A
  Where A.SellerID = custID AND A.isComplete = -1
  GROUP BY A.AuctionID;
END $$

# Auctions that are currently running
CREATE PROCEDURE getOpenAuctions(IN custID CHAR(32))
BEGIN
#TODO are we supposed to include being a seller as participant
  SELECT A.*
  FROM Auction A
  Where A.SellerID = custID AND A.isComplete = 0
  GROUP BY A.AuctionID;
END $$

# 3.3.c Items sold by a given seller and corresponding auction info
CREATE PROCEDURE itemsSoldBy(IN custID CHAR(32))
BEGIN
  SELECT I.Name, A.AuctionID, A.isComplete
  FROM  Auction A, Item I
  Where A.SellerID = custID AND A.ItemID = I.ItemID AND A.isComplete = 1
  GROUP BY A.AuctionID;
END $$

# 3.3.d Items avaliable of a particular type and corresponding auction info
CREATE PROCEDURE itemsAvailableByType(IN itemType CHAR(32))
BEGIN
  SELECT I.Name, A.CurrentHighBid, A.AuctionID, A.SellerID, A.OpeningDate, A.OpeningTime,
  A.ClosingDate, A.ClosingTime
  FROM  Auction A, Item I
  Where I.Type = itemType AND A.ItemID = I.ItemID AND A.isComplete = 0
  GROUP BY A.AuctionID;
END $$

# 3.3.e Items avaliable with a particular keyword or set of keywords in the item name, and cooresponding auction info
CREATE PROCEDURE itemsAvailableByKeyword(IN itemName CHAR(32))
BEGIN
  SELECT I.Name, A.AuctionID, A.SellerID, A.OpeningDate, A.OpeningTime,
  A.ClosingDate, A.ClosingTime
  FROM  Auction A, Item I
  Where INSTR(I.Name, itemName) > 0 AND I.ItemID AND A.isComplete = 0 #INSTR() returns the number of characters that match between two strings
  GROUP BY A.AuctionID;
END $$

CREATE PROCEDURE getItem(IN itemName CHAR(20), IN itemType CHAR(12), IN itemYear INTEGER)
BEGIN
  SELECT I.*
  FROM  Item I
  Where I.Name LIKE itemName AND I.Type LIKE itemType AND I.Year = itemYear;
END $$


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
End $$

CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2), IN inc DECIMAL(8,2), IN auctionLength INTEGER)
BEGIN
DECLARE itemsInStock INTEGER;
SELECT AmountInStock INTO itemsInStock
FROM Item
WHERE ItemID = item_id;

IF itemsInStock > 0 THEN
insert into DATABAYSE.Auction(SellerID, ItemID, EmployeeID, OpeningBid, OpeningDate, OpeningTime, ClosingDate, ClosingTime, Reserve, Increment, CurrentHighBid)
  values(Lower(seller_id), item_id, employee_id, -1, CURRENT_DATE(), CURRENT_TIME() , DATE_ADD(CURRENT_DATE(), INTERVAL auctionLength DAY), CURRENT_TIME, reserve, inc, -1
);
ELSE
  select "No items in stock";
END IF;
End $$


CREATE PROCEDURE getUnnapprovedAuctions(IN empl_id INTEGER)
BEGIN
SELECT A.*
FROM Auction A
WHERE A.isComplete = -1 AND A.EmployeeID = empl_id;
End $$

CREATE PROCEDURE approveAuction(IN auct_id INTEGER)
BEGIN
UPDATE Auction SET isComplete = 0 where AuctionID = auct_id;
END $$

CREATE PROCEDURE promoteToManager(IN employee_id INTEGER)
BEGIN
UPDATE Employee SET isManager = 1 WHERE EmployeeID = employee_id;
End $$

CREATE PROCEDURE demoteManager(IN employee_id INTEGER)
BEGIN
UPDATE Employee SET isManager = 0 WHERE EmployeeID = employee_id;
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
 DECLARE auctionComplete INTEGER;
 DECLARE currentBid DECIMAL(8,2);
 DECLARE seller CHAR(32);
 DECLARE openingBid CHAR(32);
 DECLARE bidWithIncrement DECIMAL(8,2);

 SELECT isComplete INTO auctionComplete
 FROM Auction
 WHERE AuctionID = auctID;

 SELECT SellerID INTO seller
 FROM Auction
 WHERE AuctionID = auctID;

 SELECT CurrentHighBid + Increment INTO bidWithIncrement
 FROM Auction
 WHERE AuctionID = auctID;

 SELECT CurrentHighBid INTO currentBid
 FROM Auction
 WHERE AuctionID = auctID;

 SELECT OpeningBid INTO openingBid
 FROM Auction
 WHERE AuctionID = auctID;

 IF auctionComplete = 0 AND currentBid < 0 THEN

 INSERT INTO DATABAYSE.Bid(AuctionID, CustomerID, Bid, MaxBid, BidDate, BidTime)
   values(auctID, custID, newBid, newMaxBid, CURRENT_DATE(), CURRENT_TIME());

 UPDATE Auction
 SET CurrentHighBid = newBid #AND ClosingBid = CurrentHighBid
 WHERE AuctionID = auctID;

 UPDATE Auction
 SET OpeningBid = newBid #AND ClosingBid = CurrentHighBid
 WHERE AuctionID = auctID;

ELSE
  IF auctionComplete = 0 AND newBid >= bidWithIncrement AND custID LIKE seller = 0 THEN
    INSERT INTO  DATABAYSE.Bid(AuctionID, CustomerID, Bid, MaxBid, BidDate, BidTime)
      values(auctID, custID, newBid, newMaxBid, CURRENT_DATE(), CURRENT_TIME());

      UPDATE Auction
      SET CurrentHighBid = newBid #AND ClosingBid = CurrentHighBid
      WHERE AuctionID = auctID;

      UPDATE Auction
      SET BuyerID = custID #AND ClosingBid = CurrentHighBid
      WHERE AuctionID = auctID;

  ELSE
  SELECT seller, newBid, currentBid;
  END IF;
END IF;
END $$

DELIMITER ;

/* Produce a comprehensive listing of all items  */
/* TODO: More than one variable name for the group by section?! */
# 3.1.c: Get Monthly Sales Report
CREATE VIEW DATABAYSE.viewAllItems (Name, Type, Year, CopiesSold, AmountInStock) AS
  SELECT Name, Type, Year, CopiesSold, AmountInStock
  FROM Item I
  GROUP BY Name, Type, Year;

/*3.1.d Produce a list of sales by item name */
CREATE VIEW DATABAYSE.salesByItemName(Name, TotalCopiesSold, TotalClosingBids) AS
  SELECT I.Name, SUM(I.CopiesSold), SUM(A.ClosingBid)
  FROM Item I, Auction A
  WHERE A.ItemId = I.ItemId AND A.isComplete = 1
  GROUP BY I.Name;

/*3.1.d Produce a list of sales by customer name */
CREATE VIEW DATABAYSE.salesByCustomerName(CustomerName, TotalCopiesSold, TotalClosingBids) AS
  SELECT C.CustomerID, SUM(I.CopiesSold), SUM(A.ClosingBid)
  FROM Item I, Auction A, Customer C
  WHERE A.ItemId = I.ItemId AND  A.isComplete = 1 AND A.SellerID = C.CustomerID
  GROUP BY C.CustomerID;

CREATE VIEW DATABAYSE.itemsSold(Name, Type, Year, CopiesSold) AS
  SELECT I.Name, I.Type, I.Year, SUM(I.CopiesSold)
  FROM Item I
  GROUP BY I.Name, I.Type;

/*3.1.h + 3.3.f Produce a best seller list of items*/
CREATE VIEW DATABAYSE.bestSellersList(Name, Type, Year, CopiesSold) AS
  SELECT *
  FROM itemsSold
  ORDER BY CopiesSold DESC LIMIT 10; # DESC: descending order

#3.3.c Produce a mailing list of customers
CREATE VIEW DATABAYSE.customerMailingList(LastName, FirstName, Address, City, State, ZipCode) AS
  SELECT C.LastName, C.FirstName, C.Address, C.City, C.State, C.ZipCode
  FROM Customer C;

/*produce a list of employees by total revenue*/
  CREATE VIEW DATABAYSE.employeeRevenue(ID, ItemName, AuctionID, ClosingDate, ClosingTime,Total) AS
  SELECT E.EmployeeID, I.Name,A.AuctionID, A.ClosingDate, A.ClosingTime, SUM(A.ClosingBid)
  FROM Auction A, Employee E, Item I
  WHERE A.EmployeeID = E.EmployeeID AND A.ItemID = I.ItemID AND A.isComplete = 1
  GROUP BY E.EmployeeID;

#
/*produce a list of customers by revenue, the most successful sellers*/
  CREATE VIEW DATABAYSE.SellersWhoMadeBank(SellerID, Total) AS
  SELECT C.CustomerID , SUM(A.ClosingBid)
  FROM Auction A, Customer C
  WHERE A.SellerID = C.CustomerID AND A.isComplete = 1
  GROUP BY C.CustomerID;

#
/*produce a list of customers by revenue, the most frequent buyers*/
  CREATE VIEW DATABAYSE.BuyersWhoSpentBank(BuyerID, Total) AS
  SELECT C.CustomerID , SUM(A.ClosingBid)
  FROM Auction A, Customer C
  WHERE A.BuyerID = C.CustomerID AND A.isComplete = 1
  GROUP BY C.CustomerID;

/* produce a list of types by customer*/
  CREATE VIEW DATABAYSE.getTypesForSuggestion(CustomerID, Type) AS
  SELECT C.CustomerID, I.Type
  FROM Customer C, Item I, Auction A
  WHERE A.BuyerID = C.CustomerID AND A.ItemID = I.ItemID
  GROUP BY I.Type;
