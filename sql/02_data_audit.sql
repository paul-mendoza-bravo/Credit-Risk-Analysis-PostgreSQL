/* DATA AUDIT & INTEGRITY CHECK
   ---------------------------------------------------------
   Goal: Identify outliers, duplicates, and missing values that could bias financial models.
   Target: 2,260,668 Records.
*/

-- 1. Primary Key Integrity: Duplicate Check
-- Rationale: Duplicate IDs would inflate financial metrics and losses ($4.07B total portfolio loss).
-- This is a critical check for data reliability in large datasets.
SELECT id, COUNT(*)
FROM loans
GROUP BY id
HAVING COUNT(*) > 1;

-- 2. Null Value Assessment in Critical Columns
-- Results: Found 4 nulls in income, 1,711 in DTI, and 166,931 in job titles.
-- Strategy: These 1,715 records with missing critical financial data (income/DTI) must be handled.
SELECT 
    COUNT(*) AS total_records,
    COUNT(*) - COUNT(loan_amnt) AS null_amounts,
    COUNT(*) - COUNT(annual_inc) AS null_income,
    COUNT(*) - COUNT(dti) AS null_dti,
    COUNT(*) - COUNT(emp_title) AS null_job_titles,
    COUNT(*) - COUNT(addr_state) AS null_states
FROM loans;

-- 3. Outlier Detection: Annual Income
-- Rationale: Extreme values (e.g., $110,000,000 USD) can skew the "average" risk profile.
-- These are identified for potential exclusion or special grouping.
SELECT id, annual_inc 
FROM loans 
ORDER BY CAST(annual_inc AS NUMERIC) DESC 
LIMIT 10;

-- 4. Insolvency Threshold Check (DTI > 50)
-- Observation: Found placeholder values (999) and [null] IDs in extreme DTI cases.
-- Found ratios as high as 173% in legitimate records, justifying a 40% DTI Hard Cap.
SELECT id, dti 
FROM loans 
WHERE CAST(dti AS NUMERIC) > 50 
ORDER BY CAST(dti AS NUMERIC) DESC
LIMIT 20;

-- 5. Data Consistency: Loan Amounts
-- Result: Verified 0 negative loan amounts in the dataset.
-- Rationale: Ensuring all financial amounts are positive to prevent logic errors.
SELECT COUNT(*) AS negative_loan_amounts
FROM loans 
WHERE CAST(loan_amnt AS NUMERIC) < 0;