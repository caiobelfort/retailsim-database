-- Create schemas
CREATE SCHEMA IF NOT EXISTS customers;
CREATE SCHEMA IF NOT EXISTS products;
CREATE SCHEMA IF NOT EXISTS orders;

CREATE TABLE customers.customer
(
    id         BIGSERIAL PRIMARY KEY NOT NULL,
    name       VARCHAR(70),
    created_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP,
    updated_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP
);

CREATE TABLE products.aisle
(
    id         INT PRIMARY KEY NOT NULL,
    name       VARCHAR(70),
    create_at  TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP,
    updated_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP
);

CREATE TABLE products.department
(
    id         INT PRIMARY KEY NOT NULL,
    name       VARCHAR(70),
    created_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP,
    updated_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP
);

CREATE TABLE products.product
(
    id            SERIAL PRIMARY KEY NOT NULL,
    name          VARCHAR(240),
    aisle_id      INT                NOT NULL REFERENCES products.aisle (id),
    department_id INT                NOT NULL REFERENCES products.department (id),
    created_at    TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP,
    updated_at    TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP
);

CREATE TABLE orders.order
(
    id         BIGSERIAL PRIMARY KEY NOT NULL,
    user_id    INT REFERENCES customers.customer (id),
    order_date TIMESTAMP,
    is_valid   BOOL                        DEFAULT TRUE,
    created_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP,
    updated_at TIMESTAMP          NOT NULL DEFAULT NOW()::TIMESTAMP
);


CREATE TABLE orders.order_product
(
    order_id   INT       NOT NULL REFERENCES orders.order (id),
    product_id INT       NOT NULL REFERENCES products.product (id),
    cart_order INT,
    quantity   FLOAT,
    is_valid   BOOL               DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()::TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()::TIMESTAMP,

    CONSTRAINT order_product_pk PRIMARY KEY (order_id, product_id)
);

-- Configure update_at triggers
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON customers.customer
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON products.product
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON products.aisle
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON products.department
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON orders.order
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON orders.order_product
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();