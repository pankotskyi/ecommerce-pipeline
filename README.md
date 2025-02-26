# E-commerce Data Pipeline Project

## Overview

This project demonstrates a data pipeline that extracts data from a FakeStoreAPI, transforms it into a star schema, and loads it into PostgreSQL for analysis.

## Project Components

- Data Extraction: SAS scripts to fetch data from FakeStoreAPI
- Data Transformation: Creating a star schema with fact and dimension tables
- Data Loading: Storing the processed data in PostgreSQL
- Data Visualization: Analyzing the data with Power BI

## Files

- `01_ingest_transform.sas`: Extracts data from API and transforms it into a star schema
- `02_load_postgres.sas`: Loads data into PostgreSQL database

## Data Model

The project uses a star schema with:

- Fact table: sales_fact
- Dimension tables: dim_product, dim_user, dim_date

## Visualization

The data is visualized in Power BI to show:

- Sales by product category
- Top customers
- Top-selling products
