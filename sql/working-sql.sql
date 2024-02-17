
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
and a.l2subdiv_cd = '00000'
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
    b.divisionid = c.divisionid
and c.country_iso3 = d.iso3
and a.l2subdiv_cd != '00000'
and b.l2subdiv_cd = '00000'
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
and a.l2subdiv_cd != '00000'
and a.subdiv_cd = b.subdiv_cd
and c.division_cd = 'VN-HN'
and d.iso2 = 'VN'
and b.subdiv_cd = '003'
order by a.subdiv_name

-- populate prefixes for VNM
insert into sys_prefix(prefix,unit_level,country_code)
values('TP.',1,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Tỉnh',1,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Thành phố',1,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Thành phố',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Quận',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Huyện',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Thị xã',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Phường',3,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Xã',3,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Thị trấn',3,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('TP',1,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('Q.',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('TX.',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('P.',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('F.',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('TT.',3,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('TT',3,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('TP.',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('TP',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('H.',2,'VNM');

insert into sys_prefix(prefix,unit_level,country_code)
values('X.',3,'VNM');

-- select and update dictionary of constants
select unit_level, length(prefix), lower(prefix)
from sys_prefix
where country_code = 'VNM'
order by unit_level, length(prefix) desc, prefix

select lower(prefix)
from sys_prefix
where country_code = 'VNM' and unit_level=2
order by unit_level, length(prefix) desc, prefix
