ALTER SESSION SET CONTAINER=XEPDB1;
CREATE USER SUS
  IDENTIFIED BY mypassword;
 GRANT CONNECT, RESOURCE TO SUS;
 ALTER USER SUS QUOTA UNLIMITED ON USERS;


CONNECT SUS/mypassword@//localhost:1521/XEPDB1;

CREATE TABLE ACCOUNTS(
	ACCOUNT_NUMBER VARCHAR2(15) PRIMARY KEY,
	msisdn VARCHAR2(11) NOT NULL,
	status VARCHAR2(10)
);

exit;