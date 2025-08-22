# 🧪 Multi-Format ETL Pipeline: Normalize, Transform & Log

This project implements a robust **Extract-Transform-Load (ETL)** pipeline using **Python**, capable of reading data from **CSV**, **JSON**, and **XML** files. It automatically processes files in the working directory, **normalizes measurements**, and **logs the entire process** — making it perfect for scalable and traceable data ingestion.

---

## 🔍 What It Does

### 🔹 Extract
- Automatically locates and reads structured data from:
  - `.csv` files using `pandas`
  - `.json` files (line-by-line format)
  - `.xml` files via `ElementTree`
- Extracts fields: `name`, `height` (inches), and `weight` (pounds)

### 🔹 Transform
- Converts:
  - `height` from inches to meters (× 0.0254)
  - `weight` from pounds to kilograms (× 0.45359237)
- Rounds all values to 2 decimal places for consistency

### 🔹 Load
- Saves the cleaned and unified data into:
  - `transformed_data.csv`

### 📝 Logging
- Tracks ETL job phases in `log_file.txt`
- Includes timestamps for every step (start/end of extraction, transformation, and loading)

---

## 🧠 Key Features

- ✅ **Multi-Format Support**: Works with CSV, JSON, and XML data files
- 🧼 **Standardization**: Transforms imperial units to metric system
- 🛠️ **Automation**: Auto-detects and processes all relevant files in the directory
- 📓 **Logging**: Maintains a log of all ETL steps and their timestamps
- 🧩 **Modular Code**: Easy to extend or adapt to new formats and schemas

---

## 🧰 Technologies Used
- Python
- pandas
- glob
- xml.etree.ElementTree
- datetime

# 🧪 Example Use Cases
- Preprocessing multi-source data for ML pipelines
- Normalizing health or biometric data before analysis
- Integrating raw datasets into a single standardized output


## 🗂️ Project Files

| File | Description |
|------|-------------|
| `etl_code.py` | Full ETL pipeline code |
| `source1.csv/json/xml` | Sample source files |
| `transformed_data.csv` | Output file containing normalized and cleaned data |
| `log_file.txt` | Execution log with timestamps |

---

## 💾 Output Format

### 📄 `transformed_data.csv`
```csv
name,height,weight
jack,1.75,55.94
tom,1.77,64.17
tracy,1.78,61.90
john,1.72,50.96
...
