
CREATE TABLE sys_country (
  countryid INTEGER PRIMARY KEY AUTOINCREMENT,
  iso2 char(2) COLLATE NOCASE NOT NULL,
  country_name varchar(80) COLLATE NOCASE NOT NULL,
  nicename varchar(80) COLLATE NOCASE NOT NULL,
  iso3 char(3) COLLATE NOCASE DEFAULT NULL,
  numcode INTEGER NULL,
  phonecode INTEGER NULL
)

CREATE TABLE sys_division (
  divisionid INTEGER PRIMARY KEY AUTOINCREMENT,
  countryid INTEGER NOT NULL,
  division_cd varchar(12) COLLATE NOCASE NOT NULL,
  division_name varchar(128) COLLATE NOCASE NOT NULL,
  gso_code varchar(2) COLLATE NOCASE DEFAULT NULL,
  los_code varchar(3) COLLATE NOCASE NOT NULL,
  UNIQUE (countryid,division_cd),
  CONSTRAINT sys_country_div_fk FOREIGN KEY (countryid) REFERENCES sys_country (countryid)
)

CREATE TABLE sys_division_sub (
  subdivid INTEGER PRIMARY KEY AUTOINCREMENT,
  divisionid INTEGER NOT NULL,
  subdiv_cd varchar(12) COLLATE NOCASE NOT NULL,
  l2subdiv_cd varchar(12) COLLATE NOCASE DEFAULT NULL,
  subdiv_name varchar(128) COLLATE NOCASE NOT NULL,
  los_code_sub varchar(5) COLLATE NOCASE DEFAULT NULL,
  UNIQUE (divisionid,subdiv_cd,l2subdiv_cd),
  CONSTRAINT sys_div_sub_fk FOREIGN KEY (divisionid) REFERENCES sys_division (divisionid)
)



-- getDivisions by CountryCD
select a.divisionid, a.division_cd, a.division_name, b.country_name
from sys_division a, sys_country b
where a.countryid = b.countryid
and b.iso2 = 'VN'
order by a.division_name

-- returning a.divisionid, a.division_cd, a.division_name
-- 18, VN-HN, TP. Hà Nội


-- getSubDivisions
select a.subdivid, a.subdiv_cd, a.subdiv_name, b.division_cd, b.division_name, c.country_name
from sys_division_sub a, sys_division b, sys_country c
where a.divisionid = b.divisionid
and b.countryid = c.countryid
and a.subdiv_cd != '000'
and a.l2subdiv_cd is null
and b.division_cd = 'VN-HN'
and c.iso2 = 'VN'
order by a.subdiv_name

-- returning a.subdivid, a.subdiv_cd, a.subdiv_name
-- 10391, 001, Quận Ba Đình


--- Get l2SubDivisions
select a.subdivid, a.l2subdiv_cd,a.subdiv_name, a.subdivid, a.subdiv_cd, 
	b.subdiv_cd, b.subdiv_name,
	c.division_cd, c.division_name, d.country_name
from sys_division_sub a, sys_division_sub b, sys_division c, sys_country d 
where 
    a.subdiv_cd = b.subdiv_cd
and b.divisionid = c.divisionid
and c.countryid = d.countryid
and b.subdiv_cd != '000'
and a.l2subdiv_cd is not null
and b.l2subdiv_cd is null
and a.subdiv_cd = b.subdiv_cd
and c.division_cd = 'VN-HN'
and d.iso2 = 'VN'
and b.subdiv_cd = '001'
order by a.subdiv_name

-- thiếu Phường Trúc Bạch ở Q. Ba Đình


select a.subdivid, a.l2subdiv_cd,a.subdiv_name, a.subdivid, a.subdiv_cd, 
	b.subdiv_cd, b.subdiv_name,
	c.division_cd, c.division_name, d.country_name
from sys_division_sub a, sys_division_sub b, sys_division c, sys_country d 
where 
    a.subdiv_cd = b.subdiv_cd
and b.divisionid = c.divisionid
and c.countryid = d.countryid
and b.subdiv_cd != '000'
and a.l2subdiv_cd is not null
and b.l2subdiv_cd is null
and a.subdiv_cd = b.subdiv_cd
and c.division_cd = 'VN-HN'
and d.iso2 = 'VN'
and b.subdiv_cd = '003'
order by a.subdiv_name





