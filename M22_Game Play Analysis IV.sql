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

Write an SQL query that reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, 
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

DROP TABLE Activity;
CREATE TABLE Activity (player_id int, device_id int, event_date date, games_played int);
TRUNCATE TABLE Activity;
INSERT ALL
INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', TO_DATE('2016-03-01', 'YYYY-MM-DD'), '5')
INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', TO_DATE('2016-03-02', 'YYYY-MM-DD'), '6')
INTO Activity (player_id, device_id, event_date, games_played) VALUES ('2', '3', TO_DATE('2017-06-25', 'YYYY-MM-DD'), '1')
INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '1', TO_DATE('2016-03-02', 'YYYY-MM-DD'), '0')
INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '4', TO_DATE('2018-07-03', 'YYYY-MM-DD'), '5')
SELECT * FROM DUAL;
SELECT * FROM Activity;

--i am just interested IN loggin so even though the games_played ARE 0, it IS okay!
--what IF I log IN IN 3 consecutive days? I will count it AS 2 TIMEs
--my strategy IS I will use lag FUNCTION AND compare
-- i assume that activity table is already ordered by player_id because I want to also use lag(player_id)
SELECT player_id,
event_date,
lag(player_id) OVER (ORDER BY player_id) prev_id,
lag(event_date) OVER (ORDER BY player_id) prev_date
FROM ACTIVITY;


-- used yulkyu tip!
SELECT round(count(player_id)/min(AA.tot_cnt),2) fraction
FROM 
(
SELECT count(DISTINCT player_id) tot_cnt
FROM ACTIVITY
) AA,
(
SELECT player_id,
event_date,
lag(player_id) OVER (ORDER BY player_id) prev_id, --be careful! not after_date
lag(event_date) OVER (ORDER BY player_id) prev_date
FROM ACTIVITY
) A
WHERE A.player_id = A.prev_id
AND A.event_date = A.prev_date + 1;
