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

DROP TABLE survey;
CREATE TABLE survey (u_id int, actions varchar(255), question_id int, answer_id int, q_num int, timestamps int);
TRUNCATE TABLE survey;
INSERT ALL
INTO survey (u_id, actions, question_id, answer_id, q_num, timestamps) VALUES ('5', 'show', '285', NULL, '1', '123')
INTO survey (u_id, actions, question_id, answer_id, q_num, timestamps) VALUES ('5', 'answer', '285', '124124', '1', '124')
INTO survey (u_id, actions, question_id, answer_id, q_num, timestamps) VALUES ('5', 'show', '369', NULL, '2', '125')
INTO survey (u_id, actions, question_id, answer_id, q_num, timestamps) VALUES ('5', 'skip', '369', NULL, '2', '126')
SELECT * FROM DUAL;
SELECT * FROM survey;

SELECT *
FROM SURVEY
WHERE actions != 'skip';

SELECT question_id,
count(question_id) show_cnt
FROM SURVEY
WHERE actions = 'show'
GROUP BY question_id;

-- But I want the rows even if it is 0
SELECT question_id,
count(question_id) answer_cnt
FROM SURVEY
WHERE actions = 'answer'
GROUP BY question_id;

SELECT *
FROM 
(
	SELECT question_id,
	count(question_id) show_cnt
	FROM SURVEY
	WHERE actions = 'show'
	GROUP BY question_id
) S,
(
	SELECT question_id,
	count(question_id) answer_cnt
	FROM SURVEY
	WHERE actions = 'answer'
	GROUP BY question_id
) A
WHERE S.question_id = A.question_id (+);

SELECT S.question_id,
NVL(A.answer_cnt,0)/(S.show_cnt) ratio
FROM 
(
	SELECT question_id,
	count(question_id) show_cnt
	FROM SURVEY
	WHERE actions = 'show'
	GROUP BY question_id
) S,
(
	SELECT question_id,
	count(question_id) answer_cnt
	FROM SURVEY
	WHERE actions = 'answer'
	GROUP BY question_id
) A
WHERE S.question_id = A.question_id (+);
-- ORDER BY NVL(A.answer_cnt,0)/(S.show_cnt) DESC; I could do rownum later but I should also consider it can have a tie


/*SELECT T.question_id
FROM
(
	SELECT S.question_id,
	NVL(A.answer_cnt,0)/(S.show_cnt) ratio
	FROM 
	(
		SELECT question_id,
		count(question_id) show_cnt
		FROM SURVEY
		WHERE actions = 'show'
		GROUP BY question_id
	) S,
	(
		SELECT question_id,
		count(question_id) answer_cnt
		FROM SURVEY
		WHERE actions = 'answer'
		GROUP BY question_id
	) A
	WHERE S.question_id = A.question_id (+)
) T
WHERE T.ratio =(SELECT max(T.ratio) 
				FROM 
				(
					SELECT S.question_id,
					NVL(A.answer_cnt,0)/(S.show_cnt) ratio
					FROM 
					(
						SELECT question_id,
						count(question_id) show_cnt
						FROM SURVEY
						WHERE actions = 'show'
						GROUP BY question_id
					) S,
					(
						SELECT question_id,
						count(question_id) answer_cnt
						FROM SURVEY
						WHERE actions = 'answer'
						GROUP BY question_id
					) A
					WHERE S.question_id = A.question_id (+)
				) T); --too dirty... ALL I want is just to write "(select max(T.ratio) from T)"....*/
				

SELECT *
FROM SURVEY S,
SURVEY A
WHERE S.actions      = 'show'
AND A.actions      = 'answer'      
AND S.QUESTION_ID = A.QUESTION_ID;


--FINAL: Yulkyu stype
--Approach: self-join!
SELECT QUESTION_ID
  FROM (
        SELECT QUESTION_ID, 
        		RANK() OVER (ORDER BY SURVEY_LOG DESC) AS RNK, 
        		ROW_NUMBER() OVER (ORDER BY SURVEY_LOG DESC) AS RNUM
          FROM (
				SELECT S.QUESTION_ID, 
				COUNT(A.u_id)/COUNT(S.u_id) AS SURVEY_LOG
				FROM SURVEY S,
				SURVEY A
				WHERE S.actions      = 'show'
				AND A.actions      = 'answer'      
				/*1번: 굳이 OUTER를 안쓴 이유는, answer에 값이 없다는건 아예 답을 한적이 없는 건이니까 빼도 될거 같기 때문*/
				AND S.QUESTION_ID = A.QUESTION_ID
				GROUP BY S.QUESTION_ID
				ORDER BY SURVEY_LOG DESC
               )
       )
 WHERE RNK  = 1; -- 중복 1위를 다 보고 싶을때
-- WHERE RNUM = 1 -- 중복이어도 1위는 하나만 보고 싶을때
