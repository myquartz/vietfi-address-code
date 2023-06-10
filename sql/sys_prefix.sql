PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "sys_prefix" (
	"prefix_id"	INTEGER,
	"prefix"	TEXT,
	"unit_level"	INTEGER,
	"country_code"	INTEGER, Name TEXT,
	UNIQUE("prefix","unit_level","country_code"),
	PRIMARY KEY("prefix_id"),
	CONSTRAINT "fk_country_code" FOREIGN KEY("country_code") REFERENCES "sys_country"("iso3")
);
INSERT INTO sys_prefix VALUES(1,'TP.',1,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(2,'Tỉnh',1,'VNM','Tỉnh');
INSERT INTO sys_prefix VALUES(3,'Thành phố',1,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(4,'Thành phố',2,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(5,'Quận',2,'VNM','Quận');
INSERT INTO sys_prefix VALUES(6,'Huyện',2,'VNM','Huyện');
INSERT INTO sys_prefix VALUES(7,'Thị xã',2,'VNM','Thị xã');
INSERT INTO sys_prefix VALUES(8,'Phường',3,'VNM','Phường');
INSERT INTO sys_prefix VALUES(9,'Xã',3,'VNM','Xã');
INSERT INTO sys_prefix VALUES(10,'Thị trấn',3,'VNM','Thị trấn');
INSERT INTO sys_prefix VALUES(11,'TP ',1,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(12,'Q.',2,'VNM','Quận');
INSERT INTO sys_prefix VALUES(13,'TX.',2,'VNM','Thị xã');
INSERT INTO sys_prefix VALUES(14,'P.',3,'VNM','Phường');
INSERT INTO sys_prefix VALUES(15,'F.',3,'VNM','Phường');
INSERT INTO sys_prefix VALUES(16,'TT.',3,'VNM','Thị trấn');
INSERT INTO sys_prefix VALUES(17,'TT ',3,'VNM','Thị trấn');
INSERT INTO sys_prefix VALUES(18,'TP.',2,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(19,'TP ',2,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(20,'H.',2,'VNM','Huyện');
INSERT INTO sys_prefix VALUES(21,'X.',3,'VNM','Xã');
INSERT INTO sys_prefix VALUES(23,'Thanh pho',1,'VNM','Thành phố');
INSERT INTO sys_prefix VALUES(24,'Tinh',1,'VNM','Tỉnh');
COMMIT;

