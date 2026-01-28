-- 1. Supply Chain Risk Monitor.
CREATE VIEW analytics.supply_chain_risk AS 
SELECT stock.drug_id,
	drugs."name" AS drug_name,
	stock.quantity AS current_stock,
	CASE
		WHEN stock.quantity <= 100 THEN 'CRITICAL: stock_out'
		WHEN stock.quantity <= 500 THEN 'WARNING: Low Stock'
		ELSE 'Good Stock'
		END AS risk_status,
		suppliers.name AS supplier_name,
		suppliers.contact_email AS supplier_contact_email
FROM inventory.stock
LEFT JOIN inventory.drugs ON drugs.drug_id = stock.drug_id
LEFT JOIN inventory.suppliers ON suppliers.drug_id = stock.drug_id
WHERE stock.quantity <= 1000;

-- 2. Supplier Value Report.