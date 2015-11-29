#Add, Edit and Delete information for an employee

#add employee-- we hired billiam longbottm
call addEmployee('000-43-9987', 'Billiam', 'Longbottom',
'yorkshire pudding', 'ayy lmao', 'HW', 11178, '(646)232-6765',DATE('2015-23-10'),200,'password');

call editEmployee('000-43-9987', 'William', 'Longbottom','123 Circle Road', 'Jericho', 'FL', 55102, '(646)123-4324', 40,'password');

#edit employee-- billiam longbottom moved
call editEmployee('000-43-9987', 'Billiam', 'Longbottom',
'the shire', 'britannia', 'HW', 11179, '1-800-HOTLINEBLING',DATE('2015-23-10'),'password');

/*
CREATE PROCEDURE editEmployee(IN empl_ssn CHAR(14), IN empl_fn CHAR(32), IN empl_ln CHAR(32),
IN empl_addr CHAR(128), IN empl_city CHAR(32), IN empl_state CHAR(2), IN empl_zip
INTEGER, IN empl_tel CHAR(20), IN empl_hr INTEGER)*/

#delete employee-- this deletes billiam longbottom
call deleteEmployee('000-43-9987');

#Obtain a sales report for a particular month-- get the sales report for september
call getMonthlySalesReport(10);


#Produce a comprehensive listing of all items-- how many titanic DVDs have we sold
call getRevenueByItem(1);


#Produce a list of sales by item name or by customer name-- makes a list
call getRevenueByType('DVD');

#Produce a summary listing of revenue generated by a particular item, item type, or customer

#shiyong customer
call getRevenueByCustomer('shiyong');
#DVD type
call getRevenueByType('DVD');
#Titanic particular item
call getRevenueByItem('Titanic');



#Determine which customer representative generated most total revenue
call getBestCustomerRep();

#Determine which customer generated most total revenue
#3.1.g.1 the customer who generated the most revenue by buying things
call getBestBuyer();
#3.1.g.2 the customer who generated the most revenue by selling things
call getBestMerchant();


#Produce a Best-Sellers list of items
Select * From bestSellersList;


#3.2

#Record a sale
#end the titatnic dvd auction
call endAuction(1);

#Add, Edit and Delete information for a customer
#  Add a customer
call addCustomer('werner', 'herzog',
'statue of liberty', 'spiderman', 'NY',11324,'1-800-HOTLINEBLING', 'hedgehog@stripper.org', '4444-7777-0000-1234','password');
# Edit a customer-- he got married and moved
call editCustomer('werner', 'hedgehog',
'in a hole', 'in the ground', 'NJ',11232,'1-800-HOTLINEBLING', 'hedgehog@stripper.org', '4444-7777-0000-1234', 2, 3, 1,'password');


#call addCustomer('New','Customer', 'SomeAddress', 'SomeCity', 'NY', 99999, '(999)999-0000', 'bubble@kusty.krab','1111-1111-1111-1111');
#call editCustomer('phil', 'Lewis', '156 Intellect Rd', 'Stony Brook', 'NY',11793,'(516)632-8959', 'shiyong@cs.sunysb.edu ', '6789-2345-6789-2345', 0, 0, 3);
# Delete a customer -- he died
call deleteCustomer('phil');


#Produce customer mailing lists
SELECT * FROM customerMailingList;

#Produce a list of item suggestions for a given customer (based on that customer's past purchases)
#shiyong
call getSuggestionsByType('shiyong');

#3.3

#A bid history for each auction
call getBidHistory('shiyong',1);

#A history of all current and past auctions a customer has taken part in
#shiyong
call getPastAuctions('shiyong');

#Items sold by a given seller and corresponding auction info
call itemsSoldBy('phil');

#Items available of a particular type and corresponding auction info
#DVD
call itemsAvailableByType('DVD');

#Items available with a particular keyword or set of keywords in the item name, and corresponding auction info
#Titanic
call itemsAvailableByKeyword('Titanic');

#Best-Seller list
Select * FROM bestSellersList;

#Personalized item suggestion list
#shiyong
call getSuggestionsByType('shiyong');
