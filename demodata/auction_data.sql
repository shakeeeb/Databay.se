/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
*/

call addAuction('John', 1, 1, 50.0, 55.0, 1);
#call addAuction('Haixia', 1, 1, 50.0, 55.0); #TODO remove

#call addAuction('Shiyong', 1, 1, 50.0, 55.0, 3);
#call addAuction('Haixia', 1, 1, 50.0, 55.0, 3); #TODO remove
call addAuction('Oscar', 9, 5, 6.00, 10.00, 2.00);


seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER, IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2), IN increment DECIMAL(8,2
