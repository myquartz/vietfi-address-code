SELECT COUNT(*) FROM vn_gso_province;
SELECT COUNT(*) FROM vn_gso_district_ward;

SELECT COUNT(*) FROM sys_division;

#INSERT INTO sys_division

SELECT * FROM vn_gso_province p
JOIN sys_division d ON p.prov_code = d.local_id AND d.country_iso3 = 'VNM'
WHERE p.province_name <> d.division_name;

SELECT *, INSTR(d.division_name,p.province_name) FROM iso_vn_province p
JOIN sys_division d ON p.prov_code = d.division_cd AND d.country_iso3 = 'VNM'
WHERE INSTR(d.division_name,p.province_name)=0;

INSERT INTO sys_division (country_iso3, division_cd, division_name, local_id, division_category)
SELECT 'VNM', p.prov_code AS iso_code, d.province_name, d.prov_code AS local_id, d.province_class FROM iso_vn_province p
JOIN vn_gso_province d ON INSTR(d.province_name,p.province_name)>0
UNION ALL
SELECT 'VNM', p.prov_code AS iso_code, d.province_name, d.prov_code AS local_id, d.province_class FROM iso_vn_province p
JOIN vn_gso_province d ON d.prov_code = '46' AND p.prov_code = 'VN-26'
ORDER BY province_class, local_id;
#ORDER BY NULLIF(NULLIF(NULLIF(NULLIF(NULLIF(local_id,'92'),'48'),'01'),'31'),'79'), local_id;


SELECT * FROM iso_vn_province WHERE prov_code = 'VN-47';
SELECT * FROM vn_gso_district_ward WHERE ward_code = '';

INSERT INTO sys_division_sub (divisionid, subdiv_cd, l2subdiv_cd, subdiv_name)
SELECT divisionid, '000','00000','(không có huyện/quận)' FROM sys_division WHERE country_iso3 = 'VNM'
ORDER by divisionid;

INSERT INTO sys_division_sub (divisionid, subdiv_cd, subdiv_name, l2subdiv_cd, subdiv_class)
SELECT DISTINCT s.divisionid, dist_code, district_name, '00000',
CASE 
	WHEN district_name LIKE 'Quận %' THEN 'Quận'
  WHEN district_name LIKE 'Huyện %' THEN 'Huyện'
  WHEN district_name LIKE 'Thành phố %' THEN 'Thành phố'
  WHEN district_name LIKE 'Thị Xã %' THEN 'Thị Xã'
  ELSE NULL END AS subdiv_class FROM vn_gso_district_ward d
JOIN sys_division s ON s.local_id = d.prov_code
ORDER BY s.divisionid,dist_code;

INSERT INTO sys_division_sub (divisionid, subdiv_cd, l2subdiv_cd, subdiv_name, subdiv_class)
SELECT DISTINCT s.divisionid, dist_code, ward_code, ward_name,
CASE 
	WHEN ward_name LIKE 'Phường %' THEN 'Phường'
  WHEN ward_name LIKE 'Xã %' THEN 'Xã'
  WHEN ward_name LIKE 'Thị trấn %' THEN 'Thị trấn'
  WHEN ward_name LIKE 'Thị Xã %' THEN 'Thị Xã'
  ELSE NULL END AS subdiv_class FROM vn_gso_district_ward d
JOIN sys_division s ON s.local_id = d.prov_code
WHERE ward_code <> ''
ORDER BY s.divisionid,dist_code,ward_code;

SELECT DISTINCT s.divisionid, dist_code, district_name, '00000',
CASE 
	WHEN district_name LIKE 'Quận %' THEN 'Quận'
  WHEN district_name LIKE 'Huyện %' THEN 'Huyện'
  WHEN district_name LIKE 'Thành phố %' THEN 'Thành phố'
  WHEN district_name LIKE 'Thị Xã %' THEN 'Thị Xã'
  ELSE NULL END AS subdiv_class FROM vn_gso_district_ward d
JOIN sys_division s ON s.local_id = d.prov_code
ORDER BY s.divisionid,dist_code;