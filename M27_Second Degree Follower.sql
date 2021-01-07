/*In facebook, there is a follow table with two columns: followee, follower.

Please write a sql query to get the amount of each follower's follower if he/she has one.

For example:
+-------------+------------+
| followee    | follower   |
+-------------+------------+
|     A       |     B      |
|     B       |     C      |
|     B       |     D      |
|     D       |     E      |
+-------------+------------+

should output:
+-------------+------------+
| follower    | num        |
+-------------+------------+
|     B       |  2         |
|     D       |  1         |
+-------------+------------+
Explaination:
Both B and D exist in the follower list, when as a followee, B follower is C and D, and D follower is E. A does not exist in follower list.

Note:
Followee would not follow himself/herself in all cases.
Please display the result in follower alphabet order.*/

DROP TABLE FACEBOOK;
CREATE TABLE FACEBOOK (FOLLOWEE VARCHAR(255), FOLLOWER VARCHAR(255));
TRUNCATE TABLE FACEBOOK;
INSERT ALL
INTO FACEBOOK (FOLLOWEE, FOLLOWER) VALUES ('A', 'B')
INTO FACEBOOK (FOLLOWEE, FOLLOWER) VALUES ('B', 'C')
INTO FACEBOOK (FOLLOWEE, FOLLOWER) VALUES ('B', 'D')
INTO FACEBOOK (FOLLOWEE, FOLLOWER) VALUES ('D', 'E')
SELECT * FROM DUAL;
SELECT * FROM FACEBOOK;

--LIKE THE PEOPLE THAT HM_SON7 IS FOLLOWING.
--SO, FOLLOWER BECOMES FOLLOWEE THEMSELVES.
SELECT T.FOLLOWER,
COUNT(T.FOLLOWEE) NUM
FROM
(
	SELECT F1.FOLLOWER FOLLOWER,
	F2.FOLLOWER FOLLOWEE
	FROM FACEBOOK F1,
	FACEBOOK F2
	WHERE F1.FOLLOWER = F2.FOLLOWEE
) T
GROUP BY T.FOLLOWER;