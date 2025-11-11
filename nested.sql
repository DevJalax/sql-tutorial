SELECT 
    c.name,
    COALESCE(SUM(CASE WHEN QUARTER(STR_TO_DATE(t.dt, '%Y%m%d%H%i%s')) = 1 THEN t.amount END), 0) AS q1_amount,
    COALESCE(SUM(CASE WHEN QUARTER(STR_TO_DATE(t.dt, '%Y%m%d%H%i%s')) = 2 THEN t.amount END), 0) AS q2_amount,
    COALESCE(SUM(CASE WHEN QUARTER(STR_TO_DATE(t.dt, '%Y%m%d%H%i%s')) = 3 THEN t.amount END), 0) AS q3_amount,
    COALESCE(SUM(CASE WHEN QUARTER(STR_TO_DATE(t.dt, '%Y%m%d%H%i%s')) = 4 THEN t.amount END), 0) AS q4_amount,
    COUNT(t.coin_id) AS total_txns,
    COALESCE(SUM(t.amount), 0) AS total_amt
FROM coins c
LEFT JOIN transactions t ON c.id = t.coin_id
GROUP BY c.name
ORDER BY total_amt DESC;



SELECT 
    c.name,
    SUM(CASE WHEN QUARTER(t.dt) = 1 THEN t.amount ELSE 0 END) AS q1_amount,
    SUM(CASE WHEN QUARTER(t.dt) = 2 THEN t.amount ELSE 0 END) AS q2_amount,
    SUM(CASE WHEN QUARTER(t.dt) = 3 THEN t.amount ELSE 0 END) AS q3_amount,
    SUM(CASE WHEN QUARTER(t.dt) = 4 THEN t.amount ELSE 0 END) AS q4_amount,
    COUNT(t.coin_id) AS total_txns,
    SUM(t.amount) AS total_amt
FROM coins c
LEFT JOIN transactions t ON c.id = t.coin_id
GROUP BY c.id, c.name;


LEFT JOIN transactions t ON c.id = t.coin_id
GROUP BY c.id;



-----------------------

SELECT 
    c.name,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 1 THEN t.amount ELSE 0 END), 0) AS q1_amount,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 2 THEN t.amount ELSE 0 END), 0) AS q2_amount,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 3 THEN t.amount ELSE 0 END), 0) AS q3_amount,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 4 THEN t.amount ELSE 0 END), 0) AS q4_amount,
    COUNT(t.coin_id) AS total_txns,
    COALESCE(SUM(t.amount), 0) AS total_amt
FROM coins c
LEFT JOIN transactions t 
    ON c.id = t.coin_id
    AND YEAR(t.dt) = 2024  -- Add year filter here
GROUP BY c.id, c.name
ORDER BY c.name;

--------------------


SELECT 
    c.name,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 1 THEN t.amount ELSE 0 END), 0) AS q1_amount,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 2 THEN t.amount ELSE 0 END), 0) AS q2_amount,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 3 THEN t.amount ELSE 0 END), 0) AS q3_amount,
    COALESCE(SUM(CASE WHEN QUARTER(t.dt) = 4 THEN t.amount ELSE 0 END), 0) AS q4_amount,
    COUNT(t.coin_id) AS total_txns,
    COALESCE(SUM(t.amount), 0) AS total_amt
FROM coins c
LEFT JOIN transactions t ON c.id = t.coin_id
GROUP BY c.id, c.name
ORDER BY c.name;
