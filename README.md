# formula1-data-warehouse-DQC-project
Building a DWH with SQL server on a formula 1 dataset focusing on the quality checks, including etl processes.

A SQL Server data warehouse built on the [Formula 1 World Championship (1950–2024)](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020) dataset,
with a strong focus on **data quality (DQ) checks** and ETL design — built using the Medallion Architecture (Bronze → Silver → Gold).

## Why this project
 
This project combines two goals:
1. Build a working data warehouse with a star schema (fact/dimension tables).
2. Apply a structured data quality framework based on low-level functionalities and dimensions defined in:
   > Papastergios, V., Ehrlinger, L., & Gounaris, A. (2025). *Unfolding Data Quality Dimensions in Practice: A Survey*.
Each DQ check implemented here is mapped to a specific functionality (e.g. `f-19` — missing elements check) and a specific ISO/IEC 25012 dimension (accuracy, completeness, consistency, currentness, accessibility, compliance).



## Architecture
 
```
Bronze (raw)  →  Silver (cleaned + DQ checks)  →  Gold (reporting + DQ score)
```
 
- **Bronze** — raw CSV data loaded as-is (all columns as VARCHAR/NVARCHAR), no cleaning, no type conversion. Serves as the untouched baseline.
- **Silver** — cleaned, standardized data. Each cleaning step is paired with a DQ check logged to `silver.dq_log`, capturing before/after results.
- **Gold** — business-ready views (star schema) plus a DQ summary and quality score per table/dimension.




## Dataset
 
Source tables used: `drivers`, `constructors`, `circuits`, `races`, `results`.
 
Known data quality issues in the raw data:
- Missing values represented as the literal string `\N` instead of NULL
- Inconsistent timestamp formats across different seasons
- Non-ASCII characters in driver names/URLs (encoding considerations)
- Historical inconsistencies in constructor names over time


## Data Quality Checks
 
Implemented functionalities (see `/sql/silver/` for individual scripts), each logged with its functionality ID and ISO/IEC 25012 dimension:
 
| ID | Check | Dimension(s) |
|----|-------|---------------|
| f-01 | Values fall within range/set | accuracy, compliance |
| f-02 | String length validation | accuracy, compliance |
| f-19 | Missing values detection | completeness, accuracy, accessibility |
| f-17 | Duplicate/unique elements | completeness, consistency |
| f-05/f-06 | Row-level comparisons | accuracy, consistency |
| f-11 | Matching between tables (FK integrity) | accuracy, completeness, consistency |
| f-09/f-10 | Schema conformance | completeness, accessibility |
 
All findings are logged to `silver.dq_log` with table, column, functionality, dimension, layer, and result count.



## Tech Stack
 
- SQL Server / T-SQL
- SSMS (SQL Server Management Studio)
