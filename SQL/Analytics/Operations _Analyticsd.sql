-- Employee Leaderboard (Role_specific KPI)
CREATE MATERIALIZED VIEW analytics.employee_leaderboard AS
SELECT
    e.name AS employee_name,
    e.role,
    COUNT(o.order_id) AS total_orders_handled,
    SUM(o.total_amount) AS total_sales_value
FROM operations.employees e
LEFT JOIN operations.orders o
    ON (
        (e.role = 'Pharmacist' AND o.prescribed_by = e.employee_id)
        OR
        (e.role = 'Dispatcher' AND o.dispatched_by = e.employee_id)
    )
GROUP BY e.name, e.role
ORDER BY total_sales_value DESC;