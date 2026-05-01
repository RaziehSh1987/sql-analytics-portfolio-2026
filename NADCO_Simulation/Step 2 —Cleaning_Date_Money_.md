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
## I convert Date columns to these columns (for year,month , season) and also kept the original Date column:
<img width="1892" height="651" alt="image" src="https://github.com/user-attachments/assets/bb17e9bb-b043-4d12-8257-9ee4deb4deb2" />


## ## Handling Money Column in Power Query(M)
<img width="858" height="375" alt="image" src="https://github.com/user-attachments/assets/00f46c52-3ddf-4710-ba38-4c457a4364b9" />
<img width="869" height="423" alt="image" src="https://github.com/user-attachments/assets/b4fb1e42-0241-4c28-90b8-e9094bf8109d" />


- 💰 Convert Currency Text to Number in Power Query (M)
<img width="603" height="271" alt="image" src="https://github.com/user-attachments/assets/799d0bb5-9d7d-43dd-9ab9-d72c1fe77689" />
- If we want to do on 2 column we can write like these:
<img width="430" height="345" alt="image" src="https://github.com/user-attachments/assets/e1cbdf9f-9444-48eb-b6d3-8891c0387f1f" />

### 🎯 Goal
Convert values like:
```

"$5,800.00"

```
into:
```

5800

````

---

## ✅ M Code
```m
= Table.TransformColumns(#"Previous Step", {
    {"total_revenue", each 
        Number.FromText(
            Text.Replace(
                Text.Replace(Text.From(_), "$", ""), 
            ",", "")
        ), 
    type number}
})
````

---

## 🧠 How It Works

| Step | Function                     | Purpose              |
| ---- | ---------------------------- | -------------------- |
| 1    | `Text.From(_)`               | Ensure value is text |
| 2    | `Text.Replace(..., "$", "")` | Remove `$`           |
| 3    | `Text.Replace(..., ",", "")` | Remove commas        |
| 4    | `Number.FromText(...)`       | Convert to number    |

---

## 🔄 Example

```
"$5,800.00" → "5800.00" → 5800
```

---

## ⚠️ Important

* Use this **only if your column is text**
* If already numeric → ❌ this step is unnecessary and may cause errors

---

## 🧩 Function Used

```m
Table.TransformColumns(...)
```

Applies transformation to each value in the column and sets final type to `number`

---

## 🚀 Tip (Better Approach)

If your data is well-formatted, use locale instead:

```m
= Table.TransformColumnTypes(#"Previous Step", {
    {"total_revenue", type number}
}, "en-CA")
```

✔ Cleaner
✔ More efficient
✔ Preferred in production

```
```
## 💰 Fix Money Columns in Python (Pandas)

### 🎯 Goal
Clean currency values (e.g., `$5,800`, `CAD 49.99`) and convert them to numeric format for analysis.

---

## ✅ Python Code

```python
import pandas as pd
import numpy as np

df = pd.read_csv('kit_sales.csv')

# Clean money values
def clean_money(val):
    if pd.isnull(val):
        return np.nan
    cleaned = str(val).replace('$','').replace(',','').replace('CAD','').strip()
    try:
        return round(float(cleaned), 2)
    except:
        return np.nan

df['total_revenue'] = df['total_revenue'].apply(clean_money)
df['unit_price'] = df['unit_price'].apply(clean_money)
```

## 🔍 Business Rule Validation

```python
df['revenue_check'] = np.where(
    abs(df['total_revenue'] - df['quantity'] * df['unit_price']) > 0.02,
    'MISMATCH',
    'OK'
)

mismatches = df[df['revenue_check'] == 'MISMATCH']
print(f"{len(mismatches)} revenue mismatches found")
```

---

## 🔁 Transaction Type Flag

```python
df['transaction_type'] = np.where(
    df['total_revenue'] < 0,
    'Refund',
    'Sale'
)
```

---

## 🎯 What This Does

* Removes `$`, `,`, and `CAD` from currency values
* Converts cleaned values to `float`
* Validates business logic:

  ```
  total_revenue ≈ quantity × unit_price
  ```
* Flags mismatches for investigation
* Identifies refunds (negative revenue)

---

## ⚠️ Best Practices

* Do not delete mismatches → investigate them
* Always validate financial data after cleaning
* Use tolerance (e.g., `0.02`) for rounding differences

```
```
<img width="1194" height="132" alt="image" src="https://github.com/user-attachments/assets/d4705c74-c095-4c40-a81a-8e74c065b4a7" />
<img width="864" height="207" alt="image" src="https://github.com/user-attachments/assets/d1678a66-c13f-4e61-ae7a-f885d53636b2" />

- change data type to Fixed Decimal number:
- <img width="665" height="182" alt="image" src="https://github.com/user-attachments/assets/b38682e3-c4bd-45e7-b8e0-95f3e28ad26e" />



# Text & IDs — Cleaning
- we do these steps on all text columns

<img width="776" height="288" alt="image" src="https://github.com/user-attachments/assets/45c6e64e-aaa5-4493-9ff1-1c0c135df090" />


## Power Query (M) — Apply `Text.Trim` to Multiple Columns by Index

```m
= Table.TransformColumns(
    #"Custom1",
    List.Transform(
        {1,3,5},
        each { Table.ColumnNames(#"Custom1"){_}, Text.Trim }
    )
)
````

## Explanation

* `{1,3,5}` → list of column indexes (zero-based)
* `Table.ColumnNames(#"Custom1"){_}` → converts each index to its corresponding column name
* `List.Transform(...)` → builds transformation rules like `{"ColumnName", Text.Trim}`
* `Table.TransformColumns` → applies `Text.Trim` to each selected column

## Notes

* Indexes are **zero-based**:

  * `0` = first column
  * `1` = second column
* Ensure indexes exist to avoid errors
* Useful when column names are dynamic but positions are fixed

```
```
<img width="1662" height="575" alt="image" src="https://github.com/user-attachments/assets/5f34ba19-6fab-49ba-a41d-8da7fee11f15" />



