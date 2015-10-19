CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER IN employee_id INTEGER, IN opening_bid DECIMAL(8,2) IN reserve DECIMAL(8,2))
BEGIN
start_date DATE = CURRENT_DATE;
start_time TIME = CURRENT_TIME;
closing_date DATE = ADDDATE(start_date, INTERVAL 3 DAY);
closing_time TIME = start_time; #defaults exactly 3 days later
increment DECIMAL(8,2) = opening_bid/8;# let the default increment be 1/8 the initial price
insert into DATABAYSE.Auction(SellerID, ItemID, EmployeeID, OpeningBid, OpeningDate, OpeningTime, ClosingDate, ClosingTime, Reserve, Increment)
  values(Lower(seller_id), item_id, employee_id, opening_bid, start_date, start_time , closing_date, closing_time, reserve, increment
  	);
End
$$