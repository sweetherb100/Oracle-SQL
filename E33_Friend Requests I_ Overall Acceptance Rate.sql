/*In social network like Facebook or Twitter, people send friend requests and accept others requests as well. 
 * Now given two tables as below:
 * 
Table: friend_request
| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |


Table: request_accepted
| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.
For the sample data above, your query should return the following result.

|accept_rate|
|-----------|
|       0.80|

Note:
The accepted requests are not necessarily from the table friend_request. 
In this case, you just need to simply count the total accepted requests (no matter whether they are in the original requests), 
and divide it by the number of requests to get the acceptance rate.

It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. 
!!! In this case, the duplicated requests or acceptances are only counted once. !!!!
If there is no requests at all, you should return 0.00 as the accept_rate.

Explanation: There are 4 unique accepted requests, and there are 5 requests in total. So the rate is 0.80.

Follow-up:
Can you write a query to return the accept rate but for every month?
How about the cumulative accept rate for every day?*/

DROP TABLE FRIEND_REQUEST;
CREATE TABLE FRIEND_REQUEST (SENDER_ID INT, SEND_TO_ID INT, REQUEST_DATE DATE);
TRUNCATE TABLE FRIEND_REQUEST;
INSERT ALL
INTO FRIEND_REQUEST (SENDER_ID, SEND_TO_ID, REQUEST_DATE) VALUES ('1', '2', TO_DATE('2016_06-01','YYYY-MM-DD'))
INTO FRIEND_REQUEST (SENDER_ID, SEND_TO_ID, REQUEST_DATE) VALUES ('1', '3', TO_DATE('2016_06-01','YYYY-MM-DD'))
INTO FRIEND_REQUEST (SENDER_ID, SEND_TO_ID, REQUEST_DATE) VALUES ('1', '4', TO_DATE('2016_06-01','YYYY-MM-DD'))
INTO FRIEND_REQUEST (SENDER_ID, SEND_TO_ID, REQUEST_DATE) VALUES ('2', '3', TO_DATE('2016_06-02','YYYY-MM-DD'))
INTO FRIEND_REQUEST (SENDER_ID, SEND_TO_ID, REQUEST_DATE) VALUES ('3', '4', TO_DATE('2016_06-09','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM FRIEND_REQUEST;

CREATE TABLE REQUEST_ACCEPTED (REQUESTER_ID INT, ACCEPTER_ID INT, ACCEPT_DATE DATE);
TRUNCATE TABLE REQUEST_ACCEPTED;
INSERT ALL
INTO REQUEST_ACCEPTED (REQUESTER_ID, ACCEPTER_ID, ACCEPT_DATE) VALUES ('1', '2', TO_DATE('2016_06-03','YYYY-MM-DD'))
INTO REQUEST_ACCEPTED (REQUESTER_ID, ACCEPTER_ID, ACCEPT_DATE) VALUES ('1', '3', TO_DATE('2016_06-08','YYYY-MM-DD'))
INTO REQUEST_ACCEPTED (REQUESTER_ID, ACCEPTER_ID, ACCEPT_DATE) VALUES ('2', '3', TO_DATE('2016_06-08','YYYY-MM-DD'))
INTO REQUEST_ACCEPTED (REQUESTER_ID, ACCEPTER_ID, ACCEPT_DATE) VALUES ('3', '4', TO_DATE('2016_06-09','YYYY-MM-DD'))
INTO REQUEST_ACCEPTED (REQUESTER_ID, ACCEPTER_ID, ACCEPT_DATE) VALUES ('3', '4', TO_DATE('2016_06-10','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM REQUEST_ACCEPTED;

-- Question1: Write a query to find the overall acceptance rate of requests rounded to 2 decimals
----[method 1]
SELECT ROUND(A.ACCEPTED / R.REQUESTED, 2)
FROM 
	(
    SELECT COUNT(COUNT(1)) AS ACCEPTED
      FROM REQUEST_ACCEPTED A
     GROUP BY A.REQUESTER_ID, A.ACCEPTER_ID
   ) A
 , (
    SELECT COUNT(COUNT(1)) AS REQUESTED
      FROM FRIEND_REQUEST R
     GROUP BY R.SENDER_ID, R.SEND_TO_ID
   ) R;
       
 ----[method 2]     
SELECT CASE WHEN R.REQUESTED = 0 THEN ROUND(0, 2)
                                 ELSE ROUND(A.ACCEPTED / R.REQUESTED, 2)
       END  AS ACCEPTED_RATE
  FROM (
        SELECT COUNT(COUNT(1)) AS ACCEPTED --SUM(COUNT(1)) GIVES 5 (1+1+1+2)
          FROM REQUEST_ACCEPTED A
         GROUP BY A.REQUESTER_ID, A.ACCEPTER_ID
       ) A
     , (
        SELECT COUNT(COUNT(1)) AS REQUESTED
          FROM FRIEND_REQUEST R
         GROUP BY R.SENDER_ID, R.SEND_TO_ID
       ) R;
       
--[method 3] Not really recommended because there are too many sub-queries
SELECT AA.CNT_ACCEPT / RR.CNT_REQUEST AS ACCEPT_RATE
FROM
(
SELECT COUNT(A.REQUESTER_ID) CNT_ACCEPT
FROM
	(
		SELECT DISTINCT REQUESTER_ID, 
		ACCEPTER_ID
		FROM REQUEST_ACCEPTED
	) A
) AA,
(
	SELECT COUNT(R.SENDER_ID) CNT_REQUEST
	FROM
	(
		SELECT DISTINCT SENDER_ID, 
		SEND_TO_ID
		FROM FRIEND_REQUEST
	) R
) RR
      

--WRONG! result comes out as 20. I think it is because there is table R as well
SELECT COUNT(A.REQUESTER_ID) CNT_ACCEPT
FROM
(
	SELECT DISTINCT REQUESTER_ID, 
	ACCEPTER_ID
	FROM REQUEST_ACCEPTED
) A,
(
	SELECT DISTINCT SENDER_ID, 
	SEND_TO_ID
	FROM FRIEND_REQUEST
) R;


--Question2: Can you write a query to return the accept rate but for every month?
SELECT NVL(A.CNT_ACCEPT,0)/(R.CNT_REQUEST) AS ACCEPT_RATE, 
R.REQUEST_MONTH
FROM
(
	SELECT COUNT(1) CNT_REQUEST,
	REQUEST_MONTH
	FROM
		(
		SELECT COUNT(1) CNT_REQUEST,
		TO_CHAR(REQUEST_DATE,'YYYY-MM') REQUEST_MONTH
		FROM FRIEND_REQUEST
		GROUP BY SENDER_ID, SEND_TO_ID, TO_CHAR(REQUEST_DATE,'YYYY-MM')
		)
	GROUP BY REQUEST_MONTH
) R,
(
	SELECT COUNT(1) CNT_ACCEPT,
	ACCEPT_MONTH
	FROM
		(
		SELECT COUNT(1) CNT_ACCEPT,
		TO_CHAR(ACCEPT_DATE,'YYYY-MM') ACCEPT_MONTH
		FROM REQUEST_ACCEPTED
		GROUP BY REQUESTER_ID, ACCEPTER_ID, TO_CHAR(ACCEPT_DATE,'YYYY-MM')
		)
	GROUP BY ACCEPT_MONTH
) A 
WHERE R.REQUEST_MONTH = A.ACCEPT_MONTH;

--Question3: How about the cumulative accept rate for every day?*/