# Superstore Sales & Profit Analytics (PostgreSQL + Power BI)

End-to-end analytics project using PostgreSQL (hosted on AWS RDS) and Power BI to analyze Superstore sales and profit from 2014–2017, with a focus on time-series trends, regional performance, and a deep dive into the West–Technology segment.

---

## 1. Tech Stack

- Database: PostgreSQL (AWS RDS)
- BI Tool: Power BI Desktop
- Language: SQL (PostgreSQL dialect)
- Dataset: Superstore orders (2014–2017)

---

## 2. Project Goals

- Build a clean, reusable SQL data model for Superstore orders.
- Analyze monthly and yearly sales and profit trends.
- Calculate profit margin and year-over-year (YoY) growth using window functions.
- Create interactive Power BI dashboards with:
  - Monthly overview
  - Yearly performance
  - Region & category comparison
  - Deep dive on West / Technology

---

## 3. SQL Data Model

All SQL scripts are in the [`sql/`](./sql) folder.

### 3.1 `superstore_clean` view

File: `01_create_superstore_clean_view.sql`

- Converts raw text dates to `DATE`:
  - `order_date_raw` → `order_date`
  - `ship_date_raw` → `ship_date`
- Casts numeric fields:
  - `sales` / `profit` as `numeric(12,2)`
  - `discount` as `numeric(5,2)`
  - `quantity` as `integer`
- Exposes cleaned columns for analysis.

### 3.2 Monthly overview

File: `02_create_superstore_monthly_overall_view.sql`

View: `superstore_monthly_overall`

- Aggregates at **month** level:
  - `monthly_sales`
  - `monthly_profit`
- Uses `date_trunc('month', order_date)` for time bucketing.

### 3.3 Monthly trends by region/category/segment

File: `03_create_superstore_monthly_trends_view.sql`

View: `superstore_monthly_trends`

- Grain: month × region × category × segment
- Metrics:
  - `total_sales`
  - `total_profit`
  - `total_quantity`
  - `avg_discount`
  - `profit_margin = SUM(profit) / NULLIF(SUM(sales), 0)`

### 3.4 Yearly summary with YoY growth

File: `04_create_superstore_yearly_summary_view.sql`

View: `superstore_yearly_summary`

- Aggregates by year:
  - `yearly_sales`
  - `yearly_profit`
- Computes YoY % growth using window functions:
  - `LAG(yearly_sales) OVER (ORDER BY year)`
  - `LAG(yearly_profit) OVER (ORDER BY year)`
  - Uses `NULLIF` to protect against division by zero.

---

## 4. Power BI Report

Power BI file: [`powerbi/SuperStore.pbix`](./powerbi/SuperStore.pbix)

### Pages

1. **Monthly Trends**
   - Line chart: monthly sales vs profit (2014–2017)
   - Region slicer
   - KPI cards:
     - Total sales
     - Total profit
     - Overall profit margin

2. **Yearly Performance**
   - Column chart: yearly sales by year
   - Line charts:
     - Year-over-year sales growth
     - Year-over-year profit growth

3. **Region & Category**
   - Bar chart: average profit margin by region
   - Clustered bar: total sales by category split by region
   - Time slicer for month range
   - Segment slicer (Consumer, Corporate, Home Office)

4. **Deep Dive – West x Technology**
   - Monthly sales trend for West / Technology
   - Monthly profit trend for West / Technology
   - Bar chart: top Technology sub-categories in West by sales and profit

Screenshots of each page are in the [`images/`](./images) folder.

---

## 5. How to Run This Project

1. **Set up PostgreSQL (local or AWS RDS).**
2. Create a database and load the Superstore orders dataset into a base table, e.g. `superstore_orders`.
3. Run the SQL scripts in this order:
   - `01_create_superstore_clean_view.sql`
   - `02_create_superstore_monthly_overall_view.sql`
   - `03_create_superstore_monthly_trends_view.sql`
   - `04_create_superstore_yearly_summary_view.sql`
4. Open `powerbi/SuperStore.pbix` in Power BI Desktop.
5. Update the PostgreSQL connection string to point to your database (server, database name, username, password).
6. Click **Refresh** in Power BI.

---

## 6. Key Learning Highlights

- Built a small SQL semantic layer using views for reusable analytics.
- Used date_trunc, EXTRACT, LAG and NULLIF for time-series and YoY logic.
- Designed interactive Power BI visuals to connect monthly trends, yearly growth, and segment-level deep dives.
- Deployed the data model on AWS RDS to simulate a production-like environment.

---

- LinkedIn post: [ADD LINK HERE]
