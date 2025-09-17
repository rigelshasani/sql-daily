-- Business Context: You're analyzing customer order data to understand purchasing patterns 
-- and identify potential issues with customer retention.

-- Here's your scenario:

-- CUSTOMERS table: customer_id, name,        signup_date, status
-- ORDERS    table: order_id,    customer_id, order_date,  amount

-- Problem: Find all customers who signed up in the last 90 days, show their total order value
-- (or 0 if no orders), and flag customers who have signed up but never placed an order.

SELECT C.CUSTOMER_ID, C.NAME, COALESCE(SUM(O.AMOUNT), 0) AS TOTAL_AMOUNT, CASE WHEN COUNT(O.ORDER_ID) > 0 THEN 1 ELSE 0 END AS FLAG_ORDERED
FROM CUSTOMERS C 
LEFT JOIN ORDERS O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE C.signup_date >= current_date - 90
GROUP BY C.CUSTOMER_ID, C.NAME;

-- Variant 1: Modify this to show only customers who signed up in the 
-- last 90 days but have placed NO orders (the at-risk segment).

SELECT C.CUSTOMER_ID, C.NAME, 'NO ORDERS MADE'
FROM CUSTOMERS C 
LEFT JOIN ORDERS O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE C.signup_date >= current_date - 90
GROUP BY C.CUSTOMER_ID, C.NAME
HAVING COUNT(O.ORDER_ID) = 0;

-- Variant 2: Change it to show the average order value per customer instead of total, 
-- but still handle customers with no orders appropriately.

SELECT C.CUSTOMER_ID, C.NAME, COALESCE(AVG(O.AMOUNT), 0) AS AVG_AMOUNT, CASE WHEN COUNT(O.ORDER_ID) > 0 THEN 1 ELSE 0 END AS FLAG_ORDERED
FROM CUSTOMERS C 
LEFT JOIN ORDERS O 
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE C.signup_date >= current_date - 90
GROUP BY C.CUSTOMER_ID, C.NAME;