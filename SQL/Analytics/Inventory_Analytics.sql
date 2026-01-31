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
CREATE VIEW analytics.supplier_value_report AS
SELECT
    s.name AS supplier_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS revenue_rank
FROM inventory.suppliers s
JOIN inventory.drugs d ON s.supplier_id = supplier_id
JOIN operations.orders o ON o.drug_id = d.drug_id
GROUP BY s.name
ORDER BY total_revenue DESC;