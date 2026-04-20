
# I use python script for automation cleaning step:
---

# Data Cleaning Script for Power BI (Python)

This script is designed to clean and preprocess a dataset inside Power BI using Python.

## Overview

The script performs the following steps:

- Standardizes column names
- Removes duplicate records
- Handles missing values
- Converts data types
- Removes outliers
- Cleans text fields

---

## Requirements

- Python 3.x
- pandas
- numpy

---

## Script

```python
import pandas as pd
import numpy as np

# Copy input dataset
df = dataset.copy()

# ----------------------------
# 1. Standardize column names
# ----------------------------
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
)

# ----------------------------
# 2. Remove duplicates
# ----------------------------
df = df.drop_duplicates()

# ----------------------------
# 3. Handle missing values
# ----------------------------
# Fill numeric columns with median
num_cols = df.select_dtypes(include=[np.number]).columns
df[num_cols] = df[num_cols].apply(lambda x: x.fillna(x.median()))

# Fill text columns with 'unknown'
cat_cols = df.select_dtypes(include=['object']).columns
df[cat_cols] = df[cat_cols].fillna('unknown')

# ----------------------------
# 4. Convert data types
# ----------------------------
# Try converting columns to datetime if possible
for col in df.columns:
    try:
        df[col] = pd.to_datetime(df[col])
    except:
        pass

# ----------------------------
# 5. Remove outliers (IQR method)
# ----------------------------
for col in num_cols:
    Q1 = df[col].quantile(0.25)
    Q3 = df[col].quantile(0.75)
    IQR = Q3 - Q1
    df = df[
        (df[col] >= Q1 - 1.5 * IQR) &
        (df[col] <= Q3 + 1.5 * IQR)
    ]

# ----------------------------
# 6. Trim text columns
# ----------------------------
for col in cat_cols:
    df[col] = df[col].str.strip()

# ----------------------------
# 7. Final cleaned dataset
# ----------------------------
df

```

# Now I have to run  by click on the checkmark,  then  expand value :
<img width="614" height="252" alt="image" src="https://github.com/user-attachments/assets/bc27c151-3a66-4185-b7ed-6e7721fcf392" />

<img width="1912" height="588" alt="image" src="https://github.com/user-attachments/assets/7b7deb56-24f2-4be9-a31f-426322636c89" />

## Steps in Power BI:
- Go to Power Query Editor
- In the right panel (Applied Steps) → select the step after:
- Expanded Value
-  Click fx (formula bar) to add a new step
-  Paste:
     - = Table.TransformColumnNames(#"Expanded Value", each Text.Replace(_, "Value.", ""))
 



