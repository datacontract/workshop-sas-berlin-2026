\set ON_ERROR_STOP on

CREATE TEMP TABLE staging (line jsonb);

COPY staging (line) FROM '/data/orders_v1/orders.json';

INSERT INTO orders_v1.orders (order_id, order_timestamp, order_total, customer_id, customer_email_address)
SELECT line ->> 'order_id',
       (line ->> 'order_timestamp')::timestamptz,
       (line ->> 'order_total')::bigint,
       line ->> 'customer_id',
       line ->> 'customer_email_address'
FROM staging;

TRUNCATE staging;

COPY staging (line) FROM '/data/orders_v1/line_items.json';

INSERT INTO orders_v1.line_items (lines_item_id, order_id, sku)
SELECT line ->> 'lines_item_id',
       line ->> 'order_id',
       line ->> 'sku'
FROM staging;

TRUNCATE staging;

COPY staging (line) FROM '/data/orders_v2/orders.json';

INSERT INTO orders_v2.orders (order_id, order_timestamp, order_total, customer_id, customer_email_address)
SELECT line ->> 'order_id',
       (line ->> 'order_timestamp')::timestamptz,
       (line ->> 'order_total')::bigint,
       line ->> 'customer_id',
       line ->> 'customer_email_address'
FROM staging;

TRUNCATE staging;

COPY staging (line) FROM '/data/orders_v2/line_items.json';

INSERT INTO orders_v2.line_items (lines_item_id, order_id, sku, quantity)
SELECT line ->> 'lines_item_id',
       line ->> 'order_id',
       line ->> 'sku',
       (line ->> 'quantity')::bigint
FROM staging;

DROP TABLE staging;
