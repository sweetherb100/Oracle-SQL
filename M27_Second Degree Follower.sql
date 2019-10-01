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

DROP TABLE facebook;
CREATE TABLE facebook (followee varchar(255), follower varchar(255));
TRUNCATE TABLE facebook;
INSERT ALL
INTO facebook (followee, follower) VALUES ('A', 'B')
INTO facebook (followee, follower) VALUES ('B', 'C')
INTO facebook (followee, follower) VALUES ('B', 'D')
INTO facebook (followee, follower) VALUES ('D', 'E')
SELECT * FROM DUAL;
SELECT * FROM facebook;

--follower becomes followee themselves
SELECT F1.follower,
F2.follower
FROM FACEBOOK F1,
Facebook F2
WHERE F1.FOLLOWER = f2.followee;

SELECT T.follower,
count(T.followee) num
FROM
(
	SELECT F1.follower follower,
	F2.follower followee
	FROM FACEBOOK F1,
	Facebook F2
	WHERE F1.FOLLOWER = f2.followee
) T
GROUP BY T.follower;