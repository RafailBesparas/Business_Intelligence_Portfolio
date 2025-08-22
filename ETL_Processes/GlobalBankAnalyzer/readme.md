# 🏦 Global Bank Analyzer: Web Scraping & ETL with Python

This project implements an **end-to-end ETL pipeline** that scrapes a historical Wikipedia page listing the **world’s largest banks**, enriches that data with live exchange rates, and loads it into both a **CSV file** and a **SQLite database**. It also supports SQL-based querying and includes logging for every ETL stage.

---

## Use Cases
- Financial data exploration and enrichment
- Web scraping with structured data pipelines
- Currency conversion and data normalization
- Lightweight financial analytics via SQL

## 🌐 Data Sources

1. 📄 **Wikipedia (Archived)** – [List of Largest Banks](https://web.archive.org/web/20230908091635/https://en.wikipedia.org/wiki/List_of_largest_banks)  
2. 📊 **Exchange Rates** – [`exchange_rate.csv`](./exchange_rate.csv)

---

## 🔧 Features & Workflow

### ✅ 1. **Data Extraction**
- Web scraping the second table from the Wikipedia page using **BeautifulSoup**.
- Captures bank name and market capitalization in USD (converted to billions).

### 🔁 2. **Data Transformation**
- Reads exchange rates from a CSV file.
- Converts market capitalization into:
  - GBP (British Pounds)
  - EUR (Euros)
  - INR (Indian Rupees)
- Rounds all values to two decimal places.

### 💾 3. **Data Loading**
- Saves the processed dataset to:
  - A CSV file: `Largest_banks_data.csv`
  - A SQLite database: `Banks.db` under the table `Largest_Banks`

### 🔎 4. **SQL Queries**
- Returns all bank records.
- Calculates the **average GBP market cap**.
- Lists the **top 10 banks** by USD market cap.

### 🧠 5. **Logging**
- Every ETL stage is logged with timestamps in `code_log.txt`.

---

## 📁 Project Structure

| File | Description |
|------|-------------|
| `banks_project.py` | Main Python script containing the full ETL and query logic |
| `exchange_rate.csv` | CSV file containing exchange rates (USD to GBP, EUR, INR) |
| `Largest_banks_data.csv` | Output file with processed bank data |
| `Banks.db` | SQLite database file with the final table |
| `code_log.txt` | Timestamped log of all ETL stages |

---

## 🛠️ Technologies Used

- `requests`, `BeautifulSoup` – Web scraping
- `pandas`, `numpy` – Data cleaning and transformation
- `sqlite3` – Lightweight database for storage and querying
- `datetime` – Timestamped logging

---

## 🚀 How to Run the Project

```bash
# Clone the repository or download the files
python banks_project.py

# The script will:
- Scrape the bank data
- Transform currency values using exchange rates
- Save the results to CSV and SQLite
- Print SQL query results in the terminal
- Log progress in code_log.txt


