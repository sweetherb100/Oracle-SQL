/*Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.

Write an SQL query that reports the fraction of players that logged in again on the day after the day they !!! first logged in !!!, rounded to 2 decimal places. 
In other words, you need to count the number of players that logged in for at least two consecutive days starting from their !!! first !!! login date, 
then divide that number by the total number of players.

The query result format is in the following example:
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33*/

DROP TABLE ACTIVITY;
CREATE TABLE ACTIVITY (PLAYER_ID INT, DEVICE_ID INT, EVENT_DATE DATE, GAMES_PLAYED INT);
TRUNCATE TABLE ACTIVITY;
INSERT ALL
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '2', TO_DATE('2016-03-01', 'YYYY-MM-DD'), '5')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '2', TO_DATE('2016-03-02', 'YYYY-MM-DD'), '6')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('2', '3', TO_DATE('2017-06-25', 'YYYY-MM-DD'), '1')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('3', '1', TO_DATE('2016-03-02', 'YYYY-MM-DD'), '0')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('3', '4', TO_DATE('2018-07-03', 'YYYY-MM-DD'), '5')
SELECT * FROM DUAL;
SELECT * FROM ACTIVITY;

--I AM JUST INTERESTED IN LOGGIN SO EVEN THOUGH THE GAMES_PLAYED ARE 0, IT IS OKAY!
--I DONT CARE ABOUT LOGGIN IN FOR 3 CONSECUTIVE DAYS BECAUSE I ONLY CARE ABOUT THE FIRST LOG DATE
--STRATEGY:I WILL USE LAG FUNCTION AND COMPARE
-- I ASSUME THAT ACTIVITY TABLE IS ALREADY ORDERED BY PLAYER_ID BECAUSE I WANT TO ALSO USE LAG(PLAYER_ID)

SELECT PLAYER_ID,
EVENT_DATE,
RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) RNK_DATE, --if the rank=2, at least it is the second login date
LAG(PLAYER_ID) OVER (ORDER BY PLAYER_ID) PREV_ID,
LAG(EVENT_DATE) OVER (ORDER BY PLAYER_ID) PREV_DATE
FROM ACTIVITY;

--FINAL
SELECT ROUND(COUNT(A.PLAYER_ID)/MIN(AA.TOT_CNT),2) FRACTION
FROM
(
	SELECT COUNT(DISTINCT PLAYER_ID) TOT_CNT
	FROM ACTIVITY
) AA,
(
	SELECT PLAYER_ID,
	EVENT_DATE,
	RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) RNK_DATE, --if the rank=2, at least it is the second login date
	LAG(PLAYER_ID) OVER (ORDER BY PLAYER_ID) PREV_ID,
	LAG(EVENT_DATE) OVER (ORDER BY PLAYER_ID) PREV_DATE
	FROM ACTIVITY
) A
WHERE A.RNK_DATE=2 --if the rank=2, at least it is the second login date
AND A.EVENT_DATE-1 = A.PREV_DATE
AND A.PLAYER_ID = A.PREV_ID;


--WRONG BECAUSE DIDN'T CONSIDER ONLY THE FIRST LOGIN (BE CAREFUL WITH THE TEXT!)
--AA.TT_CNT DOESN'T WORK BECAUSE IT COULD HAVE MORE THAN 1 RESULT. 
-- SO USED MIN BECAUSE I GUARANTEE IT IS ONLY 1 RESULT!
SELECT ROUND(COUNT(PLAYER_ID)/MIN(AA.TOT_CNT),2) FRACTION
FROM 
(
	SELECT COUNT(DISTINCT PLAYER_ID) TOT_CNT
	FROM ACTIVITY
) AA,
(
	SELECT PLAYER_ID,
	EVENT_DATE,
	LAG(PLAYER_ID) OVER (ORDER BY PLAYER_ID) PREV_ID, 
	LAG(EVENT_DATE) OVER (ORDER BY PLAYER_ID) PREV_DATE --BE CAREFUL! NOT AFTER_DATE
	FROM ACTIVITY
) A
WHERE A.PLAYER_ID = A.PREV_ID
AND A.EVENT_DATE = A.PREV_DATE + 1;
