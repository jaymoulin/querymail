CREATE TABLE QMAIL_EXAMPLE (
  QMAIL_EXAMPLE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  NB_DISPLAY int(11) NOT NULL,
  NB_CLICK int(11) NOT NULL,
  DATE date NOT NULL,
  NB_SEARCH int(11) NOT NULL,
  GEOZONE_CODE char(2) NOT NULL
);

INSERT INTO QMAIL_EXAMPLE VALUES (1,1052,32,'2016-11-01',3210,'FR'),(2,1245,58,'2016-11-02',4562,'ES'),(3,1080,42,'2016-11-01',3463,'ES'),(4,1148,43,'2016-11-02',4531,'FR');

CREATE TABLE QMAIL_KPI (
  KPI_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  MAIL_ID int(10)  NOT NULL,
  NAME varchar(100)  DEFAULT NULL,
  DESCRIPTION text ,
  QUERY text ,
  QUERY_COMPARE text ,
  CONNEXION varchar(20)  DEFAULT NULL,
  `GROUP` varchar(20) DEFAULT NULL,
  PRIORITY int(11) NOT NULL DEFAULT '1',
  TS_UPDATE timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  IS_ACTIVE tinyint(4) NOT NULL DEFAULT '1',
  MODE varchar(20)  NOT NULL DEFAULT 'HTML',
  GRAPH_MODE varchar(20)  NOT NULL DEFAULT 'BAR',
  DISPLAY_QUERIES tinyint(4) NOT NULL DEFAULT '0',
  ATTACH_CSV tinyint(4) NOT NULL DEFAULT '0',
  JSON_TEST_PARAM varchar(255)  DEFAULT NULL,
  LAST_USER varchar(70)  DEFAULT NULL,
  INVERT_COLOR tinyint(4) NOT NULL DEFAULT '0',
  FORMAT_INTEGER tinyint(4) NOT NULL DEFAULT '1',
  DIFF_PERCENT tinyint(4) NOT NULL DEFAULT '1',
  EXCLUDED_HOURS varchar(255) DEFAULT NULL
);

INSERT INTO QMAIL_KPI VALUES (1,1,'Data comparison','Compare KPI between two days','SELECT DATE, SUM(NB_SEARCH) NB_SEARCH, SUM(NB_DISPLAY) NB_DISPLAY, SUM(NB_CLICK) NB_CLICK, ROUND((SUM(NB_CLICK) / SUM(NB_DISPLAY)) *100, 2) CTR FROM QMAIL_EXAMPLE WHERE DATE = "2016-11-01"','SELECT DATE, SUM(NB_SEARCH) NB_SEARCH, SUM(NB_DISPLAY) NB_DISPLAY, SUM(NB_CLICK) NB_CLICK, ROUND((SUM(NB_CLICK) / SUM(NB_DISPLAY)) *100, 2) CTR FROM QMAIL_EXAMPLE WHERE DATE = "2016-11-02"','querymail','',1,'2016-10-18 12:20:14',1,'GRAPH_HTML','BAR',1,0,'',NULL,0,0,1,''),(2,1,'Group query','Select data and group them by a specific column (GEOZONE_CODE in this example)','SELECT GEOZONE_CODE, SUM(NB_SEARCH) NB_SEARCH, SUM(NB_DISPLAY) NB_DISPLAY, SUM(NB_CLICK) NB_CLICK, ROUND((SUM(NB_CLICK) / SUM(NB_DISPLAY)) *100, 2) CTR FROM QMAIL_EXAMPLE GROUP BY GEOZONE_CODE','','querymail','GEOZONE_CODE',1,'2016-10-18 09:56:52',1,'HTML','BAR',1,0,'',NULL,0,0,1,'0');

CREATE TABLE QMAIL_MAIL (
  MAIL_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  `FROM` varchar(100)  DEFAULT NULL,
  `FROM_NAME` varchar(100)  DEFAULT NULL,
  `TO` text ,
  SUBJECT varchar(100)  DEFAULT NULL,
  TS_UPDATE timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  TEMPLATE varchar(15)  NOT NULL,
  GENERATION_DURATION decimal(10,2) NOT NULL DEFAULT '0.00',
  TS_SEND timestamp NULL DEFAULT NULL,
  PROJECT_ID int(10)  DEFAULT NULL
) ;

INSERT INTO QMAIL_MAIL VALUES (1,'querymail@mycompany.com','me@mycompany.com','Example email with some KPI','2016-10-18 10:01:48','sample-layout',1.50,'2016-10-18 12:34:17',1);

CREATE TABLE QMAIL_PROJECT (
  PROJECT_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  NAME varchar(70)  DEFAULT NULL
);

INSERT INTO QMAIL_PROJECT VALUES (1,'My Awesome Project');