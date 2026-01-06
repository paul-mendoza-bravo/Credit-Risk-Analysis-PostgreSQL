/* ANALYTICAL VIEW (GOLD LAYER)
   Transformation of raw TEXT data into optimized NUMERIC/DATE formats.
   Selection of key features based on business relevance.
*/

CREATE OR REPLACE VIEW vw_loans_clean AS
SELECT 
    id AS loan_id,
    CAST(loan_amnt AS NUMERIC) AS loan_amount,
    term AS loan_term,
    -- Cleaning int_rate string and converting to decimal percentage
    CAST(REPLACE(int_rate, '%', '') AS NUMERIC) / 100 AS interest_rate,
    grade,
    home_ownership,
    CAST(annual_inc AS NUMERIC) AS annual_income,
    CAST(dti AS NUMERIC) AS debt_to_income,
    purpose,
    loan_status,
    -- Binary Target: 1 for Loss, 0 for Success
    CASE 
        WHEN loan_status IN ('Charged Off', 'Default') THEN 1 
        ELSE 0 
    END AS is_bad_loan
FROM loans
WHERE annual_inc IS NOT NULL; -- Cleaning critical nulls identified in audit.