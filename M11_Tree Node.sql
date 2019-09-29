/*Given a table tree, id is identifier of the tree node and p_id is its parent node id.

+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
Each node in the tree can be one of three types:

Leaf: if the node is a leaf node.
Root: if the node is the root of the tree.
Inner: If the node is neither a leaf node nor a root node.
Write a query to print the node id and the type of the node. Sort your output by the node id. The result for the above sample is:

+----+------+
| id | Type |
+----+------+
| 1  | Root |
| 2  | Inner|
| 3  | Leaf |
| 4  | Leaf |
| 5  | Leaf |
+----+------+
Explanation

Node 1 is root node, because its parent node is NULL and it has child node 2 and 3.
Node 2 is inner node, because it has parent node 1 and child node 4 and 5.
Node 3,4,5 is Leaf node, because they have parent node and they don't have child node.
And here is the image of the sample tree as below:

	1
      /   \
    2       3
  /   \
4       5
Note

If there is only one node on the tree, you only need to output its root attributes.*/

/*CREATE TABLE Weather (Id int, RecordDate date, Temperature int);
TRUNCATE TABLE Weather;
INSERT ALL
INTO Weather (Id, RecordDate, Temperature) VALUES ('1', TO_DATE('2015-01-01','YYYY-MM-DD'), '10')
INTO Weather (Id, RecordDate, Temperature) VALUES ('2', TO_DATE('2015-01-02','YYYY-MM-DD'), '25')
INTO Weather (Id, RecordDate, Temperature) VALUES ('3', TO_DATE('2015-01-03','YYYY-MM-DD'), '20')
INTO Weather (Id, RecordDate, Temperature) VALUES ('4', TO_DATE('2015-01-04','YYYY-MM-DD'), '30')
INTO Weather (Id, RecordDate, Temperature) VALUES ('5', TO_DATE('2015-01-14','YYYY-MM-DD'), '5')
INTO Weather (Id, RecordDate, Temperature) VALUES ('6', TO_DATE('2015-01-16','YYYY-MM-DD'), '7') --Exception case 
SELECT * FROM DUAL;
SELECT * FROM Weather;*/