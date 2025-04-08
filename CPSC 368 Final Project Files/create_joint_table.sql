CREATE TABLE AvgHealthExp_SurgWait AS
SELECT 
    e.year,
    AVG(e.TotalCurrentDollars) AS avg_total_expenditure,
    AVG(e.TotalCurrentDollarsPerCapita) AS avg_expenditure_per_capita,
    MAX(w.WAITING) AS total_waiting_patients, 
    MAX(w.COMPLETED) AS total_completed_procedures,  
    MAX(w.COMPLETED_50TH_PERCENTILE) AS median_wait_time, 
    MAX(w.COMPLETED_90TH_PERCENTILE) AS long_wait_time  
FROM HealthExpenditures e
JOIN WaitTimes w 
    ON e.year = w.YEAR
WHERE w.HEALTHAUTHORITY = 'All Health Authorities' 
    AND w.HOSPITALNAME = 'All Facilities' 
    AND w.CATEGORY = 'All Procedures'
GROUP BY e.year;