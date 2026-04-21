
## Data cleaning — state of the art guide

# 🧹 The Golden Rule of Data Cleaning

## 📌 Read This First
Never clean data in **Excel** or in the **original file**.  

- Always clean in:
  - **Power Query** → if your destination is **Power BI**
  - **Python (Pandas)** → if you need **reusable, automated pipelines**

💡 Every step in Power Query is recorded as a script and **automatically replays on refresh**.

### 🔹 For NADCo
- Use **Power Query** for the 5 CSV files inside Power BI  
- Use **Python** when:
  - You want full pipeline automation  
  - Data comes from APIs or databases  

---

## 🔍 Step 1 — Profile Your Data First, Clean Second

Before changing anything, **analyze your data profile**.

### 📊 In Power Query
Go to:
> **View tab → Enable:**
- Column Quality  
- Column Distribution  
- Column Profile  

This helps you identify:

- ✅ % of nulls per column  
- ✅ Min, max, average values (quickly detect outliers)  
- ✅ Unique value count  
  - ⚠️ Example: a date column with only 1 unique value = problem  
- ✅ Data type mismatches  

---

### 🐍 In Python (Pandas)

```python
import pandas as pd

df = pd.read_csv('kit_sales.csv')

# Full profile in a few lines
print(df.info())          # data types + null counts
print(df.describe())      # statistics (min, max, mean, etc.)
print(df.isnull().sum())  # nulls per column
print(df.duplicated().sum())  # duplicate row count
```

<img width="515" height="793" alt="image" src="https://github.com/user-attachments/assets/ed861c9e-9cb7-49a8-bb76-4ce13300a451" />
