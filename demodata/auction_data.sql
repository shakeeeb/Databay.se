/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
*/

call addAuction('Shiyong', 1, 1, 50.0, 55.0);
#call addAuction('Haixia', 1, 1, 50.0, 55.0); #TODO remove
