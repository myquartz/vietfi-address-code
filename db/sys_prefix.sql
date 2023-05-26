CREATE TABLE "sys_prefix" (
	"prefix_id"	INTEGER,
	"prefix"	TEXT,
	"unit_level"	INTEGER,
	"name" TEXT,
	"country_code"	INTEGER,
	UNIQUE("prefix","unit_level","country_code"),
	PRIMARY KEY("prefix_id"),
	CONSTRAINT "fk_country_code" FOREIGN KEY("country_code") REFERENCES "sys_country"("iso3")
)

select PRINTF("INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( %d, '%s', '%s', '%s')",
     prefix_id, prefix, name, country_code)
-- + "," + prefix + "," + name + "," + unit_level + "," + country_code + ")"
from sys_prefix
where country_code = 'VNM'
order by country_code, unit_level, prefix


INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 11, 'TP ', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 1, 'TP.', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 3, 'Thành phố', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 2, 'Tỉnh', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 20, 'H.', 'Huyện', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 6, 'Huyện', 'Huyện', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 12, 'Q.', 'Quận', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 5, 'Quận', 'Quận', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 19, 'TP ', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 18, 'TP.', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 13, 'TX.', 'Thị xã', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 4, 'Thành phố', 'Thành phố', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 7, 'Thị xã', 'Thị xã', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 15, 'F.', 'Phường', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 14, 'P.', 'Phường', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 8, 'Phường', 'Phường', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 17, 'TT ', 'Thị trấn', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 16, 'TT.', 'Thị trấn', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 10, 'Thị trấn', 'Thị trấn', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 21, 'X.', 'Xã', 'VNM')
INSERT INTO sys_prefix (prefix_id, prefix, name, unit_level, country_code) VALUES( 9, 'Xã', 'Xã', 'VNM')