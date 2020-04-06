-- How many elevators per customer do we have?
-- The number of elevators (ElevatorId) contained in the buildings belonging to each customer
SELECT customerid, buildingid, SUM(serialnumber) AS total_elevator FROM factelevator GROUP BY buildingid, customerid ORDER BY customerid

-- Visualization in Blazer

-- SELECT c.company_name, count(e.id) AS total_elevator
-- FROM customers c, buildings b, batteries bat, columns col, elevators e 
-- WHERE b.customer_id = c.id 
-- AND bat.building_id = b.id
-- AND col.battery_id = bat.id
-- AND e.column_id = col.id
-- GROUP BY c.company_name
