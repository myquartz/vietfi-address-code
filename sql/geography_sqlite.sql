-- SQLite compatible table creation script for the geography module

CREATE TABLE IF NOT EXISTS sys_country (
  iso3 char(3) COLLATE NOCASE PRIMARY KEY,
  iso2 char(2) COLLATE NOCASE NOT NULL,
  country_name varchar(80) COLLATE NOCASE NOT NULL,
  nicename varchar(80) COLLATE NOCASE NOT NULL,
  numcode INTEGER NULL,
  phonecode INTEGER NULL,
  namespaces VARCHAR(128)
);

CREATE INDEX IF NOT EXISTS iso2 ON sys_country(iso2);

--
-- Table structure for table `sys_division`
--

CREATE TABLE IF NOT EXISTS sys_division (
  divisionid INTEGER PRIMARY KEY AUTOINCREMENT,
  country_iso3 char(3) NOT NULL,
  division_cd varchar(12) COLLATE NOCASE NOT NULL,
  division_name varchar(128) COLLATE NOCASE NOT NULL,
  division_category varchar(32) COLLATE NOCASE DEFAULT NULL,
  local_id varchar(12) COLLATE NOCASE DEFAULT NULL,
  namespaceset INTEGER DEFAULT 0,
  CONSTRAINT sys_country_div_fk FOREIGN KEY (country_iso3) REFERENCES sys_country (iso3)
) ;

CREATE INDEX IF NOT EXISTS div_local_id ON sys_division(local_id);
CREATE UNIQUE INDEX division_unique_iso ON sys_division(division_cd, namespaceset);

CREATE TABLE IF NOT EXISTS sys_division_sub (
  subdivid INTEGER PRIMARY KEY AUTOINCREMENT,
  divisionid INTEGER NOT NULL,
  subdiv_cd varchar(12) COLLATE NOCASE NOT NULL,
  l2subdiv_cd varchar(12) COLLATE NOCASE NOT NULL,
  subdiv_name varchar(128) COLLATE NOCASE NOT NULL,
  subdiv_class varchar(32) COLLATE NOCASE DEFAULT NULL,
  namespaceset INTEGER DEFAULT 0,
  UNIQUE (divisionid,subdiv_cd,l2subdiv_cd),
  CONSTRAINT sys_div_sub_fk FOREIGN KEY (divisionid) REFERENCES sys_division (divisionid)
);

CREATE INDEX IF NOT EXISTS sys_division_sub3 ON sys_division_sub(subdiv_cd,l2subdiv_cd);

CREATE TABLE IF NOT EXISTS "sys_prefix" (
	"prefix_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"prefix"	TEXT,
	"unit_level"	INTEGER,
	"country_code"	INTEGER, 
  "name" TEXT,
	UNIQUE("prefix","unit_level","country_code"),
	CONSTRAINT "fk_country_code" FOREIGN KEY("country_code") REFERENCES "sys_country"("iso3")
);

CREATE TABLE IF NOT EXISTS "special_division" (
	"specialid"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"divisionid"	INTEGER,
	"division_name"	TEXT,
	UNIQUE("division_name")
);
