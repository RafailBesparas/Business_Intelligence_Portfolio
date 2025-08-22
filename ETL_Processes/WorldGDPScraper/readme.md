# 🌍 World GDP Scraper & ETL Pipeline – From Wikipedia to Database

This project demonstrates a complete **ETL pipeline** that extracts global **GDP data by country** from a historical snapshot of Wikipedia, transforms the raw figures into a clean format, and loads the results into both a **CSV file** and a **SQLite database**. The process is logged at each stage for full traceability and supports SQL querying to filter high-GDP nations.

---

## 📌 What This Project Does

### 🧾 1. Extract
- Scrapes a table of nominal GDP data from the [Wikipedia archive](https://web.archive.org/web/20230902185326/https://en.wikipedia.org/wiki/List_of_countries_by_GDP_%28nominal%29)
- Extracts:
  - Country names
  - GDP values in **USD millions**

### 🔁 2. Transform
- Converts GDP values:
  - From **millions** to **billions**
  - Cleans commas and handles missing values
- Renames the column for clarity (`GDP_USD_billions`)

### 💾 3. Load
- Saves the transformed data to:
  - `Countries_by_GDP.csv`
  - `World_Economies.db` SQLite database (`Countries_by_GDP` table)

### 🔍 4. Query
- SQL query runs on the database to retrieve countries with a **GDP ≥ 100 billion USD**
- Results are printed directly to the terminal

### 📝 5. Logging
- All steps are logged in `etl_project_log.txt` with timestamps:
  - Start/end of extraction
  - Start/end of transformation
  - Start/end of loading
  - SQL query execution

---

## 📁 Files in This Project

| File                     | Description                                          |
|--------------------------|------------------------------------------------------|
| `web_scraping.py`        | Main ETL script: extract, transform, load, query     |
| `Countries_by_GDP.csv`   | Final cleaned dataset with GDP in billions           |
| `World_Economies.db`     | SQLite database storing the transformed data         |
| `etl_project_log.txt`    | Log file with all ETL phase timestamps               |

---

## 🛠️ Technologies Used

| Library        | Purpose                             |
|----------------|-------------------------------------|
| `requests`     | Retrieve web content (HTML)         |
| `BeautifulSoup`| Parse HTML content from Wikipedia   |
| `pandas`       | Data transformation and CSV I/O     |
| `sqlite3`      | Lightweight embedded database        |
| `numpy`        | Mathematical operations              |
| `datetime`     | Timestamped logging                  |

---

## 🧪 How to Run

```bash
# Ensure all dependencies are installed
pip install requests beautifulsoup4 pandas numpy

# Run the ETL script
python web_scraping.py

# ✅ The output will be:
- A CSV file with country GDPs in billions
- A SQLite database table
- A printed SQL query showing countries with GDP ≥ 100B USD
- A log file tracking the process

# 🌐 Potential Use Cases
- Economic analytics for research
- Visualization-ready data for dashboards
- Data cleaning and enrichment for global finance tools
- Integration with machine learning pipelines

