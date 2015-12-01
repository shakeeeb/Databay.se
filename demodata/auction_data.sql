/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
*/

#<<<<<< HEAD
#<<<<<<< HEAD
call addAuction('Phil', 1, 1, 5, 10, 1, 3);
call approveAuction(1);

#=======
call addAuction('John', 2, 1, 50.0, 55.0, 1, 3);
call approveAuction(2);

#>>>>>>> d3e6ee905dbddf23b687f8d1edbf546202b7cc05
#call addAuction('Haixia', 1, 1, 50.0, 55.0); #TODO remove

#call addAuction('Shiyong', 1, 1, 50.0, 55.0, 3);
#call addAuction('Haixia', 1, 1, 50.0, 55.0, 3); #TODO remove
#<<<<<<< HEAD

#call addAuction('Oscar', 9, 5, 6.00, 29, 2.00, 5);
/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2), IN inc DECIMAL(8,2), IN auctionLength INTEGER)
*/

#call addAuction('Oscar', 9, 5, 6.00, 10.00, 2.00);
#=======
call addAuction('Oscar', 9, 5, 6.00, 10.00, 2.00, 5);
call approveAuction(3);

#>>>>>>> d3e6ee905dbddf23b687f8d1edbf546202b7cc05
###=======
#call addAuction('Shiyong', 1, 1, 50.0, 55.0, 3);
#call addAuction('Haixia', 1, 1, 50.0, 55.0, 3); #TODO remove
#call addAuction('oscar', 9, 5, 6.00, 10.00, 2.00);

#>>>>>>> 2ced6153631af4ac64dc8a65905a093364fed355
