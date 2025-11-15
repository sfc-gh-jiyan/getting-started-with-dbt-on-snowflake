show warehouses;
CREATE WAREHOUSE tasty_bytes_dbt_wh WAREHOUSE_SIZE = XLARGE;

--Create a database and schema for integrations and model materializations
CREATE DATABASE tasty_bytes_dbt_db;
CREATE SCHEMA tasty_bytes_dbt_db.integrations;
CREATE SCHEMA tasty_bytes_dbt_db.dev;
CREATE SCHEMA tasty_bytes_dbt_db.prod;

-- Create an API integration in Snowflake for connecting to GitHub
show API INTEGRATIONs;
desc  API INTEGRATION MY_GITHUB_API_INTEGRATION;
-- CREATE OR REPLACE API INTEGRATION tb_dbt_git_api_integration
-- API_PROVIDER = git_https_api
-- API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-jiyan/getting-started-with-dbt-on-snowflake.git')
-- ENABLED = TRUE;


-- Reuse API integration MY_GITHUB_API_INTEGRATION
-- EXTERNAL ACCESS INTEGRATION: security.integrations.dbt_ext_access

-- Create NETWORK RULE for external access integration
use sechema security.integrations;
drop NETWORK RULE dbt_network_rule;

CREATE OR REPLACE NETWORK RULE dbt_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  -- Minimal URL allowlist that is required for dbt deps
  VALUE_LIST = (
    'hub.getdbt.com',
    'codeload.github.com'
    );

-- Create EXTERNAL ACCESS INTEGRATION for dbt access to external dbt package locations

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION dbt_ext_access
  ALLOWED_NETWORK_RULES = (dbt_network_rule)
  ENABLED = TRUE;