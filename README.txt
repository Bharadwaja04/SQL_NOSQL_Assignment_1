# README  

## 📌 Project Overview  
This project contains SQL and MongoDB queries that address different data analysis problems across **admission funnel analytics (Q1)** and **temperature/weather analysis (Q2)**.  
Below threre are explained assumptions and methodology for the solutions

**NOTE:** I have taken help from *ChatGPT* for terms I was unfamiliar with.  
I did not blindly copy the code — I first attempted the solution on my own and then refined it using the suggestions.
If at last I still couldn't solve it then I asked for the code.  


## 📂 Folder Structure  

2025204012_A1/  
│  
├── Q1/  
│   ├── q1_a        # Queries for Q1 Sub-question 1  
│   ├── q2_b        # Queries for Q1 Sub-question 2  
│   └── q3_c        # Queries for Q1 Sub-question 3  
│  
├── Q2/  
│   ├── q1.txt      # Queries for Q2 (Sub-question a1)  
│   └── q2.txt      # Queries for Q2 (Sub-question a2)  


---

## 🔹 Q1: Admission Funnel & Performance Analysis  

### Sub-Question 1: Admission Funnel (Using CTE)  
- Implemented using **CTEs (WITH ... AS ...)**.  
- Learned about CTEs and their use in breaking complex queries into steps.  

**Assumptions:**  
- `ADVANCE` = number of students passing in each stage.  
- `DROP_OUT` = number of students failing in each stage.  
- `TurnAroundTime` in CTE = difference between `ExamDateTime` of the next stage and the current stage.  
- `NextStage` in CTE = stages are sorted by `ExamDateTime`.  
- For the final stage (Face-to-Face interview), `TurnAroundTime = NULL` since no next stage exists.  

---

### Sub-Question 2: Pass Rate Analysis  
Pass rate calculated across **3 dimensions**:  
1. Age-band (18–20, 21–23, 24–25)  
2. City  
3. Gender  

**Assumptions:**  
- Created two helper columns:  
  - `category` → stores the type (Age-band, City, Gender).  
  - `sub_category` → stores specific values (e.g., Male/Female, Bengaluru, Age group 18–20).  
- This avoids direct `UNION`, since:  
  - Cities > 20 (too many to hardcode).  
  - Gender has only 2 categories.  
- Pass rate computed separately for each `category + sub_category`.  

---

### Sub-Question 3: Performance of a Student (Stored Procedure)  
- Stored procedure created with `student_id` as input.  
- Outputs a student’s performance based on group pass rates.  

**Assumptions:**  
- A student’s performance depends on group averages:  
  - Gender pass rate (all students of same gender).  
  - Age-band pass rate (all students in same age group).  
  - City pass rate (all students from same city).  
- Final performance score = **average of these three pass rates**.  

---

## 🔹 Q2: Temperature & Weather Data Analysis  

### a. Sub-Questions (`q1.txt`)  

#### 1. Daily Average Temperature per City by Date  
- Aggregated average temperature per city, per day.  

**Assumptions:**  
- `date` field may be a string → converted using `$toDate`.  
- `temp.avg_c` field contains daily temperature in Celsius.  
- Daily averages computed across all records per city for that date.  

---

#### 2. Monthly Average Temperature per City  
- Aggregated monthly average temperature.  

**Assumptions:**  
- `date` field may be string → converted using `$toDate`.  
- `$dateToString` with format `"%Y-%m"` used to extract month.  
- Temperatures grouped by city and month.  

---

#### 3. Identify Hottest & Coldest Cities (Jan–Jun 2025)  
- Identified cities with highest and lowest **average temperatures**.  

**Assumptions:**  
- Only data between **Jan 1 – Jun 30, 2025** considered.  
- Average temperature computed per city across this period.  
- Sorted by avg temperature:  
  - `$first` = hottest city.  
  - `$last` = coldest city.  

---

### b. Sub-Questions (`q2.txt`)  

#### 1. Top 5 Hottest & Coldest Days Nationwide  
- Used `$facet` to compute hottest and coldest days simultaneously.  

**Assumptions:**  
- `temp.max_c` → daily maximum temperature per record.  
- `temp.min_c` → daily minimum temperature per record.  
- Top 5 hottest days = highest `max_c`.  
- Top 5 coldest days = lowest `min_c`.  

---

#### 2. Compare City Temperature & Weather (Is it Raining?)  
- Compared temperature with weather condition to flag rainy days.  

**Assumptions:**  
- `temperature` and `weather` collections are joined on `date`.  
- Weather condition `"Rain"` → treated as raining.  
- Any other condition → not raining (`false`).  
- Only first weather condition per date considered (`$first`).  

---

#### 3. 7-Day Moving Average Trend for a City  
- Computed rolling averages for multiple weather metrics.  

**Assumptions:**  
- Rolling window = **7 days** (`range: [-6,0]`).  
- Metrics averaged:  
  - Temperature (`temp.avg_c`)  
  - Precipitation (`precip_mm`)  
  - Humidity (`humidity_pct`)  
  - Wind (`wind_kmph`)  
  - Cloud cover (`cloud_pct`)  
- Uses `$setWindowFields` partitioned by city, ordered by date.  

---
