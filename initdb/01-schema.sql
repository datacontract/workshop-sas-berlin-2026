CREATE SCHEMA orders_v1;

CREATE TABLE orders_v1.orders (
    order_id text PRIMARY KEY,
    order_timestamp timestamptz NOT NULL,
    order_total bigint NOT NULL,
    customer_id text NOT NULL,
    customer_email_address text NOT NULL
);

CREATE TABLE orders_v1.line_items (
    lines_item_id text PRIMARY KEY,
    order_id text NOT NULL REFERENCES orders_v1.orders (order_id),
    sku text NOT NULL
);

CREATE SCHEMA orders_v2;

CREATE TABLE orders_v2.orders (
    order_id text PRIMARY KEY,
    order_timestamp timestamptz NOT NULL,
    order_total bigint NOT NULL,
    customer_id text NOT NULL,
    customer_email_address text NOT NULL
);

CREATE TABLE orders_v2.line_items (
    lines_item_id text PRIMARY KEY,
    order_id text NOT NULL REFERENCES orders_v2.orders (order_id),
    sku text NOT NULL,
    quantity bigint NOT NULL DEFAULT 1
);
