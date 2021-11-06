USE ewrflights;
SELECT *
FROM flights;

select *
FROM airports;

SELECT *
FROM carriers;

SELECT *
FROM weather
;
-- Question 1--
-- What was the longest air time for all flights out of EWR in April, 2013?  Longest air time for all flights out of EWR in April, 2013 is 666.
-- What airline flew this flight and what was its destination? The airline flew this flight is UA and its destination is HNL.

SELECT flight, dest, carrier, air_time, year, month, origin
FROM flights f
WHERE origin = 'EWR' AND year = 2013 AND month = 4
ORDER BY air_time DESC;

-- Question 2--
-- What was the shortest air time for all flights?  The shortest air time for all flights was 20.
-- What airline flew this flight and what was its destination? The airline is EV, and its destination is BDL.

SELECT flight, dest, carrier, air_time, year, month, origin
FROM flights f
ORDER BY air_time;

-- Question 3 --
-- Write a query to produce a list of flights including airline, flight number, destination airport and distance.  
-- What was the longest distance flown by planes with between 20 and 60 seats?  1325

SELECT flight, dest, carrier, air_time, distance, seats
FROM flights f
	-- JOIN airports a ON f.dest = a.faa
    -- JOIN carriers c ON c.carrier_code = f.carrier 
	JOIN planes ON planes.tailnum = f.tailnum
WHERE seats BETWEEN 20 AND 60
ORDER BY distance DESC;

-- Question 4 --
-- 4.How many different destinations did United Airlines flights fly to in April, 2013? There are 26 different destinations United Airlines flights fly to in April, 2013. (26 rows returned)
SELECT DISTINCT dest, carrier, year, month
FROM flights f
WHERE carrier = 'UA'
ORDER BY air_time;

-- Question 5 --
SELECT DATE_FORMAT(time_hour, "%m/%d/%y") AS date, carrier, flight, dest, 
	CONVERT(sched_dep_time * 100, TIME) AS sched_dep, 
    CONVERT(dep_time * 100, TIME) AS actual_dep, 
    CONVERT(sched_arr_time * 100, TIME) AS sched_arr, 
    CONVERT(arr_time * 100, TIME) AS actual_arr, 
    dep_delay - arr_delay AS gain,
    ((dep_delay - arr_delay)/60) / (air_time/60) AS gain_per_hour
FROM flights f
ORDER BY gain DESC, flight;

-- Question 6 --
-- Which flight had the worst gain?  Flight 2083 had the worst gain. It's carrier is AA. Its gain is -148, and its gain/hour is -0.64347826.
-- Which flight had the worst gain/hour?  (The answer – flight number, gain, gain/hour – is sufficient for this question. 
-- Flight 5667 had the worst gain/hour. It's carrier is EV. Its gain is -98, and its gain/hour is -1.92156863.
SELECT DATE_FORMAT(time_hour, "%m/%d/%y") AS date, carrier, flight, dest, 
	CONVERT(sched_dep_time * 100, TIME) AS sched_dep, 
    CONVERT(dep_time * 100, TIME) AS actual_dep, 
    CONVERT(sched_arr_time * 100, TIME) AS sched_arr, 
    CONVERT(arr_time * 100, TIME) AS actual_arr, 
    dep_delay - arr_delay AS gain,
    ((dep_delay - arr_delay)/60) / (air_time/60) AS gain_per_hour
FROM flights f
ORDER BY gain_per_hour;
-- Question 7 --
SELECT DATE_FORMAT(f.time_hour, "%m/%d/%y") AS date, CONVERT(sched_dep_time*100, TIME) AS sch_dep, dep_delay, temp, wind_speed, wind_gust, precip, visib
FROM flights f
    LEFT JOIN weather w ON w.time_hour = f.time_hour 
ORDER BY dep_delay DESC;
