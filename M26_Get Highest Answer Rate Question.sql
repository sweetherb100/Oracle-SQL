/*Get the highest answer rate question from a table survey_log with these columns: uid, action, question_id, answer_id, q_num, timestamp.

uid means user id; 
action has these kind of values: how, answer, skip; 
answer_id is not null when action column is answer, while is null for how and skip; 
q_num is the numeral order of the question in current session.

Write a sql query to identify the question which has the highest answer rate.

Example:
Input:
+------+-----------+--------------+------------+-----------+------------+
| uid  | action    | question_id  | answer_id  | q_num     | timestamp  |
+------+-----------+--------------+------------+-----------+------------+
| 5    | show      | 285          | null       | 1         | 123        |
| 5    | answer    | 285          | 124124     | 1         | 124        |
| 5    | show      | 369          | null       | 2         | 125        |
| 5    | skip      | 369          | null       | 2         | 126        |
+------+-----------+--------------+------------+-----------+------------+

Output:
+-------------+
| survey_log  |
+-------------+
|    285      |
+-------------+
Explanation:
question 285 has answer rate 1/1, while question 369 has 0/1 answer rate, so output 285.

Note: The highest answer rate meaning is: answer number's ratio in show number in the same question.*/

DROP TABLE SURVEY;
CREATE TABLE SURVEY (U_ID INT, ACTIONS VARCHAR(255), QUESTION_ID INT, ANSWER_ID INT, Q_NUM INT, TIMESTAMPS INT);
TRUNCATE TABLE SURVEY;
INSERT ALL
INTO SURVEY (U_ID, ACTIONS, QUESTION_ID, ANSWER_ID, Q_NUM, TIMESTAMPS) VALUES ('5', 'SHOW', '285', NULL, '1', '123')
INTO SURVEY (U_ID, ACTIONS, QUESTION_ID, ANSWER_ID, Q_NUM, TIMESTAMPS) VALUES ('5', 'ANSWER', '285', '124124', '1', '124')
INTO SURVEY (U_ID, ACTIONS, QUESTION_ID, ANSWER_ID, Q_NUM, TIMESTAMPS) VALUES ('5', 'SHOW', '369', NULL, '2', '125')
INTO SURVEY (U_ID, ACTIONS, QUESTION_ID, ANSWER_ID, Q_NUM, TIMESTAMPS) VALUES ('5', 'SKIP', '369', NULL, '2', '126')
SELECT * FROM DUAL;
SELECT * FROM SURVEY;


--[METHOD 1]
SELECT QUESTION_ID
FROM
(
	SELECT QUESTION_ID,
	RATIO,
	RANK() OVER (ORDER BY RATIO DESC) RNK_RATIO
	FROM
	(
		SELECT QUESTION_ID,
		COUNT(1) TOT_ACTION,
		COUNT(CASE WHEN ACTIONS = 'ANSWER' THEN 1 END) TOT_ANSWER,
		COUNT(CASE WHEN ACTIONS = 'ANSWER' THEN 1 END)/COUNT(1) RATIO
		FROM SURVEY
		GROUP BY QUESTION_ID
	)
)
WHERE RNK_RATIO=1;


--[METHOD 2] APPROACH: SELF-JOIN
SELECT QUESTION_ID
  FROM (
        SELECT QUESTION_ID, 
        		RANK() OVER (ORDER BY SURVEY_LOG DESC) AS RNK, 
        		ROW_NUMBER() OVER (ORDER BY SURVEY_LOG DESC) AS RNUM
          FROM (
				SELECT S.QUESTION_ID, 
				COUNT(A.U_ID)/COUNT(S.U_ID) AS SURVEY_LOG
				FROM SURVEY S,
				SURVEY A
				WHERE S.ACTIONS      = 'SHOW'
				AND A.ACTIONS      = 'ANSWER'      
				/*Didnt use Outer left join: if there is no 'answer', it is not answered */
				AND S.QUESTION_ID = A.QUESTION_ID
				GROUP BY S.QUESTION_ID
				ORDER BY SURVEY_LOG DESC
               )
       )
 WHERE RNK  = 1; -- when I want to see multiple rank 1
