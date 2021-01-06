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
!!! There is no primary key for this table, it may have duplicate rows. !!!

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
DROP TABLE VIEWS;
CREATE TABLE VIEWS (ARTICLE_ID INT, AUTHOR_ID INT, VIEWER_ID INT, VIEW_DATE DATE);
TRUNCATE TABLE VIEWS;
INSERT ALL
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('1', '3', '5', TO_DATE('2019-08-01','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('3', '4', '5', TO_DATE('2019-08-01','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('1', '3', '6', TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('2', '7', '7', TO_DATE('2019-08-01','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('2', '7', '6', TO_DATE('2019-08-02','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('4', '7', '1', TO_DATE('2019-07-22','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('3', '4', '4', TO_DATE('2019-07-21','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('3', '4', '4', TO_DATE('2019-07-21','YYYY-MM-DD'))
INTO VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID, VIEW_DATE) VALUES ('7', '7', '4', TO_DATE('2019-07-21','YYYY-MM-DD')) --ADDED FOR DENSE_RANK() VS RANK()
SELECT * FROM DUAL;
SELECT * FROM VIEWS;


--[METHOD 1]
SELECT VIEWER_ID
FROM
(
	SELECT ARTICLE_ID,
	VIEWER_ID,
	VIEW_DATE,
	DENSE_RANK() OVER (PARTITION BY VIEWER_ID, VIEW_DATE ORDER BY ARTICLE_ID) DNR_ID --DUPLICATE ROWS HAVE SAME DNR_ID
	FROM VIEWS
	ORDER BY VIEWER_ID
)
WHERE DNR_ID > 1; --MORE THAN 1 ARTICLE


--[METHOD 2] -- IT MAY HAVE DUPLICATE ROWS LIKE VIEWER_ID=4 
SELECT VIEWER_ID
	FROM (
	SELECT DISTINCT ARTICLE_ID, --REMOVE DUPLICATE ROWS FROM THE BEGINNING (DISTINCT COMBI OF 3 COLUMNS)
	VIEWER_ID, 
	VIEW_DATE
	FROM VIEWS
	)
GROUP BY VIEWER_ID, VIEW_DATE
HAVING COUNT(ARTICLE_ID) >=2
ORDER BY VIEWER_ID;
