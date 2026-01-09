# Financial Credit Risk Analysis: High-Volume Portfolio Auditing (2.26M Records)

## 🎯 Executive Summary
This project delivers a deep-dive financial audit of a massive credit portfolio, identifying systemic risks that lead to a total realized loss of **$4.07 Billion USD**. By processing **2,260,668 records** (1.10 GB) in **PostgreSQL**, I moved beyond basic reporting to pinpoint high-risk segments where volume and default rates intersect to bleed capital.

---

## 🎨 Visual Intelligence (Power BI)
*Integrating business logic with high-impact visualization for executive decision-making.*

### 🖼️ Dashboard Preview
![Financial Risk Dashboard](TU_IMAGEN_AQUI.png) 
> **Note:** Replace `report1.png` with the actual filename of your screenshot uploaded to this repository.

### 🧠 Advanced Analytics & DAX
Beyond standard charts, I engineered custom **DAX measures** to provide deep business context:
* **Risk Performance (Sparklines):** Developed time-series trend indicators to visualize loss velocity across different credit vintages.
* **Dynamic Default Velocity:** A calculation comparing the portfolio's default rate against market benchmarks ($11.96\%$ vs $7.79\%$).
* **Interactivity:** Fully cross-filtered environment allowing stakeholders to drill down from $34B in total exposure to specific "Debt Consolidation" leakages in seconds.

---

## 📊 Key Business Findings
- **Total Realized Loss:** Identified **$4.07 Billion USD** ($4,068.9M) in 'Charged Off' loans.
- **The Grade C Paradox:** While Grade G has the highest failure rate (36.83%), **Grade C** is the primary driver of loss, totaling **$1.22 Billion** due to its extreme volume in the portfolio.

### 👤 High-Risk Profile Quantification
| Profile | Total Loans | Default Rate | Millions Lost |
| :--- | :--- | :--- | :--- |
| **Grade C + Debt Consolidation** | **387,312** | **13.20%** | **$777.12** |
| **Grade C + Credit Card** | 130,553 | 12.68% | $256.50 |
| **Grade G + Debt Consolidation** | 7,594 | **37.78%** | $60.23 |

*Data extracted via SQL aggregation in pgAdmin.*

---

## 🛠️ Tech Stack & Engineering
* **Database:** PostgreSQL (Engineered for Big Data scalability).
* **Visualization:** Power BI Desktop (DAX, Power Query).
* **Performance:** Achieved high-speed bulk ingestion of 2.26M rows in **48.8 seconds** using the `COPY` command.
* **Architecture:** Implemented a **Gold Layer (View)** to normalize raw data and create boolean risk flags (`is_bad_loan`) for high-performance calculations.

## 🔍 Data Quality Audit
* **Null Management:** Detected **166,931 missing job titles**, **1,711 null DTI records**, and **4 null income records**.
* **Dirty Data Detection:** Identified "999" DTI placeholders associated with **null IDs**, requiring strict exclusion to prevent skewed insolvency metrics.
* **Outlier Isolation:** Identified extreme income anomalies (up to **$110 Million USD**) and DTI ratios of **173%**.

## 💡 Data-Backed Strategic Recommendations
*Addressing the trade-off between volume and risk mitigation:*

1.  **Targeted DTI Friction for Grade C:** * **Action:** Implement a strict **30% DTI cap** specifically for "Debt Consolidation" within Grade C.
    * **Impact:** Mitigates ~15% of losses in this **$777M** segment while preserving high-yield interest revenue.
2.  **Efficiency-Based Rejection for Grade G:** * **Action:** Immediate rejection of "Debt Consolidation" applications in Grade G.
    * **Impact:** Eliminates a segment with a critical **37.78% default rate**, reducing operational collection costs.
3.  **DTI Outlier Hard Cap (>40%):** * **Action:** Automatic rejection for any applicant exceeding 40% DTI to protect against extreme insolvency.

---
> **Professional Disclaimer:** This project focuses on exploratory and descriptive risk analysis; no predictive modeling was implemented at this stage.

*Created by **Paul Mendoza** - Junior Data Analyst*