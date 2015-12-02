/*
CREATE PROCEDURE addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2))
employees and ids

1 david smith
2 david warren
3 steve madden
4 ellen degeneres
5 jason fontaine
6 mario plumber
7 homer simpson

items and ids

1 titanic ``
2 nissan sentra ``
3 headphones
4 rainbow unicorn
5 butterfly buttercup
6 watch
7 batmobile
8 pikachu
9 garbage ``
10 Camry
11 Civic
12 Miata
13 santa Hat
14 elf outfit
15 eyepatches
16 ruffled shirt
17 Tricorne
18 strawhat
19 gba
20 goku figure
21 bobblehead
22 one piece
23 IPad
24 Galaxy
25 Roomba
26 Limes
27 Rum
28 Pomegranate
29 psl
30 cheese
31 remy Martin
32 pirateship
33 Gold
34 pegleg
35 hippo
sellers

bob
haixia
John
oscar
Phil
shiyong
tom
*/
/*
addAuction(IN seller_id CHAR(32), IN item_id INTEGER, IN employee_id INTEGER,
IN opening_bid DECIMAL(8,2), IN reserve DECIMAL(8,2), IN inc DECIMAL(8,2), IN auctionLength INTEGER) */
/* titanic DVD*/
call addAuction('Phil', 1, 1, 5, 10, 1, 3);
call setAuctionImage(1,'titanicdvd.jpg');
call approveAuction(1);
/*nissan sentra*/
call addAuction('John', 2, 1, 50.0, 55.0, 1, 3);
call setAuctionImage(2,'nissansentra.jpg');
call approveAuction(2);
/*garbage*/
call addAuction('Oscar', 9, 5, 6.00, 10.00, 2.00, 5);
call setAuctionImage(3, 'garbage.jpg');
call approveAuction(3);
/*headphones*/
call addAuction('bob', 3, 2, 10.0, 15.0, 1, 5);
call setAuctionImage(4,'headphones.jpg');
call approveAuction(4);
/*unicorn*/
call addAuction('shiyong', 4, 3, 20.0, 25.0, 1, 5);
call setAuctionImage(5,'unicorn.jpg');
call approveAuction(5);
/*butterfly*/
call addAuction('tom', 5, 4, 30.0, 35.0, 1, 3);
call setAuctionImage(6,'butterfly.jpg');
call approveAuction(6);
/*watch*/
call addAuction('haixia', 6, 5, 10.0, 15.0, 1, 5);
call setAuctionImage(7,'watch.jpg');
call approveAuction(7);
/*batmobile*/
call addAuction('john', 7, 6, 250000.0, 300000.0, 1, 5);
call setAuctionImage(8,'batmobile.jpg');
call approveAuction(8);
/*pikachu*/
call addAuction('phil', 8, 7, 200.0, 300.0, 10, 5);
call setAuctionImage(9,'pikachu.jpg');
call approveAuction(9);
/*camry*/
call addAuction('oscar', 10, 1, 4000.0, 5000.0, 100, 5);
call setAuctionImage(10,'camry.jpg');
call approveAuction(10);
/*civic*/
call addAuction('tom', 11, 2, 3000.0, 4500.0, 100, 5);
call setAuctionImage(11,'civic.jpg');
call approveAuction(11);
/*miata*/
call addAuction('bob', 12, 3, 2000.0, 2500.0, 1, 5);
call setAuctionImage(12,'miata.jpg');
call approveAuction(12);
/*santa hat*/
call addAuction('john', 13, 4, 10.0, 15.0, 1, 3);
call setAuctionImage(13,'santahat.jpg');
call approveAuction(13);
/*elf outfit*/
call addAuction('phil', 14, 5, 30.0, 35.0, 1, 3);
call setAuctionImage(14,'elfoutfit.jpg');
call approveAuction(14);
/*eyepatches*/
call addAuction('bob', 15, 6, 2.0, 4.0, 1, 5);
call setAuctionImage(15,'eyepatch.jpg');
call approveAuction(15);
/*ruffled shirt*/
call addAuction('tom', 16, 7, 200.0, 250.0, 1, 5);
call setAuctionImage(16,'ruffledshirt.jpg');
call approveAuction(16);
/*tricorne*/
call addAuction('oscar', 17, 1, 20.0, 25.0, 1, 5);
call setAuctionImage(17,'tricorne.jpg');
call approveAuction(17);
/*strawhat*/
call addAuction('haixia', 18, 2, 10.0, 15.0, 1, 5);
call setAuctionImage(18,'strawhat.jpg');
call approveAuction(18);
/*gba*/
call addAuction('shiyong', 19, 3, 100.0, 150.0, 1, 5);
call setAuctionImage(19,'gba.jpg');
call approveAuction(19);
/*goku*/
call addAuction('haixia', 20, 4, 100.0, 150.0, 1, 5);
call setAuctionImage(20,'goku.jpg');
call approveAuction(20);
/*bobblehead*/
call addAuction('phil', 21, 5, 10.0, 15.0, 1, 5);
call setAuctionImage(21,'bobblehead.jpg');
call approveAuction(21);
/*one piece*/
call addAuction('shiyong', 22, 6, 50.0, 75.0, 1, 5);
call setAuctionImage(22,'onepiece.jpg');
call approveAuction(22);
/*ipad*/
call addAuction('tom', 23, 7, 100.0, 150.0, 1, 5);
call setAuctionImage(23,'ipad.jpg');
call approveAuction(23);
/*galaxy*/
call addAuction('bob', 24, 1, 250.0, 300.0, 1, 5);
call setAuctionImage(24,'galaxys4.jpg');
call approveAuction(24);
/*roomba*/
call addAuction('oscar', 25, 2, 15.0, 20.0, 1, 5);
call setAuctionImage(25,'roomba.jpg');
call approveAuction(25);
/*limes*/
call addAuction('oscar', 26, 3, 3.0, 5.0, 1, 5);
call setAuctionImage(26,'limes.jpg');
call approveAuction(26);
/*rum*/
call addAuction('john', 27, 4, 400.0, 450.0, 1, 5);
call setAuctionImage(27,'rum.jpg');
call approveAuction(27);
/*pomegranate*/
call addAuction('phil', 28, 5, 10.0, 15.0, 1, 5);
call setAuctionImage(28,'pomegranate.jpg');
call approveAuction(28);
/*pumpkinspicelatte*/
call addAuction('haixia', 29, 6, 10.0, 15.0, 1, 5);
call setAuctionImage(29,'pumpkinspicelatte.jpg');
call approveAuction(29);
/*cheese*/
call addAuction('john', 30, 7, 200.0, 250.0, 1, 5);
call setAuctionImage(30,'cheese.jpg');
call approveAuction(30);
/*remy martin*/
call addAuction('phil', 31, 1, 100.0, 125.0, 1, 5);
call setAuctionImage(31,'remymartin.jpg');
call approveAuction(31);
/*pirateship*/
call addAuction('shiyong', 32, 2, 20000.0, 250000.0, 1, 5);
call setAuctionImage(32,'pirateship.jpg');
call approveAuction(32);
/*gold*/
call addAuction('haixia', 33, 3, 1000000.0, 1500000.0, 1, 5);
call setAuctionImage(33,'gold.jpg');
call approveAuction(33);
/*pegleg*/
call addAuction('tom', 34, 4, 200.0, 250.0, 1, 5);
call setAuctionImage(34,'pegleg.jpg');
call approveAuction(34);
/*hippo*/
call addAuction('bob', 35, 5, 60000000.0, 65000000.0, 1, 5);
call setAuctionImage(35,'nissansentra.jpg');
call approveAuction(35);
