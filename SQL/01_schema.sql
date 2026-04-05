CREATE DATABASE InventoryDB;

USE InventoryDB;
GO

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    region CHAR(7),
    customer_type CHAR(9)
);

-- PRODUCTS
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    sku_code VARCHAR(10) UNIQUE,
    category TEXT,
    brand TEXT,
    unit_cost DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);

-- SUPPLIERS
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name TEXT,
    avg_lead_time_days INT
);

-- WAREHOUSES
CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY,
    locations TEXT
);

-- INVENTORY
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    supplier_id INT,
    opening_stock INT,
    closing_stock INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- SALES
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity_sold INT NOT NULL,
    revenue DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

-- PURCHASE ORDERS
CREATE TABLE purchase_orders (
    po_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    supplier_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_qty INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- SALES RETURNS
CREATE TABLE sales_returns (
    return_id INT PRIMARY KEY,
    sale_id INT NOT NULL,
    return_reason VARCHAR(200),   -- ✅ specify length
    return_date DATE NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);


Bulk INSERT  customers
FROM 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\customers.csv'
with ( FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);

Bulk insert inventory From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\\inventory.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );

Bulk insert products From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\products.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );

Bulk insert purchase_orders From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\purchase_orders.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );


USE InventoryDB;
GO

Bulk insert sales From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\sales.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );

Bulk insert sales_returns From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\returns.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );

Bulk insert suppliers From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\suppliers.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );

Bulk insert warehouses From 'C:\Users\Chakri\Desktop\FABRIC\Invetory management\warehouses.csv'
with ( Format = 'CSV', FIRSTROW = 2, FIELDTERMINATOR =',', ROWTERMINATOR = '\n', TABLOCK );
