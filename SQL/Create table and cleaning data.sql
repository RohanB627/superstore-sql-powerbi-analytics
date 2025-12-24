CREATE TABLE IF NOT EXISTS superstore_orders (
    row_id           integer,
    order_id         text,
    order_date_raw   text,
    ship_date_raw    text,
    ship_mode        text,
    customer_id      text,
    customer_name    text,
    segment          text,
    country          text,
    city             text,
    state            text,
    postal_code      text,
    region           text,
    product_id       text,
    category         text,
    sub_category     text,
    product_name     text,
    sales_raw        text,
    quantity_raw     text,
    discount_raw     text,
    profit_raw       text
);


select count(*) from superstore_orders;
select * from superstore_orders so limit 10;

