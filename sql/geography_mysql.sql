-- MySQL compatible table creation script for the geography module

CREATE TABLE IF NOT EXISTS sys_country (
  iso3 char(3)  PRIMARY KEY,
  iso2 char(2) NOT NULL,
  country_name varchar(80) NOT NULL,
  nicename varchar(80) NOT NULL,
  numcode INTEGER NULL,
  phonecode INTEGER NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX iso2 ON sys_country(iso2);

--
-- Table structure for table `sys_division`
--

CREATE TABLE IF NOT EXISTS sys_division (
  divisionid INTEGER PRIMARY KEY AUTO_INCREMENT,
  country_iso3 CHAR(3) NOT NULL,
  division_cd varchar(12) NOT NULL,
  division_name varchar(128) NOT NULL,
  division_category varchar(32) DEFAULT NULL,
  local_id varchar(12) DEFAULT NULL,
  CONSTRAINT sys_country_div_fk FOREIGN KEY (country_iso3) REFERENCES sys_country (iso3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX div_local_id ON sys_division(local_id);
CREATE UNIQUE INDEX division_unique_iso ON sys_division(division_cd);

CREATE TABLE IF NOT EXISTS sys_division_sub (
  subdivid INTEGER PRIMARY KEY AUTO_INCREMENT,
  divisionid INTEGER NOT NULL,
  subdiv_cd varchar(12) NOT NULL,
  l2subdiv_cd varchar(12) NOT NULL,
  subdiv_name varchar(128) NOT NULL,
  subdiv_class varchar(32) DEFAULT NULL,
  UNIQUE (divisionid,subdiv_cd,l2subdiv_cd),
  CONSTRAINT sys_div_sub_fk FOREIGN KEY (divisionid) REFERENCES sys_division (divisionid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE INDEX sys_division_sub3 ON sys_division_sub(subdiv_cd,l2subdiv_cd);