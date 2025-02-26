/* Getting API data */
filename carts temp;
proc http
  url="https://fakestoreapi.com/carts"
  method="GET"
  out=carts;
run;

filename products temp;
proc http
  url="https://fakestoreapi.com/products" 
  method="GET"
  out=products;
run;

filename users temp;
proc http
  url="https://fakestoreapi.com/users"
  method="GET"
  out=users;
run;

/* Parse JSON */
libname carts_j JSON fileref=carts;
libname prod_j JSON fileref=products;
libname users_j JSON fileref=users;

/* Create products table */
data work.products;
  set prod_j.root;
  keep id title price category description;
run;

/* Create users table */
data work.users;
  set users_j.root;
  keep id username email;
  

/* Create dimension tables */
/* Create dim_product */
data work.dim_product;
  set work.products;
  rename id = product_id
         price = current_price;
  keep id title price category;
run;

/* Create dim_user */
data work.dim_user;
  set work.users;
  rename id = user_id;
run;

/* Create dim_date */
data work.dim_date;
  format date date9. year 4. month 2. day 2.;
  do date = '01JAN2020'd to '31DEC2020'd;
    date_id = year(date)*10000 + month(date)*100 + day(date);
    year = year(date);
    month = month(date);
    day = day(date);
    output;
  end;
run;

/* Create sample sales data */
data work.sales_fact;
  do sales_id = 1 to 20;
    order_id = ceil(sales_id/3);
    product_id = ceil(rand('uniform')*10);
    user_id = ceil(rand('uniform')*5);
    date_id = 20200101 + (ceil(rand('uniform')*365) - 1);
    quantity = ceil(rand('uniform')*5);
    price = round(10 + rand('uniform')*90, 0.01);
    total_price = quantity * price;
    output;
  end;
run;

/* Clean up */
proc datasets library=work nolist;
  delete products users;
quit;
