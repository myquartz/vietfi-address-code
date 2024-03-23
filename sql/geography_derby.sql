CREATE TABLE sys_country (
  iso3 char(3) NOT NULL PRIMARY KEY,
  country_name varchar(80) NOT NULL,
  nicename varchar(80) NOT NULL,
  iso2 char(2) DEFAULT NULL,
  numcode INTEGER DEFAULT NULL,
  phonecode INTEGER DEFAULT NULL
);

CREATE INDEX IF NOT EXISTS iso2 ON sys_country(iso2);

CREATE TABLE sys_division (
  divisionid INTEGER PRIMARY KEY,
  country_iso3 char(3) NOT NULL,
  division_cd varchar(12) NOT NULL,
  division_name varchar(128) NOT NULL,
  division_category varchar(32) DEFAULT NULL,
  local_id varchar(12) DEFAULT NULL,
  UNIQUE (country_iso3,division_cd),
  CONSTRAINT sys_country_div_fk FOREIGN KEY (country_iso3) REFERENCES sys_country (iso3)
);

CREATE TABLE sys_division_sub (
  subdivid INTEGER PRIMARY KEY,
  divisionid INTEGER NOT NULL,
  subdiv_cd varchar(12) NOT NULL,
  l2subdiv_cd varchar(12) DEFAULT NULL,
  subdiv_name varchar(128) NOT NULL,
  subdiv_class varchar(32) DEFAULT NULL,
  UNIQUE (divisionid,subdiv_cd,l2subdiv_cd),
  CONSTRAINT sys_div_sub_fk FOREIGN KEY (divisionid) REFERENCES sys_division (divisionid)
);

