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

Write an SQL query that reports for :
each player and date, how many games played so far by the player. 
That is, the total number of games played by the player until that date. Check the example for clarity.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 1         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+------------+---------------------+
| player_id | event_date | games_played_so_far |
+-----------+------------+---------------------+
| 1         | 2016-03-01 | 5                   |
| 1         | 2016-05-02 | 11                  |
| 1         | 2017-06-25 | 12                  |
| 3         | 2016-03-02 | 0                   |
| 3         | 2018-07-03 | 5                   |
+-----------+------------+---------------------+
For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
Note that for each player we only care about the days when the player logged in.
*/
DROP TABLE ACTIVITY;
CREATE TABLE ACTIVITY (PLAYER_ID INT, DEVICE_ID INT, EVENT_DATE DATE, GAMES_PLAYED INT);
TRUNCATE TABLE ACTIVITY;
INSERT ALL
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '2', TO_DATE('2016-03-01','YYYY-MM-DD'), '5')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '2', TO_DATE('2016-05-02','YYYY-MM-DD'), '6')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('1', '3', TO_DATE('2017-06-25','YYYY-MM-DD'), '1')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('3', '1', TO_DATE('2016-03-02','YYYY-MM-DD'), '0')
INTO ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED) VALUES ('3', '4', TO_DATE('2018-07-03','YYYY-MM-DD'), '5')
SELECT * FROM DUAL;
SELECT * FROM ACTIVITY;

--it is like cumulative sum grouped by PLAYER_ID
--[METHOD 1]
SELECT PLAYER_ID,
EVENT_DATE,
SUM(GAMES_PLAYED) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) GAMES_PLAYED_SO_FAR
FROM ACTIVITY;


--[METHOD 2] "SCALAR SUB QUERY"
SELECT A.PLAYER_ID, 
A.EVENT_DATE, 
(
	SELECT SUM(A1.GAMES_PLAYED) --I can make TEMP-SELECT at SELECT also using TABLE ALIAS from FROM
	FROM ACTIVITY A1 
	WHERE A1.PLAYER_ID = A.PLAYER_ID 
	AND A1.EVENT_DATE <= A.EVENT_DATE
) --SUM until A.EVENT_DATE
FROM ACTIVITY A;

