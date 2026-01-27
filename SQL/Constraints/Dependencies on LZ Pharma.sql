-- add dependencies
ALTER TABLE operations.orders
ADD CONSTRAINT order_customer_deletion
FOREIGN KEY (customer_id) REFERENCES operations.customers(customer_id) ON DELETE SET NULL;
-- Set the customer_id in orders table to null when a customer is deleted from the customers table.

ALTER TABLE inventory.stock
ADD CONSTRAINT stock_drug_deletion
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;
-- deletes the drug_id in stock if the drug is deleted in the drugs table

ALTER TABLE operations.orders
ADD CONSTRAINT employee_deletion
FOREIGN KEY (attendant_id) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;
ALTER TABLE operations.orders
ADD CONSTRAINT employee_customer_deletion
FOREIGN KEY (prescribed_by) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;
ALTER TABLE operations.orders
ADD CONSTRAINT employee_id_deletion
FOREIGN KEY (paid_to) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;
ALTER TABLE operations.orders
ADD CONSTRAINT employee_profile_deletion
FOREIGN KEY (dispatched_by) REFERENCES operations.employees(employee_id) ON DELETE SET NULL;

-- Create a constraint to delete the supplier informationbwhen a drug is deleted
ALTER TABLE inventory.suppliers
ADD CONSTRAINT supplier_drug_deletion
FOREIGN KEY (drug_id) REFERENCES inventory.drugs(drug_id)
ON DELETE CASCADE;