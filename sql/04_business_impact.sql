/* BUSINESS IMPACT & LOSS QUANTIFICATION
   Quantifying the financial leakage to justify credit policy adjustments.
*/

-- 1. Total Portfolio Realized Loss
-- Calculation: Identifying total capital lost in 'Charged Off' status ($406.8M).
SELECT 
    loan_status,
    COUNT(*) AS total_records,
    SUM(CAST(loan_amnt AS NUMERIC)) AS total_lost_amount_usd,
    AVG(CAST(loan_amnt AS NUMERIC)) AS avg_loss_per_event
FROM loans
WHERE loan_status = 'Charged Off'
GROUP BY loan_status;

-- 2. Risk Concentration by Purpose
-- Debt Consolidation represents the largest segment with 1.27M records.
SELECT 
    purpose, 
    COUNT(*) AS total_count,
    ROUND(AVG(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100, 2) AS default_rate_pct
FROM loans
GROUP BY purpose
ORDER BY total_count DESC;