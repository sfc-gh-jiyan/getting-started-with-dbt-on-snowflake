SHOW TABLES IN DATABASE tasty_bytes_dbt_db;

SHOW VIEWS IN DATABASE tasty_bytes_dbt_db;

-- Fixed this issue by adding this new repository.
-- Failed to push to Git: Failed to access the Git Repository. Operation push is not permitted by server for origin 'https://github.com/sfc-gh-jiyan/getting-started-with-dbt-on-snowflake.git'.

SHOW DBT PROJECTS in database TASTY_BYTES_DBT_DB;

CREATE OR REPLACE TASK tasty_bytes_dbt_db.dev.run_prepped_data_dbt
        WAREHOUSE=tasty_bytes_dbt_wh
        SCHEDULE ='USING CRON 1 * * * * America/Los_Angeles'
      AS
  EXECUTE DBT PROJECT tasty_bytes_dbt_project ARGS='run --select customer_loyalty_metrics --target dev';

show tasks in database tasty_bytes_dbt_db;
drop TASK tasty_bytes_dbt_db.dev.run_prepped_data_dbt;

-- have not been run.
DROP WAREHOUSE IF EXISTS tasty_bytes_dbt_wh;
DROP DATABASE IF EXISTS tasty_bytes_dbt_db;
DROP DATABASE IF EXISTS tb_101;
