
# I use python script for automation cleaning step:
---

##  'dataset' holds the input data for this script

import pandas as pd
- 1. Install pandas in the correct Python (Most Important)
    - Open Command Prompt as Administrator and run these commands one by one:
    - cmdcd C:\Users\razieh\AppData\Local\Programs\Python\Python38\Scripts

        - pip install pandas
        - pip install numpy
- 2. Set the correct Python path in Power BI
    - In Power BI Desktop, go to:
    - File → Options and settings → Options

    - On the left, select Python scripting
    - Under "Python home directory", browse and select this folder:
    - C:\Users\razieh\AppData\Local\Programs\Python\Python38
    - Click OK

- 3. Restart Power BI
    - Close and reopen Power BI completely.
- 4. Try running the Python script again

## ====================== AUTOMATIC DATA CLEANING ======================

df = dataset.copy()

## 1. Remove duplicate rows
df = df.drop_duplicates()

## 2. Strip whitespace from all string columns
string_cols = df.select_dtypes(include=['object']).columns
df[string_cols] = df[string_cols].apply(lambda x: x.str.strip())

## 3. Convert column names to clean format (lowercase + underscore)
df.columns = [col.strip().lower().replace(" ", "_").replace("-", "_") for col in df.columns]

## 4. Auto-detect and convert data types
for col in df.columns:
    # Try converting to datetime
    if df[col].dtype == 'object':
        try:
            df[col] = pd.to_datetime(df[col], errors='ignore')
        except:
            pass
    
    #Try converting to numeric
    if df[col].dtype == 'object':
        df[col] = pd.to_numeric(df[col], errors='ignore')

## 5. Handle missing values
for col in df.columns:
    if df[col].dtype in ['int64', 'float64']:
        #Fill numeric columns with median
        df[col] = df[col].fillna(df[col].median())
    elif df[col].dtype == 'object':
        #Fill text columns with "Unknown"
        df[col] = df[col].fillna("Unknown")
    elif pd.api.types.is_datetime64_any_dtype(df[col]):
        #Fill date columns with the most common date
        df[col] = df[col].fillna(df[col].mode()[0])

## 6. Optional: Add useful calculated columns (customize as needed)
if 'order_date' in df.columns:
    df['year'] = df['order_date'].dt.year
    df['month'] = df['order_date'].dt.month
    df['quarter'] = df['order_date'].dt.quarter

if 'quantity' in df.columns and 'unit_price' in df.columns:
    df['total_amount'] = df['quantity'] * df['unit_price']

## ====================== OUTPUT ======================
dataset = df

print("✅ Data cleaning completed successfully!")
print(f"Shape after cleaning: {df.shape}")
print("\nColumns:", df.columns.tolist())
