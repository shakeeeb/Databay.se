/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
*/

call addAuction('Phil', 1, 1, 5, 10, 1, 3);

#call addAuction('Haixia', 1, 1, 50.0, 55.0); #TODO remove

#call addAuction('Shiyong', 1, 1, 50.0, 55.0, 3);
#call addAuction('Haixia', 1, 1, 50.0, 55.0, 3); #TODO remove

call addAuction('Oscar', 9, 5, 6.00, 29, 2.00, 5);
/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2), IN inc DECIMAL(8,2), IN auctionLength INTEGER)
*/

#call addAuction('Oscar', 9, 5, 6.00, 10.00, 2.00);
