/******************************************************************************
Adds Customer Demo Data to DATABAYSE
Example: (you can copy and paste this to add new data)
call addCustomer('firstname','lastname', 'address', 'city', 'state',
zip, 'telephone', 'email','creditcard');
*******************************************************************************/

call addItem('Titanic', 'DVD', 2005, 4);
call addItem('Nissan Sentra', 'Car', 2007, 1);
call addItem('Titanic', 'DVD', 2005, 5);

call addItem('Audi R8', 'Car', 2010, 1);
call addItem('Nissan Sentra', 'Car', 2009, 1);


update Item SET CopiesSold = 1 where ItemID = 1;
update Item SET CopiesSold = 2 where ItemID = 2;
update Item SET CopiesSold = 3 where ItemID = 3;
