/*
 Write a query to print the sum of all total investment values in 2016 (TIV_2016), to a scale of 2 decimal places, 
for all policy holders who meet the following criteria:

1) Have the same TIV_2015 value as one or more other policyholders.
2) Are not located in the same city as any other policyholder (i.e.: the (latitude, longitude) attribute pairs must be unique).

Input Format:
The insurance table is described as follows:

| Column Name | Type          |
|-------------|---------------|
| PID         | INTEGER(11)   |
| TIV_2015    | NUMERIC(15,2) |
| TIV_2016    | NUMERIC(15,2) |
| LAT         | NUMERIC(5,2)  |
| LON         | NUMERIC(5,2)  |
where PID is the policyholder policy ID, 
TIV_2015 is the total investment value in 2015, 
TIV_2016 is the total investment value in 2016, 
LAT is the latitude of the policy holder city, 
and LON is the longitude of the policy holder city.

Sample Input:

| PID | TIV_2015 | TIV_2016 | LAT | LON |
|-----|----------|----------|-----|-----|
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |

Sample Output:
| TIV_2016 |
|----------|
| 45.00    |
Explanation

The first record in the table, like the last record, meets both of the two criteria.
The TIV_2015 value 10 is as the same as the third and forth record, and its location unique.

The second record does not meet any of the two criteria. Its TIV_2015 is not like any other policyholders.

And its location is the same with the third record, which makes the third record fail, too.

So, the result is the sum of TIV_2016 of the first and last record, which is 45.
*/

CREATE TABLE INSURANCE (PID INT, TIV_2015 INT, TIV_2016 INT, LAT INT, LON INT);
TRUNCATE TABLE INSURANCE;
INSERT ALL
INTO INSURANCE (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('1', '10', '5', '10', '10')
INTO INSURANCE (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('2', '20', '20', '20', '20')
INTO INSURANCE (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('3', '10', '30', '20', '20')
INTO INSURANCE (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('4', '10', '40', '40', '40')
SELECT * FROM DUAL;
SELECT * FROM INSURANCE;

--1) Have the same TIV_2015 value as one or more other policyholders
SELECT *
FROM INSURANCE
WHERE TIV_2015 IN 
				(SELECT TIV_2015
				FROM INSURANCE
				GROUP BY TIV_2015
				HAVING COUNT(TIV_2015) >=2);
				
--2) Are not located in the same city as any other policyholder
SELECT *
FROM INSURANCE
WHERE (LAT, LON) IN 
				(SELECT LAT, LON
				FROM INSURANCE
				GROUP BY LAT, LON
				HAVING COUNT(LAT) = 1); --AUTOMATICALLY COUNT(LON) IS ALSO 1
				
				
-- FINAL: JOIN 2 TABLES
SELECT SUM(I1.TIV_2016) TIV_2016
FROM
(
	SELECT PID,
	TIV_2016
	FROM INSURANCE
	WHERE TIV_2015 IN 
					(SELECT TIV_2015
					FROM INSURANCE
					GROUP BY TIV_2015
					HAVING COUNT(TIV_2015) >=2)
) I1,
(
	SELECT PID,
	TIV_2016
	FROM INSURANCE
	WHERE (LAT, LON) IN 
					(SELECT LAT, 
							LON
					FROM INSURANCE
					GROUP BY LAT, LON
					HAVING COUNT(LAT) = 1)
) I2
WHERE I1.PID = I2.PID;
