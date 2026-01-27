SELECT * FROM operations.orders;

SELECT * FROM operations.customers;

SELECT ^ FROM inventory.drugs;

EXPLAIN ANALYZE
SELECT * FROM operations.orders o
LEFT JOIN operations.employees e
ON o.attendant_id = e.employee_id;

DELETE FROM operations.customers WHERE customer_id = 23;

SELECT * FROM operations.orders WHERE customer_id = 23;

SELECT * FROM operations.orders WHERE customer_id IS NULL;