/*In social network like Facebook or Twitter, people send friend requests and accept others requests as well. Now given two tables as below:
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
In this case, the duplicated requests or acceptances are only counted once.
If there is no requests at all, you should return 0.00 as the accept_rate.

Explanation: There are 4 unique accepted requests, and there are 5 requests in total. So the rate is 0.80.

Follow-up:
Can you write a query to return the accept rate but for every month?
How about the cumulative accept rate for every day?*/

DROP TABLE friend_request;
CREATE TABLE friend_request (sender_id int, send_to_id int, request_date date);
TRUNCATE TABLE friend_request;
INSERT ALL
INTO friend_request (sender_id, send_to_id, request_date) VALUES ('1', '2', TO_DATE('2016_06-01','YYYY-MM-DD'))
INTO friend_request (sender_id, send_to_id, request_date) VALUES ('1', '3', TO_DATE('2016_06-01','YYYY-MM-DD'))
INTO friend_request (sender_id, send_to_id, request_date) VALUES ('1', '4', TO_DATE('2016_06-01','YYYY-MM-DD'))
INTO friend_request (sender_id, send_to_id, request_date) VALUES ('2', '3', TO_DATE('2016_06-02','YYYY-MM-DD'))
INTO friend_request (sender_id, send_to_id, request_date) VALUES ('3', '4', TO_DATE('2016_06-09','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM friend_request;


CREATE TABLE request_accepted (requester_id int, accepter_id int, accept_date date);
TRUNCATE TABLE request_accepted;
INSERT ALL
INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('1', '2', TO_DATE('2016_06-03','YYYY-MM-DD'))
INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('1', '3', TO_DATE('2016_06-08','YYYY-MM-DD'))
INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('2', '3', TO_DATE('2016_06-08','YYYY-MM-DD'))
INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('3', '4', TO_DATE('2016_06-09','YYYY-MM-DD'))
INTO request_accepted (requester_id, accepter_id, accept_date) VALUES ('3', '4', TO_DATE('2016_06-10','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM request_accepted;

-- Question1: Write a query to find the overall acceptance rate of requests rounded to 2 decimals
SELECT DISTINCT requester_id, 
accepter_id
FROM request_accepted;

SELECT DISTINCT sender_id, 
send_to_id
FROM friend_request;


--WEIRD!! result comes out as 20. I think it is because there is table R as well
SELECT COUNT(A.requester_id) CNT_ACCEPT
FROM
(
	SELECT DISTINCT requester_id, 
	accepter_id
	FROM request_accepted
) A,
(
	SELECT DISTINCT sender_id, 
	send_to_id
	FROM friend_request
) R;

--FINAL
SELECT AA.CNT_ACCEPT / RR.CNT_REQUEST AS accept_rate
FROM
(
SELECT COUNT(A.requester_id) CNT_ACCEPT
FROM
	(
		SELECT DISTINCT requester_id, 
		accepter_id
		FROM request_accepted
	) A
) AA,
(
	SELECT COUNT(R.sender_id) CNT_REQUEST
	FROM
	(
		SELECT DISTINCT sender_id, 
		send_to_id
		FROM friend_request
	) R
) RR

--Question2: Can you write a query to return the accept rate but for every month?

SELECT DISTINCT sender_id,
send_to_id,
request_date
FROM friend_request; --make sure there are no duplicate

SELECT count(sender_id) CNT_REQUEST,
request_month
FROM 
(
SELECT DISTINCT sender_id,
send_to_id,
TO_CHAR(request_date,'YYYY-MM') request_month
FROM friend_request
)
GROUP BY request_month;


SELECT count(requester_id) CNT_ACCEPT,
accept_month
FROM 
(
SELECT DISTINCT requester_id,
accepter_id,
TO_CHAR(accept_date,'YYYY-MM') accept_month
FROM request_accepted
)
GROUP BY accept_month;


--FINAL
SELECT NVL(A.CNT_ACCEPT,0)/(R.CNT_REQUEST) AS accept_rate, 
R.request_month
FROM
(
	SELECT count(sender_id) CNT_REQUEST,
	request_month
	FROM 
	(
		SELECT DISTINCT sender_id,
		send_to_id,
		TO_CHAR(request_date,'YYYY-MM') request_month
		FROM friend_request
	)
	GROUP BY request_month
) R,
(
	SELECT count(requester_id) CNT_ACCEPT,
	accept_month
	FROM 
	(
		SELECT DISTINCT requester_id,
		accepter_id,
		TO_CHAR(accept_date,'YYYY-MM') accept_month
		FROM request_accepted
	)
	GROUP BY accept_month
) A
WHERE R.request_month = A.accept_month;

--Question3: How about the cumulative accept rate for every day?*/