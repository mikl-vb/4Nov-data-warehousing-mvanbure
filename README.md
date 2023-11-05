# cmu-95797-23m2

## Homework 1
* sql/ingest.sql: ingest all data
* sql/dump_raw_schemas.sql: print out all table names & schemas
* put .echo on as your first line
* answers/raw_counts.txt: result of running dump_raw_counts.py
* answers/raw_schemas.txt: result of running dump_raw schemas.sql

## Homework 2
* initialize a dbt project
* add a dbt connection profile for duckdb database
* install dbt packages, specifically dbt-codegen
* add ingested raw data as dbt sources using dbt-codegen
* create staging models with cleaned data