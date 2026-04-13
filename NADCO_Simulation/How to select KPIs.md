


# 📊 Power BI & KPI Design Cheat Sheet

## 🧠 1. Core Principle: Think Before Clicking

Before writing any DAX or building visuals:

1. Understand the business
2. Define KPIs
3. Map the data

👉 BI is not about charts — it's about decisions.

---

## 🎯 2. What is a KPI?

A KPI is:

> A number that drives a decision.

❌ Bad KPI:
- Total rows in database

✅ Good KPI:
- Inventory Fill Rate → "Do we have enough stock?"

---

## 🧠 3. KPI Selection Framework (MOST IMPORTANT)

For every KPI, define:

- What does it measure?
- Who uses it?
- What decision/action does it trigger?
- How often is it needed?

👉 If it does NOT trigger a decision → it is NOT a KPI

---

## 🚫 Common Mistake

❌ Just showing numbers:
- Enrollment count
- Row count
- Clicks

👉 These do NOT drive decisions

---

## ✅ Professional Thinking

Instead of:
- "How many users?"

Think:
- "Which product is profitable?"

---

## 📦 4. KPI Categories (NADCo Example)

### 1. Sales KPIs
- Total units sold
- Revenue by channel
- Top SKU by volume  
👉 Decision: Promotion / pricing

---

### 2. Course KPIs
- Enrollment count
- Capacity utilization
- Summer vs school split  
👉 Decision: Hire instructors

---

### 3. Inventory KPIs
- Fill rate
- Days of stock
- SKUs below reorder point  
👉 Decision: Purchase orders

---

### 4. Forecast KPIs
- Predicted demand (LSTM)
- Actual vs forecast
- Confidence interval  
👉 Decision: Strategic planning

---

## ⚖️ Why 4 Categories?

- Matches business functions
- Each drives a decision
- Keeps dashboard simple

Rule:
- <3 → incomplete
- >5 → confusing

---

## 📊 5. Dashboard Design Rules

### 🔹 Rule 1: Do NOT overload one page
- Max: 4–6 KPIs per page

---

### 🔹 Rule 2: Separate pages by audience

Example:

- Page 1 → Executive (high-level KPIs)
- Page 2 → Sales (Revenue by SKU)
- Page 3 → Operations
- Page 4 → Inventory (Stock vs Forecast)

---

### 🔹 Rule 3: One dataset, multiple views

- Use shared SKU dimension
- Sync slicers across pages

👉 One data model → multiple perspectives

---

### 🔹 Rule 4: Use Drillthrough

- Executive view → click → detailed view

---

## 🔗 6. Data Modeling Insight

- One shared SKU dimension drives all views
- All reports should connect to same dataset

---

## 📈 7. Inventory KPI (Advanced)

### ❌ Reactive KPI:
- Current stock

### ✅ Proactive KPIs:

- Days of Stock Remaining  
- Forecast Coverage %  
  = stock / (forecast Jun + Jul + Aug)

- Reorder Alert  
  = TRUE if stock < reorder point

---

## 🔍 Key Insight:

> Showing stock = reactive  
> Showing stock vs forecast = proactive

---

## 📦 Data Needed for Inventory KPIs

- Forecast (LSTM) by SKU & month
- Current stock
- Lead time

---

## 🚨 Reorder Logic

Reorder when:

stock < forecast × lead time factor

---

## ☀️ Seasonal Thinking

- Summer demand uplift must be considered
- Always compare stock vs seasonal demand

---

## 🧠 8. Golden Rules

- KPI = Decision trigger
- One page = one audience
- Separate views, same dataset
- Focus > completeness
- Simplicity wins

---

## 💬 Interview Killer Line

> "I select KPIs based on decisions, not just data. Every KPI must lead to a clear business action."


