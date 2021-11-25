# Database Administration
## Mysql and AWS RDS
```
Connect to AWS RDS and restore DB

mysql -h classicmodels.cflk2eh2qr7r.us-east-2.rds.amazonaws.com -u admin -p classicmodels <  /tmp/mysqlsampledatabase.sql

mysql> SHOW TABLES;
+-------------------------+
| Tables_in_classicmodels |
+-------------------------+
| customers               |
| employees               |
| offices                 |
| orderdetails            |
| orders                  |
| payments                |
| productlines            |
| products                |
+-------------------------+
8 rows in set (0.01 sec)

mysql> SHOW columns from customers;
+------------------------+---------------+------+-----+---------+-------+
| Field                  | Type          | Null | Key | Default | Extra |
+------------------------+---------------+------+-----+---------+-------+
| customerNumber         | int           | NO   | PRI | NULL    |       |
| customerName           | varchar(50)   | NO   |     | NULL    |       |
| contactLastName        | varchar(50)   | NO   |     | NULL    |       |
| contactFirstName       | varchar(50)   | NO   |     | NULL    |       |
| phone                  | varchar(50)   | NO   |     | NULL    |       |
| addressLine1           | varchar(50)   | NO   |     | NULL    |       |
| addressLine2           | varchar(50)   | YES  |     | NULL    |       |
| city                   | varchar(50)   | NO   |     | NULL    |       |
| state                  | varchar(50)   | YES  |     | NULL    |       |
| postalCode             | varchar(15)   | YES  |     | NULL    |       |
| country                | varchar(50)   | NO   |     | NULL    |       |
| salesRepEmployeeNumber | int           | YES  | MUL | NULL    |       |
| creditLimit            | decimal(10,2) | YES  |     | NULL    |       |
+------------------------+---------------+------+-----+---------+-------+
13 rows in set (0.00 sec)

mysql> SELECT country, count(*) FROM customers WHERE creditLimit > 20000 group by COUNTRY ORDER BY count(*);
+-------------+----------+
| country     | count(*) |
+-------------+----------+
| Philippines |        1 |
| Switzerland |        1 |
| Hong Kong   |        1 |
| Ireland     |        1 |
| Austria     |        2 |
| Belgium     |        2 |
| Sweden      |        2 |
| Denmark     |        2 |
| Singapore   |        2 |
| Japan       |        2 |
| Finland     |        3 |
| Canada      |        3 |
| Germany     |        3 |
| Norway      |        3 |
| Italy       |        4 |
| New Zealand |        4 |
| UK          |        5 |
| Spain       |        5 |
| Australia   |        5 |
| France      |       12 |
| USA         |       34 |
+-------------+----------+
21 rows in set (0.00 sec)

mysql> SHOW GRANTS FOR 'testuser'@'localhost';
+---------------------------------------------------------------------------------------+
| Grants for testuser@localhost                                                         |
+---------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `testuser`@`localhost`                                          |
| GRANT SELECT, UPDATE, DELETE ON `classicmodels`.`customers` TO `testuser`@`localhost` |
+---------------------------------------------------------------------------------------+
2 rows in set (0.00 sec)
```
