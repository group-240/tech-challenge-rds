-- Enable UUID extension (Good practice for UUID handling in Postgres)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==========================================
-- SCHEMA 1: PRODUCT MANAGEMENT
-- Holds Categories and Products
-- ==========================================
CREATE SCHEMA IF NOT EXISTS product_management;

-- Table: categories
-- Entity: com.fiap.techchallenge.external.datasource.entities.CategoryJpaEntity
CREATE TABLE product_management.categories (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Table: products
-- Entity: com.fiap.techchallenge.external.datasource.entities.ProductJpaEntity
CREATE TABLE product_management.products (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(19, 2) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    category_id UUID,
    CONSTRAINT fk_product_category 
        FOREIGN KEY (category_id) 
        REFERENCES product_management.categories (id)
);

-- ==========================================
-- SCHEMA 2: ORDER MANAGEMENT
-- Holds Orders and Order Items
-- ==========================================
CREATE SCHEMA IF NOT EXISTS order_management;

-- Table: orders
-- Entity: com.fiap.techchallenge.external.datasource.entities.OrderJpaEntity
CREATE TABLE order_management.orders (
    id BIGSERIAL PRIMARY KEY, -- GenerationType.IDENTITY maps to SERIAL/BIGSERIAL
    customer_cpf VARCHAR(14),
    total_amount NUMERIC(19, 2) NOT NULL,
    status VARCHAR(50) NOT NULL, -- Enum: RECEIVED, IN_PREPARATION, READY, FINISHED
    status_payment VARCHAR(50) NOT NULL, -- Enum: AGUARDANDO_PAGAMENTO, APROVADO, REJEITADO
    id_payment BIGINT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW()
);

-- Table: order_items
-- Entity: com.fiap.techchallenge.external.datasource.entities.OrderItemJpaEntity
CREATE TABLE order_management.order_items (
    id UUID PRIMARY KEY,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(19, 2) NOT NULL,
    sub_total NUMERIC(19, 2) NOT NULL,
    order_id BIGINT NOT NULL,
    product_id UUID NOT NULL,
    
    -- Relationship to Order (Same Schema)
    CONSTRAINT fk_items_order 
        FOREIGN KEY (order_id) 
        REFERENCES order_management.orders (id) 
        ON DELETE CASCADE,

    -- Relationship to Product (Cross-Schema Foreign Key)
    -- Note: This creates a hard dependency between schemas. 
    -- In pure microservices, this FK might be removed, but for a single DB, it ensures integrity.
    CONSTRAINT fk_items_product 
        FOREIGN KEY (product_id) 
        REFERENCES product_management.products (id)
);

-- Indexes for performance (based on Repository queries)
CREATE INDEX idx_products_name ON product_management.products(name);
CREATE INDEX idx_products_category ON product_management.products(category_id);
CREATE INDEX idx_orders_status ON order_management.orders(status);