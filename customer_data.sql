USE DATABAYSE;

/******************************************************************************
Adds Customer Demo Data to DATABAYSE
Example: (you can copy and paste this to add new data)
call addCustomer('firstname','lastname', 'address', 'city', 'state',
zip, 'telephone', 'email','creditcard');
*******************************************************************************/

call addCustomer('Shiyong','Lu', '123 Success Street', 'Stony Brook', 'NY',
11790, '(516)632-8959', 'shiyong@cs.sunysb.edu','1234-5678-1234-5678');

call addAuction('Shiyong', 0, 0, 0, 50.0, 55.0); # an auciotn needs a seller id, itemid employee id, opening bid, and a reserve
