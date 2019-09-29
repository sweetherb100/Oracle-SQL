/*
 Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.

Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.

Write an SQL query to find all the people who viewed more than one article on the same date, sorted in ascending order by their id.

The query result format is in the following example:

Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 3          | 4         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+

Result table:
+------+
| id   |
+------+
| 5    |
| 6    |
+------+
*/
DROP TABLE Views;
CREATE TABLE Views (article_id int, author_id int, viewer_id int, view_date date);
TRUNCATE TABLE Views;
INSERT ALL
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('1', '3', '5', TO_DATE('2019-08-01','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('3', '4', '5', TO_DATE('2019-08-01','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('1', '3', '6', TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('2', '7', '7', TO_DATE('2019-08-01','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('2', '7', '6', TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('4', '7', '1', TO_DATE('2019-08-22','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('3', '4', '4', TO_DATE('2019-08-21','YYYY-MM-DD'))
INTO Views (article_id, author_id, viewer_id, view_date) VALUES ('3', '4', '4', TO_DATE('2019-08-21','YYYY-MM-DD'))
SELECT * FROM DUAL;
SELECT * FROM Views;

-- it may have duplicate rows like viewer_id = 4
SELECT COUNT(ARTICLE_ID),
viewer_id,
view_date
FROM Views
GROUP BY viewer_id, view_date;

SELECT DISTINCT article_id, 
viewer_id, 
view_date
FROM views;

SELECT viewer_id
	FROM (
	SELECT DISTINCT article_id, 
	viewer_id, 
	view_date
	FROM views
	)
GROUP BY viewer_id, view_date
HAVING count(ARTICLE_ID) >=2
ORDER BY viewer_id;
