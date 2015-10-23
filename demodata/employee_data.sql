call addEmployee('123-45-6789', 'David', 'Smith', '123 College road',
  'Stony Brook', 'NY', 11790, '(516)215-2345', DATE('1998-11-1'),60);

call addEmployee('789-12-3456', 'David', 'Warren', '456 Sunken Street',
  'Stony Brook', 'NY', 11794, '(516)632-9987', DATE('1999-2-2'),50);

call promoteToManager('789-12-3456');
