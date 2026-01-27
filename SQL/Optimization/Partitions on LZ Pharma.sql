-- Partitioning
-- Create parent table
-- Now changed to DEFAULTS which only copies the columns and default values but not the Primary Keys, Foreign Keys, indexes and unique constraints.
CREATE TABLE operations.orders_partitioned (
    LIKE operations.orders INCLUDING DEFAULTS
) PARTITION BY RANGE (order_datetime);

-- Adding all order constraints
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT check_total_amount CHECK (total_amount >= 0);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT order_customer_deletion
FOREIGN KEY (customer_id) REFERENCES operations.customers(customer_id) ON DELETE SET NULL;
-- Set the customer_id in orders table to null when a customer is deleted from the customers table.

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT employee_deletion
FOREIGN KEY (attendant_id) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT employee_customer_deletion
FOREIGN KEY (prescribed_by) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT employee_id_deletion
FOREIGN KEY (paid_to) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT employee_profile_deletion
FOREIGN KEY (dispatched_by) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;


-- alter the partitioned table to accept both order_id and order_date as the Primary Keys; making this a COMPOSITE Primary Key, see glossary (coming soon) for more information.
ALTER TABLE operations.orders_partitioned
ADD PRIMARY KEY (order_id, order_datetime);

-- Recreate the foreign KEYS
ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id)
    REFERENCES operations.customers(customer_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_attendant
    FOREIGN KEY (attendant_id)
    REFERENCES operations.employees(employee_id);

-- Assignment: Add the other foreign key contraints [drugs_id (drugs table), prescribed_by, paid_to, dispatched_by (all linked to employee table)].

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_drugs
	FOREIGN KEY (drug_id)
	REFERENCES inventory.drugs(drug_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_prescribed_by
    FOREIGN KEY (prescribed_by)
    REFERENCES operations.employees(employee_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_paid_to
    FOREIGN KEY (paid_to)
    REFERENCES operations.employees(employee_id);

ALTER TABLE operations.orders_partitioned
ADD CONSTRAINT fk_orders_dispatched_by
    FOREIGN KEY (dispatched_by)
    REFERENCES operations.employees(employee_id);

-- Create partitions per year
-- Assignment: Create partitioned tables up to 2026

CREATE TABLE operations.orders_2020 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE operations.orders_2021 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE operations.orders_2022 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE operations.orders_2023 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE operations.orders_2024 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE operations.orders_2025 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE operations.orders_2026 PARTITION OF operations.orders_partitioned
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Insert into the orders_partitioned after partitioning from the orders table
INSERT INTO operations.orders_partitioned
SELECT * FROM operations.orders;

-- Rename tables orders_partitioned table to orders and vice versa
ALTER TABLE operations.orders RENAME TO orders_old;
ALTER TABLE operations.orders_partitioned RENAME TO orders;