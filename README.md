# SQL Practice Portfolio

A structured collection of SQL exercises built from scratch, covering querying, database engineering and data systems. Each folder progresses in complexity — from foundational queries to production-level patterns like ETL pipelines, triggers and transaction management.

All exercises use **PostgreSQL** and include schema files to run them locally.

---

## Structure

```
sql-practice/
├── 01_querying_basics/
├── 02_advanced_querying/
├── 03_database_engineering/
└── 04_data_engineering_systems/
```

---

## 01 — Querying Basics

Foundational SQL querying across five topic areas:

- **CASE WHEN / Conditional Logic** — salary classification, performance levels, bonus eligibility using multi-condition logic
- **Advanced Data Types** — querying JSONB, arrays and boolean fields; filtering by nested preferences and skills
- **Date & Time Functions** — PostgreSQL datetime functions applied to energy consumption data
- **Sequences & Identity** — SERIAL columns, manual sequences, NEXTVAL / CURRVAL / SETVAL
- **SQL Functions** — reusable functions for name formatting, sales filtering, pagination and exception handling

---

## 02 — Advanced Querying

Complex querying patterns used in real analytics and data workflows:

- **Window Functions** — ROW_NUMBER, RANK, running totals, moving averages, partition-level comparisons
- **CTEs** — multi-step analysis for HR, finance and order data; chained CTEs for overpaid/underpaid employee detection
- **Recursive CTEs** — employee hierarchy traversal (ancestors and descendants), folder tree with path-based ordering, depth-limited hierarchies
- **Advanced JOINs** — self-joins for manager relationships, co-worker detection, latest salary with performance reviews
- **Analytics Queries** — monthly revenue, MoM growth, cumulative spend, rolling 30-day revenue, customer ranking and segmentation
- **Upserts & MERGE** — ON CONFLICT patterns for login sync, score tracking, inventory updates and API key rotation
- **Partitioning** — range and list partitions by year, country, status and amount; multi-level partitions for reporting; partition pruning for bulk deletes

---

## 03 — Database Engineering

Internals and performance:

- **Normalisation** — identifying violations, functional dependencies, step-by-step normalisation to 3NF, transitive dependencies, denormalisation trade-offs
- **Indexes** — unique indexes for login lookups, time-series dashboards, pagination, partial indexes for soft deletes, composite vs covering indexes for analytics
- **EXPLAIN ANALYZE** — scan types, primary key vs index performance, join strategies, hash joins, bitmap vs index scans
- **Views** — window function views for latest salary rows, CHECK OPTION (LOCAL and CASCADED)
- **Materialized Views** — monthly snapshots, daily aggregation tables, time-window optimisation, concurrent refresh strategies

---

## 04 — Data Engineering Systems

Production-level patterns:

- **ETL Pipelines** — skill normalisation, sales aggregation, address upserts, monthly summaries, historical price tracking
- **Transactions & ACID** — atomic borrow/return operations, rollback on constraint violation, multi-step atomic updates, isolation levels (READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ), deadlock simulation and detection
- **Triggers** — AFTER INSERT logging, BEFORE INSERT data transformation (uppercase enforcement), AFTER UPDATE change tracking, AFTER DELETE audit trail, statement-level triggers, BEFORE INSERT/UPDATE validation with RAISE EXCEPTION
- **Security & Permissions** — role setup, column-level access control, basic Row-Level Security (RLS), dynamic RLS policies, RLS with CHECK constraints

---

## How to run

Each folder contains a `*_schema.sql` file. Run that first to set up the tables and seed data, then run individual exercise files in order.

```sql
-- Example
\i transactions_acid/library_schema.sql
\i transactions_acid/01_basic_transaction_borrow.sql
```

---

## Skills demonstrated

`SQL` · `PostgreSQL` · `Window Functions` · `CTEs` · `Recursive Queries` · `Indexes` · `Query Optimisation` · `EXPLAIN ANALYZE` · `Transactions` · `ACID` · `Triggers` · `ETL` · `Row-Level Security` · `Partitioning` · `Materialized Views`