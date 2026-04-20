
# I use python script for automation cleaning step:
---
## How to handle dates correctly (Power Query, not Python)
-  In Power Query:
-  Select your date column
-  Go to:
-  Transform → Data Type → Date
-   Or with M code:
-   = Table.TransformColumnTypes(#"Previous Step", {{"date", type date}})
  
## Data Cleaning Script for Power BI (Python)

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
# 'dataset' holds the input data for this script
import pandas as pd
import numpy as np

df = dataset.copy()

# Column names
df.columns = df.columns.astype(str).str.strip().str.lower().str.replace(" ", "_")

# Remove duplicates
df = df.drop_duplicates()

# Missing values
num_cols = df.select_dtypes(include=[np.number]).columns
df[num_cols] = df[num_cols].apply(lambda x: x.fillna(x.median()))

cat_cols = df.select_dtypes(include=['object']).columns
df[cat_cols] = df[cat_cols].fillna('unknown')

# ----------------------------
# 4. Clean text safely
# ----------------------------
for col in cat_cols:
    df[col] = df[col].astype(str).str.strip()

# ----------------------------
# Final output (IMPORTANT)
# ----------------------------
result = df.reset_index(drop=True)

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
 



