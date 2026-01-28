-- Role Based Access Control
-- Create Roles
CREATE ROLE data_engineer_role NOLOGIN;
CREATE ROLE data_analyst_role NOLOGIN;
CREATE ROLE admin_role NOLOGIN;
CREATE ROLE researcher_role NOLOGIN;

-- Grant permission to the roles
-- Data engineering role permission: full read/write on the operations and inventory schema
GRANT USAGE ON SCHEMA operations, inventory TO data_engineer_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA operations, inventory TO data_engineer_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA operations, inventory TO data_engineer_role;

-- Data Analyst Permission: Full access to the analytics schema and read-only access on operations, inventory.
GRANT USAGE ON SCHEMA analytics, operations, inventory TO data_analyst_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA analytics TO data_analyst_role;
GRANT SELECT ON ALL TABLES IN SCHEMA operations, inventory TO data_analyst_role;
REVOKE SELECT ON operations.customers FROM data_analyst_role;

-- Admin role: full access to all SCHEMAS
GRANT ALL PRIVILEGES ON SCHEMA analytics, inventory, operations, research TO admin_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA analytics, inventory, operations, research TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA analytics, inventory, operations, research TO admin_role;

-- Create the users
CREATE USER Chinyere WITH PASSWORD 'omk*#123';  -- DE
CREATE USER mOHAMMED with password '*moh492#';  -- DA
create user Kolawole WITH PASSWORD 'Ace@123';  -- DA

-- Grant permission to users based on their roles
GRANT data_engineer_role TO Chinyere;
Grant data_analyst_role TO Mohammed, KOLAWOLE;