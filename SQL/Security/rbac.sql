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


-- Assignment 1: Grant the Data Engineering Role Read-Only access to all tables in the research schema in the next
GRANT SELECT ON ALL TABLES IN SCHEMA research TO data_engineer_role;

-- Assignment 2: Grant the researcher role full read/write access to the research schema and read access to the drugs table.
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA research TO researcher_role;
GRANT SELECT ON TABLE inventory.drugs TO data_engineer_role;

-- Assignment 3: We just onboarded 4 new team members in LZ Pharma (Crainsor, Temitayo, Vincent, Anthony).
-- Anthony was onboarded as a Database Administrator, Vincent was onboarded as a researcher,
-- Temitayo was onboarded as a Business Analyst, and Crainsor was onboarded as a data engineer.
-- Using the information given, create and grant user permissions based on their appropriate roles.

CREATE ROLE database_admin_role NOLOGIN;
CREATE ROLE business_analyst_role NOLOGIN;

-- Database administrator permission
GRANT ALL PRIVILEGES ON SCHEMA analytics, inventory, operations, research TO database_admin_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA analytics, inventory, operations, research TO database_admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA analytics, inventory, operations, research TO database_admin_role;

-- Business analyst permission
GRANT USAGE ON SCHEMA analytics, operations, inventory TO business_analyst_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA analytics TO business_analyst_role;
GRANT SELECT ON ALL TABLES IN SCHEMA operations, inventory TO business_analyst_role;

-- Create the users
CREATE USER Anthony WITH PASSWORD 'omk*#123';  -- DBA
CREATE USER Vincent with password '*moh492#';  -- RES
CREATE USER Temitayo WITH PASSWORD 'Ace@123';  -- BA
CREATE USER Crainsor with password '*moh492#';  -- DE

-- Grant permission to users based on their roles
GRANT database_admin_role TO Anthony;
Grant researcher_role TO Vincent;
GRANT business_analyst_role TO Temitayo;
Grant data_engineer_role TO Crainsor;

