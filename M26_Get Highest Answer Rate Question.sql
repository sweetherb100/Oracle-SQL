/*Get the highest answer rate question from a table survey_log with these columns: uid, action, question_id, answer_id, q_num, timestamp.

uid means user id; action has these kind of values: how, answer, skip; answer_id is not null when action column is answer, while is null for 
how and skip; q_num is the numeral order of the question in current session.

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

Note: The highest answer rate meaning is: answer number ratio in show number in the same question.*/

DROP TABLE survey;
CREATE TABLE survey (uid int, action vrchar(255), question_id int, answer_id int, q_num int, timestamp int);
TRUNCATE TABLE survey;
INSERT ALL
INTO survey (uid, action, question_id, answer_id, q_num, timestamp) VALUES ('5', 'show', '285', NULL, '1', '123')
INTO survey (uid, action, question_id, answer_id, q_num, timestamp) VALUES ('5', 'answer', '285', '124124', '1', '124')
INTO survey (uid, action, question_id, answer_id, q_num, timestamp) VALUES ('5', 'show', '369', NULL, '2', '125')
INTO survey (uid, action, question_id, answer_id, q_num, timestamp) VALUES ('5', 'skip', '369', NULL, '2', '126')
SELECT * FROM DUAL;
SELECT * FROM survey;