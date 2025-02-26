/* Simple PostgreSQL data loading script */

/* Connect to PostgreSQL database */
proc sql;
  connect to postgres as pg (
    server="localhost" 
    port=5432 
    user="postgres" 
    password="superadmin" 
    database="ecommerce" 
  );
  
  /* Drop existing tables */
  execute (DROP TABLE IF EXISTS sales_fact) by pg;
  execute (DROP TABLE IF EXISTS dim_product) by pg;
  execute (DROP TABLE IF EXISTS dim_user) by pg;
  execute (DROP TABLE IF EXISTS dim_date) by pg;
  
  /* Create tables */
  execute (
    CREATE TABLE dim_product (
      product_id INT PRIMARY KEY,
      title TEXT,
      category TEXT,
      current_price NUMERIC(10,2)
    )
  ) by pg;
  
  execute (
    CREATE TABLE dim_user (
      user_id INT PRIMARY KEY,
      username TEXT,
      email TEXT,
      city TEXT,
      country TEXT
    )
  ) by pg;
  
  execute (
    CREATE TABLE dim_date (
      date_id INT PRIMARY KEY,
      date DATE,
      day INT,
      month INT,
      year INT
    )
  ) by pg;
  
  execute (
    CREATE TABLE sales_fact (
      sales_id INT PRIMARY KEY,
      order_id INT,
      product_id INT,
      user_id INT,
      date_id INT,
      quantity INT,
      price NUMERIC(10,2),
      total_price NUMERIC(10,2)
    )
  ) by pg;
  
  disconnect from pg;
quit;

/* Export to CSV files for easier loading */
proc export data=work.dim_product
  outfile="dim_product.csv"
  dbms=csv replace;
run;

proc export data=work.dim_user
  outfile="dim_user.csv"
  dbms=csv replace;
run;

proc export data=work.dim_date(obs=100) 
  outfile="dim_date.csv"
  dbms=csv replace;
run;

proc export data=work.sales_fact
  outfile="sales_fact.csv"
  dbms=csv replace;
run;

