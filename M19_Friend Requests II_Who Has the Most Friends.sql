/*
 In social network like Facebook or Twitter, people send friend requests and accept others requests as well.
Table request_accepted holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.

| requester_id | accepter_id | accept_date|
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
Write a query to find the the people who has most friends and the most friends number. For the sample data above, the result is:

| id | num |
|----|-----|
| 3  | 3   |
Note:

It is guaranteed there is only 1 people having the most friends.
The friend request could only been accepted once, which mean there is no multiple records with the same requester_id and accepter_id value.
Explanation:
The person with id 3 is a friend of people 1, 2and 4, so he has 3 friends in total, which is the most number than any others.

Follow-up:
In the real world, multiple people could have the same most number of friends, can you find all these people in this case?
*/

DROP TABLE Facebook;
CREATE TABLE Facebook (requester_id int, accepter_id int, accept_date date);
TRUNCATE TABLE Facebook;
INSERT ALL
INTO Facebook (requester_id, accepter_id, accept_date) VALUES ('1', '2', TO_DATE('2016_06-03','YYYY-MM-DD'))
INTO Facebook (requester_id, accepter_id, accept_date) VALUES ('1', '3', TO_DATE('2016_06-08','YYYY-MM-DD'))
INTO Facebook (requester_id, accepter_id, accept_date) VALUES ('2', '3', TO_DATE('2016_06-08','YYYY-MM-DD'))
INTO Facebook (requester_id, accepter_id, accept_date) VALUES ('3', '4', TO_DATE('2016_06-09','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Facebook;

--UNION ALL: combine all the rows also with duplicate
SELECT requester_id
FROM Facebook
UNION all
SELECT accepter_id
FROM Facebook;

--TRIAL
SELECT F.requester_id,
count(F.requester_id)
FROM 
(
SELECT requester_id
FROM Facebook
UNION all
SELECT accepter_id
FROM Facebook
) F
GROUP BY F.requester_id;


--yulkyu said no keunbon [tree without a root!] [non-rootted tree]
SELECT --F.requester_id,
max(count(F.requester_id)) num
FROM 
(
SELECT requester_id
FROM Facebook
UNION all
SELECT accepter_id
FROM Facebook
) F
GROUP BY F.requester_id;

SELECT F.requester_id,
count(F.requester_id) num
FROM 
(
SELECT requester_id
FROM Facebook
UNION all
SELECT accepter_id
FROM Facebook
) F
GROUP BY F.requester_id;

--1) max(FF.num) not recommended
--2) use 'order by' inside and then 'where rownum=1' [recommended by yulkyu]
--3) 'order by' is done after the 'select', so I can use alias in order by!
SELECT FF.requester_id,
FF.num
FROM 
(
	SELECT F.requester_id,
	count(F.requester_id) num
	FROM 
	(
	SELECT requester_id
	FROM Facebook
	UNION all
	SELECT accepter_id
	FROM Facebook
	) F
	GROUP BY F.requester_id
	ORDER BY num DESC --max will be the first row
	
)FF
WHERE rownum = 1; --select the max row
