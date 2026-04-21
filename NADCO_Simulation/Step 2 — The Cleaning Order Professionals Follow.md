## 🧹 Step 2 — The Cleaning Order Professionals Follow

Follow this exact order to avoid breaking your data and to ensure consistency:

### 1️⃣ Fix Data Types
- Convert fields to correct types:
  - Dates → Date format  
  - Numbers → Numeric (not text)
  - Money → Fixed Decimal Number
  - Converting Text Column to Boolean (True/False) in Power Query:
      - When your column contains text values like `"0"` and `"1"`, you should explicitly map them to boolean values (`false` / `true`).
```m
= Table.TransformColumns(#"Changed Type1", {
    {"is_future", each 
        if _ = "0" then false 
        else if _ = "1" then true 
        else null, 
    type logical}
})
```
- Prevents calculation and aggregation errors  

---

### 2️⃣ Handle Nulls
- Decide for each column:
  - **Drop** → if data is not useful  
  - **Fill** → mean, median, or default value  
  - **Flag** → create indicator column for missing data  

---

### 3️⃣ Remove Duplicates
- Start with:
  - **Exact duplicates**  
- Then:
  - **Fuzzy duplicates** (similar but not identical records)  

---

### 4️⃣ Standardize Text
- Clean and unify text fields:
  - Trim spaces  
  - Fix casing (e.g., "Vancouver" vs "vancouver")  
  - Standardize naming conventions  

---

### 5️⃣ Fix Outliers
- **Investigate first**, don’t blindly remove  
- Ask:
  - Is this a real business event?  
  - Or a data error?  

---

### 6️⃣ Validate Business Rules
- Check logical consistency:
  - `total_revenue = quantity × unit_price`  
- Identify mismatches early  

---

### 7️⃣ Add Derived Columns
- Create useful analytical fields:
  - Month name  
  - Season  
  - Fiscal quarter  
  - Year  

---

## 🎯 Key Takeaway
👉 Cleaning is not random — it’s a **structured process**  
👉 Wrong order = broken data models  


## 📅 Handling Dates in Power Query & Python

---

## 🧩 Method 1 — Change Type Directly
- Click the column header icon (**ABC**) → select **Date**
- If Power Query correctly detects the format → you're done

---

## 🌍 Method 2 — Using Locale (for ambiguous formats)
When formats are unclear (e.g., `01/02/2024` → Jan 2 or Feb 1):

- Go to:
  > Home → Transform → Data Type → **Using Locale**

- Then:
  - Data Type → **Date**
  - Locale → **English (Canada)** (for `YYYY-MM-DD`)

---

## 🛠️ Method 3 — Custom M Code (Mixed Formats)

```m
// In Power Query Advanced Editor
Date.FromText([date], [Format="yyyy-MM-dd", Culture="en-CA"])
```
---

## ➕ Add Derived Date Columns (Power Query)

### Year

```m
= Date.Year([date])
```

### Month Name

```m
= Date.ToText([date], "MMM yyyy")
```

### Season

```m
= if Date.Month([date]) >= 6 and Date.Month([date]) <= 8
then "Summer" else "School Year"
```

### Day of Week

```m
= Date.DayOfWeekName([date])
```

---

## 🐍 Fix Dates in Python (Pandas)

```python
import pandas as pd

df = pd.read_csv('kit_sales.csv')

# Parse dates (fast inference)
df['date'] = pd.to_datetime(df['date'], infer_datetime_format=True)

# Handle mixed/invalid formats
df['date'] = pd.to_datetime(df['date'], errors='coerce')

# Check parsing failures
print(df['date'].isnull().sum(), "dates could not be parsed")

# Derived columns
df['year'] = df['date'].dt.year
df['month_num'] = df['date'].dt.month
df['month_name'] = df['date'].dt.strftime('%b %Y')
df['quarter'] = df['date'].dt.quarter
df['day_name'] = df['date'].dt.day_name()

df['season'] = df['month_num'].apply(
    lambda m: 'Summer' if 6 <= m <= 8 else 'School Year'
)
```

---

## ⚠️ Always Validate

```python
df['date'].dtype
```

* ✅ Should be: `datetime64[ns]`
* ❌ If it shows: `object` → parsing failed

---

## 🎯 Key Takeaways

* Always handle ambiguous date formats explicitly
* Use locale-aware parsing when needed
* Validate your data types after transformation
* Create derived date features for better analysis

```
```

