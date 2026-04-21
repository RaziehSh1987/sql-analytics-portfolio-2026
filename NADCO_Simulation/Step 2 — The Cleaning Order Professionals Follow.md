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
