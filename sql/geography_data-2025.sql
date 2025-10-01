-- Vietnam has 2 sets of prefixes, that is before2025 and 2025 (right most significant bit first.)

UPDATE sys_country SET namespaces = 'before2025,2025' WHERE iso3 = 'VNM';

-- all current divisions are before2025 (bitwise 01 = 1)
UPDATE sys_division SET namespaceset = 1 WHERE country_iso3 = 'VNM' AND namespaceset = 0;

-- Ref URL: https://xaydungchinhsach.chinhphu.vn/bang-danh-muc-va-ma-so-cua-34-tinh-thanh-moi-cac-don-vi-hanh-chinh-cap-xa-moi-11925070418263625.htm

-- divisions co-exist in both sets (bitwise 11 = 3) - same name and same local_id

-- 01 - TP. Hanoi
-- 04 Cao Bang, 08 Tuyen Quang, 11 Dien Bien, 12 Lai Chau, 14 Son La, 19 Thai Nguyen, 20 Lang Son, 22 Quang Ninh, 25 Phu Tho
-- 31 TP. Hai Phong, 33 Hung Yen, 37 Ninh Binh, 38 Thanh Hoa, 40 Nghe An, 42 Ha Tinh, 48 Da Nang, 51 Quang Ngai, 56 Khanh Hoa
-- 66 Dak Lak, 68 Lam Dong, 75 Dong Nai, 79 TP.HCM
-- 86 Vinh Long, 92 TP. Can Tho, 96 Ca Mau.
UPDATE sys_division SET namespaceset = 3 WHERE country_iso3 = 'VNM'  AND namespaceset = 0
    AND local_id IN ('01','04','08','11','12','14','19','20','22','25','31','33','37','38','40','42','48','51','56','66','68','75','79','86','92','96');

-- Renamed some divisions to match the new official names (but same division_cd and local_id), by adding more records
INSERT INTO sys_division (country_iso3, division_cd, division_name, division_category, local_id, namespaceset) VALUES 
 -- Tinh Yen Bai cu nay la Lao Cai
('VNM','VN-06','Tỉnh Lào Cai','Tỉnh','15',2),
-- Tinh Bac Giang cu nay la Bac Ninh
('VNM','VN-54','Tỉnh Bắc Ninh','Tỉnh','24',2),
-- Tinh Quang Binh cu nay la Quang Tri
('VNM','VN-24','Tỉnh Quảng Trị','Tỉnh','44',2),
-- Tinh Thua Thien Hue cu nay la TP. Hue
('VNM','VN-26','Thành phố Huế','Tỉnh','46',2),
-- Tinh Binh Dinh cu nay la Gia Lai
('VNM','VN-31','Tỉnh Gia Lai','Tỉnh','52',2),
-- Tinh Long An cu nay la Tay Ninh
('VNM','VN-41','Tỉnh Tây Ninh','Tỉnh','80',2),
-- Tinh Tiền Giang cu nay la Tinh Dong Thap
('VNM','VN-46','Tỉnh Đồng Tháp','Tỉnh','82',2),
-- Tinh Kien Giang cu nay la Tinh An Giang
('VNM','VN-47','Tỉnh An Giang','Tỉnh','91',2);


-- Phuong xa theo Ref URL: https://www.nso.gov.vn/default/2025/06/thong-bao-ma-so-va-ten-don-vi-hanh-chinh-cap-xa-moi/
-- File PDF copied
-- DANH MỤC VÀ MÃ SỐ CÁC ĐƠN VỊ HÀNH CHÍNH CẤP XÃ
-- (Ban hành kèm theo Công văn số 1027/CTK-CSCL ngày 25 tháng 6 năm 2025
-- của Cục Thống kê)

CREATE TEMPORARY TABLE sys_division_2025 (
    local_id VARCHAR(6) PRIMARY KEY,
    subdiv_name TEXT,
    division_local_id VARCHAR(6)
);

/* ********************************************************************

TP. Ha Noi
Page 1

Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
THÀNH PHỐ HÀ NỘI
1 00070 Phường Hoàn Kiếm Thành phố Hà Nội
2 00082 Phường Cửa Nam Thành phố Hà Nội
3 00004 Phường Ba Đình Thành phố Hà Nội
4 00008 Phường Ngọc Hà Thành phố Hà Nội
5 00025 Phường Giảng Võ Thành phố Hà Nội
6 00256 Phường Hai Bà Trưng Thành phố Hà Nội
7 00283 Phường Vĩnh Tuy Thành phố Hà Nội
8 00292 Phường Bạch Mai Thành phố Hà Nội
9 00235 Phường Đống Đa Thành phố Hà Nội
10 00229 Phường Kim Liên Thành phố Hà Nội
11 00226 Phường Văn Miếu - Quốc Tử Giám Thành phố Hà Nội
12 00199 Phường Láng Thành phố Hà Nội
13 00190 Phường Ô Chợ Dừa Thành phố Hà Nội
14 00097 Phường Hồng Hà Thành phố Hà Nội
15 00328 Phường Lĩnh Nam Thành phố Hà Nội
16 00331 Phường Hoàng Mai Thành phố Hà Nội
17 00301 Phường Vĩnh Hưng Thành phố Hà Nội
18 00322 Phường Tương Mai Thành phố Hà Nội
19 00316 Phường Định Công Thành phố Hà Nội
20 00337 Phường Hoàng Liệt Thành phố Hà Nội
21 00340 Phường Yên Sở Thành phố Hà Nội
22 00367 Phường Thanh Xuân Thành phố Hà Nội
23 00364 Phường Khương Đình Thành phố Hà Nội
24 00352 Phường Phương Liệt Thành phố Hà Nội
25 00166 Phường Cầu Giấy Thành phố Hà Nội
26 00160 Phường Nghĩa Đô Thành phố Hà Nội
Page 2
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
27 00175 Phường Yên Hòa Thành phố Hà Nội
28 00103 Phường Tây Hồ Thành phố Hà Nội
29 00091 Phường Phú Thượng Thành phố Hà Nội
30 00613 Phường Tây Tựu Thành phố Hà Nội
31 00619 Phường Phú Diễn Thành phố Hà Nội
32 00611 Phường Xuân Đỉnh Thành phố Hà Nội
33 00602 Phường Đông Ngạc Thành phố Hà Nội
34 00598 Phường Thượng Cát Thành phố Hà Nội
35 00592 Phường Từ Liêm Thành phố Hà Nội
36 00622 Phường Xuân Phương Thành phố Hà Nội
37 00634 Phường Tây Mỗ Thành phố Hà Nội
38 00637 Phường Đại Mỗ Thành phố Hà Nội
39 00145 Phường Long Biên Thành phố Hà Nội
40 00118 Phường Bồ Đề Thành phố Hà Nội
41 00127 Phường Việt Hưng Thành phố Hà Nội
42 00136 Phường Phúc Lợi Thành phố Hà Nội
43 09556 Phường Hà Đông Thành phố Hà Nội
44 09886 Phường Dương Nội Thành phố Hà Nội
45 09562 Phường Yên Nghĩa Thành phố Hà Nội
46 09568 Phường Phú Lương Thành phố Hà Nội
47 09552 Phường Kiến Hưng Thành phố Hà Nội
48 00640 Xã Thanh Trì Thành phố Hà Nội
49 00664 Xã Đại Thanh Thành phố Hà Nội
50 00685 Xã Nam Phù Thành phố Hà Nội
51 00679 Xã Ngọc Hồi Thành phố Hà Nội
52 00643 Phường Thanh Liệt Thành phố Hà Nội
53 10231 Xã Thượng Phúc Thành phố Hà Nội
54 10183 Xã Thường Tín Thành phố Hà Nội
55 10237 Xã Chương Dương Thành phố Hà Nội
56 10210 Xã Hồng Vân Thành phố Hà Nội
Page 3
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
57 10273 Xã Phú Xuyên Thành phố Hà Nội
58 10279 Xã Phượng Dực Thành phố Hà Nội
59 10330 Xã Chuyên Mỹ Thành phố Hà Nội
60 10342 Xã Đại Xuyên Thành phố Hà Nội
61 10114 Xã Thanh Oai Thành phố Hà Nội
62 10126 Xã Bình Minh Thành phố Hà Nội
63 10144 Xã Tam Hưng Thành phố Hà Nội
64 10180 Xã Dân Hòa Thành phố Hà Nội
65 10354 Xã Vân Đình Thành phố Hà Nội
66 10369 Xã Ứng Thiên Thành phố Hà Nội
67 10417 Xã Hòa Xá Thành phố Hà Nội
68 10402 Xã Ứng Hòa Thành phố Hà Nội
69 10441 Xã Mỹ Đức Thành phố Hà Nội
70 10465 Xã Hồng Sơn Thành phố Hà Nội
71 10459 Xã Phúc Sơn Thành phố Hà Nội
72 10489 Xã Hương Sơn Thành phố Hà Nội
73 10015 Phường Chương Mỹ Thành phố Hà Nội
74 10030 Xã Phú Nghĩa Thành phố Hà Nội
75 10045 Xã Xuân Mai Thành phố Hà Nội
76 10081 Xã Trần Phú Thành phố Hà Nội
77 10096 Xã Hòa Phú Thành phố Hà Nội
78 10072 Xã Quảng Bị Thành phố Hà Nội
79 09661 Xã Minh Châu Thành phố Hà Nội
80 09619 Xã Quảng Oai Thành phố Hà Nội
81 09664 Xã Vật Lại Thành phố Hà Nội
82 09634 Xã Cổ Đô Thành phố Hà Nội
83 09676 Xã Bất Bạt Thành phố Hà Nội
84 09694 Xã Suối Hai Thành phố Hà Nội
85 09700 Xã Ba Vì Thành phố Hà Nội
86 09706 Xã Yên Bài Thành phố Hà Nội
Page 4
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
87 09574 Phường Sơn Tây Thành phố Hà Nội
88 09604 Phường Tùng Thiện Thành phố Hà Nội
89 09616 Xã Đoài Phương Thành phố Hà Nội
90 09715 Xã Phúc Thọ Thành phố Hà Nội
91 09739 Xã Phúc Lộc Thành phố Hà Nội
92 09772 Xã Hát Môn Thành phố Hà Nội
93 09955 Xã Thạch Thất Thành phố Hà Nội
94 09982 Xã Hạ Bằng Thành phố Hà Nội
95 10003 Xã Tây Phương Thành phố Hà Nội
96 09988 Xã Hòa Lạc Thành phố Hà Nội
97 04930 Xã Yên Xuân Thành phố Hà Nội
98 09895 Xã Quốc Oai Thành phố Hà Nội
99 09931 Xã Hưng Đạo Thành phố Hà Nội
100 09910 Xã Kiều Phú Thành phố Hà Nội
101 09952 Xã Phú Cát Thành phố Hà Nội
102 09832 Xã Hoài Đức Thành phố Hà Nội
103 09856 Xã Dương Hòa Thành phố Hà Nội
104 09871 Xã Sơn Đồng Thành phố Hà Nội
105 09877 Xã An Khánh Thành phố Hà Nội
106 09784 Xã Đan Phượng Thành phố Hà Nội
107 09817 Xã Ô Diên Thành phố Hà Nội
108 09787 Xã Liên Minh Thành phố Hà Nội
109 00565 Xã Gia Lâm Thành phố Hà Nội
110 00562 Xã Thuận An Thành phố Hà Nội
111 00577 Xã Bát Tràng Thành phố Hà Nội
112 00541 Xã Phù Đổng Thành phố Hà Nội
113 00475 Xã Thư Lâm Thành phố Hà Nội
114 00454 Xã Đông Anh Thành phố Hà Nội
115 00466 Xã Phúc Thịnh Thành phố Hà Nội
116 00493 Xã Thiên Lộc Thành phố Hà Nội
Page 5
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
117 00508 Xã Vĩnh Thanh Thành phố Hà Nội
118 09022 Xã Mê Linh Thành phố Hà Nội
119 08980 Xã Yên Lãng Thành phố Hà Nội
120 08995 Xã Tiến Thắng Thành phố Hà Nội
121 08974 Xã Quang Minh Thành phố Hà Nội
122 00376 Xã Sóc Sơn Thành phố Hà Nội
123 00430 Xã Đa Phúc Thành phố Hà Nội
124 00433 Xã Nội Bài Thành phố Hà Nội
125 00385 Xã Trung Giã Thành phố Hà Nội
126 00382 Xã Kim Anh Thành phố Hà Nội

*/

-- all new phuong xa in 2025 set to temporary table
INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('00070','Phường Hoàn Kiếm','01'),
('00082','Phường Cửa Nam','01'),
('00004','Phường Ba Đình','01'),
('00008','Phường Ngọc Hà','01'),
('00025','Phường Giảng Võ','01'),
('00256','Phường Hai Bà Trưng','01'),
('00283','Phường Vĩnh Tuy','01'),
('00292','Phường Bạch Mai','01'),
('00235','Phường Đống Đa','01'),
('00229','Phường Kim Liên','01'),
('00226','Phường Văn Miếu - Quốc Tử Giám','01'),
('00199','Phường Láng','01'),
('00190','Phường Ô Chợ Dừa','01'),
('00097','Phường Hồng Hà','01'),
('00328','Phường Lĩnh Nam','01'),
('00331','Phường Hoàng Mai','01'),
('00301','Phường Vĩnh Hưng','01'),
('00322','Phường Tương Mai','01'),
('00316','Phường Định Công','01'),
('00337','Phường Hoàng Liệt','01'),
('00340','Phường Yên Sở','01'),
('00367','Phường Thanh Xuân','01'),
('00364','Phường Khương Đình','01'),
('00352','Phường Phương Liệt','01'),
('00166','Phường Cầu Giấy','01'),
('00160','Phường Nghĩa Đô','01'),
('00175','Phường Yên Hòa','01'),
('00103','Phường Tây Hồ','01'),
('00091','Phường Phú Thượng','01'),
('00613','Phường Tây Tựu','01'),
('00619','Phường Phú Diễn','01'),
('00611','Phường Xuân Đỉnh','01'),
('00602','Phường Đông Ngạc','01'),
('00598','Phường Thượng Cát','01'),
('00592','Phường Từ Liêm','01'),
('00622','Phường Xuân Phương','01'),
('00634','Phường Tây Mỗ','01'),
('00637','Phường Đại Mỗ','01'),
('00145','Phường Long Biên','01'),
('00118','Phường Bồ Đề','01'),
('00127','Phường Việt Hưng','01'),
('00136','Phường Phúc Lợi','01'),
('09556','Phường Hà Đông','01'),
('09886','Phường Dương Nội','01'),
('09562','Phường Yên Nghĩa','01'),
('09568','Phường Phú Lương','01'),
('09552','Phường Kiến Hưng','01'),
('00640','Xã Thanh Trì','01'),
('00664','Xã Đại Thanh','01'),
('00685','Xã Nam Phù','01'),
('00679','Xã Ngọc Hồi','01'),
('00643','Phường Thanh Liệt','01'),
('10231','Xã Thượng Phúc','01'),
('10183','Xã Thường Tín','01'),
('10237','Xã Chương Dương','01'),
('10210','Xã Hồng Vân','01'),
('10273','Xã Phú Xuyên','01'),
('10279','Xã Phượng Dực','01'),
('10330','Xã Chuyên Mỹ','01'),
('10342','Xã Đại Xuyên','01'),
('10114','Xã Thanh Oai','01'),
('10126','Xã Bình Minh','01'),
('10144','Xã Tam Hưng','01'),
('10180','Xã Dân Hòa','01'),
('10354','Xã Vân Đình','01'),
('10369','Xã Ứng Thiên','01'),
('10417','Xã Hòa Xá','01'),
('10402','Xã Ứng Hòa','01'),
('10441','Xã Mỹ Đức','01'),
('10465','Xã Hồng Sơn','01'),
('10459','Xã Phúc Sơn','01'),
('10489','Xã Hương Sơn','01'),
('10015','Phường Chương Mỹ','01'),
('10030','Xã Phú Nghĩa','01'),
('10045','Xã Xuân Mai','01'),
('10081','Xã Trần Phú','01'),
('10096','Xã Hòa Phú','01'),
('10072','Xã Quảng Bị','01'),
('09661','Xã Minh Châu','01'),
('09619','Xã Quảng Oai','01'),
('09664','Xã Vật Lại','01'),
('09634','Xã Cổ Đô','01'),
('09676','Xã Bất Bạt','01'),
('09694','Xã Suối Hai','01'),
('09700','Xã Ba Vì','01'),
('09706','Xã Yên Bài','01'),
('09574','Phường Sơn Tây','01'),
('09604','Phường Tùng Thiện','01'),
('09616','Xã Đoài Phương','01'),
('09715','Xã Phúc Thọ','01'),
('09739','Xã Phúc Lộc','01'),
('09772','Xã Hát Môn','01'),
('09955','Xã Thạch Thất','01'),
('09982','Xã Hạ Bằng','01'),
('10003','Xã Tây Phương','01'),
('09988','Xã Hòa Lạc','01'),
('04930','Xã Yên Xuân','01'),
('09895','Xã Quốc Oai','01'),
('09931','Xã Hưng Đạo','01'),
('09910','Xã Kiều Phú','01'),
('09952','Xã Phú Cát','01'),
('09832','Xã Hoài Đức','01'),
('09856','Xã Dương Hòa','01'),
('09871','Xã Sơn Đồng','01'),
('09877','Xã An Khánh','01'),
('09784','Xã Đan Phượng','01'),
('09817','Xã Ô Diên','01'),
('09787','Xã Liên Minh','01'),
('00565','Xã Gia Lâm','01'),
('00562','Xã Thuận An','01'),
('00577','Xã Bát Tràng','01'),
('00541','Xã Phù Đổng','01'),
('00475','Xã Thư Lâm','01'),
('00454','Xã Đông Anh','01'),
('00466','Xã Phúc Thịnh','01'),
('00493','Xã Thiên Lộc','01'),
('00508','Xã Vĩnh Thanh','01'),
('09022','Xã Mê Linh','01'),
('08980','Xã Yên Lãng','01'),
('08995','Xã Tiến Thắng','01'),
('08974','Xã Quang Minh','01'),
('00376','Xã Sóc Sơn','01'),
('00430','Xã Đa Phúc','01'),
('00433','Xã Nội Bài','01'),
('00385','Xã Trung Giã','01'),
('00382','Xã Kim Anh ','01');

/* ********************************************************************
TỈNH CAO BẰNG Tỉnh Cao Bằng
127 01273 Phường Thục Phán Tỉnh Cao Bằng
128 01279 Phường Nùng Trí Cao Tỉnh Cao Bằng
129 01288 Phường Tân Giang Tỉnh Cao Bằng
130 01304 Xã Quảng Lâm Tỉnh Cao Bằng
131 01297 Xã Nam Quang Tỉnh Cao Bằng
132 01294 Xã Lý Bôn Tỉnh Cao Bằng
133 01290 Xã Bảo Lâm Tỉnh Cao Bằng
134 01318 Xã Yên Thổ Tỉnh Cao Bằng
135 01360 Xã Sơn Lộ Tỉnh Cao Bằng
136 01351 Xã Hưng Đạo Tỉnh Cao Bằng
137 01321 Xã Bảo Lạc Tỉnh Cao Bằng
138 01324 Xã Cốc Pàng Tỉnh Cao Bằng
139 01327 Xã Cô Ba Tỉnh Cao Bằng
140 01336 Xã Khánh Xuân Tỉnh Cao Bằng
141 01339 Xã Xuân Trường Tỉnh Cao Bằng
142 01354 Xã Huy Giáp Tỉnh Cao Bằng
143 01738 Xã Ca Thành Tỉnh Cao Bằng
144 01768 Xã Phan Thanh Tỉnh Cao Bằng
145 01777 Xã Thành Công Tỉnh Cao Bằng
6
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
146 01729 Xã Tĩnh Túc Tỉnh Cao Bằng
147 01774 Xã Tam Kim Tỉnh Cao Bằng
148 01726 Xã Nguyên Bình Tỉnh Cao Bằng
149 01747 Xã Minh Tâm Tỉnh Cao Bằng
150 01387 Xã Thanh Long Tỉnh Cao Bằng
151 01366 Xã Cần Yên Tỉnh Cao Bằng
152 01363 Xã Thông Nông Tỉnh Cao Bằng
153 01392 Xã Trường Hà Tỉnh Cao Bằng
154 01438 Xã Hà Quảng Tỉnh Cao Bằng
155 01393 Xã Lũng Nặm Tỉnh Cao Bằng
156 01414 Xã Tổng Cọt Tỉnh Cao Bằng
157 01660 Xã Nam Tuấn Tỉnh Cao Bằng
158 01654 Xã Hòa An Tỉnh Cao Bằng
159 01708 Xã Bạch Đằng Tỉnh Cao Bằng
160 01699 Xã Nguyễn Huệ Tỉnh Cao Bằng
161 01795 Xã Minh Khai Tỉnh Cao Bằng
162 01789 Xã Canh Tân Tỉnh Cao Bằng
163 01792 Xã Kim Đồng Tỉnh Cao Bằng
164 01807 Xã Thạch An Tỉnh Cao Bằng
165 01786 Xã Đông Khê Tỉnh Cao Bằng
166 01822 Xã Đức Long Tỉnh Cao Bằng
167 01648 Xã Phục Hòa Tỉnh Cao Bằng
168 01636 Xã Bế Văn Đàn Tỉnh Cao Bằng
169 01594 Xã Độc Lập Tỉnh Cao Bằng
170 01576 Xã Quảng Uyên Tỉnh Cao Bằng
171 01618 Xã Hạnh Phúc Tỉnh Cao Bằng
172 01456 Xã Quang Hán Tỉnh Cao Bằng
173 01447 Xã Trà Lĩnh Tỉnh Cao Bằng
174 01465 Xã Quang Trung Tỉnh Cao Bằng
175 01525 Xã Đoài Dương Tỉnh Cao Bằng
7
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
176 01477 Xã Trùng Khánh Tỉnh Cao Bằng
177 01501 Xã Đàm Thủy Tỉnh Cao Bằng
178 01489 Xã Đình Phong Tỉnh Cao Bằng
179 01537 Xã Lý Quốc Tỉnh Cao Bằng
180 01558 Xã Hạ Lang Tỉnh Cao Bằng
181 01561 Xã Vinh Quý Tỉnh Cao Bằng
182 01552 Xã Quang Long Tỉnh Cao Bằng
*/

/* ********************************************************************
TỈNH TUYÊN QUANG Tỉnh Tuyên Quang
183 02269 Xã Thượng Lâm Tỉnh Tuyên Quang
184 02266 Xã Lâm Bình Tỉnh Tuyên Quang
185 02302 Xã Minh Quang Tỉnh Tuyên Quang
186 02296 Xã Bình An Tỉnh Tuyên Quang
187 02245 Xã Côn Lôn Tỉnh Tuyên Quang
188 02248 Xã Yên Hoa Tỉnh Tuyên Quang
189 02239 Xã Thượng Nông Tỉnh Tuyên Quang
190 02260 Xã Hồng Thái Tỉnh Tuyên Quang
191 02221 Xã Nà Hang Tỉnh Tuyên Quang
192 02308 Xã Tân Mỹ Tỉnh Tuyên Quang
193 02317 Xã Yên Lập Tỉnh Tuyên Quang
194 02320 Xã Tân An Tỉnh Tuyên Quang
195 02287 Xã Chiêm Hóa Tỉnh Tuyên Quang
196 02353 Xã Hòa An Tỉnh Tuyên Quang
197 02332 Xã Kiên Đài Tỉnh Tuyên Quang
198 02359 Xã Tri Phú Tỉnh Tuyên Quang
199 02350 Xã Kim Bình Tỉnh Tuyên Quang
200 02365 Xã Yên Nguyên Tỉnh Tuyên Quang
201 02305 Xã Trung Hà Tỉnh Tuyên Quang
202 02398 Xã Yên Phú Tỉnh Tuyên Quang
203 02380 Xã Bạch Xa Tỉnh Tuyên Quang
204 02392 Xã Phù Lưu Tỉnh Tuyên Quang
8
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
205 02374 Xã Hàm Yên Tỉnh Tuyên Quang
206 02404 Xã Bình Xa Tỉnh Tuyên Quang
207 02407 Xã Thái Sơn Tỉnh Tuyên Quang
208 02419 Xã Thái Hòa Tỉnh Tuyên Quang
209 02425 Xã Hùng Đức Tỉnh Tuyên Quang
210 02455 Xã Hùng Lợi Tỉnh Tuyên Quang
211 02458 Xã Trung Sơn Tỉnh Tuyên Quang
212 02494 Xã Thái Bình Tỉnh Tuyên Quang
213 02470 Xã Tân Long Tỉnh Tuyên Quang
214 02449 Xã Xuân Vân Tỉnh Tuyên Quang
215 02434 Xã Lực Hành Tỉnh Tuyên Quang
216 02473 Xã Yên Sơn Tỉnh Tuyên Quang
217 02530 Xã Nhữ Khê Tỉnh Tuyên Quang
218 02437 Xã Kiến Thiết Tỉnh Tuyên Quang
219 02545 Xã Tân Trào Tỉnh Tuyên Quang
220 02554 Xã Minh Thanh Tỉnh Tuyên Quang
221 02536 Xã Sơn Dương Tỉnh Tuyên Quang
222 02548 Xã Bình Ca Tỉnh Tuyên Quang
223 02578 Xã Tân Thanh Tỉnh Tuyên Quang
224 02620 Xã Sơn Thủy Tỉnh Tuyên Quang
225 02611 Xã Phú Lương Tỉnh Tuyên Quang
226 02623 Xã Trường Sinh Tỉnh Tuyên Quang
227 02608 Xã Hồng Sơn Tỉnh Tuyên Quang
228 02572 Xã Đông Thọ Tỉnh Tuyên Quang
229 02509 Phường Mỹ Lâm Tỉnh Tuyên Quang
230 02215 Phường Minh Xuân Tỉnh Tuyên Quang
231 02212 Phường Nông Tiến Tỉnh Tuyên Quang
232 02512 Phường An Tường Tỉnh Tuyên Quang
233 02524 Phường Bình Thuận Tỉnh Tuyên Quang
234 00715 Xã Lũng Cú Tỉnh Tuyên Quang
9
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
235 00721 Xã Đồng Văn Tỉnh Tuyên Quang
236 00733 Xã Sà Phìn Tỉnh Tuyên Quang
237 00745 Xã Phố Bảng Tỉnh Tuyên Quang
238 00763 Xã Lũng Phìn Tỉnh Tuyên Quang
239 00787 Xã Sủng Máng Tỉnh Tuyên Quang
240 00778 Xã Sơn Vĩ Tỉnh Tuyên Quang
241 00769 Xã Mèo Vạc Tỉnh Tuyên Quang
242 00802 Xã Khâu Vai Tỉnh Tuyên Quang
243 00817 Xã Niêm Sơn Tỉnh Tuyên Quang
244 00808 Xã Tát Ngà Tỉnh Tuyên Quang
245 00829 Xã Thắng Mố Tỉnh Tuyên Quang
246 00832 Xã Bạch Đích Tỉnh Tuyên Quang
247 00820 Xã Yên Minh Tỉnh Tuyên Quang
248 00847 Xã Mậu Duệ Tỉnh Tuyên Quang
249 00859 Xã Ngọc Long Tỉnh Tuyên Quang
250 00871 Xã Du Già Tỉnh Tuyên Quang
251 00865 Xã Đường Thượng Tỉnh Tuyên Quang
252 00901 Xã Lùng Tám Tỉnh Tuyên Quang
253 00883 Xã Cán Tỷ Tỉnh Tuyên Quang
254 00889 Xã Nghĩa Thuận Tỉnh Tuyên Quang
255 00874 Xã Quản Bạ Tỉnh Tuyên Quang
256 00892 Xã Tùng Vài Tỉnh Tuyên Quang
257 01006 Xã Yên Cường Tỉnh Tuyên Quang
258 01012 Xã Đường Hồng Tỉnh Tuyên Quang
259 00991 Xã Bắc Mê Tỉnh Tuyên Quang
260 00985 Xã Giáp Trung Tỉnh Tuyên Quang
261 00982 Xã Minh Sơn Tỉnh Tuyên Quang
262 00994 Xã Minh Ngọc Tỉnh Tuyên Quang
263 00700 Xã Ngọc Đường Tỉnh Tuyên Quang
264 00694 Phường Hà Giang 1 Tỉnh Tuyên Quang
10
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
265 00691 Phường Hà Giang 2 Tỉnh Tuyên Quang
266 00937 Xã Lao Chải Tỉnh Tuyên Quang
267 00928 Xã Thanh Thủy Tỉnh Tuyên Quang
268 00919 Xã Minh Tân Tỉnh Tuyên Quang
269 00922 Xã Thuận Hòa Tỉnh Tuyên Quang
270 00925 Xã Tùng Bá Tỉnh Tuyên Quang
271 00706 Xã Phú Linh Tỉnh Tuyên Quang
272 00970 Xã Linh Hồ Tỉnh Tuyên Quang
273 00976 Xã Bạch Ngọc Tỉnh Tuyên Quang
274 00913 Xã Vị Xuyên Tỉnh Tuyên Quang
275 00967 Xã Việt Lâm Tỉnh Tuyên Quang
276 00952 Xã Cao Bồ Tỉnh Tuyên Quang
277 00958 Xã Thượng Sơn Tỉnh Tuyên Quang
278 01171 Xã Tân Quang Tỉnh Tuyên Quang
279 01165 Xã Đồng Tâm Tỉnh Tuyên Quang
280 01192 Xã Liên Hiệp Tỉnh Tuyên Quang
281 01180 Xã Bằng Hành Tỉnh Tuyên Quang
282 01153 Xã Bắc Quang Tỉnh Tuyên Quang
283 01201 Xã Hùng An Tỉnh Tuyên Quang
284 01156 Xã Vĩnh Tuy Tỉnh Tuyên Quang
285 01216 Xã Đồng Yên Tỉnh Tuyên Quang
286 01261 Xã Tiên Yên Tỉnh Tuyên Quang
287 01255 Xã Xuân Giang Tỉnh Tuyên Quang
288 01246 Xã Bằng Lang Tỉnh Tuyên Quang
289 01234 Xã Yên Thành Tỉnh Tuyên Quang
290 01237 Xã Quang Bình Tỉnh Tuyên Quang
291 01243 Xã Tân Trịnh Tỉnh Tuyên Quang
292 01225 Xã Tiên Nguyên Tỉnh Tuyên Quang
293 01090 Xã Thông Nguyên Tỉnh Tuyên Quang
294 01084 Xã Hồ Thầu Tỉnh Tuyên Quang
11
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
295 01075 Xã Nậm Dịch Tỉnh Tuyên Quang
296 01051 Xã Tân Tiến Tỉnh Tuyên Quang
297 01021 Xã Hoàng Su Phì Tỉnh Tuyên Quang
298 01033 Xã Thàng Tín Tỉnh Tuyên Quang
299 01024 Xã Bản Máy Tỉnh Tuyên Quang
300 01057 Xã Pờ Ly Ngài Tỉnh Tuyên Quang
301 01108 Xã Xín Mần Tỉnh Tuyên Quang
302 01096 Xã Pà Vầy Sủ Tỉnh Tuyên Quang
303 01141 Xã Nấm Dẩn Tỉnh Tuyên Quang
304 01117 Xã Trung Thịnh Tỉnh Tuyên Quang
305 01144 Xã Quảng Nguyên Tỉnh Tuyên Quang
306 01147 Xã Khuôn Lùng Tỉnh Tuyên Quang
*/

/* ********************************************************************
TỈNH ĐIỆN BIÊN Tỉnh Điện Biên
307 03325 Xã Mường Phăng Tỉnh Điện Biên
308 03127 Phường Điện Biên Phủ Tỉnh Điện Biên
309 03334 Phường Mường Thanh Tỉnh Điện Biên
310 03151 Phường Mường Lay Tỉnh Điện Biên
311 03328 Xã Thanh Nưa Tỉnh Điện Biên
312 03352 Xã Thanh An Tỉnh Điện Biên
313 03349 Xã Thanh Yên Tỉnh Điện Biên
314 03356 Xã Sam Mứn Tỉnh Điện Biên
315 03358 Xã Núa Ngam Tỉnh Điện Biên
316 03368 Xã Mường Nhà Tỉnh Điện Biên
317 03253 Xã Tuần Giáo Tỉnh Điện Biên
318 03295 Xã Quài Tở Tỉnh Điện Biên
319 03268 Xã Mường Mùn Tỉnh Điện Biên
320 03260 Xã Pú Nhung Tỉnh Điện Biên
321 03283 Xã Chiềng Sinh Tỉnh Điện Biên
322 03217 Xã Tủa Chùa Tỉnh Điện Biên
323 03226 Xã Sín Chải Tỉnh Điện Biên
12
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
324 03241 Xã Sính Phình Tỉnh Điện Biên
325 03220 Xã Tủa Thàng Tỉnh Điện Biên
326 03244 Xã Sáng Nhè Tỉnh Điện Biên
327 03172 Xã Na Sang Tỉnh Điện Biên
328 03181 Xã Mường Tùng Tỉnh Điện Biên
329 03193 Xã Pa Ham Tỉnh Điện Biên
330 03194 Xã Nậm Nèn Tỉnh Điện Biên
331 03202 Xã Mường Pồn Tỉnh Điện Biên
332 03203 Xã Na Son Tỉnh Điện Biên
333 03208 Xã Xa Dung Tỉnh Điện Biên
334 03370 Xã Pu Nhi Tỉnh Điện Biên
335 03214 Xã Mường Luân Tỉnh Điện Biên
336 03385 Xã Tìa Dình Tỉnh Điện Biên
337 03382 Xã Phình Giàng Tỉnh Điện Biên
338 03166 Xã Mường Chà Tỉnh Điện Biên
339 03169 Xã Nà Hỳ Tỉnh Điện Biên
340 03176 Xã Nà Bủng Tỉnh Điện Biên
341 03175 Xã Chà Tở Tỉnh Điện Biên
342 03199 Xã Si Pa Phìn Tỉnh Điện Biên
343 03160 Xã Mường Nhé Tỉnh Điện Biên
344 03158 Xã Sín Thầu Tỉnh Điện Biên
345 03163 Xã Mường Toong Tỉnh Điện Biên
346 03162 Xã Nậm Kè Tỉnh Điện Biên
347 03164 Xã Quảng Lâm Tỉnh Điện Biên
348 03256 Xã Mường Ảng Tỉnh Điện Biên
349 03316 Xã Nà Tấu Tỉnh Điện Biên
350 03301 Xã Búng Lao Tỉnh Điện Biên
351 03313 Xã Mường Lạn Tỉnh Điện Biên
*/

/* ********************************************************************
TỈNH LAI CHÂU Tỉnh Lai Châu
352 03637 Xã Mường Kim Tỉnh Lai Châu
13
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
353 03640 Xã Khoen On Tỉnh Lai Châu
354 03595 Xã Than Uyên Tỉnh Lai Châu
355 03618 Xã Mường Than Tỉnh Lai Châu
356 03616 Xã Pắc Ta Tỉnh Lai Châu
357 03613 Xã Nậm Sỏ Tỉnh Lai Châu
358 03598 Xã Tân Uyên Tỉnh Lai Châu
359 03601 Xã Mường Khoa Tỉnh Lai Châu
360 03424 Xã Bản Bo Tỉnh Lai Châu
361 03390 Xã Bình Lư Tỉnh Lai Châu
362 03405 Xã Tả Lèng Tỉnh Lai Châu
363 03430 Xã Khun Há Tỉnh Lai Châu
364 03408 Phường Tân Phong Tỉnh Lai Châu
365 03388 Phường Đoàn Kết Tỉnh Lai Châu
366 03394 Xã Sin Suối Hồ Tỉnh Lai Châu
367 03549 Xã Phong Thổ Tỉnh Lai Châu
368 03562 Xã Sì Lở Lầu Tỉnh Lai Châu
369 03571 Xã Dào San Tỉnh Lai Châu
370 03583 Xã Khổng Lào Tỉnh Lai Châu
371 03529 Xã Tủa Sín Chải Tỉnh Lai Châu
372 03478 Xã Sìn Hồ Tỉnh Lai Châu
373 03508 Xã Hồng Thu Tỉnh Lai Châu
374 03517 Xã Nậm Tăm Tỉnh Lai Châu
375 03532 Xã Pu Sam Cáp Tỉnh Lai Châu
376 03544 Xã Nậm Cuổi Tỉnh Lai Châu
377 03538 Xã Nậm Mạ Tỉnh Lai Châu
378 03487 Xã Lê Lợi Tỉnh Lai Châu
379 03434 Xã Nậm Hàng Tỉnh Lai Châu
380 03472 Xã Mường Mô Tỉnh Lai Châu
381 03460 Xã Hua Bum Tỉnh Lai Châu
382 03503 Xã Pa Tần Tỉnh Lai Châu
14
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
383 03466 Xã Bum Nưa Tỉnh Lai Châu
384 03433 Xã Bum Tở Tỉnh Lai Châu
385 03445 Xã Mường Tè Tỉnh Lai Châu
386 03439 Xã Thu Lũm Tỉnh Lai Châu
387 03442 Xã Pa Ủ Tỉnh Lai Châu
388 03463 Xã Tà Tổng Tỉnh Lai Châu
389 03451 Xã Mù Cả Tỉnh Lai Châu
*/

/* ********************************************************************
TỈNH SƠN LA Tỉnh Sơn La
390 03646 Phường Tô Hiệu Tỉnh Sơn La
391 03664 Phường Chiềng An Tỉnh Sơn La
392 03670 Phường Chiềng Cơi Tỉnh Sơn La
393 03679 Phường Chiềng Sinh Tỉnh Sơn La
394 03980 Phường Mộc Châu Tỉnh Sơn La
395 03979 Phường Mộc Sơn Tỉnh Sơn La
396 04033 Phường Vân Sơn Tỉnh Sơn La
397 03982 Phường Thảo Nguyên Tỉnh Sơn La
398 04000 Xã Đoàn Kết Tỉnh Sơn La
399 04045 Xã Lóng Sập Tỉnh Sơn La
400 03985 Xã Chiềng Sơn Tỉnh Sơn La
401 04048 Xã Vân Hồ Tỉnh Sơn La
402 04006 Xã Song Khủa Tỉnh Sơn La
403 04018 Xã Tô Múa Tỉnh Sơn La
404 04057 Xã Xuân Nha Tỉnh Sơn La
405 03703 Xã Quỳnh Nhai Tỉnh Sơn La
406 03688 Xã Mường Chiên Tỉnh Sơn La
407 03694 Xã Mường Giôn Tỉnh Sơn La
408 03712 Xã Mường Sại Tỉnh Sơn La
409 03721 Xã Thuận Châu Tỉnh Sơn La
410 03754 Xã Chiềng La Tỉnh Sơn La
411 03784 Xã Nậm Lầu Tỉnh Sơn La
15
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
412 03799 Xã Muổi Nọi Tỉnh Sơn La
413 03757 Xã Mường Khiêng Tỉnh Sơn La
414 03781 Xã Co Mạ Tỉnh Sơn La
415 03724 Xã Bình Thuận Tỉnh Sơn La
416 03727 Xã Mường É Tỉnh Sơn La
417 03763 Xã Long Hẹ Tỉnh Sơn La
418 03808 Xã Mường La Tỉnh Sơn La
419 03814 Xã Chiềng Lao Tỉnh Sơn La
420 03847 Xã Mường Bú Tỉnh Sơn La
421 03850 Xã Chiềng Hoa Tỉnh Sơn La
422 03856 Xã Bắc Yên Tỉnh Sơn La
423 03868 Xã Tà Xùa Tỉnh Sơn La
424 03880 Xã Tạ Khoa Tỉnh Sơn La
425 03862 Xã Xím Vàng Tỉnh Sơn La
426 03871 Xã Pắc Ngà Tỉnh Sơn La
427 03892 Xã Chiềng Sại Tỉnh Sơn La
428 03910 Xã Phù Yên Tỉnh Sơn La
429 03922 Xã Gia Phù Tỉnh Sơn La
430 03958 Xã Tường Hạ Tỉnh Sơn La
431 03907 Xã Mường Cơi Tỉnh Sơn La
432 03943 Xã Mường Bang Tỉnh Sơn La
433 03970 Xã Tân Phong Tỉnh Sơn La
434 03961 Xã Kim Bon Tỉnh Sơn La
435 04075 Xã Yên Châu Tỉnh Sơn La
436 04078 Xã Chiềng Hặc Tỉnh Sơn La
437 04096 Xã Lóng Phiêng Tỉnh Sơn La
438 04087 Xã Yên Sơn Tỉnh Sơn La
439 04132 Xã Chiềng Mai Tỉnh Sơn La
440 04105 Xã Mai Sơn Tỉnh Sơn La
441 04159 Xã Phiêng Pằn Tỉnh Sơn La
16
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
442 04123 Xã Chiềng Mung Tỉnh Sơn La
443 04144 Xã Phiêng Cằm Tỉnh Sơn La
444 04117 Xã Mường Chanh Tỉnh Sơn La
445 04136 Xã Tà Hộc Tỉnh Sơn La
446 04108 Xã Chiềng Sung Tỉnh Sơn La
447 04171 Xã Bó Sinh Tỉnh Sơn La
448 04222 Xã Chiềng Khương Tỉnh Sơn La
449 04219 Xã Mường Hung Tỉnh Sơn La
450 04204 Xã Chiềng Khoong Tỉnh Sơn La
451 04183 Xã Mường Lầm Tỉnh Sơn La
452 04186 Xã Nậm Ty Tỉnh Sơn La
453 04168 Xã Sông Mã Tỉnh Sơn La
454 04210 Xã Huổi Một Tỉnh Sơn La
455 04195 Xã Chiềng Sơ Tỉnh Sơn La
456 04231 Xã Sốp Cộp Tỉnh Sơn La
457 04228 Xã Púng Bánh Tỉnh Sơn La
458 03997 Xã Tân Yên Tỉnh Sơn La
459 03760 Xã Mường Bám Tỉnh Sơn La
460 03820 Xã Ngọc Chiến Tỉnh Sơn La
461 03901 Xã Suối Tọ Tỉnh Sơn La
462 04099 Xã Phiêng Khoài Tỉnh Sơn La
463 04246 Xã Mường Lạn Tỉnh Sơn La
464 04240 Xã Mường Lèo Tỉnh Sơn La
*/

/* ********************************************************************
TỈNH LÀO CAI Tỉnh Lào Cai
465 04465 Xã Khao Mang Tỉnh Lào Cai
466 04456 Xã Mù Cang Chải Tỉnh Lào Cai
467 04492 Xã Púng Luông Tỉnh Lào Cai
468 04630 Xã Tú Lệ Tỉnh Lào Cai
469 04606 Xã Trạm Tấu Tỉnh Lào Cai
470 04585 Xã Hạnh Phúc Tỉnh Lào Cai
17
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
471 04609 Xã Phình Hồ Tỉnh Lào Cai
472 04288 Phường Nghĩa Lộ Tỉnh Lào Cai
473 04663 Phường Trung Tâm Tỉnh Lào Cai
474 04681 Phường Cầu Thia Tỉnh Lào Cai
475 04660 Xã Liên Sơn Tỉnh Lào Cai
476 04636 Xã Gia Hội Tỉnh Lào Cai
477 04651 Xã Sơn Lương Tỉnh Lào Cai
478 04705 Xã Thượng Bằng La Tỉnh Lào Cai
479 04699 Xã Chấn Thịnh Tỉnh Lào Cai
480 04711 Xã Nghĩa Tâm Tỉnh Lào Cai
481 04672 Xã Văn Chấn Tỉnh Lào Cai
482 04402 Xã Phong Dụ Hạ Tỉnh Lào Cai
483 04387 Xã Châu Quế Tỉnh Lào Cai
484 04381 Xã Lâm Giang Tỉnh Lào Cai
485 04399 Xã Đông Cuông Tỉnh Lào Cai
486 04429 Xã Tân Hợp Tỉnh Lào Cai
487 04375 Xã Mậu A Tỉnh Lào Cai
488 04441 Xã Xuân Á i Tỉnh Lào Cai
489 04450 Xã Mỏ Vàng Tỉnh Lào Cai
490 04309 Xã Lâm Thượng Tỉnh Lào Cai
491 04303 Xã Lục Yên Tỉnh Lào Cai
492 04336 Xã Tân Lĩnh Tỉnh Lào Cai
493 04342 Xã Khánh Hòa Tỉnh Lào Cai
494 04363 Xã Phúc Lợi Tỉnh Lào Cai
495 04345 Xã Mường Lai Tỉnh Lào Cai
496 04726 Xã Cảm Nhân Tỉnh Lào Cai
497 04744 Xã Yên Thành Tỉnh Lào Cai
498 04717 Xã Thác Bà Tỉnh Lào Cai
499 04714 Xã Yên Bình Tỉnh Lào Cai
500 04750 Xã Bảo Á i Tỉnh Lào Cai
18
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
501 04279 Phường Văn Phú Tỉnh Lào Cai
502 04252 Phường Yên Bái Tỉnh Lào Cai
503 04273 Phường Nam Cường Tỉnh Lào Cai
504 04543 Phường Âu Lâu Tỉnh Lào Cai
505 04498 Xã Trấn Yên Tỉnh Lào Cai
506 04576 Xã Hưng Khánh Tỉnh Lào Cai
507 04537 Xã Lương Thịnh Tỉnh Lào Cai
508 04564 Xã Việt Hồng Tỉnh Lào Cai
509 04531 Xã Quy Mông Tỉnh Lào Cai
510 02902 Xã Phong Hải Tỉnh Lào Cai
511 02926 Xã Xuân Quang Tỉnh Lào Cai
512 02905 Xã Bảo Thắng Tỉnh Lào Cai
513 02908 Xã Tằng Loỏng Tỉnh Lào Cai
514 02923 Xã Gia Phú Tỉnh Lào Cai
515 02746 Xã Cốc San Tỉnh Lào Cai
516 02680 Xã Hợp Thành Tỉnh Lào Cai
517 02671 Phường Cam Đường Tỉnh Lào Cai
518 02647 Phường Lào Cai Tỉnh Lào Cai
519 02728 Xã Mường Hum Tỉnh Lào Cai
520 02707 Xã Dền Sáng Tỉnh Lào Cai
521 02701 Xã Y Tý Tỉnh Lào Cai
522 02686 Xã A Mú Sung Tỉnh Lào Cai
523 02695 Xã Trịnh Tường Tỉnh Lào Cai
524 02725 Xã Bản Xèo Tỉnh Lào Cai
525 02683 Xã Bát Xát Tỉnh Lào Cai
526 02953 Xã Nghĩa Đô Tỉnh Lào Cai
527 02968 Xã Thượng Hà Tỉnh Lào Cai
528 02947 Xã Bảo Yên Tỉnh Lào Cai
529 02962 Xã Xuân Hòa Tỉnh Lào Cai
530 02998 Xã Phúc Khánh Tỉnh Lào Cai
19
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
531 02989 Xã Bảo Hà Tỉnh Lào Cai
532 03061 Xã Võ Lao Tỉnh Lào Cai
533 03103 Xã Khánh Yên Tỉnh Lào Cai
534 03082 Xã Văn Bàn Tỉnh Lào Cai
535 03106 Xã Dương Quỳ Tỉnh Lào Cai
536 03091 Xã Chiềng Ken Tỉnh Lào Cai
537 03121 Xã Minh Lương Tỉnh Lào Cai
538 03076 Xã Nậm Chày Tỉnh Lào Cai
539 03043 Xã Mường Bo Tỉnh Lào Cai
540 03046 Xã Bản Hồ Tỉnh Lào Cai
541 03013 Xã Tả Phìn Tỉnh Lào Cai
542 03037 Xã Tả Van Tỉnh Lào Cai
543 03006 Phường Sa Pa Tỉnh Lào Cai
544 02896 Xã Cốc Lầu Tỉnh Lào Cai
545 02890 Xã Bảo Nhai Tỉnh Lào Cai
546 02869 Xã Bản Liền Tỉnh Lào Cai
547 02839 Xã Bắc Hà Tỉnh Lào Cai
548 02842 Xã Tả Củ Tỷ Tỉnh Lào Cai
549 02848 Xã Lùng Phình Tỉnh Lào Cai
550 02752 Xã Pha Long Tỉnh Lào Cai
551 02761 Xã Mường Khương Tỉnh Lào Cai
552 02788 Xã Bản Lầu Tỉnh Lào Cai
553 02782 Xã Cao Sơn Tỉnh Lào Cai
554 02809 Xã Si Ma Cai Tỉnh Lào Cai
555 02824 Xã Sín Chéng Tỉnh Lào Cai
556 04474 Xã Lao Chải Tỉnh Lào Cai
557 04489 Xã Chế Tạo Tỉnh Lào Cai
558 04462 Xã Nậm Có Tỉnh Lào Cai
559 04603 Xã Tà Xi Láng Tỉnh Lào Cai
560 04423 Xã Phong Dụ Thượng Tỉnh Lào Cai
20
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
561 04693 Xã Cát Thịnh Tỉnh Lào Cai
562 03085 Xã Nậm Xé Tỉnh Lào Cai
563 03004 Xã Ngũ Chỉ Sơn Tỉnh Lào Cai
*/

/* ********************************************************************
TỈNH THÁI NGUYÊN Tỉnh Thái Nguyên
*/
/*
564 05443 Phường Phan Đình Phùng Tỉnh Thái Nguyên
565 05710 Phường Linh Sơn Tỉnh Thái Nguyên
566 05500 Phường Tích Lương Tỉnh Thái Nguyên
567 05467 Phường Gia Sàng Tỉnh Thái Nguyên
568 05455 Phường Quyết Thắng Tỉnh Thái Nguyên
569 05482 Phường Quan Triều Tỉnh Thái Nguyên
570 05503 Xã Tân Cương Tỉnh Thái Nguyên
571 05488 Xã Đại Phúc Tỉnh Thái Nguyên
572 05830 Xã Đại Từ Tỉnh Thái Nguyên
573 05776 Xã Đức Lương Tỉnh Thái Nguyên
574 05800 Xã Phú Thịnh Tỉnh Thái Nguyên
575 05818 Xã La Bằng Tỉnh Thái Nguyên
576 05788 Xã Phú Lạc Tỉnh Thái Nguyên
577 05809 Xã An Khánh Tỉnh Thái Nguyên
578 05851 Xã Quân Chu Tỉnh Thái Nguyên
579 05845 Xã Vạn Phú Tỉnh Thái Nguyên
580 05773 Xã Phú Xuyên Tỉnh Thái Nguyên
581 05860 Phường Phổ Yên Tỉnh Thái Nguyên
582 05890 Phường Vạn Xuân Tỉnh Thái Nguyên
583 05899 Phường Trung Thành Tỉnh Thái Nguyên
584 05857 Phường Phúc Thuận Tỉnh Thái Nguyên
585 05881 Xã Thành Công Tỉnh Thái Nguyên
586 05908 Xã Phú Bình Tỉnh Thái Nguyên
587 05923 Xã Tân Thành Tỉnh Thái Nguyên
588 05941 Xã Điềm Thụy Tỉnh Thái Nguyên
589 05953 Xã Kha Sơn Tỉnh Thái Nguyên
21
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
590 05917 Xã Tân Khánh Tỉnh Thái Nguyên
591 05692 Xã Đồng Hỷ Tỉnh Thái Nguyên
592 05674 Xã Quang Sơn Tỉnh Thái Nguyên
593 05662 Xã Trại Cau Tỉnh Thái Nguyên
594 05707 Xã Nam Hòa Tỉnh Thái Nguyên
595 05680 Xã Văn Hán Tỉnh Thái Nguyên
596 05665 Xã Văn Lăng Tỉnh Thái Nguyên
597 05518 Phường Sông Công Tỉnh Thái Nguyên
598 05533 Phường Bá Xuyên Tỉnh Thái Nguyên
599 05528 Phường Bách Quang Tỉnh Thái Nguyên
600 05611 Xã Phú Lương Tỉnh Thái Nguyên
601 05641 Xã Vô Tranh Tỉnh Thái Nguyên
602 05620 Xã Yên Trạch Tỉnh Thái Nguyên
603 05632 Xã Hợp Thành Tỉnh Thái Nguyên
604 05569 Xã Định Hóa Tỉnh Thái Nguyên
605 05587 Xã Bình Yên Tỉnh Thái Nguyên
606 05581 Xã Trung Hội Tỉnh Thái Nguyên
607 05563 Xã Phượng Tiến Tỉnh Thái Nguyên
608 05602 Xã Phú Đình Tỉnh Thái Nguyên
609 05605 Xã Bình Thành Tỉnh Thái Nguyên
610 05551 Xã Kim Phượng Tỉnh Thái Nguyên
611 05542 Xã Lam Vỹ Tỉnh Thái Nguyên
612 05716 Xã Võ Nhai Tỉnh Thái Nguyên
613 05719 Xã Sảng Mộc Tỉnh Thái Nguyên
614 05755 Xã Dân Tiến Tỉnh Thái Nguyên
615 05722 Xã Nghinh Tường Tỉnh Thái Nguyên
616 05725 Xã Thần Sa Tỉnh Thái Nguyên
617 05740 Xã La Hiên Tỉnh Thái Nguyên
618 05746 Xã Tràng Xá Tỉnh Thái Nguyên
619 01864 Xã Bằng Thành Tỉnh Thái Nguyên
22
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
620 01882 Xã Nghiên Loan Tỉnh Thái Nguyên
621 01879 Xã Cao Minh Tỉnh Thái Nguyên
622 01906 Xã Ba Bể Tỉnh Thái Nguyên
623 01912 Xã Chợ Rã Tỉnh Thái Nguyên
624 01894 Xã Phúc Lộc Tỉnh Thái Nguyên
625 01921 Xã Thượng Minh Tỉnh Thái Nguyên
626 01933 Xã Đồng Phúc Tỉnh Thái Nguyên
627 02116 Xã Yên Bình Tỉnh Thái Nguyên
628 01942 Xã Bằng Vân Tỉnh Thái Nguyên
629 01954 Xã Ngân Sơn Tỉnh Thái Nguyên
630 01936 Xã Nà Phặc Tỉnh Thái Nguyên
631 01960 Xã Hiệp Lực Tỉnh Thái Nguyên
632 02026 Xã Nam Cường Tỉnh Thái Nguyên
633 02038 Xã Quảng Bạch Tỉnh Thái Nguyên
634 02044 Xã Yên Thịnh Tỉnh Thái Nguyên
635 02020 Xã Chợ Đồn Tỉnh Thái Nguyên
636 02083 Xã Yên Phong Tỉnh Thái Nguyên
637 02071 Xã Nghĩa Tá Tỉnh Thái Nguyên
638 01969 Xã Phủ Thông Tỉnh Thái Nguyên
639 02008 Xã Cẩm Giàng Tỉnh Thái Nguyên
640 01981 Xã Vĩnh Thông Tỉnh Thái Nguyên
641 02014 Xã Bạch Thông Tỉnh Thái Nguyên
642 01849 Xã Phong Quang Tỉnh Thái Nguyên
643 01840 Phường Đức Xuân Tỉnh Thái Nguyên
644 01843 Phường Bắc Kạn Tỉnh Thái Nguyên
645 02143 Xã Văn Lang Tỉnh Thái Nguyên
646 02152 Xã Cường Lợi Tỉnh Thái Nguyên
647 02155 Xã Na Rì Tỉnh Thái Nguyên
648 02176 Xã Trần Phú Tỉnh Thái Nguyên
649 02185 Xã Côn Minh Tỉnh Thái Nguyên
23
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
650 02191 Xã Xuân Dương Tỉnh Thái Nguyên
651 02104 Xã Tân Kỳ Tỉnh Thái Nguyên
652 02101 Xã Thanh Mai Tỉnh Thái Nguyên
653 02107 Xã Thanh Thịnh Tỉnh Thái Nguyên
654 02086 Xã Chợ Mới Tỉnh Thái Nguyên
655 01957 Xã Thượng Quan Tỉnh Thái Nguyên
*/

/* ********************************************************************
TỈNH LẠNG SƠN Tỉnh Lạng Sơn
656 06040 Xã Thất Khê Tỉnh Lạng Sơn
657 06001 Xã Đoàn Kết Tỉnh Lạng Sơn
658 06019 Xã Tân Tiến Tỉnh Lạng Sơn
659 06046 Xã Tràng Định Tỉnh Lạng Sơn
660 06004 Xã Quốc Khánh Tỉnh Lạng Sơn
661 06037 Xã Kháng Chiến Tỉnh Lạng Sơn
662 06058 Xã Quốc Việt Tỉnh Lạng Sơn
663 06112 Xã Bình Gia Tỉnh Lạng Sơn
664 06115 Xã Tân Văn Tỉnh Lạng Sơn
665 06079 Xã Hồng Phong Tỉnh Lạng Sơn
666 06073 Xã Hoa Thám Tỉnh Lạng Sơn
667 06076 Xã Quý Hòa Tỉnh Lạng Sơn
668 06085 Xã Thiện Hòa Tỉnh Lạng Sơn
669 06091 Xã Thiện Thuật Tỉnh Lạng Sơn
670 06103 Xã Thiện Long Tỉnh Lạng Sơn
671 06325 Xã Bắc Sơn Tỉnh Lạng Sơn
672 06349 Xã Hưng Vũ Tỉnh Lạng Sơn
673 06367 Xã Vũ Lăng Tỉnh Lạng Sơn
674 06376 Xã Nhất Hòa Tỉnh Lạng Sơn
675 06364 Xã Vũ Lễ Tỉnh Lạng Sơn
676 06337 Xã Tân Tri Tỉnh Lạng Sơn
677 06253 Xã Văn Quan Tỉnh Lạng Sơn
678 06280 Xã Điềm He Tỉnh Lạng Sơn
24
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
679 06313 Xã Tri Lễ Tỉnh Lạng Sơn
680 06298 Xã Yên Phúc Tỉnh Lạng Sơn
681 06316 Xã Tân Đoàn Tỉnh Lạng Sơn
682 06286 Xã Khánh Khê Tỉnh Lạng Sơn
683 06124 Xã Na Sầm Tỉnh Lạng Sơn
684 06154 Xã Văn Lãng Tỉnh Lạng Sơn
685 06151 Xã Hội Hoan Tỉnh Lạng Sơn
686 06148 Xã Thụy Hùng Tỉnh Lạng Sơn
687 06172 Xã Hoàng Văn Thụ Tỉnh Lạng Sơn
688 06529 Xã Lộc Bình Tỉnh Lạng Sơn
689 06541 Xã Mẫu Sơn Tỉnh Lạng Sơn
690 06526 Xã Na Dương Tỉnh Lạng Sơn
691 06601 Xã Lợi Bác Tỉnh Lạng Sơn
692 06577 Xã Thống Nhất Tỉnh Lạng Sơn
693 06607 Xã Xuân Dương Tỉnh Lạng Sơn
694 06565 Xã Khuất Xá Tỉnh Lạng Sơn
695 06613 Xã Đình Lập Tỉnh Lạng Sơn
696 06637 Xã Châu Sơn Tỉnh Lạng Sơn
697 06625 Xã Kiên Mộc Tỉnh Lạng Sơn
698 06616 Xã Thái Bình Tỉnh Lạng Sơn
699 06385 Xã Hữu Lũng Tỉnh Lạng Sơn
700 06457 Xã Tuấn Sơn Tỉnh Lạng Sơn
701 06445 Xã Tân Thành Tỉnh Lạng Sơn
702 06415 Xã Vân Nham Tỉnh Lạng Sơn
703 06436 Xã Thiện Tân Tỉnh Lạng Sơn
704 06391 Xã Yên Bình Tỉnh Lạng Sơn
705 06400 Xã Hữu Liên Tỉnh Lạng Sơn
706 06427 Xã Cai Kinh Tỉnh Lạng Sơn
707 06463 Xã Chi Lăng Tỉnh Lạng Sơn
708 06496 Xã Nhân Lý Tỉnh Lạng Sơn
25
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
709 06481 Xã Chiến Thắng Tỉnh Lạng Sơn
710 06517 Xã Quan Sơn Tỉnh Lạng Sơn
711 06475 Xã Bằng Mạc Tỉnh Lạng Sơn
712 06505 Xã Vạn Linh Tỉnh Lạng Sơn
713 06184 Xã Đồng Đăng Tỉnh Lạng Sơn
714 06211 Xã Cao Lộc Tỉnh Lạng Sơn
715 06220 Xã Công Sơn Tỉnh Lạng Sơn
716 06196 Xã Ba Sơn Tỉnh Lạng Sơn
717 05986 Phường Tam Thanh Tỉnh Lạng Sơn
718 05983 Phường Lương Văn Tri Tỉnh Lạng Sơn
719 06187 Phường Kỳ Lừa Tỉnh Lạng Sơn
720 05977 Phường Đông Kinh Tỉnh Lạng Sơn
*/

/* ********************************************************************
TỈNH QUẢNG NINH Tỉnh Quảng Ninh
721 07090 Phường An Sinh Tỉnh Quảng Ninh
722 07093 Phường Đông Triều Tỉnh Quảng Ninh
723 07081 Phường Bình Khê Tỉnh Quảng Ninh
724 07069 Phường Mạo Khê Tỉnh Quảng Ninh
725 07114 Phường Hoàng Quế Tỉnh Quảng Ninh
726 06832 Phường Yên Tử Tỉnh Quảng Ninh
727 06820 Phường Vàng Danh Tỉnh Quảng Ninh
728 06811 Phường Uông Bí Tỉnh Quảng Ninh
729 07135 Phường Đông Mai Tỉnh Quảng Ninh
730 07147 Phường Hiệp Hòa Tỉnh Quảng Ninh
731 07132 Phường Quảng Yên Tỉnh Quảng Ninh
732 07168 Phường Hà An Tỉnh Quảng Ninh
733 07183 Phường Phong Cốc Tỉnh Quảng Ninh
734 07180 Phường Liên Hòa Tỉnh Quảng Ninh
735 06706 Phường Tuần Châu Tỉnh Quảng Ninh
736 06661 Phường Việt Hưng Tỉnh Quảng Ninh
737 06673 Phường Bãi Cháy Tỉnh Quảng Ninh
26
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
738 06652 Phường Hà Tu Tỉnh Quảng Ninh
739 06676 Phường Hà Lầm Tỉnh Quảng Ninh
740 06658 Phường Cao Xanh Tỉnh Quảng Ninh
741 06685 Phường Hồng Gai Tỉnh Quảng Ninh
742 06688 Phường Hạ Long Tỉnh Quảng Ninh
743 07030 Phường Hoành Bồ Tỉnh Quảng Ninh
744 07054 Xã Quảng La Tỉnh Quảng Ninh
745 07060 Xã Thống Nhất Tỉnh Quảng Ninh
746 06760 Phường Mông Dương Tỉnh Quảng Ninh
747 06778 Phường Quang Hanh Tỉnh Quảng Ninh
748 06793 Phường Cẩm Phả Tỉnh Quảng Ninh
749 06781 Phường Cửa Ông Tỉnh Quảng Ninh
750 06799 Xã Hải Hòa Tỉnh Quảng Ninh
751 06862 Xã Tiên Yên Tỉnh Quảng Ninh
752 06874 Xã Điền Xá Tỉnh Quảng Ninh
753 06877 Xã Đông Ngũ Tỉnh Quảng Ninh
754 06886 Xã Hải Lạng Tỉnh Quảng Ninh
755 06985 Xã Lương Minh Tỉnh Quảng Ninh
756 06979 Xã Kỳ Thượng Tỉnh Quảng Ninh
757 06970 Xã Ba Chẽ Tỉnh Quảng Ninh
758 06913 Xã Quảng Tân Tỉnh Quảng Ninh
759 06895 Xã Đầm Hà Tỉnh Quảng Ninh
760 06922 Xã Quảng Hà Tỉnh Quảng Ninh
761 06946 Xã Đường Hoa Tỉnh Quảng Ninh
762 06931 Xã Quảng Đức Tỉnh Quảng Ninh
763 06841 Xã Hoành Mô Tỉnh Quảng Ninh
764 06856 Xã Lục Hồn Tỉnh Quảng Ninh
765 06838 Xã Bình Liêu Tỉnh Quảng Ninh
766 06724 Xã Hải Sơn Tỉnh Quảng Ninh
767 06733 Xã Hải Ninh Tỉnh Quảng Ninh
27
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
768 06757 Xã Vĩnh Thực Tỉnh Quảng Ninh
769 06712 Phường Móng Cái 1 Tỉnh Quảng Ninh
770 06709 Phường Móng Cái 2 Tỉnh Quảng Ninh
771 06736 Phường Móng Cái 3 Tỉnh Quảng Ninh
772 06994 Đặc khu Vân Đồn Tỉnh Quảng Ninh
773 07192 Đặc khu Cô Tô Tỉnh Quảng Ninh
774 06967 Xã Cái Chiên Tỉnh Quảng Ninh
*/

/* ********************************************************************
TỈNH BẮC NINH Tỉnh Bắc Ninh
775 07627 Xã Đại Sơn Tỉnh Bắc Ninh
776 07615 Xã Sơn Động Tỉnh Bắc Ninh
777 07616 Xã Tây Yên Tử Tỉnh Bắc Ninh
778 07672 Xã Dương Hưu Tỉnh Bắc Ninh
779 07642 Xã Yên Định Tỉnh Bắc Ninh
780 07654 Xã An Lạc Tỉnh Bắc Ninh
781 07621 Xã Vân Sơn Tỉnh Bắc Ninh
782 07573 Xã Biển Động Tỉnh Bắc Ninh
783 07582 Xã Lục Ngạn Tỉnh Bắc Ninh
784 07594 Xã Đèo Gia Tỉnh Bắc Ninh
785 07543 Xã Sơn Hải Tỉnh Bắc Ninh
786 07531 Xã Tân Sơn Tỉnh Bắc Ninh
787 07537 Xã Biên Sơn Tỉnh Bắc Ninh
788 07534 Xã Sa Lý Tỉnh Bắc Ninh
789 07603 Xã Nam Dương Tỉnh Bắc Ninh
790 07552 Xã Kiên Lao Tỉnh Bắc Ninh
791 07525 Phường Chũ Tỉnh Bắc Ninh
792 07612 Phường Phượng Sơn Tỉnh Bắc Ninh
793 07492 Xã Lục Sơn Tỉnh Bắc Ninh
794 07489 Xã Trường Sơn Tỉnh Bắc Ninh
795 07519 Xã Cẩm Lý Tỉnh Bắc Ninh
796 07450 Xã Đông Phú Tỉnh Bắc Ninh
28
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
797 07486 Xã Nghĩa Phương Tỉnh Bắc Ninh
798 07444 Xã Lục Nam Tỉnh Bắc Ninh
799 07498 Xã Bắc Lũng Tỉnh Bắc Ninh
800 07462 Xã Bảo Đài Tỉnh Bắc Ninh
801 07375 Xã Lạng Giang Tỉnh Bắc Ninh
802 07420 Xã Mỹ Thái Tỉnh Bắc Ninh
803 07399 Xã Kép Tỉnh Bắc Ninh
804 07432 Xã Tân Dĩnh Tỉnh Bắc Ninh
805 07381 Xã Tiên Lục Tỉnh Bắc Ninh
806 07288 Xã Yên Thế Tỉnh Bắc Ninh
807 07294 Xã Bố Hạ Tỉnh Bắc Ninh
808 07282 Xã Đồng Kỳ Tỉnh Bắc Ninh
809 07246 Xã Xuân Lương Tỉnh Bắc Ninh
810 07264 Xã Tam Tiến Tỉnh Bắc Ninh
811 07339 Xã Tân Yên Tỉnh Bắc Ninh
812 07351 Xã Ngọc Thiện Tỉnh Bắc Ninh
813 07306 Xã Nhã Nam Tỉnh Bắc Ninh
814 07330 Xã Phúc Hòa Tỉnh Bắc Ninh
815 07333 Xã Quang Trung Tỉnh Bắc Ninh
816 07864 Xã Hợp Thịnh Tỉnh Bắc Ninh
817 07840 Xã Hiệp Hòa Tỉnh Bắc Ninh
818 07822 Xã Hoàng Vân Tỉnh Bắc Ninh
819 07870 Xã Xuân Cẩm Tỉnh Bắc Ninh
820 07774 Phường Tự Lạn Tỉnh Bắc Ninh
821 07777 Phường Việt Yên Tỉnh Bắc Ninh
822 07795 Phường Nếnh Tỉnh Bắc Ninh
823 07798 Phường Vân Hà Tỉnh Bắc Ninh
824 07735 Xã Đồng Việt Tỉnh Bắc Ninh
825 07210 Phường Bắc Giang Tỉnh Bắc Ninh
826 07228 Phường Đa Mai Tỉnh Bắc Ninh
29
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
827 07696 Phường Tiền Phong Tỉnh Bắc Ninh
828 07682 Phường Tân An Tỉnh Bắc Ninh
829 07681 Phường Yên Dũng Tỉnh Bắc Ninh
830 07699 Phường Tân Tiến Tỉnh Bắc Ninh
831 07738 Phường Cảnh Thụy Tỉnh Bắc Ninh
832 09187 Phường Kinh Bắc Tỉnh Bắc Ninh
833 09190 Phường Võ Cường Tỉnh Bắc Ninh
834 09169 Phường Vũ Ninh Tỉnh Bắc Ninh
835 09325 Phường Hạp Lĩnh Tỉnh Bắc Ninh
836 09286 Phường Nam Sơn Tỉnh Bắc Ninh
837 09367 Phường Từ Sơn Tỉnh Bắc Ninh
838 09370 Phường Tam Sơn Tỉnh Bắc Ninh
839 09385 Phường Đồng Nguyên Tỉnh Bắc Ninh
840 09379 Phường Phù Khê Tỉnh Bắc Ninh
841 09400 Phường Thuận Thành Tỉnh Bắc Ninh
842 09409 Phường Mão Điền Tỉnh Bắc Ninh
843 09430 Phường Trạm Lộ Tỉnh Bắc Ninh
844 09427 Phường Trí Quả Tỉnh Bắc Ninh
845 09433 Phường Song Liễu Tỉnh Bắc Ninh
846 09445 Phường Ninh Xá Tỉnh Bắc Ninh
847 09247 Phường Quế Võ Tỉnh Bắc Ninh
848 09265 Phường Phương Liễu Tỉnh Bắc Ninh
849 09253 Phường Nhân Hòa Tỉnh Bắc Ninh
850 09301 Phường Đào Viên Tỉnh Bắc Ninh
851 09295 Phường Bồng Lai Tỉnh Bắc Ninh
852 09313 Xã Chi Lăng Tỉnh Bắc Ninh
853 09292 Xã Phù Lãng Tỉnh Bắc Ninh
854 09193 Xã Yên Phong Tỉnh Bắc Ninh
855 09238 Xã Văn Môn Tỉnh Bắc Ninh
856 09202 Xã Tam Giang Tỉnh Bắc Ninh
30
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
857 09205 Xã Yên Trung Tỉnh Bắc Ninh
858 09208 Xã Tam Đa Tỉnh Bắc Ninh
859 09319 Xã Tiên Du Tỉnh Bắc Ninh
860 09334 Xã Liên Bão Tỉnh Bắc Ninh
861 09343 Xã Tân Chi Tỉnh Bắc Ninh
862 09340 Xã Đại Đồng Tỉnh Bắc Ninh
863 09349 Xã Phật Tích Tỉnh Bắc Ninh
864 09454 Xã Gia Bình Tỉnh Bắc Ninh
865 09475 Xã Nhân Thắng Tỉnh Bắc Ninh
866 09469 Xã Đại Lai Tỉnh Bắc Ninh
867 09466 Xã Cao Đức Tỉnh Bắc Ninh
868 09487 Xã Đông Cứu Tỉnh Bắc Ninh
869 09496 Xã Lương Tài Tỉnh Bắc Ninh
870 09529 Xã Lâm Thao Tỉnh Bắc Ninh
871 09523 Xã Trung Chính Tỉnh Bắc Ninh
872 09499 Xã Trung Kênh Tỉnh Bắc Ninh
873 07663 Xã Tuấn Đạo Tỉnh Bắc Ninh
*/

/* ********************************************************************
TỈNH PHÚ THỌ Tỉnh Phú Thọ
874 07900 Phường Việt Trì Tỉnh Phú Thọ
875 07894 Phường Nông Trang Tỉnh Phú Thọ
876 07909 Phường Thanh Miếu Tỉnh Phú Thọ
877 07918 Phường Vân Phú Tỉnh Phú Thọ
878 08515 Xã Hy Cương Tỉnh Phú Thọ
879 08494 Xã Lâm Thao Tỉnh Phú Thọ
880 08500 Xã Xuân Lũng Tỉnh Phú Thọ
881 08521 Xã Phùng Nguyên Tỉnh Phú Thọ
882 08527 Xã Bản Nguyên Tỉnh Phú Thọ
883 07954 Phường Phong Châu Tỉnh Phú Thọ
884 07942 Phường Phú Thọ Tỉnh Phú Thọ
885 07948 Phường Âu Cơ Tỉnh Phú Thọ
31
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
886 08230 Xã Phù Ninh Tỉnh Phú Thọ
887 08254 Xã Dân Chủ Tỉnh Phú Thọ
888 08236 Xã Phú Mỹ Tỉnh Phú Thọ
889 08245 Xã Trạm Thản Tỉnh Phú Thọ
890 08275 Xã Bình Phú Tỉnh Phú Thọ
891 08152 Xã Thanh Ba Tỉnh Phú Thọ
892 08173 Xã Quảng Yên Tỉnh Phú Thọ
893 08203 Xã Hoàng Cương Tỉnh Phú Thọ
894 08209 Xã Đông Thành Tỉnh Phú Thọ
895 08218 Xã Chí Tiên Tỉnh Phú Thọ
896 08227 Xã Liên Minh Tỉnh Phú Thọ
897 07969 Xã Đoan Hùng Tỉnh Phú Thọ
898 08023 Xã Tây Cốc Tỉnh Phú Thọ
899 08038 Xã Chân Mộng Tỉnh Phú Thọ
900 07999 Xã Chí Đám Tỉnh Phú Thọ
901 07996 Xã Bằng Luân Tỉnh Phú Thọ
902 08053 Xã Hạ Hòa Tỉnh Phú Thọ
903 08071 Xã Đan Thượng Tỉnh Phú Thọ
904 08113 Xã Yên Kỳ Tỉnh Phú Thọ
905 08143 Xã Vĩnh Chân Tỉnh Phú Thọ
906 08134 Xã Văn Lang Tỉnh Phú Thọ
907 08110 Xã Hiền Lương Tỉnh Phú Thọ
908 08341 Xã Cẩm Khê Tỉnh Phú Thọ
909 08398 Xã Phú Khê Tỉnh Phú Thọ
910 08416 Xã Hùng Việt Tỉnh Phú Thọ
911 08431 Xã Đồng Lương Tỉnh Phú Thọ
912 08344 Xã Tiên Lương Tỉnh Phú Thọ
913 08377 Xã Vân Bán Tỉnh Phú Thọ
914 08434 Xã Tam Nông Tỉnh Phú Thọ
915 08479 Xã Thọ Văn Tỉnh Phú Thọ
32
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
916 08467 Xã Vạn Xuân Tỉnh Phú Thọ
917 08443 Xã Hiền Quan Tỉnh Phú Thọ
918 08674 Xã Thanh Thủy Tỉnh Phú Thọ
919 08662 Xã Đào Xá Tỉnh Phú Thọ
920 08686 Xã Tu Vũ Tỉnh Phú Thọ
921 08542 Xã Thanh Sơn Tỉnh Phú Thọ
922 08584 Xã Võ Miếu Tỉnh Phú Thọ
923 08611 Xã Văn Miếu Tỉnh Phú Thọ
924 08614 Xã Cự Đồng Tỉnh Phú Thọ
925 08632 Xã Hương Cần Tỉnh Phú Thọ
926 08656 Xã Yên Sơn Tỉnh Phú Thọ
927 08635 Xã Khả Cửu Tỉnh Phú Thọ
928 08566 Xã Tân Sơn Tỉnh Phú Thọ
929 08593 Xã Minh Đài Tỉnh Phú Thọ
930 08560 Xã Lai Đồng Tỉnh Phú Thọ
931 08545 Xã Thu Cúc Tỉnh Phú Thọ
932 08590 Xã Xuân Đài Tỉnh Phú Thọ
933 08620 Xã Long Cốc Tỉnh Phú Thọ
934 08290 Xã Yên Lập Tỉnh Phú Thọ
935 08323 Xã Thượng Long Tỉnh Phú Thọ
936 08296 Xã Sơn Lương Tỉnh Phú Thọ
937 08305 Xã Xuân Viên Tỉnh Phú Thọ
938 08338 Xã Minh Hòa Tỉnh Phú Thọ
939 08311 Xã Trung Sơn Tỉnh Phú Thọ
940 08824 Xã Tam Sơn Tỉnh Phú Thọ
941 08848 Xã Sông Lô Tỉnh Phú Thọ
942 08782 Xã Hải Lựu Tỉnh Phú Thọ
943 08773 Xã Yên Lãng Tỉnh Phú Thọ
944 08761 Xã Lập Thạch Tỉnh Phú Thọ
945 08842 Xã Tiên Lữ Tỉnh Phú Thọ
33
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
946 08788 Xã Thái Hòa Tỉnh Phú Thọ
947 08812 Xã Liên Hòa Tỉnh Phú Thọ
948 08770 Xã Hợp Lý Tỉnh Phú Thọ
949 08866 Xã Sơn Đông Tỉnh Phú Thọ
950 08911 Xã Tam Đảo Tỉnh Phú Thọ
951 08923 Xã Đại Đình Tỉnh Phú Thọ
952 08914 Xã Đạo Trù Tỉnh Phú Thọ
953 08869 Xã Tam Dương Tỉnh Phú Thọ
954 08905 Xã Hội Thịnh Tỉnh Phú Thọ
955 08896 Xã Hoàng An Tỉnh Phú Thọ
956 08872 Xã Tam Dương Bắc Tỉnh Phú Thọ
957 09076 Xã Vĩnh Tường Tỉnh Phú Thọ
958 09112 Xã Thổ Tang Tỉnh Phú Thọ
959 09100 Xã Vĩnh Hưng Tỉnh Phú Thọ
960 09079 Xã Vĩnh An Tỉnh Phú Thọ
961 09154 Xã Vĩnh Phú Tỉnh Phú Thọ
962 09106 Xã Vĩnh Thành Tỉnh Phú Thọ
963 09025 Xã Yên Lạc Tỉnh Phú Thọ
964 09040 Xã Tề Lỗ Tỉnh Phú Thọ
965 09064 Xã Liên Châu Tỉnh Phú Thọ
966 09043 Xã Tam Hồng Tỉnh Phú Thọ
967 09052 Xã Nguyệt Đức Tỉnh Phú Thọ
968 08935 Xã Bình Nguyên Tỉnh Phú Thọ
969 08971 Xã Xuân Lãng Tỉnh Phú Thọ
970 08950 Xã Bình Xuyên Tỉnh Phú Thọ
971 08944 Xã Bình Tuyền Tỉnh Phú Thọ
972 08716 Phường Vĩnh Phúc Tỉnh Phú Thọ
973 08707 Phường Vĩnh Yên Tỉnh Phú Thọ
974 08740 Phường Phúc Yên Tỉnh Phú Thọ
975 08746 Phường Xuân Hòa Tỉnh Phú Thọ
34
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
976 05089 Xã Cao Phong Tỉnh Phú Thọ
977 05116 Xã Mường Thàng Tỉnh Phú Thọ
978 05092 Xã Thung Nai Tỉnh Phú Thọ
979 04831 Xã Đà Bắc Tỉnh Phú Thọ
980 04876 Xã Cao Sơn Tỉnh Phú Thọ
981 04846 Xã Đức Nhàn Tỉnh Phú Thọ
982 04873 Xã Quy Đức Tỉnh Phú Thọ
983 04849 Xã Tân Pheo Tỉnh Phú Thọ
984 04891 Xã Tiền Phong Tỉnh Phú Thọ
985 04978 Xã Kim Bôi Tỉnh Phú Thọ
986 05014 Xã Mường Động Tỉnh Phú Thọ
987 05086 Xã Dũng Tiến Tỉnh Phú Thọ
988 05068 Xã Hợp Kim Tỉnh Phú Thọ
989 04990 Xã Nật Sơn Tỉnh Phú Thọ
990 05266 Xã Lạc Sơn Tỉnh Phú Thọ
991 05287 Xã Mường Vang Tỉnh Phú Thọ
992 05347 Xã Đại Đồng Tỉnh Phú Thọ
993 05329 Xã Ngọc Sơn Tỉnh Phú Thọ
994 05290 Xã Nhân Nghĩa Tỉnh Phú Thọ
995 05323 Xã Quyết Thắng Tỉnh Phú Thọ
996 05293 Xã Thượng Cốc Tỉnh Phú Thọ
997 05305 Xã Yên Phú Tỉnh Phú Thọ
998 05392 Xã Lạc Thủy Tỉnh Phú Thọ
999 05425 Xã An Bình Tỉnh Phú Thọ
1000 05395 Xã An Nghĩa Tỉnh Phú Thọ
1001 04924 Xã Lương Sơn Tỉnh Phú Thọ
1002 05047 Xã Cao Dương Tỉnh Phú Thọ
1003 04960 Xã Liên Sơn Tỉnh Phú Thọ
1004 05200 Xã Mai Châu Tỉnh Phú Thọ
1005 05245 Xã Bao La Tỉnh Phú Thọ
35
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1006 05251 Xã Mai Hạ Tỉnh Phú Thọ
1007 05212 Xã Pà Cò Tỉnh Phú Thọ
1008 05206 Xã Tân Mai Tỉnh Phú Thọ
1009 05128 Xã Tân Lạc Tỉnh Phú Thọ
1010 05158 Xã Mường Bi Tỉnh Phú Thọ
1011 05134 Xã Mường Hoa Tỉnh Phú Thọ
1012 05191 Xã Toàn Thắng Tỉnh Phú Thọ
1013 05152 Xã Vân Sơn Tỉnh Phú Thọ
1014 05353 Xã Yên Thủy Tỉnh Phú Thọ
1015 05362 Xã Lạc Lương Tỉnh Phú Thọ
1016 05386 Xã Yên Trị Tỉnh Phú Thọ
1017 04897 Xã Thịnh Minh Tỉnh Phú Thọ
1018 04795 Phường Hòa Bình Tỉnh Phú Thọ
1019 04894 Phường Kỳ Sơn Tỉnh Phú Thọ
1020 04792 Phường Tân Hòa Tỉnh Phú Thọ
1021 04828 Phường Thống Nhất Tỉnh Phú Thọ
*/

/* ********************************************************************
THÀNH PHỐ HẢI PHÒNG Tp Hải Phòng
1022 11560 Phường Thủy Nguyên Tp Hải Phòng
1023 11557 Phường Thiên Hương Tp Hải Phòng
1024 11533 Phường Hòa Bình Tp Hải Phòng
1025 11542 Phường Nam Triệu Tp Hải Phòng
1026 11473 Phường Bạch Đằng Tp Hải Phòng
1027 11488 Phường Lưu Kiếm Tp Hải Phòng
1028 11506 Phường Lê Ích Mộc Tp Hải Phòng
1029 11311 Phường Hồng Bàng Tp Hải Phòng
1030 11602 Phường Hồng An Tp Hải Phòng
1031 11329 Phường Ngô Quyền Tp Hải Phòng
1032 11359 Phường Gia Viên Tp Hải Phòng
1033 11383 Phường Lê Chân Tp Hải Phòng
1034 11407 Phường An Biên Tp Hải Phòng
36
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1035 11413 Phường Hải An Tp Hải Phòng
1036 11411 Phường Đông Hải Tp Hải Phòng
1037 11443 Phường Kiến An Tp Hải Phòng
1038 11446 Phường Phù Liễn Tp Hải Phòng
1039 11737 Phường Nam Đồ Sơn Tp Hải Phòng
1040 11455 Phường Đồ Sơn Tp Hải Phòng
1041 11689 Phường Hưng Đạo Tp Hải Phòng
1042 11692 Phường Dương Kinh Tp Hải Phòng
1043 11581 Phường An Dương Tp Hải Phòng
1044 11617 Phường An Hải Tp Hải Phòng
1045 11593 Phường An Phong Tp Hải Phòng
1046 11674 Xã An Hưng Tp Hải Phòng
1047 11668 Xã An Khánh Tp Hải Phòng
1048 11647 Xã An Quang Tp Hải Phòng
1049 11635 Xã An Trường Tp Hải Phòng
1050 11629 Xã An Lão Tp Hải Phòng
1051 11680 Xã Kiến Thụy Tp Hải Phòng
1052 11725 Xã Kiến Minh Tp Hải Phòng
1053 11749 Xã Kiến Hải Tp Hải Phòng
1054 11728 Xã Kiến Hưng Tp Hải Phòng
1055 11713 Xã Nghi Dương Tp Hải Phòng
1056 11761 Xã Quyết Thắng Tp Hải Phòng
1057 11755 Xã Tiên Lãng Tp Hải Phòng
1058 11779 Xã Tân Minh Tp Hải Phòng
1059 11791 Xã Tiên Minh Tp Hải Phòng
1060 11806 Xã Chấn Hưng Tp Hải Phòng
1061 11809 Xã Hùng Thắng Tp Hải Phòng
1062 11824 Xã Vĩnh Bảo Tp Hải Phòng
1063 11911 Xã Nguyễn Bỉnh Khiêm Tp Hải Phòng
1064 11887 Xã Vĩnh Am Tp Hải Phòng
37
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1065 11875 Xã Vĩnh Hải Tp Hải Phòng
1066 11848 Xã Vĩnh Hòa Tp Hải Phòng
1067 11836 Xã Vĩnh Thịnh Tp Hải Phòng
1068 11842 Xã Vĩnh Thuận Tp Hải Phòng
1069 11503 Xã Việt Khê Tp Hải Phòng
1070 11914 Đặc khu Cát Hải Tp Hải Phòng
1071 11948 Đặc khu Bạch Long Vĩ Tp Hải Phòng
1072 10525 Phường Hải Dương Tp Hải Phòng
1073 10532 Phường Lê Thanh Nghị Tp Hải Phòng
1074 10543 Phường Việt Hòa Tp Hải Phòng
1075 10507 Phường Thành Đông Tp Hải Phòng
1076 10837 Phường Nam Đồng Tp Hải Phòng
1077 10537 Phường Tân Hưng Tp Hải Phòng
1078 11002 Phường Thạch Khôi Tp Hải Phòng
1079 10891 Phường Tứ Minh Tp Hải Phòng
1080 10660 Phường Á i Quốc Tp Hải Phòng
1081 10549 Phường Chu Văn An Tp Hải Phòng
1082 10546 Phường Chí Linh Tp Hải Phòng
1083 10570 Phường Trần Hưng Đạo Tp Hải Phòng
1084 10552 Phường Nguyễn Trãi Tp Hải Phòng
1085 10573 Phường Trần Nhân Tông Tp Hải Phòng
1086 10603 Phường Lê Đại Hành Tp Hải Phòng
1087 10675 Phường Kinh Môn Tp Hải Phòng
1088 10744 Phường Nguyễn Đại Năng Tp Hải Phòng
1089 10729 Phường Trần Liễu Tp Hải Phòng
1090 10678 Phường Bắc An Phụ Tp Hải Phòng
1091 10726 Phường Phạm Sư Mạnh Tp Hải Phòng
1092 10714 Phường Nhị Chiểu Tp Hải Phòng
1093 10705 Xã Nam An Phụ Tp Hải Phòng
1094 10606 Xã Nam Sách Tp Hải Phòng
38
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1095 10642 Xã Thái Tân Tp Hải Phòng
1096 10615 Xã Hợp Tiến Tp Hải Phòng
1097 10633 Xã Trần Phú Tp Hải Phòng
1098 10645 Xã An Phú Tp Hải Phòng
1099 10813 Xã Thanh Hà Tp Hải Phòng
1100 10846 Xã Hà Tây Tp Hải Phòng
1101 10816 Xã Hà Bắc Tp Hải Phòng
1102 10843 Xã Hà Nam Tp Hải Phòng
1103 10882 Xã Hà Đông Tp Hải Phòng
1104 10888 Xã Cẩm Giang Tp Hải Phòng
1105 10909 Xã Tuệ Tĩnh Tp Hải Phòng
1106 10930 Xã Mao Điền Tp Hải Phòng
1107 10903 Xã Cẩm Giàng Tp Hải Phòng
1108 10945 Xã Kẻ Sặt Tp Hải Phòng
1109 10966 Xã Bình Giang Tp Hải Phòng
1110 10972 Xã Đường An Tp Hải Phòng
1111 10993 Xã Thượng Hồng Tp Hải Phòng
1112 10999 Xã Gia Lộc Tp Hải Phòng
1113 11020 Xã Yết Kiêu Tp Hải Phòng
1114 11050 Xã Gia Phúc Tp Hải Phòng
1115 11065 Xã Trường Tân Tp Hải Phòng
1116 11074 Xã Tứ Kỳ Tp Hải Phòng
1117 11113 Xã Tân Kỳ Tp Hải Phòng
1118 11086 Xã Đại Sơn Tp Hải Phòng
1119 11131 Xã Chí Minh Tp Hải Phòng
1120 11140 Xã Lạc Phượng Tp Hải Phòng
1121 11146 Xã Nguyên Giáp Tp Hải Phòng
1122 11203 Xã Ninh Giang Tp Hải Phòng
1123 11164 Xã Vĩnh Lại Tp Hải Phòng
1124 11224 Xã Khúc Thừa Dụ Tp Hải Phòng
39
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1125 11167 Xã Tân An Tp Hải Phòng
1126 11218 Xã Hồng Châu Tp Hải Phòng
1127 11239 Xã Thanh Miện Tp Hải Phòng
1128 11254 Xã Bắc Thanh Miện Tp Hải Phòng
1129 11257 Xã Hải Hưng Tp Hải Phòng
1130 11242 Xã Nguyễn Lương Bằng Tp Hải Phòng
1131 11284 Xã Nam Thanh Miện Tp Hải Phòng
1132 10750 Xã Phú Thái Tp Hải Phòng
1133 10756 Xã Lai Khê Tp Hải Phòng
1134 10792 Xã An Thành Tp Hải Phòng
1135 10804 Xã Kim Thành Tp Hải Phòng
*/

/* ********************************************************************
TỈNH HƯNG YÊN Tỉnh Hưng Yên
1136 11953 Phường Phố Hiến Tỉnh Hưng Yên
1137 11983 Phường Sơn Nam Tỉnh Hưng Yên
1138 11980 Phường Hồng Châu Tỉnh Hưng Yên
1139 12103 Phường Mỹ Hào Tỉnh Hưng Yên
1140 12133 Phường Đường Hào Tỉnh Hưng Yên
1141 12127 Phường Thượng Hồng Tỉnh Hưng Yên
1142 11977 Xã Tân Hưng Tỉnh Hưng Yên
1143 12337 Xã Hoàng Hoa Thám Tỉnh Hưng Yên
1144 12364 Xã Tiên Lữ Tỉnh Hưng Yên
1145 12361 Xã Tiên Hoa Tỉnh Hưng Yên
1146 12391 Xã Quang Hưng Tỉnh Hưng Yên
1147 12406 Xã Đoàn Đào Tỉnh Hưng Yên
1148 12424 Xã Tiên Tiến Tỉnh Hưng Yên
1149 12427 Xã Tống Trân Tỉnh Hưng Yên
1150 12280 Xã Lương Bằng Tỉnh Hưng Yên
1151 12286 Xã Nghĩa Dân Tỉnh Hưng Yên
1152 12322 Xã Hiệp Cường Tỉnh Hưng Yên
1153 12313 Xã Đức Hợp Tỉnh Hưng Yên
40
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1154 12142 Xã Ân Thi Tỉnh Hưng Yên
1155 12166 Xã Xuân Trúc Tỉnh Hưng Yên
1156 12148 Xã Phạm Ngũ Lão Tỉnh Hưng Yên
1157 12184 Xã Nguyễn Trãi Tỉnh Hưng Yên
1158 12196 Xã Hồng Quang Tỉnh Hưng Yên
1159 12205 Xã Khoái Châu Tỉnh Hưng Yên
1160 12223 Xã Triệu Việt Vương Tỉnh Hưng Yên
1161 12238 Xã Việt Tiến Tỉnh Hưng Yên
1162 12271 Xã Chí Minh Tỉnh Hưng Yên
1163 12247 Xã Châu Ninh Tỉnh Hưng Yên
1164 12073 Xã Yên Mỹ Tỉnh Hưng Yên
1165 12091 Xã Việt Yên Tỉnh Hưng Yên
1166 12070 Xã Hoàn Long Tỉnh Hưng Yên
1167 12064 Xã Nguyễn Văn Linh Tỉnh Hưng Yên
1168 12004 Xã Như Quỳnh Tỉnh Hưng Yên
1169 11992 Xã Lạc Đạo Tỉnh Hưng Yên
1170 11995 Xã Đại Đồng Tỉnh Hưng Yên
1171 12031 Xã Nghĩa Trụ Tỉnh Hưng Yên
1172 12025 Xã Phụng Công Tỉnh Hưng Yên
1173 12019 Xã Văn Giang Tỉnh Hưng Yên
1174 12049 Xã Mễ Sở Tỉnh Hưng Yên
1175 13225 Phường Thái Bình Tỉnh Hưng Yên
1176 12454 Phường Trần Lãm Tỉnh Hưng Yên
1177 12452 Phường Trần Hưng Đạo Tỉnh Hưng Yên
1178 12817 Phường Trà Lý Tỉnh Hưng Yên
1179 12466 Phường Vũ Phúc Tỉnh Hưng Yên
1180 12826 Xã Thái Thụy Tỉnh Hưng Yên
1181 12862 Xã Đông Thụy Anh Tỉnh Hưng Yên
1182 12859 Xã Bắc Thụy Anh Tỉnh Hưng Yên
1183 12865 Xã Thụy Anh Tỉnh Hưng Yên
41
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1184 12904 Xã Nam Thụy Anh Tỉnh Hưng Yên
1185 12916 Xã Bắc Thái Ninh Tỉnh Hưng Yên
1186 12922 Xã Thái Ninh Tỉnh Hưng Yên
1187 12943 Xã Đông Thái Ninh Tỉnh Hưng Yên
1188 12961 Xã Nam Thái Ninh Tỉnh Hưng Yên
1189 12919 Xã Tây Thái Ninh Tỉnh Hưng Yên
1190 12850 Xã Tây Thụy Anh Tỉnh Hưng Yên
1191 12970 Xã Tiền Hải Tỉnh Hưng Yên
1192 13039 Xã Tây Tiền Hải Tỉnh Hưng Yên
1193 13021 Xã Á i Quốc Tỉnh Hưng Yên
1194 13003 Xã Đồng Châu Tỉnh Hưng Yên
1195 12988 Xã Đông Tiền Hải Tỉnh Hưng Yên
1196 13057 Xã Nam Cường Tỉnh Hưng Yên
1197 13066 Xã Hưng Phú Tỉnh Hưng Yên
1198 13063 Xã Nam Tiền Hải Tỉnh Hưng Yên
1199 12472 Xã Quỳnh Phụ Tỉnh Hưng Yên
1200 12511 Xã Minh Thọ Tỉnh Hưng Yên
1201 12532 Xã Nguyễn Du Tỉnh Hưng Yên
1202 12577 Xã Quỳnh An Tỉnh Hưng Yên
1203 12517 Xã Ngọc Lâm Tỉnh Hưng Yên
1204 12526 Xã Đồng Bằng Tỉnh Hưng Yên
1205 12499 Xã A Sào Tỉnh Hưng Yên
1206 12523 Xã Phụ Dực Tỉnh Hưng Yên
1207 12583 Xã Tân Tiến Tỉnh Hưng Yên
1208 12586 Xã Hưng Hà Tỉnh Hưng Yên
1209 12634 Xã Tiên La Tỉnh Hưng Yên
1210 12676 Xã Lê Quý Đôn Tỉnh Hưng Yên
1211 12685 Xã Hồng Minh Tỉnh Hưng Yên
1212 12631 Xã Thần Khê Tỉnh Hưng Yên
1213 12619 Xã Diên Hà Tỉnh Hưng Yên
42
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1214 12595 Xã Ngự Thiên Tỉnh Hưng Yên
1215 12613 Xã Long Hưng Tỉnh Hưng Yên
1216 12688 Xã Đông Hưng Tỉnh Hưng Yên
1217 12700 Xã Bắc Tiên Hưng Tỉnh Hưng Yên
1218 12736 Xã Đông Tiên Hưng Tỉnh Hưng Yên
1219 12775 Xã Nam Đông Hưng Tỉnh Hưng Yên
1220 12745 Xã Bắc Đông Quan Tỉnh Hưng Yên
1221 12694 Xã Bắc Đông Hưng Tỉnh Hưng Yên
1222 12793 Xã Đông Quan Tỉnh Hưng Yên
1223 12763 Xã Nam Tiên Hưng Tỉnh Hưng Yên
1224 12754 Xã Tiên Hưng Tỉnh Hưng Yên
1225 13120 Xã Lê Lợi Tỉnh Hưng Yên
1226 13075 Xã Kiến Xương Tỉnh Hưng Yên
1227 13132 Xã Quang Lịch Tỉnh Hưng Yên
1228 13141 Xã Vũ Quý Tỉnh Hưng Yên
1229 13183 Xã Bình Thanh Tỉnh Hưng Yên
1230 13186 Xã Bình Định Tỉnh Hưng Yên
1231 13159 Xã Hồng Vũ Tỉnh Hưng Yên
1232 13096 Xã Bình Nguyên Tỉnh Hưng Yên
1233 13093 Xã Trà Giang Tỉnh Hưng Yên
1234 13192 Xã Vũ Thư Tỉnh Hưng Yên
1235 13222 Xã Thư Trì Tỉnh Hưng Yên
1236 13246 Xã Tân Thuận Tỉnh Hưng Yên
1237 13264 Xã Thư Vũ Tỉnh Hưng Yên
1238 13279 Xã Vũ Tiên Tỉnh Hưng Yên
1239 13219 Xã Vạn Xuân Tỉnh Hưng Yên
*/

/* ********************************************************************
TỈNH NINH BÌNH Tỉnh Ninh Bình
1240 14464 Xã Gia Viễn Tỉnh Ninh Bình
1241 14500 Xã Đại Hoàng Tỉnh Ninh Bình
1242 14482 Xã Gia Hưng Tỉnh Ninh Bình
43
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1243 14524 Xã Gia Phong Tỉnh Ninh Bình
1244 14488 Xã Gia Vân Tỉnh Ninh Bình
1245 14494 Xã Gia Trấn Tỉnh Ninh Bình
1246 14428 Xã Nho Quan Tỉnh Ninh Bình
1247 14389 Xã Gia Lâm Tỉnh Ninh Bình
1248 14401 Xã Gia Tường Tỉnh Ninh Bình
1249 14407 Xã Phú Sơn Tỉnh Ninh Bình
1250 14404 Xã Cúc Phương Tỉnh Ninh Bình
1251 14458 Xã Phú Long Tỉnh Ninh Bình
1252 14434 Xã Thanh Sơn Tỉnh Ninh Bình
1253 14452 Xã Quỳnh Lưu Tỉnh Ninh Bình
1254 14560 Xã Yên Khánh Tỉnh Ninh Bình
1255 14611 Xã Khánh Nhạc Tỉnh Ninh Bình
1256 14563 Xã Khánh Thiện Tỉnh Ninh Bình
1257 14614 Xã Khánh Hội Tỉnh Ninh Bình
1258 14608 Xã Khánh Trung Tỉnh Ninh Bình
1259 14701 Xã Yên Mô Tỉnh Ninh Bình
1260 14728 Xã Yên Từ Tỉnh Ninh Bình
1261 14743 Xã Yên Mạc Tỉnh Ninh Bình
1262 14746 Xã Đồng Thái Tỉnh Ninh Bình
1263 14653 Xã Chất Bình Tỉnh Ninh Bình
1264 14638 Xã Kim Sơn Tỉnh Ninh Bình
1265 14647 Xã Quang Thiện Tỉnh Ninh Bình
1266 14620 Xã Phát Diệm Tỉnh Ninh Bình
1267 14674 Xã Lai Thành Tỉnh Ninh Bình
1268 14677 Xã Định Hóa Tỉnh Ninh Bình
1269 14623 Xã Bình Minh Tỉnh Ninh Bình
1270 14698 Xã Kim Đông Tỉnh Ninh Bình
1271 13504 Xã Bình Lục Tỉnh Ninh Bình
1272 13501 Xã Bình Mỹ Tỉnh Ninh Bình
44
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1273 13540 Xã Bình An Tỉnh Ninh Bình
1274 13531 Xã Bình Giang Tỉnh Ninh Bình
1275 13558 Xã Bình Sơn Tỉnh Ninh Bình
1276 13456 Xã Liêm Hà Tỉnh Ninh Bình
1277 13474 Xã Tân Thanh Tỉnh Ninh Bình
1278 13483 Xã Thanh Bình Tỉnh Ninh Bình
1279 13489 Xã Thanh Lâm Tỉnh Ninh Bình
1280 13495 Xã Thanh Liêm Tỉnh Ninh Bình
1281 13573 Xã Lý Nhân Tỉnh Ninh Bình
1282 13591 Xã Nam Xang Tỉnh Ninh Bình
1283 13579 Xã Bắc Lý Tỉnh Ninh Bình
1284 13597 Xã Vĩnh Trụ Tỉnh Ninh Bình
1285 13594 Xã Trần Thương Tỉnh Ninh Bình
1286 13609 Xã Nhân Hà Tỉnh Ninh Bình
1287 13627 Xã Nam Lý Tỉnh Ninh Bình
1288 13966 Xã Nam Trực Tỉnh Ninh Bình
1289 14011 Xã Nam Minh Tỉnh Ninh Bình
1290 14014 Xã Nam Đồng Tỉnh Ninh Bình
1291 14005 Xã Nam Ninh Tỉnh Ninh Bình
1292 13987 Xã Nam Hồng Tỉnh Ninh Bình
1293 13750 Xã Minh Tân Tỉnh Ninh Bình
1294 13753 Xã Hiển Khánh Tỉnh Ninh Bình
1295 13741 Xã Vụ Bản Tỉnh Ninh Bình
1296 13786 Xã Liên Minh Tỉnh Ninh Bình
1297 13795 Xã Ý Yên Tỉnh Ninh Bình
1298 13879 Xã Yên Đồng Tỉnh Ninh Bình
1299 13870 Xã Yên Cường Tỉnh Ninh Bình
1300 13864 Xã Vạn Thắng Tỉnh Ninh Bình
1301 13834 Xã Vũ Dương Tỉnh Ninh Bình
1302 13807 Xã Tân Minh Tỉnh Ninh Bình
45
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1303 13822 Xã Phong Doanh Tỉnh Ninh Bình
1304 14026 Xã Cổ Lễ Tỉnh Ninh Bình
1305 14038 Xã Ninh Giang Tỉnh Ninh Bình
1306 14056 Xã Cát Thành Tỉnh Ninh Bình
1307 14053 Xã Trực Ninh Tỉnh Ninh Bình
1308 14062 Xã Quang Hưng Tỉnh Ninh Bình
1309 14071 Xã Minh Thái Tỉnh Ninh Bình
1310 14077 Xã Ninh Cường Tỉnh Ninh Bình
1311 14089 Xã Xuân Trường Tỉnh Ninh Bình
1312 14122 Xã Xuân Hưng Tỉnh Ninh Bình
1313 14104 Xã Xuân Giang Tỉnh Ninh Bình
1314 14095 Xã Xuân Hồng Tỉnh Ninh Bình
1315 14215 Xã Hải Hậu Tỉnh Ninh Bình
1316 14236 Xã Hải Anh Tỉnh Ninh Bình
1317 14218 Xã Hải Tiến Tỉnh Ninh Bình
1318 14248 Xã Hải Hưng Tỉnh Ninh Bình
1319 14281 Xã Hải An Tỉnh Ninh Bình
1320 14287 Xã Hải Quang Tỉnh Ninh Bình
1321 14308 Xã Hải Xuân Tỉnh Ninh Bình
1322 14221 Xã Hải Thịnh Tỉnh Ninh Bình
1323 14161 Xã Giao Minh Tỉnh Ninh Bình
1324 14182 Xã Giao Hòa Tỉnh Ninh Bình
1325 14167 Xã Giao Thủy Tỉnh Ninh Bình
1326 14203 Xã Giao Phúc Tỉnh Ninh Bình
1327 14179 Xã Giao Hưng Tỉnh Ninh Bình
1328 14194 Xã Giao Bình Tỉnh Ninh Bình
1329 14212 Xã Giao Ninh Tỉnh Ninh Bình
1330 13900 Xã Đồng Thịnh Tỉnh Ninh Bình
1331 13891 Xã Nghĩa Hưng Tỉnh Ninh Bình
1332 13918 Xã Nghĩa Sơn Tỉnh Ninh Bình
46
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1333 13927 Xã Hồng Phong Tỉnh Ninh Bình
1334 13939 Xã Quỹ Nhất Tỉnh Ninh Bình
1335 13957 Xã Nghĩa Lâm Tỉnh Ninh Bình
1336 13894 Xã Rạng Đông Tỉnh Ninh Bình
1337 14533 Phường Tây Hoa Lư Tỉnh Ninh Bình
1338 14329 Phường Hoa Lư Tỉnh Ninh Bình
1339 14359 Phường Nam Hoa Lư Tỉnh Ninh Bình
1340 14566 Phường Đông Hoa Lư Tỉnh Ninh Bình
1341 14362 Phường Tam Điệp Tỉnh Ninh Bình
1342 14371 Phường Yên Sơn Tỉnh Ninh Bình
1343 14365 Phường Trung Sơn Tỉnh Ninh Bình
1344 14725 Phường Yên Thắng Tỉnh Ninh Bình
1345 13366 Phường Hà Nam Tỉnh Ninh Bình
1346 13285 Phường Phủ Lý Tỉnh Ninh Bình
1347 13291 Phường Phù Vân Tỉnh Ninh Bình
1348 13318 Phường Châu Sơn Tỉnh Ninh Bình
1349 13444 Phường Liêm Tuyền Tỉnh Ninh Bình
1350 13324 Phường Duy Tiên Tỉnh Ninh Bình
1351 13330 Phường Duy Tân Tỉnh Ninh Bình
1352 13348 Phường Đồng Văn Tỉnh Ninh Bình
1353 13336 Phường Duy Hà Tỉnh Ninh Bình
1354 13363 Phường Tiên Sơn Tỉnh Ninh Bình
1355 13393 Phường Lê Hồ Tỉnh Ninh Bình
1356 13396 Phường Nguyễn Úy Tỉnh Ninh Bình
1357 13435 Phường Lý Thường Kiệt Tỉnh Ninh Bình
1358 13402 Phường Kim Thanh Tỉnh Ninh Bình
1359 13420 Phường Tam Chúc Tỉnh Ninh Bình
1360 13384 Phường Kim Bảng Tỉnh Ninh Bình
1361 13669 Phường Nam Định Tỉnh Ninh Bình
1362 13684 Phường Thiên Trường Tỉnh Ninh Bình
47
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1363 13693 Phường Đông A Tỉnh Ninh Bình
1364 13972 Phường Vị Khê Tỉnh Ninh Bình
1365 13699 Phường Thành Nam Tỉnh Ninh Bình
1366 13777 Phường Trường Thi Tỉnh Ninh Bình
1367 13984 Phường Hồng Quang Tỉnh Ninh Bình
1368 13708 Phường Mỹ Lộc Tỉnh Ninh Bình
*/

/* ********************************************************************
TỈNH THANH HÓA Tỉnh Thanh Hóa
1369 14797 Phường Hạc Thành Tỉnh Thanh Hóa
1370 16522 Phường Quảng Phú Tỉnh Thanh Hóa
1371 16417 Phường Đông Quang Tỉnh Thanh Hóa
1372 16378 Phường Đông Sơn Tỉnh Thanh Hóa
1373 15853 Phường Đông Tiến Tỉnh Thanh Hóa
1374 14758 Phường Hàm Rồng Tỉnh Thanh Hóa
1375 15925 Phường Nguyệt Viên Tỉnh Thanh Hóa
1376 16531 Phường Sầm Sơn Tỉnh Thanh Hóa
1377 16516 Phường Nam Sầm Sơn Tỉnh Thanh Hóa
1378 14812 Phường Bỉm Sơn Tỉnh Thanh Hóa
1379 14818 Phường Quang Trung Tỉnh Thanh Hóa
1380 16576 Phường Ngọc Sơn Tỉnh Thanh Hóa
1381 16594 Phường Tân Dân Tỉnh Thanh Hóa
1382 16597 Phường Hải Lĩnh Tỉnh Thanh Hóa
1383 16561 Phường Tĩnh Gia Tỉnh Thanh Hóa
1384 16609 Phường Đào Duy Từ Tỉnh Thanh Hóa
1385 16645 Phường Hải Bình Tỉnh Thanh Hóa
1386 16624 Phường Trúc Lâm Tỉnh Thanh Hóa
1387 16654 Phường Nghi Sơn Tỉnh Thanh Hóa
1388 16591 Xã Các Sơn Tỉnh Thanh Hóa
1389 16636 Xã Trường Lâm Tỉnh Thanh Hóa
1390 15271 Xã Hà Trung Tỉnh Thanh Hóa
1391 15316 Xã Tống Sơn Tỉnh Thanh Hóa
48
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1392 15274 Xã Hà Long Tỉnh Thanh Hóa
1393 15286 Xã Hoạt Giang Tỉnh Thanh Hóa
1394 15298 Xã Lĩnh Toại Tỉnh Thanh Hóa
1395 16021 Xã Triệu Lộc Tỉnh Thanh Hóa
1396 16033 Xã Đông Thành Tỉnh Thanh Hóa
1397 16012 Xã Hậu Lộc Tỉnh Thanh Hóa
1398 16072 Xã Hoa Lộc Tỉnh Thanh Hóa
1399 16078 Xã Vạn Lộc Tỉnh Thanh Hóa
1400 16093 Xã Nga Sơn Tỉnh Thanh Hóa
1401 16114 Xã Nga Thắng Tỉnh Thanh Hóa
1402 16138 Xã Hồ Vương Tỉnh Thanh Hóa
1403 16108 Xã Tân Tiến Tỉnh Thanh Hóa
1404 16144 Xã Nga An Tỉnh Thanh Hóa
1405 16171 Xã Ba Đình Tỉnh Thanh Hóa
1406 15865 Xã Hoằng Hóa Tỉnh Thanh Hóa
1407 15991 Xã Hoằng Tiến Tỉnh Thanh Hóa
1408 16000 Xã Hoằng Thanh Tỉnh Thanh Hóa
1409 15961 Xã Hoằng Lộc Tỉnh Thanh Hóa
1410 15976 Xã Hoằng Châu Tỉnh Thanh Hóa
1411 15910 Xã Hoằng Sơn Tỉnh Thanh Hóa
1412 15889 Xã Hoằng Phú Tỉnh Thanh Hóa
1413 15880 Xã Hoằng Giang Tỉnh Thanh Hóa
1414 16438 Xã Lưu Vệ Tỉnh Thanh Hóa
1415 16480 Xã Quảng Yên Tỉnh Thanh Hóa
1416 16498 Xã Quảng Ngọc Tỉnh Thanh Hóa
1417 16540 Xã Quảng Ninh Tỉnh Thanh Hóa
1418 16543 Xã Quảng Bình Tỉnh Thanh Hóa
1419 16549 Xã Tiên Trang Tỉnh Thanh Hóa
1420 16489 Xã Quảng Chính Tỉnh Thanh Hóa
1421 16279 Xã Nông Cống Tỉnh Thanh Hóa
49
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1422 16309 Xã Thắng Lợi Tỉnh Thanh Hóa
1423 16297 Xã Trung Chính Tỉnh Thanh Hóa
1424 16348 Xã Trường Văn Tỉnh Thanh Hóa
1425 16342 Xã Thăng Bình Tỉnh Thanh Hóa
1426 16363 Xã Tượng Lĩnh Tỉnh Thanh Hóa
1427 16369 Xã Công Chính Tỉnh Thanh Hóa
1428 15772 Xã Thiệu Hóa Tỉnh Thanh Hóa
1429 15796 Xã Thiệu Quang Tỉnh Thanh Hóa
1430 15778 Xã Thiệu Tiến Tỉnh Thanh Hóa
1431 15820 Xã Thiệu Toán Tỉnh Thanh Hóa
1432 15835 Xã Thiệu Trung Tỉnh Thanh Hóa
1433 15469 Xã Yên Định Tỉnh Thanh Hóa
1434 15421 Xã Yên Trường Tỉnh Thanh Hóa
1435 15409 Xã Yên Phú Tỉnh Thanh Hóa
1436 15412 Xã Quý Lộc Tỉnh Thanh Hóa
1437 15442 Xã Yên Ninh Tỉnh Thanh Hóa
1438 15457 Xã Định Tân Tỉnh Thanh Hóa
1439 15448 Xã Định Hòa Tỉnh Thanh Hóa
1440 15499 Xã Thọ Xuân Tỉnh Thanh Hóa
1441 15505 Xã Thọ Long Tỉnh Thanh Hóa
1442 15520 Xã Xuân Hòa Tỉnh Thanh Hóa
1443 15553 Xã Sao Vàng Tỉnh Thanh Hóa
1444 15544 Xã Lam Sơn Tỉnh Thanh Hóa
1445 15568 Xã Thọ Lập Tỉnh Thanh Hóa
1446 15574 Xã Xuân Tín Tỉnh Thanh Hóa
1447 15592 Xã Xuân Lập Tỉnh Thanh Hóa
1448 15349 Xã Vĩnh Lộc Tỉnh Thanh Hóa
1449 15361 Xã Tây Đô Tỉnh Thanh Hóa
1450 15382 Xã Biện Thượng Tỉnh Thanh Hóa
1451 15664 Xã Triệu Sơn Tỉnh Thanh Hóa
50
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1452 15667 Xã Thọ Bình Tỉnh Thanh Hóa
1453 15754 Xã Thọ Ngọc Tỉnh Thanh Hóa
1454 15763 Xã Thọ Phú Tỉnh Thanh Hóa
1455 15682 Xã Hợp Tiến Tỉnh Thanh Hóa
1456 15766 Xã An Nông Tỉnh Thanh Hóa
1457 15715 Xã Tân Ninh Tỉnh Thanh Hóa
1458 15724 Xã Đồng Tiến Tỉnh Thanh Hóa
1459 14866 Xã Mường Chanh Tỉnh Thanh Hóa
1460 14860 Xã Quang Chiểu Tỉnh Thanh Hóa
1461 14848 Xã Tam Chung Tỉnh Thanh Hóa
1462 14845 Xã Mường Lát Tỉnh Thanh Hóa
1463 14863 Xã Pù Nhi Tỉnh Thanh Hóa
1464 14864 Xã Nhi Sơn Tỉnh Thanh Hóa
1465 14854 Xã Mường Lý Tỉnh Thanh Hóa
1466 14857 Xã Trung Lý Tỉnh Thanh Hóa
1467 14869 Xã Hồi Xuân Tỉnh Thanh Hóa
1468 14902 Xã Nam Xuân Tỉnh Thanh Hóa
1469 14908 Xã Thiên Phủ Tỉnh Thanh Hóa
1470 14896 Xã Hiền Kiệt Tỉnh Thanh Hóa
1471 14890 Xã Phú Xuân Tỉnh Thanh Hóa
1472 14878 Xã Phú Lệ Tỉnh Thanh Hóa
1473 14872 Xã Trung Thành Tỉnh Thanh Hóa
1474 14875 Xã Trung Sơn Tỉnh Thanh Hóa
1475 15013 Xã Na Mèo Tỉnh Thanh Hóa
1476 15010 Xã Sơn Thủy Tỉnh Thanh Hóa
1477 15022 Xã Sơn Điện Tỉnh Thanh Hóa
1478 15025 Xã Mường Mìn Tỉnh Thanh Hóa
1479 15007 Xã Tam Thanh Tỉnh Thanh Hóa
1480 15019 Xã Tam Lư Tỉnh Thanh Hóa
1481 15016 Xã Quan Sơn Tỉnh Thanh Hóa
51
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1482 15001 Xã Trung Hạ Tỉnh Thanh Hóa
1483 15055 Xã Linh Sơn Tỉnh Thanh Hóa
1484 15058 Xã Đồng Lương Tỉnh Thanh Hóa
1485 15049 Xã Văn Phú Tỉnh Thanh Hóa
1486 15043 Xã Giao An Tỉnh Thanh Hóa
1487 15031 Xã Yên Khương Tỉnh Thanh Hóa
1488 15034 Xã Yên Thắng Tỉnh Thanh Hóa
1489 14974 Xã Văn Nho Tỉnh Thanh Hóa
1490 14980 Xã Thiết Ống Tỉnh Thanh Hóa
1491 14923 Xã Bá Thước Tỉnh Thanh Hóa
1492 14959 Xã Cổ Lũng Tỉnh Thanh Hóa
1493 14956 Xã Pù Luông Tỉnh Thanh Hóa
1494 14950 Xã Điền Lư Tỉnh Thanh Hóa
1495 14932 Xã Điền Quang Tỉnh Thanh Hóa
1496 14953 Xã Quý Lương Tỉnh Thanh Hóa
1497 15061 Xã Ngọc Lặc Tỉnh Thanh Hóa
1498 15085 Xã Thạch Lập Tỉnh Thanh Hóa
1499 15091 Xã Ngọc Liên Tỉnh Thanh Hóa
1500 15124 Xã Minh Sơn Tỉnh Thanh Hóa
1501 15106 Xã Nguyệt Ấn Tỉnh Thanh Hóa
1502 15112 Xã Kiên Thọ Tỉnh Thanh Hóa
1503 15142 Xã Cẩm Thạch Tỉnh Thanh Hóa
1504 15127 Xã Cẩm Thủy Tỉnh Thanh Hóa
1505 15148 Xã Cẩm Tú Tỉnh Thanh Hóa
1506 15163 Xã Cẩm Vân Tỉnh Thanh Hóa
1507 15178 Xã Cẩm Tân Tỉnh Thanh Hóa
1508 15187 Xã Kim Tân Tỉnh Thanh Hóa
1509 15190 Xã Vân Du Tỉnh Thanh Hóa
1510 15250 Xã Ngọc Trạo Tỉnh Thanh Hóa
1511 15211 Xã Thạch Bình Tỉnh Thanh Hóa
52
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1512 15229 Xã Thành Vinh Tỉnh Thanh Hóa
1513 15199 Xã Thạch Quảng Tỉnh Thanh Hóa
1514 16174 Xã Như Xuân Tỉnh Thanh Hóa
1515 16225 Xã Thượng Ninh Tỉnh Thanh Hóa
1516 16177 Xã Xuân Bình Tỉnh Thanh Hóa
1517 16186 Xã Hóa Quỳ Tỉnh Thanh Hóa
1518 16222 Xã Thanh Quân Tỉnh Thanh Hóa
1519 16213 Xã Thanh Phong Tỉnh Thanh Hóa
1520 16234 Xã Xuân Du Tỉnh Thanh Hóa
1521 16249 Xã Mậu Lâm Tỉnh Thanh Hóa
1522 16228 Xã Như Thanh Tỉnh Thanh Hóa
1523 16264 Xã Yên Thọ Tỉnh Thanh Hóa
1524 16258 Xã Xuân Thái Tỉnh Thanh Hóa
1525 16273 Xã Thanh Kỳ Tỉnh Thanh Hóa
1526 15607 Xã Bát Mọt Tỉnh Thanh Hóa
1527 15610 Xã Yên Nhân Tỉnh Thanh Hóa
1528 15628 Xã Lương Sơn Tỉnh Thanh Hóa
1529 15646 Xã Thường Xuân Tỉnh Thanh Hóa
1530 15634 Xã Luận Thành Tỉnh Thanh Hóa
1531 15661 Xã Tân Thành Tỉnh Thanh Hóa
1532 15622 Xã Vạn Xuân Tỉnh Thanh Hóa
1533 15643 Xã Thắng Lộc Tỉnh Thanh Hóa
1534 15658 Xã Xuân Chinh Tỉnh Thanh Hóa
*/

/* ********************************************************************
TỈNH NGHỆ AN Tỉnh Nghệ An
1535 17329 Xã Anh Sơn Tỉnh Nghệ An
1536 17380 Xã Yên Xuân Tỉnh Nghệ An
1537 17344 Xã Nhân Hòa Tỉnh Nghệ An
1538 17365 Xã Anh Sơn Đông Tỉnh Nghệ An
1539 17357 Xã Vĩnh Tường Tỉnh Nghệ An
1540 17335 Xã Thành Bình Thọ Tỉnh Nghệ An
53
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1541 17254 Xã Con Cuông Tỉnh Nghệ An
1542 17263 Xã Môn Sơn Tỉnh Nghệ An
1543 17239 Xã Mậu Thạch Tỉnh Nghệ An
1544 17242 Xã Cam Phục Tỉnh Nghệ An
1545 17248 Xã Châu Khê Tỉnh Nghệ An
1546 17230 Xã Bình Chuẩn Tỉnh Nghệ An
1547 17464 Xã Diễn Châu Tỉnh Nghệ An
1548 17416 Xã Đức Châu Tỉnh Nghệ An
1549 17443 Xã Quảng Châu Tỉnh Nghệ An
1550 17419 Xã Hải Châu Tỉnh Nghệ An
1551 17488 Xã Tân Châu Tỉnh Nghệ An
1552 17479 Xã An Châu Tỉnh Nghệ An
1553 17476 Xã Minh Châu Tỉnh Nghệ An
1554 17395 Xã Hùng Châu Tỉnh Nghệ An
1555 17662 Xã Đô Lương Tỉnh Nghệ An
1556 17623 Xã Bạch Ngọc Tỉnh Nghệ An
1557 17677 Xã Văn Hiến Tỉnh Nghệ An
1558 17707 Xã Bạch Hà Tỉnh Nghệ An
1559 17689 Xã Thuần Trung Tỉnh Nghệ An
1560 17641 Xã Lương Sơn Tỉnh Nghệ An
1561 17110 Phường Hoàng Mai Tỉnh Nghệ An
1562 17128 Phường Tân Mai Tỉnh Nghệ An
1563 17125 Phường Quỳnh Mai Tỉnh Nghệ An
1564 18001 Xã Hưng Nguyên Tỉnh Nghệ An
1565 18007 Xã Yên Trung Tỉnh Nghệ An
1566 18028 Xã Hưng Nguyên Nam Tỉnh Nghệ An
1567 18040 Xã Lam Thành Tỉnh Nghệ An
1568 16813 Xã Mường Xén Tỉnh Nghệ An
1569 16849 Xã Hữu Kiệm Tỉnh Nghệ An
1570 16837 Xã Nậm Cắn Tỉnh Nghệ An
54
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1571 16855 Xã Chiêu Lưu Tỉnh Nghệ An
1572 16834 Xã Na Loi Tỉnh Nghệ An
1573 16858 Xã Mường Típ Tỉnh Nghệ An
1574 16870 Xã Na Ngoi Tỉnh Nghệ An
1575 16816 Xã Mỹ Lý Tỉnh Nghệ An
1576 16819 Xã Bắc Lý Tỉnh Nghệ An
1577 16822 Xã Keng Đu Tỉnh Nghệ An
1578 16828 Xã Huồi Tụ Tỉnh Nghệ An
1579 16831 Xã Mường Lống Tỉnh Nghệ An
1580 17950 Xã Vạn An Tỉnh Nghệ An
1581 17935 Xã Nam Đàn Tỉnh Nghệ An
1582 17944 Xã Đại Huệ Tỉnh Nghệ An
1583 17989 Xã Thiên Nhẫn Tỉnh Nghệ An
1584 17971 Xã Kim Liên Tỉnh Nghệ An
1585 16941 Xã Nghĩa Đàn Tỉnh Nghệ An
1586 16969 Xã Nghĩa Thọ Tỉnh Nghệ An
1587 16951 Xã Nghĩa Lâm Tỉnh Nghệ An
1588 16975 Xã Nghĩa Mai Tỉnh Nghệ An
1589 16972 Xã Nghĩa Hưng Tỉnh Nghệ An
1590 17032 Xã Nghĩa Khánh Tỉnh Nghệ An
1591 17029 Xã Nghĩa Lộc Tỉnh Nghệ An
1592 17827 Xã Nghi Lộc Tỉnh Nghệ An
1593 17857 Xã Phúc Lộc Tỉnh Nghệ An
1594 17878 Xã Đông Lộc Tỉnh Nghệ An
1595 17866 Xã Trung Lộc Tỉnh Nghệ An
1596 17842 Xã Thần Lĩnh Tỉnh Nghệ An
1597 17833 Xã Hải Lộc Tỉnh Nghệ An
1598 17854 Xã Văn Kiều Tỉnh Nghệ An
1599 16738 Xã Quế Phong Tỉnh Nghệ An
1600 16750 Xã Tiền Phong Tỉnh Nghệ An
55
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1601 16756 Xã Tri Lễ Tỉnh Nghệ An
1602 16774 Xã Mường Quàng Tỉnh Nghệ An
1603 16744 Xã Thông Thụ Tỉnh Nghệ An
1604 16777 Xã Quỳ Châu Tỉnh Nghệ An
1605 16792 Xã Châu Tiến Tỉnh Nghệ An
1606 16801 Xã Hùng Chân Tỉnh Nghệ An
1607 16804 Xã Châu Bình Tỉnh Nghệ An
1608 17035 Xã Quỳ Hợp Tỉnh Nghệ An
1609 17059 Xã Tam Hợp Tỉnh Nghệ An
1610 17056 Xã Châu Lộc Tỉnh Nghệ An
1611 17044 Xã Châu Hồng Tỉnh Nghệ An
1612 17077 Xã Mường Ham Tỉnh Nghệ An
1613 17089 Xã Mường Chọng Tỉnh Nghệ An
1614 17071 Xã Minh Hợp Tỉnh Nghệ An
1615 17179 Xã Quỳnh Lưu Tỉnh Nghệ An
1616 17143 Xã Quỳnh Văn Tỉnh Nghệ An
1617 17176 Xã Quỳnh Anh Tỉnh Nghệ An
1618 17149 Xã Quỳnh Tam Tỉnh Nghệ An
1619 17212 Xã Quỳnh Phú Tỉnh Nghệ An
1620 17170 Xã Quỳnh Sơn Tỉnh Nghệ An
1621 17224 Xã Quỳnh Thắng Tỉnh Nghệ An
1622 17266 Xã Tân Kỳ Tỉnh Nghệ An
1623 17272 Xã Tân Phú Tỉnh Nghệ An
1624 17305 Xã Tân An Tỉnh Nghệ An
1625 17284 Xã Nghĩa Đồng Tỉnh Nghệ An
1626 17278 Xã Giai Xuân Tỉnh Nghệ An
1627 17326 Xã Nghĩa Hành Tỉnh Nghệ An
1628 17287 Xã Tiên Đồng Tỉnh Nghệ An
1629 16939 Phường Thái Hòa Tỉnh Nghệ An
1630 17011 Phường Tây Hiếu Tỉnh Nghệ An
56
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1631 17017 Xã Đông Hiếu Tỉnh Nghệ An
1632 17728 Xã Cát Ngạn Tỉnh Nghệ An
1633 17743 Xã Tam Đồng Tỉnh Nghệ An
1634 17722 Xã Hạnh Lâm Tỉnh Nghệ An
1635 17759 Xã Sơn Lâm Tỉnh Nghệ An
1636 17770 Xã Hoa Quân Tỉnh Nghệ An
1637 17791 Xã Kim Bảng Tỉnh Nghệ An
1638 17818 Xã Bích Hào Tỉnh Nghệ An
1639 17713 Xã Đại Đồng Tỉnh Nghệ An
1640 17779 Xã Xuân Lâm Tỉnh Nghệ An
1641 16933 Xã Tam Quang Tỉnh Nghệ An
1642 16936 Xã Tam Thái Tỉnh Nghệ An
1643 16876 Xã Tương Dương Tỉnh Nghệ An
1644 16906 Xã Lượng Minh Tỉnh Nghệ An
1645 16912 Xã Yên Na Tỉnh Nghệ An
1646 16909 Xã Yên Hòa Tỉnh Nghệ An
1647 16903 Xã Nga My Tỉnh Nghệ An
1648 16885 Xã Hữu Khuông Tỉnh Nghệ An
1649 16882 Xã Nhôn Mai Tỉnh Nghệ An
1650 16690 Phường Trường Vinh Tỉnh Nghệ An
1651 16681 Phường Thành Vinh Tỉnh Nghệ An
1652 17920 Phường Vinh Hưng Tỉnh Nghệ An
1653 16702 Phường Vinh Phú Tỉnh Nghệ An
1654 16708 Phường Vinh Lộc Tỉnh Nghệ An
1655 16732 Phường Cửa Lò Tỉnh Nghệ An
1656 17506 Xã Yên Thành Tỉnh Nghệ An
1657 17569 Xã Quan Thành Tỉnh Nghệ An
1658 17605 Xã Hợp Minh Tỉnh Nghệ An
1659 17611 Xã Vân Tụ Tỉnh Nghệ An
1660 17560 Xã Vân Du Tỉnh Nghệ An
57
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1661 17521 Xã Quang Đồng Tỉnh Nghệ An
1662 17524 Xã Giai Lạc Tỉnh Nghệ An
1663 17515 Xã Bình Minh Tỉnh Nghệ An
1664 17530 Xã Đông Thành Tỉnh Nghệ An
*/

/* ********************************************************************
TỈNH HÀ TĨNH Tỉnh Hà Tĩnh
1665 18754 Phường Sông Trí Tỉnh Hà Tĩnh
1666 18781 Phường Hải Ninh Tỉnh Hà Tĩnh
1667 18832 Phường Hoành Sơn Tỉnh Hà Tĩnh
1668 18823 Phường Vũng Áng Tỉnh Hà Tĩnh
1669 18766 Xã Kỳ Xuân Tỉnh Hà Tĩnh
1670 18775 Xã Kỳ Anh Tỉnh Hà Tĩnh
1671 18814 Xã Kỳ Hoa Tỉnh Hà Tĩnh
1672 18787 Xã Kỳ Văn Tỉnh Hà Tĩnh
1673 18790 Xã Kỳ Khang Tỉnh Hà Tĩnh
1674 18838 Xã Kỳ Lạc Tỉnh Hà Tĩnh
1675 18844 Xã Kỳ Thượng Tỉnh Hà Tĩnh
1676 18673 Xã Cẩm Xuyên Tỉnh Hà Tĩnh
1677 18676 Xã Thiên Cầm Tỉnh Hà Tĩnh
1678 18739 Xã Cẩm Duệ Tỉnh Hà Tĩnh
1679 18736 Xã Cẩm Hưng Tỉnh Hà Tĩnh
1680 18748 Xã Cẩm Lạc Tỉnh Hà Tĩnh
1681 18742 Xã Cẩm Trung Tỉnh Hà Tĩnh
1682 18682 Xã Yên Hòa Tỉnh Hà Tĩnh
1683 18073 Phường Thành Sen Tỉnh Hà Tĩnh
1684 18100 Phường Trần Phú Tỉnh Hà Tĩnh
1685 18652 Phường Hà Huy Tập Tỉnh Hà Tĩnh
1686 18628 Xã Thạch Lạc Tỉnh Hà Tĩnh
1687 18619 Xã Đồng Tiến Tỉnh Hà Tĩnh
1688 18604 Xã Thạch Khê Tỉnh Hà Tĩnh
1689 18685 Xã Cẩm Bình Tỉnh Hà Tĩnh
58
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1690 18562 Xã Thạch Hà Tỉnh Hà Tĩnh
1691 18634 Xã Toàn Lưu Tỉnh Hà Tĩnh
1692 18601 Xã Việt Xuyên Tỉnh Hà Tĩnh
1693 18586 Xã Đông Kinh Tỉnh Hà Tĩnh
1694 18667 Xã Thạch Xuân Tỉnh Hà Tĩnh
1695 18568 Xã Lộc Hà Tỉnh Hà Tĩnh
1696 18409 Xã Hồng Lộc Tỉnh Hà Tĩnh
1697 18583 Xã Mai Phụ Tỉnh Hà Tĩnh
1698 18406 Xã Can Lộc Tỉnh Hà Tĩnh
1699 18418 Xã Tùng Lộc Tỉnh Hà Tĩnh
1700 18466 Xã Gia Hanh Tỉnh Hà Tĩnh
1701 18436 Xã Trường Lưu Tỉnh Hà Tĩnh
1702 18481 Xã Xuân Lộc Tỉnh Hà Tĩnh
1703 18484 Xã Đồng Lộc Tỉnh Hà Tĩnh
1704 18115 Phường Bắc Hồng Lĩnh Tỉnh Hà Tĩnh
1705 18118 Phường Nam Hồng Lĩnh Tỉnh Hà Tĩnh
1706 18373 Xã Tiên Điền Tỉnh Hà Tĩnh
1707 18352 Xã Nghi Xuân Tỉnh Hà Tĩnh
1708 18394 Xã Cổ Đạm Tỉnh Hà Tĩnh
1709 18364 Xã Đan Hải Tỉnh Hà Tĩnh
1710 18229 Xã Đức Thọ Tỉnh Hà Tĩnh
1711 18262 Xã Đức Quang Tỉnh Hà Tĩnh
1712 18304 Xã Đức Đồng Tỉnh Hà Tĩnh
1713 18277 Xã Đức Thịnh Tỉnh Hà Tĩnh
1714 18244 Xã Đức Minh Tỉnh Hà Tĩnh
1715 18133 Xã Hương Sơn Tỉnh Hà Tĩnh
1716 18172 Xã Sơn Tây Tỉnh Hà Tĩnh
1717 18202 Xã Tứ Mỹ Tỉnh Hà Tĩnh
1718 18184 Xã Sơn Giang Tỉnh Hà Tĩnh
1719 18163 Xã Sơn Tiến Tỉnh Hà Tĩnh
59
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1720 18160 Xã Sơn Hồng Tỉnh Hà Tĩnh
1721 18223 Xã Kim Hoa Tỉnh Hà Tĩnh
1722 18313 Xã Vũ Quang Tỉnh Hà Tĩnh
1723 18322 Xã Mai Hoa Tỉnh Hà Tĩnh
1724 18328 Xã Thượng Đức Tỉnh Hà Tĩnh
1725 18496 Xã Hương Khê Tỉnh Hà Tĩnh
1726 18532 Xã Hương Phố Tỉnh Hà Tĩnh
1727 18550 Xã Hương Đô Tỉnh Hà Tĩnh
1728 18502 Xã Hà Linh Tỉnh Hà Tĩnh
1729 18523 Xã Hương Bình Tỉnh Hà Tĩnh
1730 18547 Xã Phúc Trạch Tỉnh Hà Tĩnh
1731 18544 Xã Hương Xuân Tỉnh Hà Tĩnh
1732 18196 Xã Sơn Kim 1 Tỉnh Hà Tĩnh
1733 18199 Xã Sơn Kim 2 Tỉnh Hà Tĩnh
*/

/* ********************************************************************
TỈNH QUẢNG TRỊ Tỉnh Quảng Trị
1734 18880 Phường Đồng Hới Tỉnh Quảng Trị
1735 18859 Phường Đồng Thuận Tỉnh Quảng Trị
1736 18871 Phường Đồng Sơn Tỉnh Quảng Trị
1737 19093 Xã Nam Gianh Tỉnh Quảng Trị
1738 19075 Xã Nam Ba Đồn Tỉnh Quảng Trị
1739 19009 Phường Ba Đồn Tỉnh Quảng Trị
1740 19066 Phường Bắc Gianh Tỉnh Quảng Trị
1741 18904 Xã Dân Hóa Tỉnh Quảng Trị
1742 18922 Xã Kim Điền Tỉnh Quảng Trị
1743 18943 Xã Kim Phú Tỉnh Quảng Trị
1744 18901 Xã Minh Hóa Tỉnh Quảng Trị
1745 18919 Xã Tân Thành Tỉnh Quảng Trị
1746 18958 Xã Tuyên Lâm Tỉnh Quảng Trị
1747 18952 Xã Tuyên Sơn Tỉnh Quảng Trị
1748 18949 Xã Đồng Lê Tỉnh Quảng Trị
60
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1749 18985 Xã Tuyên Phú Tỉnh Quảng Trị
1750 18991 Xã Tuyên Bình Tỉnh Quảng Trị
1751 18997 Xã Tuyên Hóa Tỉnh Quảng Trị
1752 19051 Xã Tân Gianh Tỉnh Quảng Trị
1753 19030 Xã Trung Thuần Tỉnh Quảng Trị
1754 19057 Xã Quảng Trạch Tỉnh Quảng Trị
1755 19033 Xã Hòa Trạch Tỉnh Quảng Trị
1756 19021 Xã Phú Trạch Tỉnh Quảng Trị
1757 19147 Xã Thượng Trạch Tỉnh Quảng Trị
1758 19138 Xã Phong Nha Tỉnh Quảng Trị
1759 19126 Xã Bắc Trạch Tỉnh Quảng Trị
1760 19159 Xã Đông Trạch Tỉnh Quảng Trị
1761 19111 Xã Hoàn Lão Tỉnh Quảng Trị
1762 19141 Xã Bố Trạch Tỉnh Quảng Trị
1763 19198 Xã Nam Trạch Tỉnh Quảng Trị
1764 19207 Xã Quảng Ninh Tỉnh Quảng Trị
1765 19225 Xã Ninh Châu Tỉnh Quảng Trị
1766 19237 Xã Trường Ninh Tỉnh Quảng Trị
1767 19204 Xã Trường Sơn Tỉnh Quảng Trị
1768 19249 Xã Lệ Thủy Tỉnh Quảng Trị
1769 19255 Xã Cam Hồng Tỉnh Quảng Trị
1770 19288 Xã Sen Ngư Tỉnh Quảng Trị
1771 19291 Xã Tân Mỹ Tỉnh Quảng Trị
1772 19309 Xã Trường Phú Tỉnh Quảng Trị
1773 19246 Xã Lệ Ninh Tỉnh Quảng Trị
1774 19318 Xã Kim Ngân Tỉnh Quảng Trị
1775 19333 Phường Đông Hà Tỉnh Quảng Trị
1776 19351 Phường Nam Đông Hà Tỉnh Quảng Trị
1777 19360 Phường Quảng Trị Tỉnh Quảng Trị
1778 19363 Xã Vĩnh Linh Tỉnh Quảng Trị
61
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1779 19414 Xã Cửa Tùng Tỉnh Quảng Trị
1780 19372 Xã Vĩnh Hoàng Tỉnh Quảng Trị
1781 19405 Xã Vĩnh Thủy Tỉnh Quảng Trị
1782 19366 Xã Bến Quan Tỉnh Quảng Trị
1783 19537 Xã Cồn Tiên Tỉnh Quảng Trị
1784 19496 Xã Cửa Việt Tỉnh Quảng Trị
1785 19495 Xã Gio Linh Tỉnh Quảng Trị
1786 19501 Xã Bến Hải Tỉnh Quảng Trị
1787 19435 Xã Hướng Lập Tỉnh Quảng Trị
1788 19441 Xã Hướng Phùng Tỉnh Quảng Trị
1789 19429 Xã Khe Sanh Tỉnh Quảng Trị
1790 19462 Xã Tân Lập Tỉnh Quảng Trị
1791 19432 Xã Lao Bảo Tỉnh Quảng Trị
1792 19489 Xã Lìa Tỉnh Quảng Trị
1793 19483 Xã A Dơi Tỉnh Quảng Trị
1794 19594 Xã La Lay Tỉnh Quảng Trị
1795 19588 Xã Tà Rụt Tỉnh Quảng Trị
1796 19564 Xã Đakrông Tỉnh Quảng Trị
1797 19567 Xã Ba Lòng Tỉnh Quảng Trị
1798 19555 Xã Hướng Hiệp Tỉnh Quảng Trị
1799 19597 Xã Cam Lộ Tỉnh Quảng Trị
1800 19603 Xã Hiếu Giang Tỉnh Quảng Trị
1801 19624 Xã Triệu Phong Tỉnh Quảng Trị
1802 19669 Xã Ái Tử Tỉnh Quảng Trị
1803 19645 Xã Triệu Bình Tỉnh Quảng Trị
1804 19654 Xã Triệu Cơ Tỉnh Quảng Trị
1805 19639 Xã Nam Cửa Việt Tỉnh Quảng Trị
1806 19681 Xã Diên Sanh Tỉnh Quảng Trị
1807 19741 Xã Mỹ Thủy Tỉnh Quảng Trị
1808 19702 Xã Hải Lăng Tỉnh Quảng Trị
62
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1809 19699 Xã Vĩnh Định Tỉnh Quảng Trị
1810 19735 Xã Nam Hải Lăng Tỉnh Quảng Trị
1811 19742 Đặc khu Cồn Cỏ Tỉnh Quảng Trị
*/

/* ********************************************************************
THÀNH PHỐ HUẾ Thành phố Huế
1812 19900 Phường Thuận An Thành phố Huế
1813 20014 Phường Hóa Châu Thành phố Huế
1814 19930 Phường Mỹ Thượng Thành phố Huế
1815 19777 Phường Vỹ Dạ Thành phố Huế
1816 19789 Phường Thuận Hóa Thành phố Huế
1817 19815 Phường An Cựu Thành phố Huế
1818 19813 Phường Thủy Xuân Thành phố Huế
1819 19774 Phường Kim Long Thành phố Huế
1820 19804 Phường Hương An Thành phố Huế
1821 19753 Phường Phú Xuân Thành phố Huế
1822 19996 Phường Hương Trà Thành phố Huế
1823 20017 Phường Kim Trà Thành phố Huế
1824 19969 Phường Thanh Thủy Thành phố Huế
1825 19975 Phường Hương Thủy Thành phố Huế
1826 19960 Phường Phú Bài Thành phố Huế
1827 19819 Phường Phong Điền Thành phố Huế
1828 19858 Phường Phong Thái Thành phố Huế
1829 19831 Phường Phong Dinh Thành phố Huế
1830 19828 Phường Phong Phú Thành phố Huế
1831 19873 Phường Phong Quảng Thành phố Huế
1832 19885 Xã Đan Điền Thành phố Huế
1833 19867 Xã Quảng Điền Thành phố Huế
1834 19945 Xã Phú Vinh Thành phố Huế
1835 19918 Xã Phú Hồ Thành phố Huế
1836 19942 Xã Phú Vang Thành phố Huế
1837 20122 Xã Vinh Lộc Thành phố Huế
63
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1838 20131 Xã Hưng Lộc Thành phố Huế
1839 20140 Xã Lộc An Thành phố Huế
1840 20107 Xã Phú Lộc Thành phố Huế
1841 20137 Xã Chân Mây - Lăng Cô Thành phố Huế
1842 20182 Xã Long Quảng Thành phố Huế
1843 20179 Xã Nam Đông Thành phố Huế
1844 20161 Xã Khe Tre Thành phố Huế
1845 20035 Xã Bình Điền Thành phố Huế
1846 20056 Xã A Lưới 1 Thành phố Huế
1847 20044 Xã A Lưới 2 Thành phố Huế
1848 20071 Xã A Lưới 3 Thành phố Huế
1849 20101 Xã A Lưới 4 Thành phố Huế
1850 20050 Xã A Lưới 5 Thành phố Huế
1851 19909 Phường Dương Nỗ Thành phố Huế
*/

/* ********************************************************************
THÀNH PHỐ ĐÀ NẴNG Tp Đà Nẵng
1852 20242 Phường Hải Châu Tp Đà Nẵng
1853 20257 Phường Hòa Cường Tp Đà Nẵng
1854 20209 Phường Thanh Khê Tp Đà Nẵng
1855 20305 Phường An Khê Tp Đà Nẵng
1856 20275 Phường An Hải Tp Đà Nẵng
1857 20263 Phường Sơn Trà Tp Đà Nẵng
1858 20285 Phường Ngũ Hành Sơn Tp Đà Nẵng
1859 20200 Phường Hòa Khánh Tp Đà Nẵng
1860 20194 Phường Hải Vân Tp Đà Nẵng
1861 20197 Phường Liên Chiểu Tp Đà Nẵng
1862 20260 Phường Cẩm Lệ Tp Đà Nẵng
1863 20314 Phường Hòa Xuân Tp Đà Nẵng
1864 20320 Xã Hòa Vang Tp Đà Nẵng
1865 20332 Xã Hòa Tiến Tp Đà Nẵng
1866 20308 Xã Bà Nà Tp Đà Nẵng
64
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1867 20333 Đặc khu Hoàng Sa Tp Đà Nẵng
1868 20965 Xã Núi Thành Tp Đà Nẵng
1869 21004 Xã Tam Mỹ Tp Đà Nẵng
1870 20984 Xã Tam Anh Tp Đà Nẵng
1871 20977 Xã Đức Phú Tp Đà Nẵng
1872 20971 Xã Tam Xuân Tp Đà Nẵng
1873 20992 Xã Tam Hải Tp Đà Nẵng
1874 20341 Phường Tam Kỳ Tp Đà Nẵng
1875 20356 Phường Quảng Phú Tp Đà Nẵng
1876 20350 Phường Hương Trà Tp Đà Nẵng
1877 20335 Phường Bàn Thạch Tp Đà Nẵng
1878 20380 Xã Tây Hồ Tp Đà Nẵng
1879 20364 Xã Chiên Đàn Tp Đà Nẵng
1880 20392 Xã Phú Ninh Tp Đà Nẵng
1881 20875 Xã Lãnh Ngọc Tp Đà Nẵng
1882 20854 Xã Tiên Phước Tp Đà Nẵng
1883 20878 Xã Thạnh Bình Tp Đà Nẵng
1884 20857 Xã Sơn Cẩm Hà Tp Đà Nẵng
1885 20908 Xã Trà Liên Tp Đà Nẵng
1886 20929 Xã Trà Giáp Tp Đà Nẵng
1887 20923 Xã Trà Tân Tp Đà Nẵng
1888 20920 Xã Trà Đốc Tp Đà Nẵng
1889 20900 Xã Trà My Tp Đà Nẵng
1890 20944 Xã Nam Trà My Tp Đà Nẵng
1891 20941 Xã Trà Tập Tp Đà Nẵng
1892 20959 Xã Trà Vân Tp Đà Nẵng
1893 20950 Xã Trà Linh Tp Đà Nẵng
1894 20938 Xã Trà Leng Tp Đà Nẵng
1895 20791 Xã Thăng Bình Tp Đà Nẵng
65
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1896 20794 Xã Thăng An Tp Đà Nẵng
1897 20836 Xã Thăng Trường Tp Đà Nẵng
1898 20848 Xã Thăng Điền Tp Đà Nẵng
1899 20827 Xã Thăng Phú Tp Đà Nẵng
1900 20818 Xã Đồng Dương Tp Đà Nẵng
1901 20662 Xã Quế Sơn Trung Tp Đà Nẵng
1902 20641 Xã Quế Sơn Tp Đà Nẵng
1903 20650 Xã Xuân Phú Tp Đà Nẵng
1904 20656 Xã Nông Sơn Tp Đà Nẵng
1905 20669 Xã Quế Phước Tp Đà Nẵng
1906 20635 Xã Duy Nghĩa Tp Đà Nẵng
1907 20599 Xã Nam Phước Tp Đà Nẵng
1908 20623 Xã Duy Xuyên Tp Đà Nẵng
1909 20611 Xã Thu Bồn Tp Đà Nẵng
1910 20551 Phường Điện Bàn Tp Đà Nẵng
1911 20579 Phường Điện Bàn Đông Tp Đà Nẵng
1912 20575 Phường An Thắng Tp Đà Nẵng
1913 20557 Phường Điện Bàn Bắc Tp Đà Nẵng
1914 20569 Xã Điện Bàn Tây Tp Đà Nẵng
1915 20587 Xã Gò Nổi Tp Đà Nẵng
1916 20410 Phường Hội An Tp Đà Nẵng
1917 20413 Phường Hội An Đông Tp Đà Nẵng
1918 20401 Phường Hội An Tây Tp Đà Nẵng
1919 20434 Xã Tân Hiệp Tp Đà Nẵng
1920 20500 Xã Đại Lộc Tp Đà Nẵng
1921 20515 Xã Hà Nha Tp Đà Nẵng
1922 20506 Xã Thượng Đức Tp Đà Nẵng
1923 20539 Xã Vu Gia Tp Đà Nẵng
1924 20542 Xã Phú Thuận Tp Đà Nẵng
1925 20695 Xã Thạnh Mỹ Tp Đà Nẵng
66
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1926 20710 Xã Bến Giằng Tp Đà Nẵng
1927 20707 Xã Nam Giang Tp Đà Nẵng
1928 20716 Xã Đắc Pring Tp Đà Nẵng
1929 20704 Xã La Dêê Tp Đà Nẵng
1930 20698 Xã La Êê Tp Đà Nẵng
1931 20485 Xã Sông Vàng Tp Đà Nẵng
1932 20476 Xã Sông Kôn Tp Đà Nẵng
1933 20467 Xã Đông Giang Tp Đà Nẵng
1934 20494 Xã Bến Hiên Tp Đà Nẵng
1935 20458 Xã Avương Tp Đà Nẵng
1936 20455 Xã Tây Giang Tp Đà Nẵng
1937 20443 Xã Hùng Sơn Tp Đà Nẵng
1938 20779 Xã Hiệp Đức Tp Đà Nẵng
1939 20767 Xã Việt An Tp Đà Nẵng
1940 20770 Xã Phước Trà Tp Đà Nẵng
1941 20722 Xã Khâm Đức Tp Đà Nẵng
1942 20734 Xã Phước Năng Tp Đà Nẵng
1943 20740 Xã Phước Chánh Tp Đà Nẵng
1944 20752 Xã Phước Thành Tp Đà Nẵng
1945 20728 Xã Phước Hiệp Tp Đà Nẵng
*/

/* ********************************************************************
TỈNH QUẢNG NGÃI Tỉnh Quảng Ngãi
1946 21211 Xã Tịnh Khê Tỉnh Quảng Ngãi
1947 21172 Phường Trương Quang Trọng Tỉnh Quảng Ngãi
1948 21034 Xã An Phú Tỉnh Quảng Ngãi
1949 21025 Phường Cẩm Thành Tỉnh Quảng Ngãi
1950 21028 Phường Nghĩa Lộ Tỉnh Quảng Ngãi
1951 21451 Phường Trà Câu Tỉnh Quảng Ngãi
1952 21457 Xã Nguyễn Nghiêm Tỉnh Quảng Ngãi
1953 21439 Phường Đức Phổ Tỉnh Quảng Ngãi
1954 21472 Xã Khánh Cường Tỉnh Quảng Ngãi
67
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1955 21478 Phường Sa Huỳnh Tỉnh Quảng Ngãi
1956 21085 Xã Bình Minh Tỉnh Quảng Ngãi
1957 21100 Xã Bình Chương Tỉnh Quảng Ngãi
1958 21040 Xã Bình Sơn Tỉnh Quảng Ngãi
1959 21061 Xã Vạn Tường Tỉnh Quảng Ngãi
1960 21109 Xã Đông Sơn Tỉnh Quảng Ngãi
1961 21196 Xã Trường Giang Tỉnh Quảng Ngãi
1962 21205 Xã Ba Gia Tỉnh Quảng Ngãi
1963 21220 Xã Sơn Tịnh Tỉnh Quảng Ngãi
1964 21181 Xã Thọ Phong Tỉnh Quảng Ngãi
1965 21235 Xã Tư Nghĩa Tỉnh Quảng Ngãi
1966 21238 Xã Vệ Giang Tỉnh Quảng Ngãi
1967 21250 Xã Nghĩa Giang Tỉnh Quảng Ngãi
1968 21244 Xã Trà Giang Tỉnh Quảng Ngãi
1969 21364 Xã Nghĩa Hành Tỉnh Quảng Ngãi
1970 21385 Xã Đình Cương Tỉnh Quảng Ngãi
1971 21388 Xã Thiện Tín Tỉnh Quảng Ngãi
1972 21370 Xã Phước Giang Tỉnh Quảng Ngãi
1973 21409 Xã Long Phụng Tỉnh Quảng Ngãi
1974 21421 Xã Mỏ Cày Tỉnh Quảng Ngãi
1975 21400 Xã Mộ Đức Tỉnh Quảng Ngãi
1976 21433 Xã Lân Phong Tỉnh Quảng Ngãi
1977 21115 Xã Trà Bồng Tỉnh Quảng Ngãi
1978 21127 Xã Đông Trà Bồng Tỉnh Quảng Ngãi
1979 21154 Xã Tây Trà Tỉnh Quảng Ngãi
1980 21124 Xã Thanh Bồng Tỉnh Quảng Ngãi
1981 21136 Xã Cà Đam Tỉnh Quảng Ngãi
1982 21157 Xã Tây Trà Bồng Tỉnh Quảng Ngãi
1983 21292 Xã Sơn Hạ Tỉnh Quảng Ngãi
1984 21307 Xã Sơn Linh Tỉnh Quảng Ngãi
68
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
1985 21289 Xã Sơn Hà Tỉnh Quảng Ngãi
1986 21319 Xã Sơn Thủy Tỉnh Quảng Ngãi
1987 21325 Xã Sơn Kỳ Tỉnh Quảng Ngãi
1988 21340 Xã Sơn Tây Tỉnh Quảng Ngãi
1989 21334 Xã Sơn Tây Thượng Tỉnh Quảng Ngãi
1990 21343 Xã Sơn Tây Hạ Tỉnh Quảng Ngãi
1991 21361 Xã Minh Long Tỉnh Quảng Ngãi
1992 21349 Xã Sơn Mai Tỉnh Quảng Ngãi
1993 21529 Xã Ba Vì Tỉnh Quảng Ngãi
1994 21523 Xã Ba Tô Tỉnh Quảng Ngãi
1995 21499 Xã Ba Dinh Tỉnh Quảng Ngãi
1996 21484 Xã Ba Tơ Tỉnh Quảng Ngãi
1997 21490 Xã Ba Vinh Tỉnh Quảng Ngãi
1998 21496 Xã Ba Động Tỉnh Quảng Ngãi
1999 21520 Xã Đặng Thùy Trâm Tỉnh Quảng Ngãi
2000 21538 Xã Ba Xa Tỉnh Quảng Ngãi
2001 21548 Đặc khu Lý Sơn Tỉnh Quảng Ngãi
2002 23293 Phường Kon Tum Tỉnh Quảng Ngãi
2003 23284 Phường Đăk Cấm Tỉnh Quảng Ngãi
2004 23302 Phường Đăk Bla Tỉnh Quảng Ngãi
2005 23317 Xã Ngọk Bay Tỉnh Quảng Ngãi
2006 23326 Xã Ia Chim Tỉnh Quảng Ngãi
2007 23332 Xã Đăk Rơ Wa Tỉnh Quảng Ngãi
2008 23504 Xã Đăk Pxi Tỉnh Quảng Ngãi
2009 23512 Xã Đăk Mar Tỉnh Quảng Ngãi
2010 23510 Xã Đăk Ui Tỉnh Quảng Ngãi
2011 23515 Xã Ngọk Réo Tỉnh Quảng Ngãi
2012 23500 Xã Đăk Hà Tỉnh Quảng Ngãi
2013 23428 Xã Ngọk Tụ Tỉnh Quảng Ngãi
2014 23401 Xã Đăk Tô Tỉnh Quảng Ngãi
69
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2015 23430 Xã Kon Đào Tỉnh Quảng Ngãi
2016 23416 Xã Đăk Sao Tỉnh Quảng Ngãi
2017 23419 Xã Đăk Tờ Kan Tỉnh Quảng Ngãi
2018 23425 Xã Tu Mơ Rông Tỉnh Quảng Ngãi
2019 23446 Xã Măng Ri Tỉnh Quảng Ngãi
2020 23377 Xã Bờ Y Tỉnh Quảng Ngãi
2021 23392 Xã Sa Loong Tỉnh Quảng Ngãi
2022 23383 Xã Dục Nông Tỉnh Quảng Ngãi
2023 23356 Xã Xốp Tỉnh Quảng Ngãi
2024 23365 Xã Ngọc Linh Tỉnh Quảng Ngãi
2025 23344 Xã Đăk Plô Tỉnh Quảng Ngãi
2026 23341 Xã Đăk Pék Tỉnh Quảng Ngãi
2027 23374 Xã Đăk Môn Tỉnh Quảng Ngãi
2028 23527 Xã Sa Thầy Tỉnh Quảng Ngãi
2029 23534 Xã Sa Bình Tỉnh Quảng Ngãi
2030 23548 Xã Ya Ly Tỉnh Quảng Ngãi
2031 23538 Xã Ia Tơi Tỉnh Quảng Ngãi
2032 23485 Xã Đăk Kôi Tỉnh Quảng Ngãi
2033 23497 Xã Kon Braih Tỉnh Quảng Ngãi
2034 23479 Xã Đăk Rve Tỉnh Quảng Ngãi
2035 23473 Xã Măng Đen Tỉnh Quảng Ngãi
2036 23455 Xã Măng Bút Tỉnh Quảng Ngãi
2037 23476 Xã Kon Plông Tỉnh Quảng Ngãi
2038 23368 Xã Đăk Long Tỉnh Quảng Ngãi
2039 23530 Xã Rờ Kơi Tỉnh Quảng Ngãi
2040 23536 Xã Mô Rai Tỉnh Quảng Ngãi
2041 23535 Xã Ia Đal Tỉnh Quảng Ngãi
*/

/* ********************************************************************
TỈNH GIA LAI Tỉnh Gia Lai
2042 21583 Phường Quy Nhơn Tỉnh Gia Lai
2043 21601 Phường Quy Nhơn Đông Tỉnh Gia Lai
70
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2044 21589 Phường Quy Nhơn Tây Tỉnh Gia Lai
2045 21592 Phường Quy Nhơn Nam Tỉnh Gia Lai
2046 21553 Phường Quy Nhơn Bắc Tỉnh Gia Lai
2047 21907 Phường Bình Định Tỉnh Gia Lai
2048 21910 Phường An Nhơn Tỉnh Gia Lai
2049 21934 Phường An Nhơn Đông Tỉnh Gia Lai
2050 21943 Phường An Nhơn Nam Tỉnh Gia Lai
2051 21925 Phường An Nhơn Bắc Tỉnh Gia Lai
2052 21940 Xã An Nhơn Tây Tỉnh Gia Lai
2053 21640 Phường Bồng Sơn Tỉnh Gia Lai
2054 21664 Phường Hoài Nhơn Tỉnh Gia Lai
2055 21637 Phường Tam Quan Tỉnh Gia Lai
2056 21670 Phường Hoài Nhơn Đông Tỉnh Gia Lai
2057 21661 Phường Hoài Nhơn Tây Tỉnh Gia Lai
2058 21673 Phường Hoài Nhơn Nam Tỉnh Gia Lai
2059 21655 Phường Hoài Nhơn Bắc Tỉnh Gia Lai
2060 21853 Xã Phù Cát Tỉnh Gia Lai
2061 21892 Xã Xuân An Tỉnh Gia Lai
2062 21901 Xã Ngô Mây Tỉnh Gia Lai
2063 21880 Xã Cát Tiến Tỉnh Gia Lai
2064 21859 Xã Đề Gi Tỉnh Gia Lai
2065 21871 Xã Hòa Hội Tỉnh Gia Lai
2066 21868 Xã Hội Sơn Tỉnh Gia Lai
2067 21730 Xã Phù Mỹ Tỉnh Gia Lai
2068 21769 Xã An Lương Tỉnh Gia Lai
2069 21733 Xã Bình Dương Tỉnh Gia Lai
2070 21751 Xã Phù Mỹ Đông Tỉnh Gia Lai
2071 21757 Xã Phù Mỹ Tây Tỉnh Gia Lai
2072 21775 Xã Phù Mỹ Nam Tỉnh Gia Lai
2073 21739 Xã Phù Mỹ Bắc Tỉnh Gia Lai
71
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2074 21952 Xã Tuy Phước Tỉnh Gia Lai
2075 21970 Xã Tuy Phước Đông Tỉnh Gia Lai
2076 21985 Xã Tuy Phước Tây Tỉnh Gia Lai
2077 21964 Xã Tuy Phước Bắc Tỉnh Gia Lai
2078 21808 Xã Tây Sơn Tỉnh Gia Lai
2079 21820 Xã Bình Khê Tỉnh Gia Lai
2080 21835 Xã Bình Phú Tỉnh Gia Lai
2081 21817 Xã Bình Hiệp Tỉnh Gia Lai
2082 21829 Xã Bình An Tỉnh Gia Lai
2083 21688 Xã Hoài Ân Tỉnh Gia Lai
2084 21715 Xã Ân Tường Tỉnh Gia Lai
2085 21727 Xã Kim Sơn Tỉnh Gia Lai
2086 21703 Xã Vạn Đức Tỉnh Gia Lai
2087 21697 Xã Ân Hảo Tỉnh Gia Lai
2088 21994 Xã Vân Canh Tỉnh Gia Lai
2089 22006 Xã Canh Vinh Tỉnh Gia Lai
2090 21997 Xã Canh Liên Tỉnh Gia Lai
2091 21786 Xã Vĩnh Thạnh Tỉnh Gia Lai
2092 21796 Xã Vĩnh Thịnh Tỉnh Gia Lai
2093 21805 Xã Vĩnh Quang Tỉnh Gia Lai
2094 21787 Xã Vĩnh Sơn Tỉnh Gia Lai
2095 21628 Xã An Hòa Tỉnh Gia Lai
2096 21609 Xã An Lão Tỉnh Gia Lai
2097 21616 Xã An Vinh Tỉnh Gia Lai
2098 21622 Xã An Toàn Tỉnh Gia Lai
2099 23575 Phường Pleiku Tỉnh Gia Lai
2100 23586 Phường Hội Phú Tỉnh Gia Lai
2101 23584 Phường Thống Nhất Tỉnh Gia Lai
2102 23563 Phường Diên Hồng Tỉnh Gia Lai
2103 23602 Phường An Phú Tỉnh Gia Lai
72
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2104 23590 Xã Biển Hồ Tỉnh Gia Lai
2105 23611 Xã Gào Tỉnh Gia Lai
2106 23734 Xã Ia Ly Tỉnh Gia Lai
2107 23722 Xã Chư Păh Tỉnh Gia Lai
2108 23728 Xã Ia Khươl Tỉnh Gia Lai
2109 23749 Xã Ia Phí Tỉnh Gia Lai
2110 23887 Xã Chư Prông Tỉnh Gia Lai
2111 23896 Xã Bàu Cạn Tỉnh Gia Lai
2112 23911 Xã Ia Boòng Tỉnh Gia Lai
2113 23935 Xã Ia Lâu Tỉnh Gia Lai
2114 23926 Xã Ia Pia Tỉnh Gia Lai
2115 23908 Xã Ia Tôr Tỉnh Gia Lai
2116 23941 Xã Chư Sê Tỉnh Gia Lai
2117 23947 Xã Bờ Ngoong Tỉnh Gia Lai
2118 23977 Xã Ia Ko Tỉnh Gia Lai
2119 23954 Xã Al Bá Tỉnh Gia Lai
2120 23942 Xã Chư Pưh Tỉnh Gia Lai
2121 23986 Xã Ia Le Tỉnh Gia Lai
2122 23971 Xã Ia Hrú Tỉnh Gia Lai
2123 23617 Phường An Khê Tỉnh Gia Lai
2124 23614 Phường An Bình Tỉnh Gia Lai
2125 23629 Xã Cửu An Tỉnh Gia Lai
2126 23995 Xã Đak Pơ Tỉnh Gia Lai
2127 24007 Xã Ya Hội Tỉnh Gia Lai
2128 23638 Xã Kbang Tỉnh Gia Lai
2129 23674 Xã Kông Bơ La Tỉnh Gia Lai
2130 23668 Xã Tơ Tung Tỉnh Gia Lai
2131 23647 Xã Sơn Lang Tỉnh Gia Lai
2132 23644 Xã Đak Rong Tỉnh Gia Lai
2133 23824 Xã Kông Chro Tỉnh Gia Lai
73
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2134 23833 Xã Ya Ma Tỉnh Gia Lai
2135 23830 Xã Chư Krey Tỉnh Gia Lai
2136 23839 Xã SRó Tỉnh Gia Lai
2137 23842 Xã Đăk Song Tỉnh Gia Lai
2138 23851 Xã Chơ Long Tỉnh Gia Lai
2139 24044 Phường Ayun Pa Tỉnh Gia Lai
2140 24065 Xã Ia Rbol Tỉnh Gia Lai
2141 24073 Xã Ia Sao Tỉnh Gia Lai
2142 24043 Xã Phú Thiện Tỉnh Gia Lai
2143 24049 Xã Chư A Thai Tỉnh Gia Lai
2144 24061 Xã Ia Hiao Tỉnh Gia Lai
2145 24013 Xã Pờ Tó Tỉnh Gia Lai
2146 24022 Xã Ia Pa Tỉnh Gia Lai
2147 24028 Xã Ia Tul Tỉnh Gia Lai
2148 24076 Xã Phú Túc Tỉnh Gia Lai
2149 24100 Xã Ia Dreh Tỉnh Gia Lai
2150 24112 Xã Ia Rsai Tỉnh Gia Lai
2151 24109 Xã Uar Tỉnh Gia Lai
2152 23677 Xã Đak Đoa Tỉnh Gia Lai
2153 23701 Xã Kon Gang Tỉnh Gia Lai
2154 23710 Xã Ia Băng Tỉnh Gia Lai
2155 23714 Xã KDang Tỉnh Gia Lai
2156 23683 Xã Đak Sơmei Tỉnh Gia Lai
2157 23794 Xã Mang Yang Tỉnh Gia Lai
2158 23812 Xã Lơ Pang Tỉnh Gia Lai
2159 23818 Xã Kon Chiêng Tỉnh Gia Lai
2160 23799 Xã Hra Tỉnh Gia Lai
2161 23798 Xã Ayun Tỉnh Gia Lai
2162 23764 Xã Ia Grai Tỉnh Gia Lai
2163 23776 Xã Ia Krái Tỉnh Gia Lai
74
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2164 23767 Xã Ia Hrung Tỉnh Gia Lai
2165 23857 Xã Đức Cơ Tỉnh Gia Lai
2166 23869 Xã Ia Dơk Tỉnh Gia Lai
2167 23866 Xã Ia Krêl Tỉnh Gia Lai
2168 21607 Xã Nhơn Châu Tỉnh Gia Lai
2169 23917 Xã Ia Púch Tỉnh Gia Lai
2170 23737 Xã Ia Mơ Tỉnh Gia Lai
2171 23881 Xã Ia Pnôn Tỉnh Gia Lai
2172 23884 Xã Ia Nan Tỉnh Gia Lai
2173 23872 Xã Ia Dom Tỉnh Gia Lai
2174 23788 Xã Ia Chia Tỉnh Gia Lai
2175 23782 Xã Ia O Tỉnh Gia Lai
2176 23650 Xã Krong Tỉnh Gia Lai
*/

/* ********************************************************************
TỈNH KHÁNH HÒA Tỉnh Khánh Hòa
2177 22366 Phường Nha Trang Tỉnh Khánh Hòa
2178 22333 Phường Bắc Nha Trang Tỉnh Khánh Hòa
2179 22390 Phường Tây Nha Trang Tỉnh Khánh Hòa
2180 22402 Phường Nam Nha Trang Tỉnh Khánh Hòa
2181 22411 Phường Bắc Cam Ranh Tỉnh Khánh Hòa
2182 22420 Phường Cam Ranh Tỉnh Khánh Hòa
2183 22432 Phường Cam Linh Tỉnh Khánh Hòa
2184 22423 Phường Ba Ngòi Tỉnh Khánh Hòa
2185 22480 Xã Nam Cam Ranh Tỉnh Khánh Hòa
2186 22546 Xã Bắc Ninh Hòa Tỉnh Khánh Hòa
2187 22528 Phường Ninh Hòa Tỉnh Khánh Hòa
2188 22576 Xã Tân Định Tỉnh Khánh Hòa
2189 22561 Phường Đông Ninh Hòa Tỉnh Khánh Hòa
2190 22591 Phường Hòa Thắng Tỉnh Khánh Hòa
2191 22597 Xã Nam Ninh Hòa Tỉnh Khánh Hòa
2192 22552 Xã Tây Ninh Hòa Tỉnh Khánh Hòa
75
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2193 22558 Xã Hòa Trí Tỉnh Khánh Hòa
2194 22504 Xã Đại Lãnh Tỉnh Khánh Hòa
2195 22498 Xã Tu Bông Tỉnh Khánh Hòa
2196 22516 Xã Vạn Thắng Tỉnh Khánh Hòa
2197 22489 Xã Vạn Ninh Tỉnh Khánh Hòa
2198 22525 Xã Vạn Hưng Tỉnh Khánh Hòa
2199 22651 Xã Diên Khánh Tỉnh Khánh Hòa
2200 22678 Xã Diên Lạc Tỉnh Khánh Hòa
2201 22657 Xã Diên Điền Tỉnh Khánh Hòa
2202 22660 Xã Diên Lâm Tỉnh Khánh Hòa
2203 22672 Xã Diên Thọ Tỉnh Khánh Hòa
2204 22702 Xã Suối Hiệp Tỉnh Khánh Hòa
2205 22453 Xã Cam Lâm Tỉnh Khánh Hòa
2206 22708 Xã Suối Dầu Tỉnh Khánh Hòa
2207 22435 Xã Cam Hiệp Tỉnh Khánh Hòa
2208 22465 Xã Cam An Tỉnh Khánh Hòa
2209 22615 Xã Bắc Khánh Vĩnh Tỉnh Khánh Hòa
2210 22612 Xã Trung Khánh Vĩnh Tỉnh Khánh Hòa
2211 22624 Xã Tây Khánh Vĩnh Tỉnh Khánh Hòa
2212 22648 Xã Nam Khánh Vĩnh Tỉnh Khánh Hòa
2213 22609 Xã Khánh Vĩnh Tỉnh Khánh Hòa
2214 22714 Xã Khánh Sơn Tỉnh Khánh Hòa
2215 22720 Xã Tây Khánh Sơn Tỉnh Khánh Hòa
2216 22732 Xã Đông Khánh Sơn Tỉnh Khánh Hòa
2217 22736 Đặc khu Trường Sa Tỉnh Khánh Hòa
2218 22759 Phường Phan Rang Tỉnh Khánh Hòa
2219 22780 Phường Đông Hải Tỉnh Khánh Hòa
2220 22834 Phường Ninh Chử Tỉnh Khánh Hòa
2221 22741 Phường Bảo An Tỉnh Khánh Hòa
2222 22738 Phường Đô Vinh Tỉnh Khánh Hòa
76
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2223 22870 Xã Ninh Phước Tỉnh Khánh Hòa
2224 22891 Xã Phước Hữu Tỉnh Khánh Hòa
2225 22873 Xã Phước Hậu Tỉnh Khánh Hòa
2226 22897 Xã Thuận Nam Tỉnh Khánh Hòa
2227 22909 Xã Cà Ná Tỉnh Khánh Hòa
2228 22900 Xã Phước Hà Tỉnh Khánh Hòa
2229 22888 Xã Phước Dinh Tỉnh Khánh Hòa
2230 22852 Xã Ninh Hải Tỉnh Khánh Hòa
2231 22861 Xã Xuân Hải Tỉnh Khánh Hòa
2232 22846 Xã Vĩnh Hải Tỉnh Khánh Hòa
2233 22849 Xã Thuận Bắc Tỉnh Khánh Hòa
2234 22840 Xã Công Hải Tỉnh Khánh Hòa
2235 22810 Xã Ninh Sơn Tỉnh Khánh Hòa
2236 22813 Xã Lâm Sơn Tỉnh Khánh Hòa
2237 22828 Xã Anh Dũng Tỉnh Khánh Hòa
2238 22822 Xã Mỹ Sơn Tỉnh Khánh Hòa
2239 22801 Xã Bác Ái Đông Tỉnh Khánh Hòa
2240 22795 Xã Bác Ái Tỉnh Khánh Hòa
2241 22786 Xã Bác Ái Tây Tỉnh Khánh Hòa
*/

/* ********************************************************************
TỈNH ĐẮK LẮK Tỉnh Đắk Lắk
2242 24175 Xã Hòa Phú Tỉnh Đắk Lắk
2243 24133 Phường Buôn Ma Thuột Tỉnh Đắk Lắk
2244 24163 Phường Tân An Tỉnh Đắk Lắk
2245 24121 Phường Tân Lập Tỉnh Đắk Lắk
2246 24154 Phường Thành Nhất Tỉnh Đắk Lắk
2247 24169 Phường Ea Kao Tỉnh Đắk Lắk
2248 24328 Xã Ea Drông Tỉnh Đắk Lắk
2249 24305 Phường Buôn Hồ Tỉnh Đắk Lắk
2250 24340 Phường Cư Bao Tỉnh Đắk Lắk
2251 24211 Xã Ea Súp Tỉnh Đắk Lắk
77
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2252 24217 Xã Ea Rốk Tỉnh Đắk Lắk
2253 24229 Xã Ea Bung Tỉnh Đắk Lắk
2254 24221 Xã Ia Rvê Tỉnh Đắk Lắk
2255 24214 Xã Ia Lốp Tỉnh Đắk Lắk
2256 24241 Xã Ea Wer Tỉnh Đắk Lắk
2257 24250 Xã Ea Nuôl Tỉnh Đắk Lắk
2258 24235 Xã Buôn Đôn Tỉnh Đắk Lắk
2259 24265 Xã Ea Kiết Tỉnh Đắk Lắk
2260 24286 Xã Ea M’Droh Tỉnh Đắk Lắk
2261 24259 Xã Quảng Phú Tỉnh Đắk Lắk
2262 24301 Xã Cuôr Đăng Tỉnh Đắk Lắk
2263 24280 Xã Cư M’gar Tỉnh Đắk Lắk
2264 24277 Xã Ea Tul Tỉnh Đắk Lắk
2265 24316 Xã Pơng Drang Tỉnh Đắk Lắk
2266 24310 Xã Krông Búk Tỉnh Đắk Lắk
2267 24313 Xã Cư Pơng Tỉnh Đắk Lắk
2268 24208 Xã Ea Khăl Tỉnh Đắk Lắk
2269 24181 Xã Ea Drăng Tỉnh Đắk Lắk
2270 24193 Xã Ea Wy Tỉnh Đắk Lắk
2271 24184 Xã Ea H’Leo Tỉnh Đắk Lắk
2272 24187 Xã Ea Hiao Tỉnh Đắk Lắk
2273 24343 Xã Krông Năng Tỉnh Đắk Lắk
2274 24346 Xã Dliê Ya Tỉnh Đắk Lắk
2275 24352 Xã Tam Giang Tỉnh Đắk Lắk
2276 24364 Xã Phú Xuân Tỉnh Đắk Lắk
2277 24490 Xã Krông Pắc Tỉnh Đắk Lắk
2278 24505 Xã Ea Knuếc Tỉnh Đắk Lắk
2279 24526 Xã Tân Tiến Tỉnh Đắk Lắk
2280 24502 Xã Ea Phê Tỉnh Đắk Lắk
2281 24496 Xã Ea Kly Tỉnh Đắk Lắk
78
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2282 24529 Xã Vụ Bổn Tỉnh Đắk Lắk
2283 24373 Xã Ea Kar Tỉnh Đắk Lắk
2284 24403 Xã Ea Ô Tỉnh Đắk Lắk
2285 24376 Xã Ea Knốp Tỉnh Đắk Lắk
2286 24406 Xã Cư Yang Tỉnh Đắk Lắk
2287 24400 Xã Ea Păl Tỉnh Đắk Lắk
2288 24412 Xã M’Drắk Tỉnh Đắk Lắk
2289 24433 Xã Ea Riêng Tỉnh Đắk Lắk
2290 24436 Xã Cư M’ta Tỉnh Đắk Lắk
2291 24444 Xã Krông Á Tỉnh Đắk Lắk
2292 24415 Xã Cư Prao Tỉnh Đắk Lắk
2293 24445 Xã Ea Trang Tỉnh Đắk Lắk
2294 24472 Xã Hòa Sơn Tỉnh Đắk Lắk
2295 24454 Xã Dang Kang Tỉnh Đắk Lắk
2296 24448 Xã Krông Bông Tỉnh Đắk Lắk
2297 24484 Xã Yang Mao Tỉnh Đắk Lắk
2298 24478 Xã Cư Pui Tỉnh Đắk Lắk
2299 24580 Xã Liên Sơn Lắk Tỉnh Đắk Lắk
2300 24595 Xã Đắk Liêng Tỉnh Đắk Lắk
2301 24607 Xã Nam Ka Tỉnh Đắk Lắk
2302 24598 Xã Đắk Phơi Tỉnh Đắk Lắk
2303 24604 Xã Krông Nô Tỉnh Đắk Lắk
2304 24540 Xã Ea Ning Tỉnh Đắk Lắk
2305 24561 Xã Dray Bhăng Tỉnh Đắk Lắk
2306 24544 Xã Ea Ktur Tỉnh Đắk Lắk
2307 24538 Xã Krông Ana Tỉnh Đắk Lắk
2308 24568 Xã Dur Kmăl Tỉnh Đắk Lắk
2309 24559 Xã Ea Na Tỉnh Đắk Lắk
2310 22015 Phường Tuy Hòa Tỉnh Đắk Lắk
2311 22240 Phường Phú Yên Tỉnh Đắk Lắk
79
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2312 22045 Phường Bình Kiến Tỉnh Đắk Lắk
2313 22075 Xã Xuân Thọ Tỉnh Đắk Lắk
2314 22060 Xã Xuân Cảnh Tỉnh Đắk Lắk
2315 22057 Xã Xuân Lộc Tỉnh Đắk Lắk
2316 22076 Phường Xuân Đài Tỉnh Đắk Lắk
2317 22051 Phường Sông Cầu Tỉnh Đắk Lắk
2318 22291 Xã Hòa Xuân Tỉnh Đắk Lắk
2319 22258 Phường Đông Hòa Tỉnh Đắk Lắk
2320 22261 Phường Hòa Hiệp Tỉnh Đắk Lắk
2321 22114 Xã Tuy An Bắc Tỉnh Đắk Lắk
2322 22120 Xã Tuy An Đông Tỉnh Đắk Lắk
2323 22147 Xã Ô Loan Tỉnh Đắk Lắk
2324 22153 Xã Tuy An Nam Tỉnh Đắk Lắk
2325 22132 Xã Tuy An Tây Tỉnh Đắk Lắk
2326 22319 Xã Phú Hòa 1 Tỉnh Đắk Lắk
2327 22303 Xã Phú Hòa 2 Tỉnh Đắk Lắk
2328 22255 Xã Tây Hòa Tỉnh Đắk Lắk
2329 22276 Xã Hòa Thịnh Tỉnh Đắk Lắk
2330 22285 Xã Hòa Mỹ Tỉnh Đắk Lắk
2331 22250 Xã Sơn Thành Tỉnh Đắk Lắk
2332 22165 Xã Sơn Hòa Tỉnh Đắk Lắk
2333 22177 Xã Vân Hòa Tỉnh Đắk Lắk
2334 22171 Xã Tây Sơn Tỉnh Đắk Lắk
2335 22192 Xã Suối Trai Tỉnh Đắk Lắk
2336 22237 Xã Ea Ly Tỉnh Đắk Lắk
2337 22225 Xã Ea Bá Tỉnh Đắk Lắk
2338 22222 Xã Đức Bình Tỉnh Đắk Lắk
2339 22207 Xã Sông Hinh Tỉnh Đắk Lắk
2340 22090 Xã Xuân Lãnh Tỉnh Đắk Lắk
2341 22096 Xã Phú Mỡ Tỉnh Đắk Lắk
80
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2342 22111 Xã Xuân Phước Tỉnh Đắk Lắk
2343 22081 Xã Đồng Xuân Tỉnh Đắk Lắk
*/

/* ********************************************************************
TỈNH LÂM ĐỒNG Tỉnh Lâm Đồng
2344 24781 Phường Xuân Hương - Đà Lạt Tỉnh Lâm Đồng
2345 24787 Phường Cam Ly - Đà Lạt Tỉnh Lâm Đồng
2346 24778 Phường Lâm Viên - Đà Lạt Tỉnh Lâm Đồng
2347 24805 Phường Xuân Trường - Đà Lạt Tỉnh Lâm Đồng
2348 24846 Phường Lang Biang - Đà Lạt Tỉnh Lâm Đồng
2349 24823 Phường 1 Bảo Lộc Tỉnh Lâm Đồng
2350 24820 Phường 2 Bảo Lộc Tỉnh Lâm Đồng
2351 24841 Phường 3 Bảo Lộc Tỉnh Lâm Đồng
2352 24829 Phường B'Lao Tỉnh Lâm Đồng
2353 24848 Xã Lạc Dương Tỉnh Lâm Đồng
2354 24931 Xã Đơn Dương Tỉnh Lâm Đồng
2355 24943 Xã Ka Đô Tỉnh Lâm Đồng
2356 24955 Xã Quảng Lập Tỉnh Lâm Đồng
2357 24934 Xã D'Ran Tỉnh Lâm Đồng
2358 24967 Xã Hiệp Thạnh Tỉnh Lâm Đồng
2359 24958 Xã Đức Trọng Tỉnh Lâm Đồng
2360 24976 Xã Tân Hội Tỉnh Lâm Đồng
2361 24991 Xã Tà Hine Tỉnh Lâm Đồng
2362 24988 Xã Tà Năng Tỉnh Lâm Đồng
2363 24871 Xã Đinh Văn Lâm Hà Tỉnh Lâm Đồng
2364 24895 Xã Phú Sơn Lâm Hà Tỉnh Lâm Đồng
2365 24883 Xã Nam Hà Lâm Hà Tỉnh Lâm Đồng
2366 24868 Xã Nam Ban Lâm Hà Tỉnh Lâm Đồng
2367 24916 Xã Tân Hà Lâm Hà Tỉnh Lâm Đồng
2368 24907 Xã Phúc Thọ Lâm Hà Tỉnh Lâm Đồng
2369 24886 Xã Đam Rông 1 Tỉnh Lâm Đồng
2370 24877 Xã Đam Rông 2 Tỉnh Lâm Đồng
81
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2371 24875 Xã Đam Rông 3 Tỉnh Lâm Đồng
2372 24853 Xã Đam Rông 4 Tỉnh Lâm Đồng
2373 25000 Xã Di Linh Tỉnh Lâm Đồng
2374 25036 Xã Hòa Ninh Tỉnh Lâm Đồng
2375 25042 Xã Hòa Bắc Tỉnh Lâm Đồng
2376 25007 Xã Đinh Trang Thượng Tỉnh Lâm Đồng
2377 25018 Xã Bảo Thuận Tỉnh Lâm Đồng
2378 25051 Xã Sơn Điền Tỉnh Lâm Đồng
2379 25015 Xã Gia Hiệp Tỉnh Lâm Đồng
2380 25054 Xã Bảo Lâm 1 Tỉnh Lâm Đồng
2381 25084 Xã Bảo Lâm 2 Tỉnh Lâm Đồng
2382 25093 Xã Bảo Lâm 3 Tỉnh Lâm Đồng
2383 25063 Xã Bảo Lâm 4 Tỉnh Lâm Đồng
2384 25057 Xã Bảo Lâm 5 Tỉnh Lâm Đồng
2385 25099 Xã Đạ Huoai Tỉnh Lâm Đồng
2386 25105 Xã Đạ Huoai 2 Tỉnh Lâm Đồng
2387 25114 Xã Đạ Huoai 3 Tỉnh Lâm Đồng
2388 25126 Xã Đạ Tẻh Tỉnh Lâm Đồng
2389 25138 Xã Đạ Tẻh 2 Tỉnh Lâm Đồng
2390 25135 Xã Đạ Tẻh 3 Tỉnh Lâm Đồng
2391 25159 Xã Cát Tiên Tỉnh Lâm Đồng
2392 25180 Xã Cát Tiên 2 Tỉnh Lâm Đồng
2393 25162 Xã Cát Tiên 3 Tỉnh Lâm Đồng
2394 22933 Phường Hàm Thắng Tỉnh Lâm Đồng
2395 22960 Phường Bình Thuận Tỉnh Lâm Đồng
2396 22918 Phường Mũi Né Tỉnh Lâm Đồng
2397 22924 Phường Phú Thủy Tỉnh Lâm Đồng
2398 22945 Phường Phan Thiết Tỉnh Lâm Đồng
2399 22954 Phường Tiến Thành Tỉnh Lâm Đồng
2400 23235 Phường La Gi Tỉnh Lâm Đồng
82
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2401 23231 Phường Phước Hội Tỉnh Lâm Đồng
2402 22963 Xã Tuyên Quang Tỉnh Lâm Đồng
2403 23246 Xã Tân Hải Tỉnh Lâm Đồng
2404 22981 Xã Vĩnh Hảo Tỉnh Lâm Đồng
2405 22969 Xã Liên Hương Tỉnh Lâm Đồng
2406 22978 Xã Tuy Phong Tỉnh Lâm Đồng
2407 22972 Xã Phan Rí Cửa Tỉnh Lâm Đồng
2408 23005 Xã Bắc Bình Tỉnh Lâm Đồng
2409 23041 Xã Hồng Thái Tỉnh Lâm Đồng
2410 23020 Xã Hải Ninh Tỉnh Lâm Đồng
2411 23008 Xã Phan Sơn Tỉnh Lâm Đồng
2412 23023 Xã Sông Lũy Tỉnh Lâm Đồng
2413 23032 Xã Lương Sơn Tỉnh Lâm Đồng
2414 23053 Xã Hòa Thắng Tỉnh Lâm Đồng
2415 23074 Xã Đông Giang Tỉnh Lâm Đồng
2416 23065 Xã La Dạ Tỉnh Lâm Đồng
2417 23089 Xã Hàm Thuận Bắc Tỉnh Lâm Đồng
2418 23059 Xã Hàm Thuận Tỉnh Lâm Đồng
2419 23086 Xã Hồng Sơn Tỉnh Lâm Đồng
2420 23095 Xã Hàm Liêm Tỉnh Lâm Đồng
2421 23122 Xã Hàm Thạnh Tỉnh Lâm Đồng
2422 23128 Xã Hàm Kiệm Tỉnh Lâm Đồng
2423 23143 Xã Tân Thành Tỉnh Lâm Đồng
2424 23110 Xã Hàm Thuận Nam Tỉnh Lâm Đồng
2425 23134 Xã Tân Lập Tỉnh Lâm Đồng
2426 23230 Xã Tân Minh Tỉnh Lâm Đồng
2427 23236 Xã Hàm Tân Tỉnh Lâm Đồng
2428 23266 Xã Sơn Mỹ Tỉnh Lâm Đồng
2429 23152 Xã Bắc Ruộng Tỉnh Lâm Đồng
2430 23158 Xã Nghị Đức Tỉnh Lâm Đồng
83
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2431 23173 Xã Đồng Kho Tỉnh Lâm Đồng
2432 23149 Xã Tánh Linh Tỉnh Lâm Đồng
2433 23188 Xã Suối Kiết Tỉnh Lâm Đồng
2434 23200 Xã Nam Thành Tỉnh Lâm Đồng
2435 23191 Xã Đức Linh Tỉnh Lâm Đồng
2436 23194 Xã Hoài Đức Tỉnh Lâm Đồng
2437 23227 Xã Trà Tân Tỉnh Lâm Đồng
2438 23272 Đặc khu Phú Quý Tỉnh Lâm Đồng
2439 24611 Phường Bắc Gia Nghĩa Tỉnh Lâm Đồng
2440 24615 Phường Nam Gia Nghĩa Tỉnh Lâm Đồng
2441 24617 Phường Đông Gia Nghĩa Tỉnh Lâm Đồng
2442 24646 Xã Đắk Wil Tỉnh Lâm Đồng
2443 24649 Xã Nam Dong Tỉnh Lâm Đồng
2444 24640 Xã Cư Jút Tỉnh Lâm Đồng
2445 24682 Xã Thuận An Tỉnh Lâm Đồng
2446 24664 Xã Đức Lập Tỉnh Lâm Đồng
2447 24670 Xã Đắk Mil Tỉnh Lâm Đồng
2448 24678 Xã Đắk Sắk Tỉnh Lâm Đồng
2449 24697 Xã Nam Đà Tỉnh Lâm Đồng
2450 24688 Xã Krông Nô Tỉnh Lâm Đồng
2451 24703 Xã Nâm Nung Tỉnh Lâm Đồng
2452 24712 Xã Quảng Phú Tỉnh Lâm Đồng
2453 24718 Xã Đắk Song Tỉnh Lâm Đồng
2454 24717 Xã Đức An Tỉnh Lâm Đồng
2455 24722 Xã Thuận Hạnh Tỉnh Lâm Đồng
2456 24730 Xã Trường Xuân Tỉnh Lâm Đồng
2457 24637 Xã Tà Đùng Tỉnh Lâm Đồng
2458 24631 Xã Quảng Khê Tỉnh Lâm Đồng
2459 24748 Xã Quảng Tân Tỉnh Lâm Đồng
2460 24739 Xã Tuy Đức Tỉnh Lâm Đồng
84
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2461 24733 Xã Kiến Đức Tỉnh Lâm Đồng
2462 24751 Xã Nhân Cơ Tỉnh Lâm Đồng
2463 24760 Xã Quảng Tín Tỉnh Lâm Đồng
2464 24985 Xã Ninh Gia Tỉnh Lâm Đồng
2465 24620 Xã Quảng Hòa Tỉnh Lâm Đồng
2466 24616 Xã Quảng Sơn Tỉnh Lâm Đồng
2467 24736 Xã Quảng Trực Tỉnh Lâm Đồng
*/

/* ********************************************************************
TỈNH ĐỒNG NAI Tỉnh Đồng Nai
2468 26068 Phường Biên Hòa Tỉnh Đồng Nai
2469 26041 Phường Trấn Biên Tỉnh Đồng Nai
2470 26017 Phường Tam Hiệp Tỉnh Đồng Nai
2471 26020 Phường Long Bình Tỉnh Đồng Nai
2472 25993 Phường Trảng Dài Tỉnh Đồng Nai
2473 26005 Phường Hố Nai Tỉnh Đồng Nai
2474 26380 Phường Long Hưng Tỉnh Đồng Nai
2475 26491 Xã Đại Phước Tỉnh Đồng Nai
2476 26485 Xã Nhơn Trạch Tỉnh Đồng Nai
2477 26503 Xã Phước An Tỉnh Đồng Nai
2478 26422 Xã Phước Thái Tỉnh Đồng Nai
2479 26413 Xã Long Phước Tỉnh Đồng Nai
2480 26389 Xã Bình An Tỉnh Đồng Nai
2481 26368 Xã Long Thành Tỉnh Đồng Nai
2482 26383 Xã An Phước Tỉnh Đồng Nai
2483 26296 Xã An Viễn Tỉnh Đồng Nai
2484 26278 Xã Bình Minh Tỉnh Đồng Nai
2485 26248 Xã Trảng Bom Tỉnh Đồng Nai
2486 26254 Xã Bàu Hàm Tỉnh Đồng Nai
2487 26281 Xã Hưng Thịnh Tỉnh Đồng Nai
2488 26326 Xã Dầu Giây Tỉnh Đồng Nai
2489 26311 Xã Gia Kiệm Tỉnh Đồng Nai
85
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2490 26299 Xã Thống Nhất Tỉnh Đồng Nai
2491 26089 Phường Bình Lộc Tỉnh Đồng Nai
2492 26098 Phường Bảo Vinh Tỉnh Đồng Nai
2493 26104 Phường Xuân Lập Tỉnh Đồng Nai
2494 26080 Phường Long Khánh Tỉnh Đồng Nai
2495 26113 Phường Hàng Gòn Tỉnh Đồng Nai
2496 26332 Xã Xuân Quế Tỉnh Đồng Nai
2497 26347 Xã Xuân Đường Tỉnh Đồng Nai
2498 26341 Xã Cẩm Mỹ Tỉnh Đồng Nai
2499 26362 Xã Sông Ray Tỉnh Đồng Nai
2500 26359 Xã Xuân Đông Tỉnh Đồng Nai
2501 26461 Xã Xuân Định Tỉnh Đồng Nai
2502 26458 Xã Xuân Phú Tỉnh Đồng Nai
2503 26425 Xã Xuân Lộc Tỉnh Đồng Nai
2504 26446 Xã Xuân Hòa Tỉnh Đồng Nai
2505 26434 Xã Xuân Thành Tỉnh Đồng Nai
2506 26428 Xã Xuân Bắc Tỉnh Đồng Nai
2507 26227 Xã La Ngà Tỉnh Đồng Nai
2508 26206 Xã Định Quán Tỉnh Đồng Nai
2509 26215 Xã Phú Vinh Tỉnh Đồng Nai
2510 26221 Xã Phú Hòa Tỉnh Đồng Nai
2511 26134 Xã Tà Lài Tỉnh Đồng Nai
2512 26122 Xã Nam Cát Tiên Tỉnh Đồng Nai
2513 26116 Xã Tân Phú Tỉnh Đồng Nai
2514 26158 Xã Phú Lâm Tỉnh Đồng Nai
2515 26170 Xã Trị An Tỉnh Đồng Nai
2516 26179 Xã Tân An Tỉnh Đồng Nai
2517 26188 Phường Tân Triều Tỉnh Đồng Nai
2518 25441 Phường Minh Hưng Tỉnh Đồng Nai
2519 25432 Phường Chơn Thành Tỉnh Đồng Nai
86
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2520 25450 Xã Nha Bích Tỉnh Đồng Nai
2521 25351 Xã Tân Quan Tỉnh Đồng Nai
2522 25345 Xã Tân Hưng Tỉnh Đồng Nai
2523 25357 Xã Tân Khai Tỉnh Đồng Nai
2524 25349 Xã Minh Đức Tỉnh Đồng Nai
2525 25326 Phường Bình Long Tỉnh Đồng Nai
2526 25333 Phường An Lộc Tỉnh Đồng Nai
2527 25294 Xã Lộc Thành Tỉnh Đồng Nai
2528 25270 Xã Lộc Ninh Tỉnh Đồng Nai
2529 25303 Xã Lộc Hưng Tỉnh Đồng Nai
2530 25279 Xã Lộc Tấn Tỉnh Đồng Nai
2531 25280 Xã Lộc Thạnh Tỉnh Đồng Nai
2532 25292 Xã Lộc Quang Tỉnh Đồng Nai
2533 25318 Xã Tân Tiến Tỉnh Đồng Nai
2534 25308 Xã Thiện Hưng Tỉnh Đồng Nai
2535 25309 Xã Hưng Phước Tỉnh Đồng Nai
2536 25267 Xã Phú Nghĩa Tỉnh Đồng Nai
2537 25231 Xã Đa Kia Tỉnh Đồng Nai
2538 25220 Phường Phước Bình Tỉnh Đồng Nai
2539 25217 Phường Phước Long Tỉnh Đồng Nai
2540 25246 Xã Bình Tân Tỉnh Đồng Nai
2541 25255 Xã Long Hà Tỉnh Đồng Nai
2542 25252 Xã Phú Riềng Tỉnh Đồng Nai
2543 25261 Xã Phú Trung Tỉnh Đồng Nai
2544 25210 Phường Đồng Xoài Tỉnh Đồng Nai
2545 25195 Phường Bình Phước Tỉnh Đồng Nai
2546 25387 Xã Thuận Lợi Tỉnh Đồng Nai
2547 25390 Xã Đồng Tâm Tỉnh Đồng Nai
2548 25378 Xã Tân Lợi Tỉnh Đồng Nai
2549 25363 Xã Đồng Phú Tỉnh Đồng Nai
87
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2550 25420 Xã Phước Sơn Tỉnh Đồng Nai
2551 25417 Xã Nghĩa Trung Tỉnh Đồng Nai
2552 25396 Xã Bù Đăng Tỉnh Đồng Nai
2553 25402 Xã Thọ Sơn Tỉnh Đồng Nai
2554 25399 Xã Đak Nhau Tỉnh Đồng Nai
2555 25405 Xã Bom Bo Tỉnh Đồng Nai
2556 26374 Phường Tam Phước Tỉnh Đồng Nai
2557 26377 Phường Phước Tân Tỉnh Đồng Nai
2558 26209 Xã Thanh Sơn Tỉnh Đồng Nai
2559 26119 Xã Đak Lua Tỉnh Đồng Nai
2560 26173 Xã Phú Lý Tỉnh Đồng Nai
2561 25222 Xã Bù Gia Mập Tỉnh Đồng Nai
2562 25225 Xã Đăk Ơ Tỉnh Đồng Nai
*/

/* ********************************************************************
THÀNH PHỐ HỒ CHÍ MINH Tp Hồ Chí Minh
2563 26506 Phường Vũng Tàu Tp Hồ Chí Minh
2564 26526 Phường Tam Thắng Tp Hồ Chí Minh
2565 26536 Phường Rạch Dừa Tp Hồ Chí Minh
2566 26542 Phường Phước Thắng Tp Hồ Chí Minh
2567 26560 Phường Bà Rịa Tp Hồ Chí Minh
2568 26566 Phường Long Hương Tp Hồ Chí Minh
2569 26704 Phường Phú Mỹ Tp Hồ Chí Minh
2570 26572 Phường Tam Long Tp Hồ Chí Minh
2571 26725 Phường Tân Thành Tp Hồ Chí Minh
2572 26713 Phường Tân Phước Tp Hồ Chí Minh
2573 26710 Phường Tân Hải Tp Hồ Chí Minh
2574 26728 Xã Châu Pha Tp Hồ Chí Minh
2575 26575 Xã Ngãi Giao Tp Hồ Chí Minh
2576 26590 Xã Bình Giã Tp Hồ Chí Minh
2577 26608 Xã Kim Long Tp Hồ Chí Minh
2578 26596 Xã Châu Đức Tp Hồ Chí Minh
88
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2579 26584 Xã Xuân Sơn Tp Hồ Chí Minh
2580 26617 Xã Nghĩa Thành Tp Hồ Chí Minh
2581 26620 Xã Hồ Tràm Tp Hồ Chí Minh
2582 26632 Xã Xuyên Mộc Tp Hồ Chí Minh
2583 26641 Xã Hòa Hội Tp Hồ Chí Minh
2584 26638 Xã Bàu Lâm Tp Hồ Chí Minh
2585 26686 Xã Phước Hải Tp Hồ Chí Minh
2586 26662 Xã Long Hải Tp Hồ Chí Minh
2587 26680 Xã Đất Đỏ Tp Hồ Chí Minh
2588 26659 Xã Long Điền Tp Hồ Chí Minh
2589 26732 Đặc khu Côn Đảo Tp Hồ Chí Minh
2590 25951 Phường Đông Hòa Tp Hồ Chí Minh
2591 25942 Phường Dĩ An Tp Hồ Chí Minh
2592 25945 Phường Tân Đông Hiệp Tp Hồ Chí Minh
2593 25978 Phường Thuận An Tp Hồ Chí Minh
2594 25969 Phường Thuận Giao Tp Hồ Chí Minh
2595 25987 Phường Bình Hòa Tp Hồ Chí Minh
2596 25966 Phường Lái Thiêu Tp Hồ Chí Minh
2597 25975 Phường An Phú Tp Hồ Chí Minh
2598 25760 Phường Bình Dương Tp Hồ Chí Minh
2599 25771 Phường Chánh Hiệp Tp Hồ Chí Minh
2600 25747 Phường Thủ Dầu Một Tp Hồ Chí Minh
2601 25750 Phường Phú Lợi Tp Hồ Chí Minh
2602 25912 Phường Vĩnh Tân Tp Hồ Chí Minh
2603 25915 Phường Bình Cơ Tp Hồ Chí Minh
2604 25888 Phường Tân Uyên Tp Hồ Chí Minh
2605 25920 Phường Tân Hiệp Tp Hồ Chí Minh
2606 25891 Phường Tân Khánh Tp Hồ Chí Minh
2607 25849 Phường Hòa Lợi Tp Hồ Chí Minh
2608 25768 Phường Phú An Tp Hồ Chí Minh
89
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2609 25843 Phường Tây Nam Tp Hồ Chí Minh
2610 25840 Phường Long Nguyên Tp Hồ Chí Minh
2611 25813 Phường Bến Cát Tp Hồ Chí Minh
2612 25837 Phường Chánh Phú Hòa Tp Hồ Chí Minh
2613 25906 Xã Bắc Tân Uyên Tp Hồ Chí Minh
2614 25909 Xã Thường Tân Tp Hồ Chí Minh
2615 25867 Xã An Long Tp Hồ Chí Minh
2616 25864 Xã Phước Thành Tp Hồ Chí Minh
2617 25882 Xã Phước Hòa Tp Hồ Chí Minh
2618 25858 Xã Phú Giáo Tp Hồ Chí Minh
2619 25819 Xã Trừ Văn Thố Tp Hồ Chí Minh
2620 25822 Xã Bàu Bàng Tp Hồ Chí Minh
2621 25780 Xã Minh Thạnh Tp Hồ Chí Minh
2622 25792 Xã Long Hòa Tp Hồ Chí Minh
2623 25777 Xã Dầu Tiếng Tp Hồ Chí Minh
2624 25807 Xã Thanh An Tp Hồ Chí Minh
2625 26740 Phường Sài Gòn Tp Hồ Chí Minh
2626 26737 Phường Tân Định Tp Hồ Chí Minh
2627 26743 Phường Bến Thành Tp Hồ Chí Minh
2628 26758 Phường Cầu Ông Lãnh Tp Hồ Chí Minh
2629 27154 Phường Bàn Cờ Tp Hồ Chí Minh
2630 27139 Phường Xuân Hòa Tp Hồ Chí Minh
2631 27142 Phường Nhiêu Lộc Tp Hồ Chí Minh
2632 27259 Phường Xóm Chiếu Tp Hồ Chí Minh
2633 27265 Phường Khánh Hội Tp Hồ Chí Minh
2634 27286 Phường Vĩnh Hội Tp Hồ Chí Minh
2635 27301 Phường Chợ Quán Tp Hồ Chí Minh
2636 27316 Phường An Đông Tp Hồ Chí Minh
2637 27343 Phường Chợ Lớn Tp Hồ Chí Minh
2638 27367 Phường Bình Tây Tp Hồ Chí Minh
90
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2639 27373 Phường Bình Tiên Tp Hồ Chí Minh
2640 27364 Phường Bình Phú Tp Hồ Chí Minh
2641 27349 Phường Phú Lâm Tp Hồ Chí Minh
2642 27478 Phường Tân Thuận Tp Hồ Chí Minh
2643 27484 Phường Phú Thuận Tp Hồ Chí Minh
2644 27487 Phường Tân Mỹ Tp Hồ Chí Minh
2645 27475 Phường Tân Hưng Tp Hồ Chí Minh
2646 27418 Phường Chánh Hưng Tp Hồ Chí Minh
2647 27427 Phường Phú Định Tp Hồ Chí Minh
2648 27424 Phường Bình Đông Tp Hồ Chí Minh
2649 27169 Phường Diên Hồng Tp Hồ Chí Minh
2650 27190 Phường Vườn Lài Tp Hồ Chí Minh
2651 27163 Phường Hòa Hưng Tp Hồ Chí Minh
2652 27238 Phường Minh Phụng Tp Hồ Chí Minh
2653 27232 Phường Bình Thới Tp Hồ Chí Minh
2654 27211 Phường Hòa Bình Tp Hồ Chí Minh
2655 27226 Phường Phú Thọ Tp Hồ Chí Minh
2656 26791 Phường Đông Hưng Thuận Tp Hồ Chí Minh
2657 26785 Phường Trung Mỹ Tây Tp Hồ Chí Minh
2658 26782 Phường Tân Thới Hiệp Tp Hồ Chí Minh
2659 26773 Phường Thới An Tp Hồ Chí Minh
2660 26767 Phường An Phú Đông Tp Hồ Chí Minh
2661 27460 Phường An Lạc Tp Hồ Chí Minh
2662 27457 Phường Tân Tạo Tp Hồ Chí Minh
2663 27442 Phường Bình Tân Tp Hồ Chí Minh
2664 27448 Phường Bình Trị Đông Tp Hồ Chí Minh
2665 27439 Phường Bình Hưng Hòa Tp Hồ Chí Minh
2666 26944 Phường Gia Định Tp Hồ Chí Minh
2667 26929 Phường Bình Thạnh Tp Hồ Chí Minh
2668 26905 Phường Bình Lợi Trung Tp Hồ Chí Minh
91
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2669 26956 Phường Thạnh Mỹ Tây Tp Hồ Chí Minh
2670 26911 Phường Bình Quới Tp Hồ Chí Minh
2671 26890 Phường Hạnh Thông Tp Hồ Chí Minh
2672 26876 Phường An Nhơn Tp Hồ Chí Minh
2673 26884 Phường Gò Vấp Tp Hồ Chí Minh
2674 26878 Phường An Hội Đông Tp Hồ Chí Minh
2675 26898 Phường Thông Tây Hội Tp Hồ Chí Minh
2676 26882 Phường An Hội Tây Tp Hồ Chí Minh
2677 27043 Phường Đức Nhuận Tp Hồ Chí Minh
2678 27058 Phường Cầu Kiệu Tp Hồ Chí Minh
2679 27073 Phường Phú Nhuận Tp Hồ Chí Minh
2680 26977 Phường Tân Sơn Hòa Tp Hồ Chí Minh
2681 26968 Phường Tân Sơn Nhất Tp Hồ Chí Minh
2682 26995 Phường Tân Hòa Tp Hồ Chí Minh
2683 26983 Phường Bảy Hiền Tp Hồ Chí Minh
2684 27004 Phường Tân Bình Tp Hồ Chí Minh
2685 27007 Phường Tân Sơn Tp Hồ Chí Minh
2686 27013 Phường Tây Thạnh Tp Hồ Chí Minh
2687 27019 Phường Tân Sơn Nhì Tp Hồ Chí Minh
2688 27022 Phường Phú Thọ Hòa Tp Hồ Chí Minh
2689 27031 Phường Tân Phú Tp Hồ Chí Minh
2690 27028 Phường Phú Thạnh Tp Hồ Chí Minh
2691 26809 Phường Hiệp Bình Tp Hồ Chí Minh
2692 26824 Phường Thủ Đức Tp Hồ Chí Minh
2693 26803 Phường Tam Bình Tp Hồ Chí Minh
2694 26800 Phường Linh Xuân Tp Hồ Chí Minh
2695 26842 Phường Tăng Nhơn Phú Tp Hồ Chí Minh
2696 26833 Phường Long Bình Tp Hồ Chí Minh
2697 26857 Phường Long Phước Tp Hồ Chí Minh
2698 26860 Phường Long Trường Tp Hồ Chí Minh
92
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2699 27112 Phường Cát Lái Tp Hồ Chí Minh
2700 27097 Phường Bình Trưng Tp Hồ Chí Minh
2701 26848 Phường Phước Long Tp Hồ Chí Minh
2702 27094 Phường An Khánh Tp Hồ Chí Minh
2703 27601 Xã Vĩnh Lộc Tp Hồ Chí Minh
2704 27604 Xã Tân Vĩnh Lộc Tp Hồ Chí Minh
2705 27610 Xã Bình Lợi Tp Hồ Chí Minh
2706 27595 Xã Tân Nhựt Tp Hồ Chí Minh
2707 27637 Xã Bình Chánh Tp Hồ Chí Minh
2708 27628 Xã Hưng Long Tp Hồ Chí Minh
2709 27619 Xã Bình Hưng Tp Hồ Chí Minh
2710 27667 Xã Bình Khánh Tp Hồ Chí Minh
2711 27673 Xã An Thới Đông Tp Hồ Chí Minh
2712 27664 Xã Cần Giờ Tp Hồ Chí Minh
2713 27553 Xã Củ Chi Tp Hồ Chí Minh
2714 27496 Xã Tân An Hội Tp Hồ Chí Minh
2715 27526 Xã Thái Mỹ Tp Hồ Chí Minh
2716 27508 Xã An Nhơn Tây Tp Hồ Chí Minh
2717 27511 Xã Nhuận Đức Tp Hồ Chí Minh
2718 27541 Xã Phú Hòa Đông Tp Hồ Chí Minh
2719 27544 Xã Bình Mỹ Tp Hồ Chí Minh
2720 27568 Xã Đông Thạnh Tp Hồ Chí Minh
2721 27559 Xã Hóc Môn Tp Hồ Chí Minh
2722 27577 Xã Xuân Thới Sơn Tp Hồ Chí Minh
2723 27592 Xã Bà Điểm Tp Hồ Chí Minh
2724 27655 Xã Nhà Bè Tp Hồ Chí Minh
2725 27658 Xã Hiệp Phước Tp Hồ Chí Minh
2726 26545 Xã Long Sơn Tp Hồ Chí Minh
2727 26647 Xã Hòa Hiệp Tp Hồ Chí Minh
2728 26656 Xã Bình Châu Tp Hồ Chí Minh
93
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2729 25846 Phường Thới Hòa Tp Hồ Chí Minh
2730 27676 Xã Thạnh An Tp Hồ Chí Minh
*/

/* ********************************************************************
TỈNH TÂY NINH Tỉnh Tây Ninh
2731 27727 Xã Hưng Điền Tỉnh Tây Ninh
2732 27736 Xã Vĩnh Thạnh Tỉnh Tây Ninh
2733 27721 Xã Tân Hưng Tỉnh Tây Ninh
2734 27748 Xã Vĩnh Châu Tỉnh Tây Ninh
2735 27775 Xã Tuyên Bình Tỉnh Tây Ninh
2736 27757 Xã Vĩnh Hưng Tỉnh Tây Ninh
2737 27763 Xã Khánh Hưng Tỉnh Tây Ninh
2738 27817 Xã Tuyên Thạnh Tỉnh Tây Ninh
2739 27793 Xã Bình Hiệp Tỉnh Tây Ninh
2740 27787 Phường Kiến Tường Tỉnh Tây Ninh
2741 27811 Xã Bình Hòa Tỉnh Tây Ninh
2742 27823 Xã Mộc Hóa Tỉnh Tây Ninh
2743 27841 Xã Hậu Thạnh Tỉnh Tây Ninh
2744 27838 Xã Nhơn Hòa Lập Tỉnh Tây Ninh
2745 27856 Xã Nhơn Ninh Tỉnh Tây Ninh
2746 27826 Xã Tân Thạnh Tỉnh Tây Ninh
2747 27868 Xã Bình Thành Tỉnh Tây Ninh
2748 27877 Xã Thạnh Phước Tỉnh Tây Ninh
2749 27865 Xã Thạnh Hóa Tỉnh Tây Ninh
2750 27889 Xã Tân Tây Tỉnh Tây Ninh
2751 28036 Xã Thủ Thừa Tỉnh Tây Ninh
2752 28066 Xã Mỹ An Tỉnh Tây Ninh
2753 28051 Xã Mỹ Thạnh Tỉnh Tây Ninh
2754 28072 Xã Tân Long Tỉnh Tây Ninh
2755 27907 Xã Mỹ Quý Tỉnh Tây Ninh
2756 27898 Xã Đông Thành Tỉnh Tây Ninh
2757 27925 Xã Đức Huệ Tỉnh Tây Ninh
94
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2758 27943 Xã An Ninh Tỉnh Tây Ninh
2759 27952 Xã Hiệp Hòa Tỉnh Tây Ninh
2760 27931 Xã Hậu Nghĩa Tỉnh Tây Ninh
2761 27979 Xã Hòa Khánh Tỉnh Tây Ninh
2762 27964 Xã Đức Lập Tỉnh Tây Ninh
2763 27976 Xã Mỹ Hạnh Tỉnh Tây Ninh
2764 27937 Xã Đức Hòa Tỉnh Tây Ninh
2765 27994 Xã Thạnh Lợi Tỉnh Tây Ninh
2766 28015 Xã Bình Đức Tỉnh Tây Ninh
2767 28003 Xã Lương Hòa Tỉnh Tây Ninh
2768 27991 Xã Bến Lức Tỉnh Tây Ninh
2769 28018 Xã Mỹ Yên Tỉnh Tây Ninh
2770 28126 Xã Long Cang Tỉnh Tây Ninh
2771 28114 Xã Rạch Kiến Tỉnh Tây Ninh
2772 28132 Xã Mỹ Lệ Tỉnh Tây Ninh
2773 28138 Xã Tân Lân Tỉnh Tây Ninh
2774 28108 Xã Cần Đước Tỉnh Tây Ninh
2775 28144 Xã Long Hựu Tỉnh Tây Ninh
2776 28165 Xã Phước Lý Tỉnh Tây Ninh
2777 28177 Xã Mỹ Lộc Tỉnh Tây Ninh
2778 28159 Xã Cần Giuộc Tỉnh Tây Ninh
2779 28201 Xã Phước Vĩnh Tây Tỉnh Tây Ninh
2780 28207 Xã Tân Tập Tỉnh Tây Ninh
2781 28093 Xã Vàm Cỏ Tỉnh Tây Ninh
2782 28075 Xã Tân Trụ Tỉnh Tây Ninh
2783 28087 Xã Nhựt Tảo Tỉnh Tây Ninh
2784 28225 Xã Thuận Mỹ Tỉnh Tây Ninh
2785 28243 Xã An Lục Long Tỉnh Tây Ninh
2786 28210 Xã Tầm Vu Tỉnh Tây Ninh
2787 28222 Xã Vĩnh Công Tỉnh Tây Ninh
95
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2788 27694 Phường Long An Tỉnh Tây Ninh
2789 27712 Phường Tân An Tỉnh Tây Ninh
2790 27715 Phường Khánh Hậu Tỉnh Tây Ninh
2791 25459 Phường Tân Ninh Tỉnh Tây Ninh
2792 25480 Phường Bình Minh Tỉnh Tây Ninh
2793 25567 Phường Ninh Thạnh Tỉnh Tây Ninh
2794 25630 Phường Long Hoa Tỉnh Tây Ninh
2795 25645 Phường Hòa Thành Tỉnh Tây Ninh
2796 25633 Phường Thanh Điền Tỉnh Tây Ninh
2797 25708 Phường Trảng Bàng Tỉnh Tây Ninh
2798 25732 Phường An Tịnh Tỉnh Tây Ninh
2799 25654 Phường Gò Dầu Tỉnh Tây Ninh
2800 25672 Phường Gia Lộc Tỉnh Tây Ninh
2801 25711 Xã Hưng Thuận Tỉnh Tây Ninh
2802 25729 Xã Phước Chỉ Tỉnh Tây Ninh
2803 25657 Xã Thạnh Đức Tỉnh Tây Ninh
2804 25663 Xã Phước Thạnh Tỉnh Tây Ninh
2805 25666 Xã Truông Mít Tỉnh Tây Ninh
2806 25579 Xã Lộc Ninh Tỉnh Tây Ninh
2807 25573 Xã Cầu Khởi Tỉnh Tây Ninh
2808 25552 Xã Dương Minh Châu Tỉnh Tây Ninh
2809 25522 Xã Tân Đông Tỉnh Tây Ninh
2810 25516 Xã Tân Châu Tỉnh Tây Ninh
2811 25549 Xã Tân Phú Tỉnh Tây Ninh
2812 25525 Xã Tân Hội Tỉnh Tây Ninh
2813 25534 Xã Tân Thành Tỉnh Tây Ninh
2814 25531 Xã Tân Hòa Tỉnh Tây Ninh
2815 25489 Xã Tân Lập Tỉnh Tây Ninh
2816 25486 Xã Tân Biên Tỉnh Tây Ninh
2817 25498 Xã Thạnh Bình Tỉnh Tây Ninh
96
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2818 25510 Xã Trà Vong Tỉnh Tây Ninh
2819 25591 Xã Phước Vinh Tỉnh Tây Ninh
2820 25606 Xã Hòa Hội Tỉnh Tây Ninh
2821 25621 Xã Ninh Điền Tỉnh Tây Ninh
2822 25585 Xã Châu Thành Tỉnh Tây Ninh
2823 25588 Xã Hảo Đước Tỉnh Tây Ninh
2824 25684 Xã Long Chữ Tỉnh Tây Ninh
2825 25702 Xã Long Thuận Tỉnh Tây Ninh
2826 25681 Xã Bến Cầu Tỉnh Tây Ninh
*/

/* ********************************************************************
TỈNH ĐỒNG THÁP Tỉnh Đồng Tháp
2827 28261 Phường Mỹ Tho Tỉnh Đồng Tháp
2828 28249 Phường Đạo Thạnh Tỉnh Đồng Tháp
2829 28273 Phường Mỹ Phong Tỉnh Đồng Tháp
2830 28270 Phường Thới Sơn Tỉnh Đồng Tháp
2831 28285 Phường Trung An Tỉnh Đồng Tháp
2832 28306 Phường Gò Công Tỉnh Đồng Tháp
2833 28297 Phường Long Thuận Tỉnh Đồng Tháp
2834 28729 Phường Sơn Qui Tỉnh Đồng Tháp
2835 28315 Phường Bình Xuân Tỉnh Đồng Tháp
2836 28435 Phường Mỹ Phước Tây Tỉnh Đồng Tháp
2837 28436 Phường Thanh Hòa Tỉnh Đồng Tháp
2838 28439 Phường Cai Lậy Tỉnh Đồng Tháp
2839 28477 Phường Nhị Quý Tỉnh Đồng Tháp
2840 28468 Xã Tân Phú Tỉnh Đồng Tháp
2841 28426 Xã Thanh Hưng Tỉnh Đồng Tháp
2842 28429 Xã An Hữu Tỉnh Đồng Tháp
2843 28414 Xã Mỹ Lợi Tỉnh Đồng Tháp
2844 28405 Xã Mỹ Đức Tây Tỉnh Đồng Tháp
2845 28378 Xã Mỹ Thiện Tỉnh Đồng Tháp
2846 28366 Xã Hậu Mỹ Tỉnh Đồng Tháp
97
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2847 28393 Xã Hội Cư Tỉnh Đồng Tháp
2848 28360 Xã Cái Bè Tỉnh Đồng Tháp
2849 28471 Xã Bình Phú Tỉnh Đồng Tháp
2850 28501 Xã Hiệp Đức Tỉnh Đồng Tháp
2851 28516 Xã Ngũ Hiệp Tỉnh Đồng Tháp
2852 28504 Xã Long Tiên Tỉnh Đồng Tháp
2853 28456 Xã Mỹ Thành Tỉnh Đồng Tháp
2854 28444 Xã Thạnh Phú Tỉnh Đồng Tháp
2855 28321 Xã Tân Phước 1 Tỉnh Đồng Tháp
2856 28327 Xã Tân Phước 2 Tỉnh Đồng Tháp
2857 28345 Xã Tân Phước 3 Tỉnh Đồng Tháp
2858 28336 Xã Hưng Thạnh Tỉnh Đồng Tháp
2859 28525 Xã Tân Hương Tỉnh Đồng Tháp
2860 28519 Xã Châu Thành Tỉnh Đồng Tháp
2861 28537 Xã Long Hưng Tỉnh Đồng Tháp
2862 28543 Xã Long Định Tỉnh Đồng Tháp
2863 28576 Xã Vĩnh Kim Tỉnh Đồng Tháp
2864 28582 Xã Kim Sơn Tỉnh Đồng Tháp
2865 28564 Xã Bình Trưng Tỉnh Đồng Tháp
2866 28603 Xã Mỹ Tịnh An Tỉnh Đồng Tháp
2867 28615 Xã Lương Hòa Lạc Tỉnh Đồng Tháp
2868 28627 Xã Tân Thuận Bình Tỉnh Đồng Tháp
2869 28594 Xã Chợ Gạo Tỉnh Đồng Tháp
2870 28633 Xã An Thạnh Thủy Tỉnh Đồng Tháp
2871 28648 Xã Bình Ninh Tỉnh Đồng Tháp
2872 28651 Xã Vĩnh Bình Tỉnh Đồng Tháp
2873 28660 Xã Đồng Sơn Tỉnh Đồng Tháp
2874 28663 Xã Phú Thành Tỉnh Đồng Tháp
2875 28687 Xã Long Bình Tỉnh Đồng Tháp
2876 28678 Xã Vĩnh Hựu Tỉnh Đồng Tháp
98
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2877 28747 Xã Gò Công Đông Tỉnh Đồng Tháp
2878 28738 Xã Tân Điền Tỉnh Đồng Tháp
2879 28702 Xã Tân Hòa Tỉnh Đồng Tháp
2880 28723 Xã Tân Đông Tỉnh Đồng Tháp
2881 28720 Xã Gia Thuận Tỉnh Đồng Tháp
2882 28693 Xã Tân Thới Tỉnh Đồng Tháp
2883 28696 Xã Tân Phú Đông Tỉnh Đồng Tháp
2884 29926 Xã Tân Hồng Tỉnh Đồng Tháp
2885 29938 Xã Tân Thành Tỉnh Đồng Tháp
2886 29929 Xã Tân Hộ Cơ Tỉnh Đồng Tháp
2887 29944 Xã An Phước Tỉnh Đồng Tháp
2888 29954 Phường An Bình Tỉnh Đồng Tháp
2889 29955 Phường Hồng Ngự Tỉnh Đồng Tháp
2890 29978 Phường Thường Lạc Tỉnh Đồng Tháp
2891 29971 Xã Thường Phước Tỉnh Đồng Tháp
2892 29983 Xã Long Khánh Tỉnh Đồng Tháp
2893 29992 Xã Long Phú Thuận Tỉnh Đồng Tháp
2894 30019 Xã An Hòa Tỉnh Đồng Tháp
2895 30010 Xã Tam Nông Tỉnh Đồng Tháp
2896 30034 Xã Phú Thọ Tỉnh Đồng Tháp
2897 30001 Xã Tràm Chim Tỉnh Đồng Tháp
2898 30025 Xã Phú Cường Tỉnh Đồng Tháp
2899 30028 Xã An Long Tỉnh Đồng Tháp
2900 30130 Xã Thanh Bình Tỉnh Đồng Tháp
2901 30157 Xã Tân Thạnh Tỉnh Đồng Tháp
2902 30163 Xã Bình Thành Tỉnh Đồng Tháp
2903 30154 Xã Tân Long Tỉnh Đồng Tháp
2904 30037 Xã Tháp Mười Tỉnh Đồng Tháp
2905 30073 Xã Thanh Mỹ Tỉnh Đồng Tháp
2906 30055 Xã Mỹ Quí Tỉnh Đồng Tháp
99
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2907 30061 Xã Đốc Binh Kiều Tỉnh Đồng Tháp
2908 30046 Xã Trường Xuân Tỉnh Đồng Tháp
2909 30043 Xã Phương Thịnh Tỉnh Đồng Tháp
2910 30088 Xã Phong Mỹ Tỉnh Đồng Tháp
2911 30085 Xã Ba Sao Tỉnh Đồng Tháp
2912 30076 Xã Mỹ Thọ Tỉnh Đồng Tháp
2913 30118 Xã Bình Hàng Trung Tỉnh Đồng Tháp
2914 30112 Xã Mỹ Hiệp Tỉnh Đồng Tháp
2915 29869 Phường Cao Lãnh Tỉnh Đồng Tháp
2916 29884 Phường Mỹ Ngãi Tỉnh Đồng Tháp
2917 29888 Phường Mỹ Trà Tỉnh Đồng Tháp
2918 30178 Xã Mỹ An Hưng Tỉnh Đồng Tháp
2919 30184 Xã Tân Khánh Trung Tỉnh Đồng Tháp
2920 30169 Xã Lấp Vò Tỉnh Đồng Tháp
2921 30226 Xã Lai Vung Tỉnh Đồng Tháp
2922 30208 Xã Hòa Long Tỉnh Đồng Tháp
2923 30235 Xã Phong Hòa Tỉnh Đồng Tháp
2924 29905 Phường Sa Đéc Tỉnh Đồng Tháp
2925 30214 Xã Tân Dương Tỉnh Đồng Tháp
2926 30244 Xã Phú Hựu Tỉnh Đồng Tháp
2927 30253 Xã Tân Nhuận Đông Tỉnh Đồng Tháp
2928 30259 Xã Tân Phú Trung Tỉnh Đồng Tháp
*/

/* ********************************************************************
TỈNH VĨNH LONG Tỉnh Vĩnh Long
2929 29641 Xã Cái Nhum Tỉnh Vĩnh Long
2930 29653 Xã Tân Long Hội Tỉnh Vĩnh Long
2931 29623 Xã Nhơn Phú Tỉnh Vĩnh Long
2932 29638 Xã Bình Phước Tỉnh Vĩnh Long
2933 29584 Xã An Bình Tỉnh Vĩnh Long
2934 29602 Xã Long Hồ Tỉnh Vĩnh Long
2935 29611 Xã Phú Quới Tỉnh Vĩnh Long
100
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2936 29590 Phường Thanh Đức Tỉnh Vĩnh Long
2937 29551 Phường Long Châu Tỉnh Vĩnh Long
2938 29557 Phường Phước Hậu Tỉnh Vĩnh Long
2939 29593 Phường Tân Hạnh Tỉnh Vĩnh Long
2940 29566 Phường Tân Ngãi Tỉnh Vĩnh Long
2941 29677 Xã Quới Thiện Tỉnh Vĩnh Long
2942 29659 Xã Trung Thành Tỉnh Vĩnh Long
2943 29698 Xã Trung Ngãi Tỉnh Vĩnh Long
2944 29668 Xã Quới An Tỉnh Vĩnh Long
2945 29683 Xã Trung Hiệp Tỉnh Vĩnh Long
2946 29701 Xã Hiếu Phụng Tỉnh Vĩnh Long
2947 29713 Xã Hiếu Thành Tỉnh Vĩnh Long
2948 29857 Xã Lục Sĩ Thành Tỉnh Vĩnh Long
2949 29821 Xã Trà Ôn Tỉnh Vĩnh Long
2950 29836 Xã Trà Côn Tỉnh Vĩnh Long
2951 29845 Xã Vĩnh Xuân Tỉnh Vĩnh Long
2952 29830 Xã Hòa Bình Tỉnh Vĩnh Long
2953 29734 Xã Hòa Hiệp Tỉnh Vĩnh Long
2954 29719 Xã Tam Bình Tỉnh Vĩnh Long
2955 29767 Xã Ngãi Tứ Tỉnh Vĩnh Long
2956 29740 Xã Song Phú Tỉnh Vĩnh Long
2957 29728 Xã Cái Ngang Tỉnh Vĩnh Long
2958 29800 Xã Tân Quới Tỉnh Vĩnh Long
2959 29785 Xã Tân Lược Tỉnh Vĩnh Long
2960 29788 Xã Mỹ Thuận Tỉnh Vĩnh Long
2961 29771 Phường Bình Minh Tỉnh Vĩnh Long
2962 29770 Phường Cái Vồn Tỉnh Vĩnh Long
2963 29812 Phường Đông Thành Tỉnh Vĩnh Long
2964 29263 Phường Long Đức Tỉnh Vĩnh Long
2965 29242 Phường Trà Vinh Tỉnh Vĩnh Long
101
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2966 29254 Phường Nguyệt Hóa Tỉnh Vĩnh Long
2967 29398 Phường Hòa Thuận Tỉnh Vĩnh Long
2968 29275 Xã An Trường Tỉnh Vĩnh Long
2969 29278 Xã Tân An Tỉnh Vĩnh Long
2970 29266 Xã Càng Long Tỉnh Vĩnh Long
2971 29302 Xã Nhị Long Tỉnh Vĩnh Long
2972 29287 Xã Bình Phú Tỉnh Vĩnh Long
2973 29386 Xã Song Lộc Tỉnh Vĩnh Long
2974 29374 Xã Châu Thành Tỉnh Vĩnh Long
2975 29407 Xã Hưng Mỹ Tỉnh Vĩnh Long
2976 29410 Xã Hòa Minh Tỉnh Vĩnh Long
2977 29413 Xã Long Hòa Tỉnh Vĩnh Long
2978 29308 Xã Cầu Kè Tỉnh Vĩnh Long
2979 29329 Xã Phong Thạnh Tỉnh Vĩnh Long
2980 29317 Xã An Phú Tân Tỉnh Vĩnh Long
2981 29335 Xã Tam Ngãi Tỉnh Vĩnh Long
2982 29371 Xã Tân Hòa Tỉnh Vĩnh Long
2983 29362 Xã Hùng Hòa Tỉnh Vĩnh Long
2984 29341 Xã Tiểu Cần Tỉnh Vĩnh Long
2985 29365 Xã Tập Ngãi Tỉnh Vĩnh Long
2986 29419 Xã Mỹ Long Tỉnh Vĩnh Long
2987 29431 Xã Vinh Kim Tỉnh Vĩnh Long
2988 29416 Xã Cầu Ngang Tỉnh Vĩnh Long
2989 29446 Xã Nhị Trường Tỉnh Vĩnh Long
2990 29455 Xã Hiệp Mỹ Tỉnh Vĩnh Long
2991 29476 Xã Lưu Nghiệp Anh Tỉnh Vĩnh Long
2992 29491 Xã Đại An Tỉnh Vĩnh Long
2993 29489 Xã Hàm Giang Tỉnh Vĩnh Long
2994 29461 Xã Trà Cú Tỉnh Vĩnh Long
2995 29506 Xã Long Hiệp Tỉnh Vĩnh Long
102
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
2996 29467 Xã Tập Sơn Tỉnh Vĩnh Long
2997 29512 Phường Duyên Hải Tỉnh Vĩnh Long
2998 29516 Phường Trường Long Hòa Tỉnh Vĩnh Long
2999 29518 Xã Long Hữu Tỉnh Vĩnh Long
3000 29513 Xã Long Thành Tỉnh Vĩnh Long
3001 29536 Xã Đông Hải Tỉnh Vĩnh Long
3002 29533 Xã Long Vĩnh Tỉnh Vĩnh Long
3003 29497 Xã Đôn Châu Tỉnh Vĩnh Long
3004 29530 Xã Ngũ Lạc Tỉnh Vĩnh Long
3005 28777 Phường An Hội Tỉnh Vĩnh Long
3006 28756 Phường Phú Khương Tỉnh Vĩnh Long
3007 28789 Phường Bến Tre Tỉnh Vĩnh Long
3008 28783 Phường Sơn Đông Tỉnh Vĩnh Long
3009 28858 Phường Phú Tân Tỉnh Vĩnh Long
3010 28810 Xã Phú Túc Tỉnh Vĩnh Long
3011 28807 Xã Giao Long Tỉnh Vĩnh Long
3012 28861 Xã Tiên Thủy Tỉnh Vĩnh Long
3013 28840 Xã Tân Phú Tỉnh Vĩnh Long
3014 28879 Xã Phú Phụng Tỉnh Vĩnh Long
3015 28870 Xã Chợ Lách Tỉnh Vĩnh Long
3016 28894 Xã Vĩnh Thành Tỉnh Vĩnh Long
3017 28901 Xã Hưng Khánh Trung Tỉnh Vĩnh Long
3018 28915 Xã Phước Mỹ Trung Tỉnh Vĩnh Long
3019 28921 Xã Tân Thành Bình Tỉnh Vĩnh Long
3020 28948 Xã Nhuận Phú Tân Tỉnh Vĩnh Long
3021 28945 Xã Đồng Khởi Tỉnh Vĩnh Long
3022 28903 Xã Mỏ Cày Tỉnh Vĩnh Long
3023 28969 Xã Thành Thới Tỉnh Vĩnh Long
3024 28957 Xã An Định Tỉnh Vĩnh Long
3025 28981 Xã Hương Mỹ Tỉnh Vĩnh Long
103
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3026 29194 Xã Đại Điền Tỉnh Vĩnh Long
3027 29191 Xã Quới Điền Tỉnh Vĩnh Long
3028 29182 Xã Thạnh Phú Tỉnh Vĩnh Long
3029 29224 Xã An Qui Tỉnh Vĩnh Long
3030 29221 Xã Thạnh Hải Tỉnh Vĩnh Long
3031 29227 Xã Thạnh Phong Tỉnh Vĩnh Long
3032 29167 Xã Tân Thủy Tỉnh Vĩnh Long
3033 29125 Xã Bảo Thạnh Tỉnh Vĩnh Long
3034 29110 Xã Ba Tri Tỉnh Vĩnh Long
3035 29137 Xã Tân Xuân Tỉnh Vĩnh Long
3036 29122 Xã Mỹ Chánh Hòa Tỉnh Vĩnh Long
3037 29143 Xã An Ngãi Trung Tỉnh Vĩnh Long
3038 29158 Xã An Hiệp Tỉnh Vĩnh Long
3039 29044 Xã Hưng Nhượng Tỉnh Vĩnh Long
3040 28984 Xã Giồng Trôm Tỉnh Vĩnh Long
3041 29029 Xã Tân Hào Tỉnh Vĩnh Long
3042 29020 Xã Phước Long Tỉnh Vĩnh Long
3043 28993 Xã Lương Phú Tỉnh Vĩnh Long
3044 28996 Xã Châu Hòa Tỉnh Vĩnh Long
3045 28987 Xã Lương Hòa Tỉnh Vĩnh Long
3046 29107 Xã Thới Thuận Tỉnh Vĩnh Long
3047 29104 Xã Thạnh Phước Tỉnh Vĩnh Long
3048 29050 Xã Bình Đại Tỉnh Vĩnh Long
3049 29089 Xã Thạnh Trị Tỉnh Vĩnh Long
3050 29077 Xã Lộc Thuận Tỉnh Vĩnh Long
3051 29083 Xã Châu Hưng Tỉnh Vĩnh Long
3052 29062 Xã Phú Thuận Tỉnh Vĩnh Long
*/

/* ********************************************************************
TỈNH AN GIANG
3053 30313 Xã Mỹ Hòa Hưng Tỉnh An Giang
3054 30307 Phường Long Xuyên Tỉnh An Giang
104
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3055 30292 Phường Bình Đức Tỉnh An Giang
3056 30301 Phường Mỹ Thới Tỉnh An Giang
3057 30316 Phường Châu Đốc Tỉnh An Giang
3058 30325 Phường Vĩnh Tế Tỉnh An Giang
3059 30337 Xã An Phú Tỉnh An Giang
3060 30367 Xã Vĩnh Hậu Tỉnh An Giang
3061 30346 Xã Nhơn Hội Tỉnh An Giang
3062 30341 Xã Khánh Bình Tỉnh An Giang
3063 30352 Xã Phú Hữu Tỉnh An Giang
3064 30388 Xã Tân An Tỉnh An Giang
3065 30403 Xã Châu Phong Tỉnh An Giang
3066 30385 Xã Vĩnh Xương Tỉnh An Giang
3067 30376 Phường Tân Châu Tỉnh An Giang
3068 30377 Phường Long Phú Tỉnh An Giang
3069 30406 Xã Phú Tân Tỉnh An Giang
3070 30436 Xã Phú An Tỉnh An Giang
3071 30445 Xã Bình Thạnh Đông Tỉnh An Giang
3072 30409 Xã Chợ Vàm Tỉnh An Giang
3073 30430 Xã Hòa Lạc Tỉnh An Giang
3074 30421 Xã Phú Lâm Tỉnh An Giang
3075 30463 Xã Châu Phú Tỉnh An Giang
3076 30469 Xã Mỹ Đức Tỉnh An Giang
3077 30478 Xã Vĩnh Thạnh Trung Tỉnh An Giang
3078 30487 Xã Bình Mỹ Tỉnh An Giang
3079 30481 Xã Thạnh Mỹ Tây Tỉnh An Giang
3080 30526 Xã An Cư Tỉnh An Giang
3081 30538 Xã Núi Cấm Tỉnh An Giang
3082 30520 Phường Tịnh Biên Tỉnh An Giang
3083 30502 Phường Thới Sơn Tỉnh An Giang
3084 30505 Phường Chi Lăng Tỉnh An Giang
105
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3085 30547 Xã Ba Chúc Tỉnh An Giang
3086 30544 Xã Tri Tôn Tỉnh An Giang
3087 30577 Xã Ô Lâm Tỉnh An Giang
3088 30580 Xã Cô Tô Tỉnh An Giang
3089 30568 Xã Vĩnh Gia Tỉnh An Giang
3090 30589 Xã An Châu Tỉnh An Giang
3091 30607 Xã Bình Hòa Tỉnh An Giang
3092 30595 Xã Cần Đăng Tỉnh An Giang
3093 30619 Xã Vĩnh Hanh Tỉnh An Giang
3094 30604 Xã Vĩnh An Tỉnh An Giang
3095 30628 Xã Chợ Mới Tỉnh An Giang
3096 30643 Xã Cù Lao Giêng Tỉnh An Giang
3097 30673 Xã Hội An Tỉnh An Giang
3098 30631 Xã Long Điền Tỉnh An Giang
3099 30658 Xã Nhơn Mỹ Tỉnh An Giang
3100 30664 Xã Long Kiến Tỉnh An Giang
3101 30682 Xã Thoại Sơn Tỉnh An Giang
3102 30688 Xã Óc Eo Tỉnh An Giang
3103 30709 Xã Định Mỹ Tỉnh An Giang
3104 30685 Xã Phú Hòa Tỉnh An Giang
3105 30697 Xã Vĩnh Trạch Tỉnh An Giang
3106 30691 Xã Tây Phú Tỉnh An Giang
3107 31064 Xã Vĩnh Bình Tỉnh An Giang
3108 31069 Xã Vĩnh Thuận Tỉnh An Giang
3109 31051 Xã Vĩnh Phong Tỉnh An Giang
3110 31012 Xã Vĩnh Hòa Tỉnh An Giang
3111 31027 Xã U Minh Thượng Tỉnh An Giang
3112 31024 Xã Đông Hòa Tỉnh An Giang
3113 31031 Xã Tân Thạnh Tỉnh An Giang
3114 31036 Xã Đông Hưng Tỉnh An Giang
106
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3115 31018 Xã An Minh Tỉnh An Giang
3116 31042 Xã Vân Khánh Tỉnh An Giang
3117 30988 Xã Tây Yên Tỉnh An Giang
3118 31006 Xã Đông Thái Tỉnh An Giang
3119 30985 Xã An Biên Tỉnh An Giang
3120 30958 Xã Định Hòa Tỉnh An Giang
3121 30952 Xã Gò Quao Tỉnh An Giang
3122 30970 Xã Vĩnh Hòa Hưng Tỉnh An Giang
3123 30982 Xã Vĩnh Tuy Tỉnh An Giang
3124 30904 Xã Giồng Riềng Tỉnh An Giang
3125 30910 Xã Thạnh Hưng Tỉnh An Giang
3126 30943 Xã Long Thạnh Tỉnh An Giang
3127 30934 Xã Hòa Hưng Tỉnh An Giang
3128 30928 Xã Ngọc Chúc Tỉnh An Giang
3129 30949 Xã Hòa Thuận Tỉnh An Giang
3130 30856 Xã Tân Hội Tỉnh An Giang
3131 30850 Xã Tân Hiệp Tỉnh An Giang
3132 30874 Xã Thạnh Đông Tỉnh An Giang
3133 30886 Xã Thạnh Lộc Tỉnh An Giang
3134 30880 Xã Châu Thành Tỉnh An Giang
3135 30898 Xã Bình An Tỉnh An Giang
3136 30817 Xã Hòn Đất Tỉnh An Giang
3137 30835 Xã Sơn Kiên Tỉnh An Giang
3138 30838 Xã Mỹ Thuận Tỉnh An Giang
3139 30823 Xã Bình Sơn Tỉnh An Giang
3140 30826 Xã Bình Giang Tỉnh An Giang
3141 30796 Xã Giang Thành Tỉnh An Giang
3142 30793 Xã Vĩnh Điều Tỉnh An Giang
3143 30790 Xã Hòa Điền Tỉnh An Giang
3144 30787 Xã Kiên Lương Tỉnh An Giang
107
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3145 30811 Xã Sơn Hải Tỉnh An Giang
3146 30814 Xã Hòn Nghệ Tỉnh An Giang
3147 31108 Đặc khu Kiên Hải Tỉnh An Giang
3148 30760 Phường Vĩnh Thông Tỉnh An Giang
3149 30742 Phường Rạch Giá Tỉnh An Giang
3150 30769 Phường Hà Tiên Tỉnh An Giang
3151 30766 Phường Tô Châu Tỉnh An Giang
3152 30781 Xã Tiên Hải Tỉnh An Giang
3153 31078 Đặc khu Phú Quốc Tỉnh An Giang
3154 31105 Đặc khu Thổ Châu Tỉnh An Giang
*/

/* ********************************************************************
THÀNH PHỐ CẦN THƠ
3155 31135 Phường Ninh Kiều Tp Cần Thơ
3156 31120 Phường Cái Khế Tp Cần Thơ
3157 31147 Phường Tân An Tp Cần Thơ
3158 31150 Phường An Bình Tp Cần Thơ
3159 31174 Phường Thới An Đông Tp Cần Thơ
3160 31168 Phường Bình Thủy Tp Cần Thơ
3161 31183 Phường Long Tuyền Tp Cần Thơ
3162 31186 Phường Cái Răng Tp Cần Thơ
3163 31201 Phường Hưng Phú Tp Cần Thơ
3164 31153 Phường Ô Môn Tp Cần Thơ
3165 31157 Phường Thới Long Tp Cần Thơ
3166 31162 Phường Phước Thới Tp Cần Thơ
3167 31217 Phường Trung Nhứt Tp Cần Thơ
3168 31207 Phường Thốt Nốt Tp Cần Thơ
3169 31228 Phường Thuận Hưng Tp Cần Thơ
3170 31213 Phường Tân Lộc Tp Cần Thơ
3171 31299 Xã Phong Điền Tp Cần Thơ
3172 31315 Xã Nhơn Ái Tp Cần Thơ
3173 31309 Xã Trường Long Tp Cần Thơ
108
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3174 31258 Xã Thới Lai Tp Cần Thơ
3175 31282 Xã Đông Thuận Tp Cần Thơ
3176 31294 Xã Trường Xuân Tp Cần Thơ
3177 31288 Xã Trường Thành Tp Cần Thơ
3178 31261 Xã Cờ Đỏ Tp Cần Thơ
3179 31273 Xã Đông Hiệp Tp Cần Thơ
3180 31249 Xã Thạnh Phú Tp Cần Thơ
3181 31264 Xã Thới Hưng Tp Cần Thơ
3182 31255 Xã Trung Hưng Tp Cần Thơ
3183 31232 Xã Vĩnh Thạnh Tp Cần Thơ
3184 31237 Xã Vĩnh Trinh Tp Cần Thơ
3185 31231 Xã Thạnh An Tp Cần Thơ
3186 31246 Xã Thạnh Quới Tp Cần Thơ
3187 31338 Xã Hỏa Lựu Tp Cần Thơ
3188 31321 Phường Vị Thanh Tp Cần Thơ
3189 31333 Phường Vị Tân Tp Cần Thơ
3190 31441 Xã Vị Thủy Tp Cần Thơ
3191 31453 Xã Vĩnh Thuận Đông Tp Cần Thơ
3192 31465 Xã Vị Thanh 1 Tp Cần Thơ
3193 31459 Xã Vĩnh Tường Tp Cần Thơ
3194 31489 Xã Vĩnh Viễn Tp Cần Thơ
3195 31495 Xã Xà Phiên Tp Cần Thơ
3196 31492 Xã Lương Tâm Tp Cần Thơ
3197 31473 Phường Long Bình Tp Cần Thơ
3198 31471 Phường Long Mỹ Tp Cần Thơ
3199 31480 Phường Long Phú 1 Tp Cần Thơ
3200 31360 Xã Thạnh Xuân Tp Cần Thơ
3201 31342 Xã Tân Hòa Tp Cần Thơ
3202 31348 Xã Trường Long Tây Tp Cần Thơ
3203 31366 Xã Châu Thành Tp Cần Thơ
109
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3204 31369 Xã Đông Phước Tp Cần Thơ
3205 31378 Xã Phú Hữu Tp Cần Thơ
3206 31411 Phường Đại Thành Tp Cần Thơ
3207 31340 Phường Ngã Bảy Tp Cần Thơ
3208 31399 Xã Tân Bình Tp Cần Thơ
3209 31393 Xã Hòa An Tp Cần Thơ
3210 31426 Xã Phương Bình Tp Cần Thơ
3211 31432 Xã Tân Phước Hưng Tp Cần Thơ
3212 31396 Xã Hiệp Hưng Tp Cần Thơ
3213 31420 Xã Phụng Hiệp Tp Cần Thơ
3214 31408 Xã Thạnh Hòa Tp Cần Thơ
3215 31510 Phường Phú Lợi Tp Cần Thơ
3216 31507 Phường Sóc Trăng Tp Cần Thơ
3217 31684 Phường Mỹ Xuyên Tp Cần Thơ
3218 31717 Xã Hòa Tú Tp Cần Thơ
3219 31726 Xã Gia Hòa Tp Cần Thơ
3220 31708 Xã Nhu Gia Tp Cần Thơ
3221 31723 Xã Ngọc Tố Tp Cần Thơ
3222 31654 Xã Trường Khánh Tp Cần Thơ
3223 31645 Xã Đại Ngãi Tp Cần Thơ
3224 31666 Xã Tân Thạnh Tp Cần Thơ
3225 31639 Xã Long Phú Tp Cần Thơ
3226 31552 Xã Nhơn Mỹ Tp Cần Thơ
3227 31537 Xã Phong Nẫm Tp Cần Thơ
3228 31531 Xã An Lạc Thôn Tp Cần Thơ
3229 31528 Xã Kế Sách Tp Cần Thơ
3230 31540 Xã Thới An Hội Tp Cần Thơ
3231 31561 Xã Đại Hải Tp Cần Thơ
3232 31569 Xã Phú Tâm Tp Cần Thơ
3233 31594 Xã An Ninh Tp Cần Thơ
110
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3234 31582 Xã Thuận Hòa Tp Cần Thơ
3235 31570 Xã Hồ Đắc Kiện Tp Cần Thơ
3236 31567 Xã Mỹ Tú Tp Cần Thơ
3237 31579 Xã Long Hưng Tp Cần Thơ
3238 31603 Xã Mỹ Phước Tp Cần Thơ
3239 31591 Xã Mỹ Hương Tp Cần Thơ
3240 31795 Xã Vĩnh Hải Tp Cần Thơ
3241 31810 Xã Lai Hòa Tp Cần Thơ
3242 31804 Phường Vĩnh Phước Tp Cần Thơ
3243 31783 Phường Vĩnh Châu Tp Cần Thơ
3244 31789 Phường Khánh Hòa Tp Cần Thơ
3245 31741 Xã Tân Long Tp Cần Thơ
3246 31732 Phường Ngã Năm Tp Cần Thơ
3247 31753 Phường Mỹ Quới Tp Cần Thơ
3248 31756 Xã Phú Lộc Tp Cần Thơ
3249 31777 Xã Vĩnh Lợi Tp Cần Thơ
3250 31759 Xã Lâm Tân Tp Cần Thơ
3251 31699 Xã Thạnh Thới An Tp Cần Thơ
3252 31687 Xã Tài Văn Tp Cần Thơ
3253 31675 Xã Liêu Tú Tp Cần Thơ
3254 31679 Xã Lịch Hội Thượng Tp Cần Thơ
3255 31673 Xã Trần Đề Tp Cần Thơ
3256 31615 Xã An Thạnh Tp Cần Thơ
3257 31633 Xã Cù Lao Dung Tp Cần Thơ
*/

/* ********************************************************************
TỈNH CÀ MAU
3258 32002 Phường An Xuyên Tỉnh Cà Mau
3259 32014 Phường Lý Văn Lâm Tỉnh Cà Mau
3260 32025 Phường Tân Thành Tỉnh Cà Mau
3261 32041 Phường Hòa Thành Tỉnh Cà Mau
3262 32167 Xã Tân Thuận Tỉnh Cà Mau
111
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3263 32188 Xã Tân Tiến Tỉnh Cà Mau
3264 32155 Xã Tạ An Khương Tỉnh Cà Mau
3265 32161 Xã Trần Phán Tỉnh Cà Mau
3266 32185 Xã Thanh Tùng Tỉnh Cà Mau
3267 32152 Xã Đầm Dơi Tỉnh Cà Mau
3268 32182 Xã Quách Phẩm Tỉnh Cà Mau
3269 32047 Xã U Minh Tỉnh Cà Mau
3270 32044 Xã Nguyễn Phích Tỉnh Cà Mau
3271 32062 Xã Khánh Lâm Tỉnh Cà Mau
3272 32059 Xã Khánh An Tỉnh Cà Mau
3273 32244 Xã Phan Ngọc Hiển Tỉnh Cà Mau
3274 32248 Xã Đất Mũi Tỉnh Cà Mau
3275 32236 Xã Tân Ân Tỉnh Cà Mau
3276 32110 Xã Khánh Bình Tỉnh Cà Mau
3277 32104 Xã Đá Bạc Tỉnh Cà Mau
3278 32119 Xã Khánh Hưng Tỉnh Cà Mau
3279 32098 Xã Sông Đốc Tỉnh Cà Mau
3280 32095 Xã Trần Văn Thời Tỉnh Cà Mau
3281 32065 Xã Thới Bình Tỉnh Cà Mau
3282 32071 Xã Trí Phải Tỉnh Cà Mau
3283 32083 Xã Tân Lộc Tỉnh Cà Mau
3284 32092 Xã Hồ Thị Kỷ Tỉnh Cà Mau
3285 32069 Xã Biển Bạch Tỉnh Cà Mau
3286 32201 Xã Đất Mới Tỉnh Cà Mau
3287 32191 Xã Năm Căn Tỉnh Cà Mau
3288 32206 Xã Tam Giang Tỉnh Cà Mau
3289 32212 Xã Cái Đôi Vàm Tỉnh Cà Mau
3290 32227 Xã Nguyễn Việt Khái Tỉnh Cà Mau
3291 32218 Xã Phú Tân Tỉnh Cà Mau
3292 32214 Xã Phú Mỹ Tỉnh Cà Mau
112
Stt Mã số Tên đơn vị hành chính Tỉnh (thành phố)
3293 32134 Xã Lương Thế Trân Tỉnh Cà Mau
3294 32137 Xã Tân Hưng Tỉnh Cà Mau
3295 32140 Xã Hưng Mỹ Tỉnh Cà Mau
3296 32128 Xã Cái Nước Tỉnh Cà Mau
3297 31825 Phường Bạc Liêu Tỉnh Cà Mau
3298 31834 Phường Vĩnh Trạch Tỉnh Cà Mau
3299 31840 Phường Hiệp Thành Tỉnh Cà Mau
3300 31942 Phường Giá Rai Tỉnh Cà Mau
3301 31951 Phường Láng Tròn Tỉnh Cà Mau
3302 31957 Xã Phong Thạnh Tỉnh Cà Mau
3303 31843 Xã Hồng Dân Tỉnh Cà Mau
3304 31858 Xã Vĩnh Lộc Tỉnh Cà Mau
3305 31864 Xã Ninh Thạnh Lợi Tỉnh Cà Mau
3306 31849 Xã Ninh Quới Tỉnh Cà Mau
3307 31972 Xã Gành Hào Tỉnh Cà Mau
3308 31993 Xã Định Thành Tỉnh Cà Mau
3309 31988 Xã An Trạch Tỉnh Cà Mau
3310 31985 Xã Long Điền Tỉnh Cà Mau
3311 31975 Xã Đông Hải Tỉnh Cà Mau
3312 31891 Xã Hòa Bình Tỉnh Cà Mau
3313 31918 Xã Vĩnh Mỹ Tỉnh Cà Mau
3314 31927 Xã Vĩnh Hậu Tỉnh Cà Mau
3315 31867 Xã Phước Long Tỉnh Cà Mau
3316 31876 Xã Vĩnh Phước Tỉnh Cà Mau
3317 31885 Xã Phong Hiệp Tỉnh Cà Mau
3318 31882 Xã Vĩnh Thanh Tỉnh Cà Mau
3319 31900 Xã Vĩnh Lợi Tỉnh Cà Mau
3320 31906 Xã Hưng Hội Tỉnh Cà Mau
3321 31894 Xã Châu Thới Tỉnh Cà Mau
*/

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('01273','Phường Thục Phán','04'),
('01279','Phường Nùng Trí Cao','04'),
('01288','Phường Tân Giang','04'),
('01304','Xã Quảng Lâm','04'),
('01297','Xã Nam Quang','04'),
('01294','Xã Lý Bôn','04'),
('01290','Xã Bảo Lâm','04'),
('01318','Xã Yên Thổ','04'),
('01360','Xã Sơn Lộ','04'),
('01351','Xã Hưng Đạo','04'),
('01321','Xã Bảo Lạc','04'),
('01324','Xã Cốc Pàng','04'),
('01327','Xã Cô Ba','04'),
('01336','Xã Khánh Xuân','04'),
('01339','Xã Xuân Trường','04'),
('01354','Xã Huy Giáp','04'),
('01738','Xã Ca Thành','04'),
('01768','Xã Phan Thanh','04'),
('01777','Xã Thành Công','04'),
('01729','Xã Tĩnh Túc','04'),
('01774','Xã Tam Kim','04'),
('01726','Xã Nguyên Bình','04'),
('01747','Xã Minh Tâm','04'),
('01387','Xã Thanh Long','04'),
('01366','Xã Cần Yên','04'),
('01363','Xã Thông Nông','04'),
('01392','Xã Trường Hà','04'),
('01438','Xã Hà Quảng','04'),
('01393','Xã Lũng Nặm','04'),
('01414','Xã Tổng Cọt','04'),
('01660','Xã Nam Tuấn','04'),
('01654','Xã Hòa An','04'),
('01708','Xã Bạch Đằng','04'),
('01699','Xã Nguyễn Huệ','04'),
('01795','Xã Minh Khai','04'),
('01789','Xã Canh Tân','04'),
('01792','Xã Kim Đồng','04'),
('01807','Xã Thạch An','04'),
('01786','Xã Đông Khê','04'),
('01822','Xã Đức Long','04'),
('01648','Xã Phục Hòa','04'),
('01636','Xã Bế Văn Đàn','04'),
('01594','Xã Độc Lập','04'),
('01576','Xã Quảng Uyên','04'),
('01618','Xã Hạnh Phúc','04'),
('01456','Xã Quang Hán','04'),
('01447','Xã Trà Lĩnh','04'),
('01465','Xã Quang Trung','04'),
('01525','Xã Đoài Dương','04'),
('01477','Xã Trùng Khánh','04'),
('01501','Xã Đàm Thủy','04'),
('01489','Xã Đình Phong','04'),
('01537','Xã Lý Quốc','04'),
('01558','Xã Hạ Lang','04'),
('01561','Xã Vinh Quý','04'),
('01552','Xã Quang Long','04');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('02269','Xã Thượng Lâm','08'),
('02266','Xã Lâm Bình','08'),
('02302','Xã Minh Quang','08'),
('02296','Xã Bình An','08'),
('02245','Xã Côn Lôn','08'),
('02248','Xã Yên Hoa','08'),
('02239','Xã Thượng Nông','08'),
('02260','Xã Hồng Thái','08'),
('02221','Xã Nà Hang','08'),
('02308','Xã Tân Mỹ','08'),
('02317','Xã Yên Lập','08'),
('02320','Xã Tân An','08'),
('02287','Xã Chiêm Hóa','08'),
('02353','Xã Hòa An','08'),
('02332','Xã Kiên Đài','08'),
('02359','Xã Tri Phú','08'),
('02350','Xã Kim Bình','08'),
('02365','Xã Yên Nguyên','08'),
('02305','Xã Trung Hà','08'),
('02398','Xã Yên Phú','08'),
('02380','Xã Bạch Xa','08'),
('02392','Xã Phù Lưu','08'),
('02374','Xã Hàm Yên','08'),
('02404','Xã Bình Xa','08'),
('02407','Xã Thái Sơn','08'),
('02419','Xã Thái Hòa','08'),
('02425','Xã Hùng Đức','08'),
('02455','Xã Hùng Lợi','08'),
('02458','Xã Trung Sơn','08'),
('02494','Xã Thái Bình','08'),
('02470','Xã Tân Long','08'),
('02449','Xã Xuân Vân','08'),
('02434','Xã Lực Hành','08'),
('02473','Xã Yên Sơn','08'),
('02530','Xã Nhữ Khê','08'),
('02437','Xã Kiến Thiết','08'),
('02545','Xã Tân Trào','08'),
('02554','Xã Minh Thanh','08'),
('02536','Xã Sơn Dương','08'),
('02548','Xã Bình Ca','08'),
('02578','Xã Tân Thanh','08'),
('02620','Xã Sơn Thủy','08'),
('02611','Xã Phú Lương','08'),
('02623','Xã Trường Sinh','08'),
('02608','Xã Hồng Sơn','08'),
('02572','Xã Đông Thọ','08'),
('02509','Phường Mỹ Lâm','08'),
('02215','Phường Minh Xuân','08'),
('02212','Phường Nông Tiến','08'),
('02512','Phường An Tường','08'),
('02524','Phường Bình Thuận','08'),
('00715','Xã Lũng Cú','08'),
('00721','Xã Đồng Văn','08'),
('00733','Xã Sà Phìn','08'),
('00745','Xã Phố Bảng','08'),
('00763','Xã Lũng Phìn','08'),
('00787','Xã Sủng Máng','08'),
('00778','Xã Sơn Vĩ','08'),
('00769','Xã Mèo Vạc','08'),
('00802','Xã Khâu Vai','08'),
('00817','Xã Niêm Sơn','08'),
('00808','Xã Tát Ngà','08'),
('00829','Xã Thắng Mố','08'),
('00832','Xã Bạch Đích','08'),
('00820','Xã Yên Minh','08'),
('00847','Xã Mậu Duệ','08'),
('00859','Xã Ngọc Long','08'),
('00871','Xã Du Già','08'),
('00865','Xã Đường Thượng','08'),
('00901','Xã Lùng Tám','08'),
('00883','Xã Cán Tỷ','08'),
('00889','Xã Nghĩa Thuận','08'),
('00874','Xã Quản Bạ','08'),
('00892','Xã Tùng Vài','08'),
('01006','Xã Yên Cường','08'),
('01012','Xã Đường Hồng','08'),
('00991','Xã Bắc Mê','08'),
('00985','Xã Giáp Trung','08'),
('00982','Xã Minh Sơn','08'),
('00994','Xã Minh Ngọc','08'),
('00700','Xã Ngọc Đường','08'),
('00694','Phường Hà Giang 1','08'),
('00691','Phường Hà Giang 2','08'),
('00937','Xã Lao Chải','08'),
('00928','Xã Thanh Thủy','08'),
('00919','Xã Minh Tân','08'),
('00922','Xã Thuận Hòa','08'),
('00925','Xã Tùng Bá','08'),
('00706','Xã Phú Linh','08'),
('00970','Xã Linh Hồ','08'),
('00976','Xã Bạch Ngọc','08'),
('00913','Xã Vị Xuyên','08'),
('00967','Xã Việt Lâm','08'),
('00952','Xã Cao Bồ','08'),
('00958','Xã Thượng Sơn','08'),
('01171','Xã Tân Quang','08'),
('01165','Xã Đồng Tâm','08'),
('01192','Xã Liên Hiệp','08'),
('01180','Xã Bằng Hành','08'),
('01153','Xã Bắc Quang','08'),
('01201','Xã Hùng An','08'),
('01156','Xã Vĩnh Tuy','08'),
('01216','Xã Đồng Yên','08'),
('01261','Xã Tiên Yên','08'),
('01255','Xã Xuân Giang','08'),
('01246','Xã Bằng Lang','08'),
('01234','Xã Yên Thành','08'),
('01237','Xã Quang Bình','08'),
('01243','Xã Tân Trịnh','08'),
('01225','Xã Tiên Nguyên','08'),
('01090','Xã Thông Nguyên','08'),
('01084','Xã Hồ Thầu','08'),
('01075','Xã Nậm Dịch','08'),
('01051','Xã Tân Tiến','08'),
('01021','Xã Hoàng Su Phì','08'),
('01033','Xã Thàng Tín','08'),
('01024','Xã Bản Máy','08'),
('01057','Xã Pờ Ly Ngài','08'),
('01108','Xã Xín Mần','08'),
('01096','Xã Pà Vầy Sủ','08'),
('01141','Xã Nấm Dẩn','08'),
('01117','Xã Trung Thịnh','08'),
('01144','Xã Quảng Nguyên','08'),
('01147','Xã Khuôn Lùng','08');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('03325','Xã Mường Phăng','11'),
('03127','Phường Điện Biên Phủ','11'),
('03334','Phường Mường Thanh','11'),
('03151','Phường Mường Lay','11'),
('03328','Xã Thanh Nưa','11'),
('03352','Xã Thanh An','11'),
('03349','Xã Thanh Yên','11'),
('03356','Xã Sam Mứn','11'),
('03358','Xã Núa Ngam','11'),
('03368','Xã Mường Nhà','11'),
('03253','Xã Tuần Giáo','11'),
('03295','Xã Quài Tở','11'),
('03268','Xã Mường Mùn','11'),
('03260','Xã Pú Nhung','11'),
('03283','Xã Chiềng Sinh','11'),
('03217','Xã Tủa Chùa','11'),
('03226','Xã Sín Chải','11'),
('03241','Xã Sính Phình','11'),
('03220','Xã Tủa Thàng','11'),
('03244','Xã Sáng Nhè','11'),
('03172','Xã Na Sang','11'),
('03181','Xã Mường Tùng','11'),
('03193','Xã Pa Ham','11'),
('03194','Xã Nậm Nèn','11'),
('03202','Xã Mường Pồn','11'),
('03203','Xã Na Son','11'),
('03208','Xã Xa Dung','11'),
('03370','Xã Pu Nhi','11'),
('03214','Xã Mường Luân','11'),
('03385','Xã Tìa Dình','11'),
('03382','Xã Phình Giàng','11'),
('03166','Xã Mường Chà','11'),
('03169','Xã Nà Hỳ','11'),
('03176','Xã Nà Bủng','11'),
('03175','Xã Chà Tở','11'),
('03199','Xã Si Pa Phìn','11'),
('03160','Xã Mường Nhé','11'),
('03158','Xã Sín Thầu','11'),
('03163','Xã Mường Toong','11'),
('03162','Xã Nậm Kè','11'),
('03164','Xã Quảng Lâm','11'),
('03256','Xã Mường Ảng','11'),
('03316','Xã Nà Tấu','11'),
('03301','Xã Búng Lao','11'),
('03313','Xã Mường Lạn','11');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('03637','Xã Mường Kim','12'),
('03640','Xã Khoen On','12'),
('03595','Xã Than Uyên','12'),
('03618','Xã Mường Than','12'),
('03616','Xã Pắc Ta','12'),
('03613','Xã Nậm Sỏ','12'),
('03598','Xã Tân Uyên','12'),
('03601','Xã Mường Khoa','12'),
('03424','Xã Bản Bo','12'),
('03390','Xã Bình Lư','12'),
('03405','Xã Tả Lèng','12'),
('03430','Xã Khun Há','12'),
('03408','Phường Tân Phong','12'),
('03388','Phường Đoàn Kết','12'),
('03394','Xã Sin Suối Hồ','12'),
('03549','Xã Phong Thổ','12'),
('03562','Xã Sì Lở Lầu','12'),
('03571','Xã Dào San','12'),
('03583','Xã Khổng Lào','12'),
('03529','Xã Tủa Sín Chải','12'),
('03478','Xã Sìn Hồ','12'),
('03508','Xã Hồng Thu','12'),
('03517','Xã Nậm Tăm','12'),
('03532','Xã Pu Sam Cáp','12'),
('03544','Xã Nậm Cuổi','12'),
('03538','Xã Nậm Mạ','12'),
('03487','Xã Lê Lợi','12'),
('03434','Xã Nậm Hàng','12'),
('03472','Xã Mường Mô','12'),
('03460','Xã Hua Bum','12'),
('03503','Xã Pa Tần','12'),
('03466','Xã Bum Nưa','12'),
('03433','Xã Bum Tở','12'),
('03445','Xã Mường Tè','12'),
('03439','Xã Thu Lũm','12'),
('03442','Xã Pa Ủ','12'),
('03463','Xã Tà Tổng','12'),
('03451','Xã Mù Cả','12');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('03646','Phường Tô Hiệu','14'),
('03664','Phường Chiềng An','14'),
('03670','Phường Chiềng Cơi','14'),
('03679','Phường Chiềng Sinh','14'),
('03980','Phường Mộc Châu','14'),
('03979','Phường Mộc Sơn','14'),
('04033','Phường Vân Sơn','14'),
('03982','Phường Thảo Nguyên','14'),
('04000','Xã Đoàn Kết','14'),
('04045','Xã Lóng Sập','14'),
('03985','Xã Chiềng Sơn','14'),
('04048','Xã Vân Hồ','14'),
('04006','Xã Song Khủa','14'),
('04018','Xã Tô Múa','14'),
('04057','Xã Xuân Nha','14'),
('03703','Xã Quỳnh Nhai','14'),
('03688','Xã Mường Chiên','14'),
('03694','Xã Mường Giôn','14'),
('03712','Xã Mường Sại','14'),
('03721','Xã Thuận Châu','14'),
('03754','Xã Chiềng La','14'),
('03784','Xã Nậm Lầu','14'),
('03799','Xã Muổi Nọi','14'),
('03757','Xã Mường Khiêng','14'),
('03781','Xã Co Mạ','14'),
('03724','Xã Bình Thuận','14'),
('03727','Xã Mường É','14'),
('03763','Xã Long Hẹ','14'),
('03808','Xã Mường La','14'),
('03814','Xã Chiềng Lao','14'),
('03847','Xã Mường Bú','14'),
('03850','Xã Chiềng Hoa','14'),
('03856','Xã Bắc Yên','14'),
('03868','Xã Tà Xùa','14'),
('03880','Xã Tạ Khoa','14'),
('03862','Xã Xím Vàng','14'),
('03871','Xã Pắc Ngà','14'),
('03892','Xã Chiềng Sại','14'),
('03910','Xã Phù Yên','14'),
('03922','Xã Gia Phù','14'),
('03958','Xã Tường Hạ','14'),
('03907','Xã Mường Cơi','14'),
('03943','Xã Mường Bang','14'),
('03970','Xã Tân Phong','14'),
('03961','Xã Kim Bon','14'),
('04075','Xã Yên Châu','14'),
('04078','Xã Chiềng Hặc','14'),
('04096','Xã Lóng Phiêng','14'),
('04087','Xã Yên Sơn','14'),
('04132','Xã Chiềng Mai','14'),
('04105','Xã Mai Sơn','14'),
('04159','Xã Phiêng Pằn','14'),
('04123','Xã Chiềng Mung','14'),
('04144','Xã Phiêng Cằm','14'),
('04117','Xã Mường Chanh','14'),
('04136','Xã Tà Hộc','14'),
('04108','Xã Chiềng Sung','14'),
('04171','Xã Bó Sinh','14'),
('04222','Xã Chiềng Khương','14'),
('04219','Xã Mường Hung','14'),
('04204','Xã Chiềng Khoong','14'),
('04183','Xã Mường Lầm','14'),
('04186','Xã Nậm Ty','14'),
('04168','Xã Sông Mã','14'),
('04210','Xã Huổi Một','14'),
('04195','Xã Chiềng Sơ','14'),
('04231','Xã Sốp Cộp','14'),
('04228','Xã Púng Bánh','14'),
('03997','Xã Tân Yên','14'),
('03760','Xã Mường Bám','14'),
('03820','Xã Ngọc Chiến','14'),
('03901','Xã Suối Tọ','14'),
('04099','Xã Phiêng Khoài','14'),
('04246','Xã Mường Lạn','14'),
('04240','Xã Mường Lèo','14');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('04465','Xã Khao Mang','15'),
('04456','Xã Mù Cang Chải','15'),
('04492','Xã Púng Luông','15'),
('04630','Xã Tú Lệ','15'),
('04606','Xã Trạm Tấu','15'),
('04585','Xã Hạnh Phúc','15'),
('04609','Xã Phình Hồ','15'),
('04288','Phường Nghĩa Lộ','15'),
('04663','Phường Trung Tâm','15'),
('04681','Phường Cầu Thia','15'),
('04660','Xã Liên Sơn','15'),
('04636','Xã Gia Hội','15'),
('04651','Xã Sơn Lương','15'),
('04705','Xã Thượng Bằng La','15'),
('04699','Xã Chấn Thịnh','15'),
('04711','Xã Nghĩa Tâm','15'),
('04672','Xã Văn Chấn','15'),
('04402','Xã Phong Dụ Hạ','15'),
('04387','Xã Châu Quế','15'),
('04381','Xã Lâm Giang','15'),
('04399','Xã Đông Cuông','15'),
('04429','Xã Tân Hợp','15'),
('04375','Xã Mậu A','15'),
('04441','Xã Xuân Á i','15'),
('04450','Xã Mỏ Vàng','15'),
('04309','Xã Lâm Thượng','15'),
('04303','Xã Lục Yên','15'),
('04336','Xã Tân Lĩnh','15'),
('04342','Xã Khánh Hòa','15'),
('04363','Xã Phúc Lợi','15'),
('04345','Xã Mường Lai','15'),
('04726','Xã Cảm Nhân','15'),
('04744','Xã Yên Thành','15'),
('04717','Xã Thác Bà','15'),
('04714','Xã Yên Bình','15'),
('04750','Xã Bảo Á i','15'),
('04279','Phường Văn Phú','15'),
('04252','Phường Yên Bái','15'),
('04273','Phường Nam Cường','15'),
('04543','Phường Âu Lâu','15'),
('04498','Xã Trấn Yên','15'),
('04576','Xã Hưng Khánh','15'),
('04537','Xã Lương Thịnh','15'),
('04564','Xã Việt Hồng','15'),
('04531','Xã Quy Mông','15'),
('02902','Xã Phong Hải','15'),
('02926','Xã Xuân Quang','15'),
('02905','Xã Bảo Thắng','15'),
('02908','Xã Tằng Loỏng','15'),
('02923','Xã Gia Phú','15'),
('02746','Xã Cốc San','15'),
('02680','Xã Hợp Thành','15'),
('02671','Phường Cam Đường','15'),
('02647','Phường Lào Cai','15'),
('02728','Xã Mường Hum','15'),
('02707','Xã Dền Sáng','15'),
('02701','Xã Y Tý','15'),
('02686','Xã A Mú Sung','15'),
('02695','Xã Trịnh Tường','15'),
('02725','Xã Bản Xèo','15'),
('02683','Xã Bát Xát','15'),
('02953','Xã Nghĩa Đô','15'),
('02968','Xã Thượng Hà','15'),
('02947','Xã Bảo Yên','15'),
('02962','Xã Xuân Hòa','15'),
('02998','Xã Phúc Khánh','15'),
('02989','Xã Bảo Hà','15'),
('03061','Xã Võ Lao','15'),
('03103','Xã Khánh Yên','15'),
('03082','Xã Văn Bàn','15'),
('03106','Xã Dương Quỳ','15'),
('03091','Xã Chiềng Ken','15'),
('03121','Xã Minh Lương','15'),
('03076','Xã Nậm Chày','15'),
('03043','Xã Mường Bo','15'),
('03046','Xã Bản Hồ','15'),
('03013','Xã Tả Phìn','15'),
('03037','Xã Tả Van','15'),
('03006','Phường Sa Pa','15'),
('02896','Xã Cốc Lầu','15'),
('02890','Xã Bảo Nhai','15'),
('02869','Xã Bản Liền','15'),
('02839','Xã Bắc Hà','15'),
('02842','Xã Tả Củ Tỷ','15'),
('02848','Xã Lùng Phình','15'),
('02752','Xã Pha Long','15'),
('02761','Xã Mường Khương','15'),
('02788','Xã Bản Lầu','15'),
('02782','Xã Cao Sơn','15'),
('02809','Xã Si Ma Cai','15'),
('02824','Xã Sín Chéng','15'),
('04474','Xã Lao Chải','15'),
('04489','Xã Chế Tạo','15'),
('04462','Xã Nậm Có','15'),
('04603','Xã Tà Xi Láng','15'),
('04423','Xã Phong Dụ Thượng','15'),
('04693','Xã Cát Thịnh','15'),
('03085','Xã Nậm Xé','15'),
('03004','Xã Ngũ Chỉ Sơn','15');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('05443','Phường Phan Đình Phùng','19'),
('05710','Phường Linh Sơn','19'),
('05500','Phường Tích Lương','19'),
('05467','Phường Gia Sàng','19'),
('05455','Phường Quyết Thắng','19'),
('05482','Phường Quan Triều','19'),
('05503','Xã Tân Cương','19'),
('05488','Xã Đại Phúc','19'),
('05830','Xã Đại Từ','19'),
('05776','Xã Đức Lương','19'),
('05800','Xã Phú Thịnh','19'),
('05818','Xã La Bằng','19'),
('05788','Xã Phú Lạc','19'),
('05809','Xã An Khánh','19'),
('05851','Xã Quân Chu','19'),
('05845','Xã Vạn Phú','19'),
('05773','Xã Phú Xuyên','19'),
('05860','Phường Phổ Yên','19'),
('05890','Phường Vạn Xuân','19'),
('05899','Phường Trung Thành','19'),
('05857','Phường Phúc Thuận','19'),
('05881','Xã Thành Công','19'),
('05908','Xã Phú Bình','19'),
('05923','Xã Tân Thành','19'),
('05941','Xã Điềm Thụy','19'),
('05953','Xã Kha Sơn','19'),
('05917','Xã Tân Khánh','19'),
('05692','Xã Đồng Hỷ','19'),
('05674','Xã Quang Sơn','19'),
('05662','Xã Trại Cau','19'),
('05707','Xã Nam Hòa','19'),
('05680','Xã Văn Hán','19'),
('05665','Xã Văn Lăng','19'),
('05518','Phường Sông Công','19'),
('05533','Phường Bá Xuyên','19'),
('05528','Phường Bách Quang','19'),
('05611','Xã Phú Lương','19'),
('05641','Xã Vô Tranh','19'),
('05620','Xã Yên Trạch','19'),
('05632','Xã Hợp Thành','19'),
('05569','Xã Định Hóa','19'),
('05587','Xã Bình Yên','19'),
('05581','Xã Trung Hội','19'),
('05563','Xã Phượng Tiến','19'),
('05602','Xã Phú Đình','19'),
('05605','Xã Bình Thành','19'),
('05551','Xã Kim Phượng','19'),
('05542','Xã Lam Vỹ','19'),
('05716','Xã Võ Nhai','19'),
('05719','Xã Sảng Mộc','19'),
('05755','Xã Dân Tiến','19'),
('05722','Xã Nghinh Tường','19'),
('05725','Xã Thần Sa','19'),
('05740','Xã La Hiên','19'),
('05746','Xã Tràng Xá','19'),
('01864','Xã Bằng Thành','19'),
('01882','Xã Nghiên Loan','19'),
('01879','Xã Cao Minh','19'),
('01906','Xã Ba Bể','19'),
('01912','Xã Chợ Rã','19'),
('01894','Xã Phúc Lộc','19'),
('01921','Xã Thượng Minh','19'),
('01933','Xã Đồng Phúc','19'),
('02116','Xã Yên Bình','19'),
('01942','Xã Bằng Vân','19'),
('01954','Xã Ngân Sơn','19'),
('01936','Xã Nà Phặc','19'),
('01960','Xã Hiệp Lực','19'),
('02026','Xã Nam Cường','19'),
('02038','Xã Quảng Bạch','19'),
('02044','Xã Yên Thịnh','19'),
('02020','Xã Chợ Đồn','19'),
('02083','Xã Yên Phong','19'),
('02071','Xã Nghĩa Tá','19'),
('01969','Xã Phủ Thông','19'),
('02008','Xã Cẩm Giàng','19'),
('01981','Xã Vĩnh Thông','19'),
('02014','Xã Bạch Thông','19'),
('01849','Xã Phong Quang','19'),
('01840','Phường Đức Xuân','19'),
('01843','Phường Bắc Kạn','19'),
('02143','Xã Văn Lang','19'),
('02152','Xã Cường Lợi','19'),
('02155','Xã Na Rì','19'),
('02176','Xã Trần Phú','19'),
('02185','Xã Côn Minh','19'),
('02191','Xã Xuân Dương','19'),
('02104','Xã Tân Kỳ','19'),
('02101','Xã Thanh Mai','19'),
('02107','Xã Thanh Thịnh','19'),
('02086','Xã Chợ Mới','19'),
('01957','Xã Thượng Quan','19');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('06040','Xã Thất Khê','20'),
('06001','Xã Đoàn Kết','20'),
('06019','Xã Tân Tiến','20'),
('06046','Xã Tràng Định','20'),
('06004','Xã Quốc Khánh','20'),
('06037','Xã Kháng Chiến','20'),
('06058','Xã Quốc Việt','20'),
('06112','Xã Bình Gia','20'),
('06115','Xã Tân Văn','20'),
('06079','Xã Hồng Phong','20'),
('06073','Xã Hoa Thám','20'),
('06076','Xã Quý Hòa','20'),
('06085','Xã Thiện Hòa','20'),
('06091','Xã Thiện Thuật','20'),
('06103','Xã Thiện Long','20'),
('06325','Xã Bắc Sơn','20'),
('06349','Xã Hưng Vũ','20'),
('06367','Xã Vũ Lăng','20'),
('06376','Xã Nhất Hòa','20'),
('06364','Xã Vũ Lễ','20'),
('06337','Xã Tân Tri','20'),
('06253','Xã Văn Quan','20'),
('06280','Xã Điềm He','20'),
('06313','Xã Tri Lễ','20'),
('06298','Xã Yên Phúc','20'),
('06316','Xã Tân Đoàn','20'),
('06286','Xã Khánh Khê','20'),
('06124','Xã Na Sầm','20'),
('06154','Xã Văn Lãng','20'),
('06151','Xã Hội Hoan','20'),
('06148','Xã Thụy Hùng','20'),
('06172','Xã Hoàng Văn Thụ','20'),
('06529','Xã Lộc Bình','20'),
('06541','Xã Mẫu Sơn','20'),
('06526','Xã Na Dương','20'),
('06601','Xã Lợi Bác','20'),
('06577','Xã Thống Nhất','20'),
('06607','Xã Xuân Dương','20'),
('06565','Xã Khuất Xá','20'),
('06613','Xã Đình Lập','20'),
('06637','Xã Châu Sơn','20'),
('06625','Xã Kiên Mộc','20'),
('06616','Xã Thái Bình','20'),
('06385','Xã Hữu Lũng','20'),
('06457','Xã Tuấn Sơn','20'),
('06445','Xã Tân Thành','20'),
('06415','Xã Vân Nham','20'),
('06436','Xã Thiện Tân','20'),
('06391','Xã Yên Bình','20'),
('06400','Xã Hữu Liên','20'),
('06427','Xã Cai Kinh','20'),
('06463','Xã Chi Lăng','20'),
('06496','Xã Nhân Lý','20'),
('06481','Xã Chiến Thắng','20'),
('06517','Xã Quan Sơn','20'),
('06475','Xã Bằng Mạc','20'),
('06505','Xã Vạn Linh','20'),
('06184','Xã Đồng Đăng','20'),
('06211','Xã Cao Lộc','20'),
('06220','Xã Công Sơn','20'),
('06196','Xã Ba Sơn','20'),
('05986','Phường Tam Thanh','20'),
('05983','Phường Lương Văn Tri','20'),
('06187','Phường Kỳ Lừa','20'),
('05977','Phường Đông Kinh','20');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('07090','Phường An Sinh','22'),
('07093','Phường Đông Triều','22'),
('07081','Phường Bình Khê','22'),
('07069','Phường Mạo Khê','22'),
('07114','Phường Hoàng Quế','22'),
('06832','Phường Yên Tử','22'),
('06820','Phường Vàng Danh','22'),
('06811','Phường Uông Bí','22'),
('07135','Phường Đông Mai','22'),
('07147','Phường Hiệp Hòa','22'),
('07132','Phường Quảng Yên','22'),
('07168','Phường Hà An','22'),
('07183','Phường Phong Cốc','22'),
('07180','Phường Liên Hòa','22'),
('06706','Phường Tuần Châu','22'),
('06661','Phường Việt Hưng','22'),
('06673','Phường Bãi Cháy','22'),
('06652','Phường Hà Tu','22'),
('06676','Phường Hà Lầm','22'),
('06658','Phường Cao Xanh','22'),
('06685','Phường Hồng Gai','22'),
('06688','Phường Hạ Long','22'),
('07030','Phường Hoành Bồ','22'),
('07054','Xã Quảng La','22'),
('07060','Xã Thống Nhất','22'),
('06760','Phường Mông Dương','22'),
('06778','Phường Quang Hanh','22'),
('06793','Phường Cẩm Phả','22'),
('06781','Phường Cửa Ông','22'),
('06799','Xã Hải Hòa','22'),
('06862','Xã Tiên Yên','22'),
('06874','Xã Điền Xá','22'),
('06877','Xã Đông Ngũ','22'),
('06886','Xã Hải Lạng','22'),
('06985','Xã Lương Minh','22'),
('06979','Xã Kỳ Thượng','22'),
('06970','Xã Ba Chẽ','22'),
('06913','Xã Quảng Tân','22'),
('06895','Xã Đầm Hà','22'),
('06922','Xã Quảng Hà','22'),
('06946','Xã Đường Hoa','22'),
('06931','Xã Quảng Đức','22'),
('06841','Xã Hoành Mô','22'),
('06856','Xã Lục Hồn','22'),
('06838','Xã Bình Liêu','22'),
('06724','Xã Hải Sơn','22'),
('06733','Xã Hải Ninh','22'),
('06757','Xã Vĩnh Thực','22'),
('06712','Phường Móng Cái 1','22'),
('06709','Phường Móng Cái 2','22'),
('06736','Phường Móng Cái 3','22'),
('06994','Đặc khu Vân Đồn','22'),
('07192','Đặc khu Cô Tô','22'),
('06967','Xã Cái Chiên','22');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('07627','Xã Đại Sơn','24'),
('07615','Xã Sơn Động','24'),
('07616','Xã Tây Yên Tử','24'),
('07672','Xã Dương Hưu','24'),
('07642','Xã Yên Định','24'),
('07654','Xã An Lạc','24'),
('07621','Xã Vân Sơn','24'),
('07573','Xã Biển Động','24'),
('07582','Xã Lục Ngạn','24'),
('07594','Xã Đèo Gia','24'),
('07543','Xã Sơn Hải','24'),
('07531','Xã Tân Sơn','24'),
('07537','Xã Biên Sơn','24'),
('07534','Xã Sa Lý','24'),
('07603','Xã Nam Dương','24'),
('07552','Xã Kiên Lao','24'),
('07525','Phường Chũ','24'),
('07612','Phường Phượng Sơn','24'),
('07492','Xã Lục Sơn','24'),
('07489','Xã Trường Sơn','24'),
('07519','Xã Cẩm Lý','24'),
('07450','Xã Đông Phú','24'),
('07486','Xã Nghĩa Phương','24'),
('07444','Xã Lục Nam','24'),
('07498','Xã Bắc Lũng','24'),
('07462','Xã Bảo Đài','24'),
('07375','Xã Lạng Giang','24'),
('07420','Xã Mỹ Thái','24'),
('07399','Xã Kép','24'),
('07432','Xã Tân Dĩnh','24'),
('07381','Xã Tiên Lục','24'),
('07288','Xã Yên Thế','24'),
('07294','Xã Bố Hạ','24'),
('07282','Xã Đồng Kỳ','24'),
('07246','Xã Xuân Lương','24'),
('07264','Xã Tam Tiến','24'),
('07339','Xã Tân Yên','24'),
('07351','Xã Ngọc Thiện','24'),
('07306','Xã Nhã Nam','24'),
('07330','Xã Phúc Hòa','24'),
('07333','Xã Quang Trung','24'),
('07864','Xã Hợp Thịnh','24'),
('07840','Xã Hiệp Hòa','24'),
('07822','Xã Hoàng Vân','24'),
('07870','Xã Xuân Cẩm','24'),
('07774','Phường Tự Lạn','24'),
('07777','Phường Việt Yên','24'),
('07795','Phường Nếnh','24'),
('07798','Phường Vân Hà','24'),
('07735','Xã Đồng Việt','24'),
('07210','Phường Bắc Giang','24'),
('07228','Phường Đa Mai','24'),
('07696','Phường Tiền Phong','24'),
('07682','Phường Tân An','24'),
('07681','Phường Yên Dũng','24'),
('07699','Phường Tân Tiến','24'),
('07738','Phường Cảnh Thụy','24'),
('09187','Phường Kinh Bắc','24'),
('09190','Phường Võ Cường','24'),
('09169','Phường Vũ Ninh','24'),
('09325','Phường Hạp Lĩnh','24'),
('09286','Phường Nam Sơn','24'),
('09367','Phường Từ Sơn','24'),
('09370','Phường Tam Sơn','24'),
('09385','Phường Đồng Nguyên','24'),
('09379','Phường Phù Khê','24'),
('09400','Phường Thuận Thành','24'),
('09409','Phường Mão Điền','24'),
('09430','Phường Trạm Lộ','24'),
('09427','Phường Trí Quả','24'),
('09433','Phường Song Liễu','24'),
('09445','Phường Ninh Xá','24'),
('09247','Phường Quế Võ','24'),
('09265','Phường Phương Liễu','24'),
('09253','Phường Nhân Hòa','24'),
('09301','Phường Đào Viên','24'),
('09295','Phường Bồng Lai','24'),
('09313','Xã Chi Lăng','24'),
('09292','Xã Phù Lãng','24'),
('09193','Xã Yên Phong','24'),
('09238','Xã Văn Môn','24'),
('09202','Xã Tam Giang','24'),
('09205','Xã Yên Trung','24'),
('09208','Xã Tam Đa','24'),
('09319','Xã Tiên Du','24'),
('09334','Xã Liên Bão','24'),
('09343','Xã Tân Chi','24'),
('09340','Xã Đại Đồng','24'),
('09349','Xã Phật Tích','24'),
('09454','Xã Gia Bình','24'),
('09475','Xã Nhân Thắng','24'),
('09469','Xã Đại Lai','24'),
('09466','Xã Cao Đức','24'),
('09487','Xã Đông Cứu','24'),
('09496','Xã Lương Tài','24'),
('09529','Xã Lâm Thao','24'),
('09523','Xã Trung Chính','24'),
('09499','Xã Trung Kênh','24'),
('07663','Xã Tuấn Đạo','24');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('07900','Phường Việt Trì','25'),
('07894','Phường Nông Trang','25'),
('07909','Phường Thanh Miếu','25'),
('07918','Phường Vân Phú','25'),
('08515','Xã Hy Cương','25'),
('08494','Xã Lâm Thao','25'),
('08500','Xã Xuân Lũng','25'),
('08521','Xã Phùng Nguyên','25'),
('08527','Xã Bản Nguyên','25'),
('07954','Phường Phong Châu','25'),
('07942','Phường Phú Thọ','25'),
('07948','Phường Âu Cơ','25'),
('08230','Xã Phù Ninh','25'),
('08254','Xã Dân Chủ','25'),
('08236','Xã Phú Mỹ','25'),
('08245','Xã Trạm Thản','25'),
('08275','Xã Bình Phú','25'),
('08152','Xã Thanh Ba','25'),
('08173','Xã Quảng Yên','25'),
('08203','Xã Hoàng Cương','25'),
('08209','Xã Đông Thành','25'),
('08218','Xã Chí Tiên','25'),
('08227','Xã Liên Minh','25'),
('07969','Xã Đoan Hùng','25'),
('08023','Xã Tây Cốc','25'),
('08038','Xã Chân Mộng','25'),
('07999','Xã Chí Đám','25'),
('07996','Xã Bằng Luân','25'),
('08053','Xã Hạ Hòa','25'),
('08071','Xã Đan Thượng','25'),
('08113','Xã Yên Kỳ','25'),
('08143','Xã Vĩnh Chân','25'),
('08134','Xã Văn Lang','25'),
('08110','Xã Hiền Lương','25'),
('08341','Xã Cẩm Khê','25'),
('08398','Xã Phú Khê','25'),
('08416','Xã Hùng Việt','25'),
('08431','Xã Đồng Lương','25'),
('08344','Xã Tiên Lương','25'),
('08377','Xã Vân Bán','25'),
('08434','Xã Tam Nông','25'),
('08479','Xã Thọ Văn','25'),
('08467','Xã Vạn Xuân','25'),
('08443','Xã Hiền Quan','25'),
('08674','Xã Thanh Thủy','25'),
('08662','Xã Đào Xá','25'),
('08686','Xã Tu Vũ','25'),
('08542','Xã Thanh Sơn','25'),
('08584','Xã Võ Miếu','25'),
('08611','Xã Văn Miếu','25'),
('08614','Xã Cự Đồng','25'),
('08632','Xã Hương Cần','25'),
('08656','Xã Yên Sơn','25'),
('08635','Xã Khả Cửu','25'),
('08566','Xã Tân Sơn','25'),
('08593','Xã Minh Đài','25'),
('08560','Xã Lai Đồng','25'),
('08545','Xã Thu Cúc','25'),
('08590','Xã Xuân Đài','25'),
('08620','Xã Long Cốc','25'),
('08290','Xã Yên Lập','25'),
('08323','Xã Thượng Long','25'),
('08296','Xã Sơn Lương','25'),
('08305','Xã Xuân Viên','25'),
('08338','Xã Minh Hòa','25'),
('08311','Xã Trung Sơn','25'),
('08824','Xã Tam Sơn','25'),
('08848','Xã Sông Lô','25'),
('08782','Xã Hải Lựu','25'),
('08773','Xã Yên Lãng','25'),
('08761','Xã Lập Thạch','25'),
('08842','Xã Tiên Lữ','25'),
('08788','Xã Thái Hòa','25'),
('08812','Xã Liên Hòa','25'),
('08770','Xã Hợp Lý','25'),
('08866','Xã Sơn Đông','25'),
('08911','Xã Tam Đảo','25'),
('08923','Xã Đại Đình','25'),
('08914','Xã Đạo Trù','25'),
('08869','Xã Tam Dương','25'),
('08905','Xã Hội Thịnh','25'),
('08896','Xã Hoàng An','25'),
('08872','Xã Tam Dương Bắc','25'),
('09076','Xã Vĩnh Tường','25'),
('09112','Xã Thổ Tang','25'),
('09100','Xã Vĩnh Hưng','25'),
('09079','Xã Vĩnh An','25'),
('09154','Xã Vĩnh Phú','25'),
('09106','Xã Vĩnh Thành','25'),
('09025','Xã Yên Lạc','25'),
('09040','Xã Tề Lỗ','25'),
('09064','Xã Liên Châu','25'),
('09043','Xã Tam Hồng','25'),
('09052','Xã Nguyệt Đức','25'),
('08935','Xã Bình Nguyên','25'),
('08971','Xã Xuân Lãng','25'),
('08950','Xã Bình Xuyên','25'),
('08944','Xã Bình Tuyền','25'),
('08716','Phường Vĩnh Phúc','25'),
('08707','Phường Vĩnh Yên','25'),
('08740','Phường Phúc Yên','25'),
('08746','Phường Xuân Hòa','25'),
('05089','Xã Cao Phong','25'),
('05116','Xã Mường Thàng','25'),
('05092','Xã Thung Nai','25'),
('04831','Xã Đà Bắc','25'),
('04876','Xã Cao Sơn','25'),
('04846','Xã Đức Nhàn','25'),
('04873','Xã Quy Đức','25'),
('04849','Xã Tân Pheo','25'),
('04891','Xã Tiền Phong','25'),
('04978','Xã Kim Bôi','25'),
('05014','Xã Mường Động','25'),
('05086','Xã Dũng Tiến','25'),
('05068','Xã Hợp Kim','25'),
('04990','Xã Nật Sơn','25'),
('05266','Xã Lạc Sơn','25'),
('05287','Xã Mường Vang','25'),
('05347','Xã Đại Đồng','25'),
('05329','Xã Ngọc Sơn','25'),
('05290','Xã Nhân Nghĩa','25'),
('05323','Xã Quyết Thắng','25'),
('05293','Xã Thượng Cốc','25'),
('05305','Xã Yên Phú','25'),
('05392','Xã Lạc Thủy','25'),
('05425','Xã An Bình','25'),
('05395','Xã An Nghĩa','25'),
('04924','Xã Lương Sơn','25'),
('05047','Xã Cao Dương','25'),
('04960','Xã Liên Sơn','25'),
('05200','Xã Mai Châu','25'),
('05245','Xã Bao La','25'),
('05251','Xã Mai Hạ','25'),
('05212','Xã Pà Cò','25'),
('05206','Xã Tân Mai','25'),
('05128','Xã Tân Lạc','25'),
('05158','Xã Mường Bi','25'),
('05134','Xã Mường Hoa','25'),
('05191','Xã Toàn Thắng','25'),
('05152','Xã Vân Sơn','25'),
('05353','Xã Yên Thủy','25'),
('05362','Xã Lạc Lương','25'),
('05386','Xã Yên Trị','25'),
('04897','Xã Thịnh Minh','25'),
('04795','Phường Hòa Bình','25'),
('04894','Phường Kỳ Sơn','25'),
('04792','Phường Tân Hòa','25'),
('04828','Phường Thống Nhất','25');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('11560','Phường Thủy Nguyên','31'),
('11557','Phường Thiên Hương','31'),
('11533','Phường Hòa Bình','31'),
('11542','Phường Nam Triệu','31'),
('11473','Phường Bạch Đằng','31'),
('11488','Phường Lưu Kiếm','31'),
('11506','Phường Lê Ích Mộc','31'),
('11311','Phường Hồng Bàng','31'),
('11602','Phường Hồng An','31'),
('11329','Phường Ngô Quyền','31'),
('11359','Phường Gia Viên','31'),
('11383','Phường Lê Chân','31'),
('11407','Phường An Biên','31'),
('11413','Phường Hải An','31'),
('11411','Phường Đông Hải','31'),
('11443','Phường Kiến An','31'),
('11446','Phường Phù Liễn','31'),
('11737','Phường Nam Đồ Sơn','31'),
('11455','Phường Đồ Sơn','31'),
('11689','Phường Hưng Đạo','31'),
('11692','Phường Dương Kinh','31'),
('11581','Phường An Dương','31'),
('11617','Phường An Hải','31'),
('11593','Phường An Phong','31'),
('11674','Xã An Hưng','31'),
('11668','Xã An Khánh','31'),
('11647','Xã An Quang','31'),
('11635','Xã An Trường','31'),
('11629','Xã An Lão','31'),
('11680','Xã Kiến Thụy','31'),
('11725','Xã Kiến Minh','31'),
('11749','Xã Kiến Hải','31'),
('11728','Xã Kiến Hưng','31'),
('11713','Xã Nghi Dương','31'),
('11761','Xã Quyết Thắng','31'),
('11755','Xã Tiên Lãng','31'),
('11779','Xã Tân Minh','31'),
('11791','Xã Tiên Minh','31'),
('11806','Xã Chấn Hưng','31'),
('11809','Xã Hùng Thắng','31'),
('11824','Xã Vĩnh Bảo','31'),
('11911','Xã Nguyễn Bỉnh Khiêm','31'),
('11887','Xã Vĩnh Am','31'),
('11875','Xã Vĩnh Hải','31'),
('11848','Xã Vĩnh Hòa','31'),
('11836','Xã Vĩnh Thịnh','31'),
('11842','Xã Vĩnh Thuận','31'),
('11503','Xã Việt Khê','31'),
('11914','Đặc khu Cát Hải','31'),
('11948','Đặc khu Bạch Long Vĩ','31'),
('10525','Phường Hải Dương','31'),
('10532','Phường Lê Thanh Nghị','31'),
('10543','Phường Việt Hòa','31'),
('10507','Phường Thành Đông','31'),
('10837','Phường Nam Đồng','31'),
('10537','Phường Tân Hưng','31'),
('11002','Phường Thạch Khôi','31'),
('10891','Phường Tứ Minh','31'),
('10660','Phường Á i Quốc','31'),
('10549','Phường Chu Văn An','31'),
('10546','Phường Chí Linh','31'),
('10570','Phường Trần Hưng Đạo','31'),
('10552','Phường Nguyễn Trãi','31'),
('10573','Phường Trần Nhân Tông','31'),
('10603','Phường Lê Đại Hành','31'),
('10675','Phường Kinh Môn','31'),
('10744','Phường Nguyễn Đại Năng','31'),
('10729','Phường Trần Liễu','31'),
('10678','Phường Bắc An Phụ','31'),
('10726','Phường Phạm Sư Mạnh','31'),
('10714','Phường Nhị Chiểu','31'),
('10705','Xã Nam An Phụ','31'),
('10606','Xã Nam Sách','31'),
('10642','Xã Thái Tân','31'),
('10615','Xã Hợp Tiến','31'),
('10633','Xã Trần Phú','31'),
('10645','Xã An Phú','31'),
('10813','Xã Thanh Hà','31'),
('10846','Xã Hà Tây','31'),
('10816','Xã Hà Bắc','31'),
('10843','Xã Hà Nam','31'),
('10882','Xã Hà Đông','31'),
('10888','Xã Cẩm Giang','31'),
('10909','Xã Tuệ Tĩnh','31'),
('10930','Xã Mao Điền','31'),
('10903','Xã Cẩm Giàng','31'),
('10945','Xã Kẻ Sặt','31'),
('10966','Xã Bình Giang','31'),
('10972','Xã Đường An','31'),
('10993','Xã Thượng Hồng','31'),
('10999','Xã Gia Lộc','31'),
('11020','Xã Yết Kiêu','31'),
('11050','Xã Gia Phúc','31'),
('11065','Xã Trường Tân','31'),
('11074','Xã Tứ Kỳ','31'),
('11113','Xã Tân Kỳ','31'),
('11086','Xã Đại Sơn','31'),
('11131','Xã Chí Minh','31'),
('11140','Xã Lạc Phượng','31'),
('11146','Xã Nguyên Giáp','31'),
('11203','Xã Ninh Giang','31'),
('11164','Xã Vĩnh Lại','31'),
('11224','Xã Khúc Thừa Dụ','31'),
('11167','Xã Tân An','31'),
('11218','Xã Hồng Châu','31'),
('11239','Xã Thanh Miện','31'),
('11254','Xã Bắc Thanh Miện','31'),
('11257','Xã Hải Hưng','31'),
('11242','Xã Nguyễn Lương Bằng','31'),
('11284','Xã Nam Thanh Miện','31'),
('10750','Xã Phú Thái','31'),
('10756','Xã Lai Khê','31'),
('10792','Xã An Thành','31'),
('10804','Xã Kim Thành','31');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('11953','Phường Phố Hiến','33'),
('11983','Phường Sơn Nam','33'),
('11980','Phường Hồng Châu','33'),
('12103','Phường Mỹ Hào','33'),
('12133','Phường Đường Hào','33'),
('12127','Phường Thượng Hồng','33'),
('11977','Xã Tân Hưng','33'),
('12337','Xã Hoàng Hoa Thám','33'),
('12364','Xã Tiên Lữ','33'),
('12361','Xã Tiên Hoa','33'),
('12391','Xã Quang Hưng','33'),
('12406','Xã Đoàn Đào','33'),
('12424','Xã Tiên Tiến','33'),
('12427','Xã Tống Trân','33'),
('12280','Xã Lương Bằng','33'),
('12286','Xã Nghĩa Dân','33'),
('12322','Xã Hiệp Cường','33'),
('12313','Xã Đức Hợp','33'),
('12142','Xã Ân Thi','33'),
('12166','Xã Xuân Trúc','33'),
('12148','Xã Phạm Ngũ Lão','33'),
('12184','Xã Nguyễn Trãi','33'),
('12196','Xã Hồng Quang','33'),
('12205','Xã Khoái Châu','33'),
('12223','Xã Triệu Việt Vương','33'),
('12238','Xã Việt Tiến','33'),
('12271','Xã Chí Minh','33'),
('12247','Xã Châu Ninh','33'),
('12073','Xã Yên Mỹ','33'),
('12091','Xã Việt Yên','33'),
('12070','Xã Hoàn Long','33'),
('12064','Xã Nguyễn Văn Linh','33'),
('12004','Xã Như Quỳnh','33'),
('11992','Xã Lạc Đạo','33'),
('11995','Xã Đại Đồng','33'),
('12031','Xã Nghĩa Trụ','33'),
('12025','Xã Phụng Công','33'),
('12019','Xã Văn Giang','33'),
('12049','Xã Mễ Sở','33'),
('13225','Phường Thái Bình','33'),
('12454','Phường Trần Lãm','33'),
('12452','Phường Trần Hưng Đạo','33'),
('12817','Phường Trà Lý','33'),
('12466','Phường Vũ Phúc','33'),
('12826','Xã Thái Thụy','33'),
('12862','Xã Đông Thụy Anh','33'),
('12859','Xã Bắc Thụy Anh','33'),
('12865','Xã Thụy Anh','33'),
('12904','Xã Nam Thụy Anh','33'),
('12916','Xã Bắc Thái Ninh','33'),
('12922','Xã Thái Ninh','33'),
('12943','Xã Đông Thái Ninh','33'),
('12961','Xã Nam Thái Ninh','33'),
('12919','Xã Tây Thái Ninh','33'),
('12850','Xã Tây Thụy Anh','33'),
('12970','Xã Tiền Hải','33'),
('13039','Xã Tây Tiền Hải','33'),
('13021','Xã Á i Quốc','33'),
('13003','Xã Đồng Châu','33'),
('12988','Xã Đông Tiền Hải','33'),
('13057','Xã Nam Cường','33'),
('13066','Xã Hưng Phú','33'),
('13063','Xã Nam Tiền Hải','33'),
('12472','Xã Quỳnh Phụ','33'),
('12511','Xã Minh Thọ','33'),
('12532','Xã Nguyễn Du','33'),
('12577','Xã Quỳnh An','33'),
('12517','Xã Ngọc Lâm','33'),
('12526','Xã Đồng Bằng','33'),
('12499','Xã A Sào','33'),
('12523','Xã Phụ Dực','33'),
('12583','Xã Tân Tiến','33'),
('12586','Xã Hưng Hà','33'),
('12634','Xã Tiên La','33'),
('12676','Xã Lê Quý Đôn','33'),
('12685','Xã Hồng Minh','33'),
('12631','Xã Thần Khê','33'),
('12619','Xã Diên Hà','33'),
('12595','Xã Ngự Thiên','33'),
('12613','Xã Long Hưng','33'),
('12688','Xã Đông Hưng','33'),
('12700','Xã Bắc Tiên Hưng','33'),
('12736','Xã Đông Tiên Hưng','33'),
('12775','Xã Nam Đông Hưng','33'),
('12745','Xã Bắc Đông Quan','33'),
('12694','Xã Bắc Đông Hưng','33'),
('12793','Xã Đông Quan','33'),
('12763','Xã Nam Tiên Hưng','33'),
('12754','Xã Tiên Hưng','33'),
('13120','Xã Lê Lợi','33'),
('13075','Xã Kiến Xương','33'),
('13132','Xã Quang Lịch','33'),
('13141','Xã Vũ Quý','33'),
('13183','Xã Bình Thanh','33'),
('13186','Xã Bình Định','33'),
('13159','Xã Hồng Vũ','33'),
('13096','Xã Bình Nguyên','33'),
('13093','Xã Trà Giang','33'),
('13192','Xã Vũ Thư','33'),
('13222','Xã Thư Trì','33'),
('13246','Xã Tân Thuận','33'),
('13264','Xã Thư Vũ','33'),
('13279','Xã Vũ Tiên','33'),
('13219','Xã Vạn Xuân','33');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('14464','Xã Gia Viễn','37'),
('14500','Xã Đại Hoàng','37'),
('14482','Xã Gia Hưng','37'),
('14524','Xã Gia Phong','37'),
('14488','Xã Gia Vân','37'),
('14494','Xã Gia Trấn','37'),
('14428','Xã Nho Quan','37'),
('14389','Xã Gia Lâm','37'),
('14401','Xã Gia Tường','37'),
('14407','Xã Phú Sơn','37'),
('14404','Xã Cúc Phương','37'),
('14458','Xã Phú Long','37'),
('14434','Xã Thanh Sơn','37'),
('14452','Xã Quỳnh Lưu','37'),
('14560','Xã Yên Khánh','37'),
('14611','Xã Khánh Nhạc','37'),
('14563','Xã Khánh Thiện','37'),
('14614','Xã Khánh Hội','37'),
('14608','Xã Khánh Trung','37'),
('14701','Xã Yên Mô','37'),
('14728','Xã Yên Từ','37'),
('14743','Xã Yên Mạc','37'),
('14746','Xã Đồng Thái','37'),
('14653','Xã Chất Bình','37'),
('14638','Xã Kim Sơn','37'),
('14647','Xã Quang Thiện','37'),
('14620','Xã Phát Diệm','37'),
('14674','Xã Lai Thành','37'),
('14677','Xã Định Hóa','37'),
('14623','Xã Bình Minh','37'),
('14698','Xã Kim Đông','37'),
('13504','Xã Bình Lục','37'),
('13501','Xã Bình Mỹ','37'),
('13540','Xã Bình An','37'),
('13531','Xã Bình Giang','37'),
('13558','Xã Bình Sơn','37'),
('13456','Xã Liêm Hà','37'),
('13474','Xã Tân Thanh','37'),
('13483','Xã Thanh Bình','37'),
('13489','Xã Thanh Lâm','37'),
('13495','Xã Thanh Liêm','37'),
('13573','Xã Lý Nhân','37'),
('13591','Xã Nam Xang','37'),
('13579','Xã Bắc Lý','37'),
('13597','Xã Vĩnh Trụ','37'),
('13594','Xã Trần Thương','37'),
('13609','Xã Nhân Hà','37'),
('13627','Xã Nam Lý','37'),
('13966','Xã Nam Trực','37'),
('14011','Xã Nam Minh','37'),
('14014','Xã Nam Đồng','37'),
('14005','Xã Nam Ninh','37'),
('13987','Xã Nam Hồng','37'),
('13750','Xã Minh Tân','37'),
('13753','Xã Hiển Khánh','37'),
('13741','Xã Vụ Bản','37'),
('13786','Xã Liên Minh','37'),
('13795','Xã Ý Yên','37'),
('13879','Xã Yên Đồng','37'),
('13870','Xã Yên Cường','37'),
('13864','Xã Vạn Thắng','37'),
('13834','Xã Vũ Dương','37'),
('13807','Xã Tân Minh','37'),
('13822','Xã Phong Doanh','37'),
('14026','Xã Cổ Lễ','37'),
('14038','Xã Ninh Giang','37'),
('14056','Xã Cát Thành','37'),
('14053','Xã Trực Ninh','37'),
('14062','Xã Quang Hưng','37'),
('14071','Xã Minh Thái','37'),
('14077','Xã Ninh Cường','37'),
('14089','Xã Xuân Trường','37'),
('14122','Xã Xuân Hưng','37'),
('14104','Xã Xuân Giang','37'),
('14095','Xã Xuân Hồng','37'),
('14215','Xã Hải Hậu','37'),
('14236','Xã Hải Anh','37'),
('14218','Xã Hải Tiến','37'),
('14248','Xã Hải Hưng','37'),
('14281','Xã Hải An','37'),
('14287','Xã Hải Quang','37'),
('14308','Xã Hải Xuân','37'),
('14221','Xã Hải Thịnh','37'),
('14161','Xã Giao Minh','37'),
('14182','Xã Giao Hòa','37'),
('14167','Xã Giao Thủy','37'),
('14203','Xã Giao Phúc','37'),
('14179','Xã Giao Hưng','37'),
('14194','Xã Giao Bình','37'),
('14212','Xã Giao Ninh','37'),
('13900','Xã Đồng Thịnh','37'),
('13891','Xã Nghĩa Hưng','37'),
('13918','Xã Nghĩa Sơn','37'),
('13927','Xã Hồng Phong','37'),
('13939','Xã Quỹ Nhất','37'),
('13957','Xã Nghĩa Lâm','37'),
('13894','Xã Rạng Đông','37'),
('14533','Phường Tây Hoa Lư','37'),
('14329','Phường Hoa Lư','37'),
('14359','Phường Nam Hoa Lư','37'),
('14566','Phường Đông Hoa Lư','37'),
('14362','Phường Tam Điệp','37'),
('14371','Phường Yên Sơn','37'),
('14365','Phường Trung Sơn','37'),
('14725','Phường Yên Thắng','37'),
('13366','Phường Hà Nam','37'),
('13285','Phường Phủ Lý','37'),
('13291','Phường Phù Vân','37'),
('13318','Phường Châu Sơn','37'),
('13444','Phường Liêm Tuyền','37'),
('13324','Phường Duy Tiên','37'),
('13330','Phường Duy Tân','37'),
('13348','Phường Đồng Văn','37'),
('13336','Phường Duy Hà','37'),
('13363','Phường Tiên Sơn','37'),
('13393','Phường Lê Hồ','37'),
('13396','Phường Nguyễn Úy','37'),
('13435','Phường Lý Thường Kiệt','37'),
('13402','Phường Kim Thanh','37'),
('13420','Phường Tam Chúc','37'),
('13384','Phường Kim Bảng','37'),
('13669','Phường Nam Định','37'),
('13684','Phường Thiên Trường','37'),
('13693','Phường Đông A','37'),
('13972','Phường Vị Khê','37'),
('13699','Phường Thành Nam','37'),
('13777','Phường Trường Thi','37'),
('13984','Phường Hồng Quang','37'),
('13708','Phường Mỹ Lộc','37');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('14797','Phường Hạc Thành','38'),
('16522','Phường Quảng Phú','38'),
('16417','Phường Đông Quang','38'),
('16378','Phường Đông Sơn','38'),
('15853','Phường Đông Tiến','38'),
('14758','Phường Hàm Rồng','38'),
('15925','Phường Nguyệt Viên','38'),
('16531','Phường Sầm Sơn','38'),
('16516','Phường Nam Sầm Sơn','38'),
('14812','Phường Bỉm Sơn','38'),
('14818','Phường Quang Trung','38'),
('16576','Phường Ngọc Sơn','38'),
('16594','Phường Tân Dân','38'),
('16597','Phường Hải Lĩnh','38'),
('16561','Phường Tĩnh Gia','38'),
('16609','Phường Đào Duy Từ','38'),
('16645','Phường Hải Bình','38'),
('16624','Phường Trúc Lâm','38'),
('16654','Phường Nghi Sơn','38'),
('16591','Xã Các Sơn','38'),
('16636','Xã Trường Lâm','38'),
('15271','Xã Hà Trung','38'),
('15316','Xã Tống Sơn','38'),
('15274','Xã Hà Long','38'),
('15286','Xã Hoạt Giang','38'),
('15298','Xã Lĩnh Toại','38'),
('16021','Xã Triệu Lộc','38'),
('16033','Xã Đông Thành','38'),
('16012','Xã Hậu Lộc','38'),
('16072','Xã Hoa Lộc','38'),
('16078','Xã Vạn Lộc','38'),
('16093','Xã Nga Sơn','38'),
('16114','Xã Nga Thắng','38'),
('16138','Xã Hồ Vương','38'),
('16108','Xã Tân Tiến','38'),
('16144','Xã Nga An','38'),
('16171','Xã Ba Đình','38'),
('15865','Xã Hoằng Hóa','38'),
('15991','Xã Hoằng Tiến','38'),
('16000','Xã Hoằng Thanh','38'),
('15961','Xã Hoằng Lộc','38'),
('15976','Xã Hoằng Châu','38'),
('15910','Xã Hoằng Sơn','38'),
('15889','Xã Hoằng Phú','38'),
('15880','Xã Hoằng Giang','38'),
('16438','Xã Lưu Vệ','38'),
('16480','Xã Quảng Yên','38'),
('16498','Xã Quảng Ngọc','38'),
('16540','Xã Quảng Ninh','38'),
('16543','Xã Quảng Bình','38'),
('16549','Xã Tiên Trang','38'),
('16489','Xã Quảng Chính','38'),
('16279','Xã Nông Cống','38'),
('16309','Xã Thắng Lợi','38'),
('16297','Xã Trung Chính','38'),
('16348','Xã Trường Văn','38'),
('16342','Xã Thăng Bình','38'),
('16363','Xã Tượng Lĩnh','38'),
('16369','Xã Công Chính','38'),
('15772','Xã Thiệu Hóa','38'),
('15796','Xã Thiệu Quang','38'),
('15778','Xã Thiệu Tiến','38'),
('15820','Xã Thiệu Toán','38'),
('15835','Xã Thiệu Trung','38'),
('15469','Xã Yên Định','38'),
('15421','Xã Yên Trường','38'),
('15409','Xã Yên Phú','38'),
('15412','Xã Quý Lộc','38'),
('15442','Xã Yên Ninh','38'),
('15457','Xã Định Tân','38'),
('15448','Xã Định Hòa','38'),
('15499','Xã Thọ Xuân','38'),
('15505','Xã Thọ Long','38'),
('15520','Xã Xuân Hòa','38'),
('15553','Xã Sao Vàng','38'),
('15544','Xã Lam Sơn','38'),
('15568','Xã Thọ Lập','38'),
('15574','Xã Xuân Tín','38'),
('15592','Xã Xuân Lập','38'),
('15349','Xã Vĩnh Lộc','38'),
('15361','Xã Tây Đô','38'),
('15382','Xã Biện Thượng','38'),
('15664','Xã Triệu Sơn','38'),
('15667','Xã Thọ Bình','38'),
('15754','Xã Thọ Ngọc','38'),
('15763','Xã Thọ Phú','38'),
('15682','Xã Hợp Tiến','38'),
('15766','Xã An Nông','38'),
('15715','Xã Tân Ninh','38'),
('15724','Xã Đồng Tiến','38'),
('14866','Xã Mường Chanh','38'),
('14860','Xã Quang Chiểu','38'),
('14848','Xã Tam Chung','38'),
('14845','Xã Mường Lát','38'),
('14863','Xã Pù Nhi','38'),
('14864','Xã Nhi Sơn','38'),
('14854','Xã Mường Lý','38'),
('14857','Xã Trung Lý','38'),
('14869','Xã Hồi Xuân','38'),
('14902','Xã Nam Xuân','38'),
('14908','Xã Thiên Phủ','38'),
('14896','Xã Hiền Kiệt','38'),
('14890','Xã Phú Xuân','38'),
('14878','Xã Phú Lệ','38'),
('14872','Xã Trung Thành','38'),
('14875','Xã Trung Sơn','38'),
('15013','Xã Na Mèo','38'),
('15010','Xã Sơn Thủy','38'),
('15022','Xã Sơn Điện','38'),
('15025','Xã Mường Mìn','38'),
('15007','Xã Tam Thanh','38'),
('15019','Xã Tam Lư','38'),
('15016','Xã Quan Sơn','38'),
('15001','Xã Trung Hạ','38'),
('15055','Xã Linh Sơn','38'),
('15058','Xã Đồng Lương','38'),
('15049','Xã Văn Phú','38'),
('15043','Xã Giao An','38'),
('15031','Xã Yên Khương','38'),
('15034','Xã Yên Thắng','38'),
('14974','Xã Văn Nho','38'),
('14980','Xã Thiết Ống','38'),
('14923','Xã Bá Thước','38'),
('14959','Xã Cổ Lũng','38'),
('14956','Xã Pù Luông','38'),
('14950','Xã Điền Lư','38'),
('14932','Xã Điền Quang','38'),
('14953','Xã Quý Lương','38'),
('15061','Xã Ngọc Lặc','38'),
('15085','Xã Thạch Lập','38'),
('15091','Xã Ngọc Liên','38'),
('15124','Xã Minh Sơn','38'),
('15106','Xã Nguyệt Ấn','38'),
('15112','Xã Kiên Thọ','38'),
('15142','Xã Cẩm Thạch','38'),
('15127','Xã Cẩm Thủy','38'),
('15148','Xã Cẩm Tú','38'),
('15163','Xã Cẩm Vân','38'),
('15178','Xã Cẩm Tân','38'),
('15187','Xã Kim Tân','38'),
('15190','Xã Vân Du','38'),
('15250','Xã Ngọc Trạo','38'),
('15211','Xã Thạch Bình','38'),
('15229','Xã Thành Vinh','38'),
('15199','Xã Thạch Quảng','38'),
('16174','Xã Như Xuân','38'),
('16225','Xã Thượng Ninh','38'),
('16177','Xã Xuân Bình','38'),
('16186','Xã Hóa Quỳ','38'),
('16222','Xã Thanh Quân','38'),
('16213','Xã Thanh Phong','38'),
('16234','Xã Xuân Du','38'),
('16249','Xã Mậu Lâm','38'),
('16228','Xã Như Thanh','38'),
('16264','Xã Yên Thọ','38'),
('16258','Xã Xuân Thái','38'),
('16273','Xã Thanh Kỳ','38'),
('15607','Xã Bát Mọt','38'),
('15610','Xã Yên Nhân','38'),
('15628','Xã Lương Sơn','38'),
('15646','Xã Thường Xuân','38'),
('15634','Xã Luận Thành','38'),
('15661','Xã Tân Thành','38'),
('15622','Xã Vạn Xuân','38'),
('15643','Xã Thắng Lộc','38'),
('15658','Xã Xuân Chinh','38');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('17329','Xã Anh Sơn','40'),
('17380','Xã Yên Xuân','40'),
('17344','Xã Nhân Hòa','40'),
('17365','Xã Anh Sơn Đông','40'),
('17357','Xã Vĩnh Tường','40'),
('17335','Xã Thành Bình Thọ','40'),
('17254','Xã Con Cuông','40'),
('17263','Xã Môn Sơn','40'),
('17239','Xã Mậu Thạch','40'),
('17242','Xã Cam Phục','40'),
('17248','Xã Châu Khê','40'),
('17230','Xã Bình Chuẩn','40'),
('17464','Xã Diễn Châu','40'),
('17416','Xã Đức Châu','40'),
('17443','Xã Quảng Châu','40'),
('17419','Xã Hải Châu','40'),
('17488','Xã Tân Châu','40'),
('17479','Xã An Châu','40'),
('17476','Xã Minh Châu','40'),
('17395','Xã Hùng Châu','40'),
('17662','Xã Đô Lương','40'),
('17623','Xã Bạch Ngọc','40'),
('17677','Xã Văn Hiến','40'),
('17707','Xã Bạch Hà','40'),
('17689','Xã Thuần Trung','40'),
('17641','Xã Lương Sơn','40'),
('17110','Phường Hoàng Mai','40'),
('17128','Phường Tân Mai','40'),
('17125','Phường Quỳnh Mai','40'),
('18001','Xã Hưng Nguyên','40'),
('18007','Xã Yên Trung','40'),
('18028','Xã Hưng Nguyên Nam','40'),
('18040','Xã Lam Thành','40'),
('16813','Xã Mường Xén','40'),
('16849','Xã Hữu Kiệm','40'),
('16837','Xã Nậm Cắn','40'),
('16855','Xã Chiêu Lưu','40'),
('16834','Xã Na Loi','40'),
('16858','Xã Mường Típ','40'),
('16870','Xã Na Ngoi','40'),
('16816','Xã Mỹ Lý','40'),
('16819','Xã Bắc Lý','40'),
('16822','Xã Keng Đu','40'),
('16828','Xã Huồi Tụ','40'),
('16831','Xã Mường Lống','40'),
('17950','Xã Vạn An','40'),
('17935','Xã Nam Đàn','40'),
('17944','Xã Đại Huệ','40'),
('17989','Xã Thiên Nhẫn','40'),
('17971','Xã Kim Liên','40'),
('16941','Xã Nghĩa Đàn','40'),
('16969','Xã Nghĩa Thọ','40'),
('16951','Xã Nghĩa Lâm','40'),
('16975','Xã Nghĩa Mai','40'),
('16972','Xã Nghĩa Hưng','40'),
('17032','Xã Nghĩa Khánh','40'),
('17029','Xã Nghĩa Lộc','40'),
('17827','Xã Nghi Lộc','40'),
('17857','Xã Phúc Lộc','40'),
('17878','Xã Đông Lộc','40'),
('17866','Xã Trung Lộc','40'),
('17842','Xã Thần Lĩnh','40'),
('17833','Xã Hải Lộc','40'),
('17854','Xã Văn Kiều','40'),
('16738','Xã Quế Phong','40'),
('16750','Xã Tiền Phong','40'),
('16756','Xã Tri Lễ','40'),
('16774','Xã Mường Quàng','40'),
('16744','Xã Thông Thụ','40'),
('16777','Xã Quỳ Châu','40'),
('16792','Xã Châu Tiến','40'),
('16801','Xã Hùng Chân','40'),
('16804','Xã Châu Bình','40'),
('17035','Xã Quỳ Hợp','40'),
('17059','Xã Tam Hợp','40'),
('17056','Xã Châu Lộc','40'),
('17044','Xã Châu Hồng','40'),
('17077','Xã Mường Ham','40'),
('17089','Xã Mường Chọng','40'),
('17071','Xã Minh Hợp','40'),
('17179','Xã Quỳnh Lưu','40'),
('17143','Xã Quỳnh Văn','40'),
('17176','Xã Quỳnh Anh','40'),
('17149','Xã Quỳnh Tam','40'),
('17212','Xã Quỳnh Phú','40'),
('17170','Xã Quỳnh Sơn','40'),
('17224','Xã Quỳnh Thắng','40'),
('17266','Xã Tân Kỳ','40'),
('17272','Xã Tân Phú','40'),
('17305','Xã Tân An','40'),
('17284','Xã Nghĩa Đồng','40'),
('17278','Xã Giai Xuân','40'),
('17326','Xã Nghĩa Hành','40'),
('17287','Xã Tiên Đồng','40'),
('16939','Phường Thái Hòa','40'),
('17011','Phường Tây Hiếu','40'),
('17017','Xã Đông Hiếu','40'),
('17728','Xã Cát Ngạn','40'),
('17743','Xã Tam Đồng','40'),
('17722','Xã Hạnh Lâm','40'),
('17759','Xã Sơn Lâm','40'),
('17770','Xã Hoa Quân','40'),
('17791','Xã Kim Bảng','40'),
('17818','Xã Bích Hào','40'),
('17713','Xã Đại Đồng','40'),
('17779','Xã Xuân Lâm','40'),
('16933','Xã Tam Quang','40'),
('16936','Xã Tam Thái','40'),
('16876','Xã Tương Dương','40'),
('16906','Xã Lượng Minh','40'),
('16912','Xã Yên Na','40'),
('16909','Xã Yên Hòa','40'),
('16903','Xã Nga My','40'),
('16885','Xã Hữu Khuông','40'),
('16882','Xã Nhôn Mai','40'),
('16690','Phường Trường Vinh','40'),
('16681','Phường Thành Vinh','40'),
('17920','Phường Vinh Hưng','40'),
('16702','Phường Vinh Phú','40'),
('16708','Phường Vinh Lộc','40'),
('16732','Phường Cửa Lò','40'),
('17506','Xã Yên Thành','40'),
('17569','Xã Quan Thành','40'),
('17605','Xã Hợp Minh','40'),
('17611','Xã Vân Tụ','40'),
('17560','Xã Vân Du','40'),
('17521','Xã Quang Đồng','40'),
('17524','Xã Giai Lạc','40'),
('17515','Xã Bình Minh','40'),
('17530','Xã Đông Thành','40');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('18754','Phường Sông Trí','42'),
('18781','Phường Hải Ninh','42'),
('18832','Phường Hoành Sơn','42'),
('18823','Phường Vũng Áng','42'),
('18766','Xã Kỳ Xuân','42'),
('18775','Xã Kỳ Anh','42'),
('18814','Xã Kỳ Hoa','42'),
('18787','Xã Kỳ Văn','42'),
('18790','Xã Kỳ Khang','42'),
('18838','Xã Kỳ Lạc','42'),
('18844','Xã Kỳ Thượng','42'),
('18673','Xã Cẩm Xuyên','42'),
('18676','Xã Thiên Cầm','42'),
('18739','Xã Cẩm Duệ','42'),
('18736','Xã Cẩm Hưng','42'),
('18748','Xã Cẩm Lạc','42'),
('18742','Xã Cẩm Trung','42'),
('18682','Xã Yên Hòa','42'),
('18073','Phường Thành Sen','42'),
('18100','Phường Trần Phú','42'),
('18652','Phường Hà Huy Tập','42'),
('18628','Xã Thạch Lạc','42'),
('18619','Xã Đồng Tiến','42'),
('18604','Xã Thạch Khê','42'),
('18685','Xã Cẩm Bình','42'),
('18562','Xã Thạch Hà','42'),
('18634','Xã Toàn Lưu','42'),
('18601','Xã Việt Xuyên','42'),
('18586','Xã Đông Kinh','42'),
('18667','Xã Thạch Xuân','42'),
('18568','Xã Lộc Hà','42'),
('18409','Xã Hồng Lộc','42'),
('18583','Xã Mai Phụ','42'),
('18406','Xã Can Lộc','42'),
('18418','Xã Tùng Lộc','42'),
('18466','Xã Gia Hanh','42'),
('18436','Xã Trường Lưu','42'),
('18481','Xã Xuân Lộc','42'),
('18484','Xã Đồng Lộc','42'),
('18115','Phường Bắc Hồng Lĩnh','42'),
('18118','Phường Nam Hồng Lĩnh','42'),
('18373','Xã Tiên Điền','42'),
('18352','Xã Nghi Xuân','42'),
('18394','Xã Cổ Đạm','42'),
('18364','Xã Đan Hải','42'),
('18229','Xã Đức Thọ','42'),
('18262','Xã Đức Quang','42'),
('18304','Xã Đức Đồng','42'),
('18277','Xã Đức Thịnh','42'),
('18244','Xã Đức Minh','42'),
('18133','Xã Hương Sơn','42'),
('18172','Xã Sơn Tây','42'),
('18202','Xã Tứ Mỹ','42'),
('18184','Xã Sơn Giang','42'),
('18163','Xã Sơn Tiến','42'),
('18160','Xã Sơn Hồng','42'),
('18223','Xã Kim Hoa','42'),
('18313','Xã Vũ Quang','42'),
('18322','Xã Mai Hoa','42'),
('18328','Xã Thượng Đức','42'),
('18496','Xã Hương Khê','42'),
('18532','Xã Hương Phố','42'),
('18550','Xã Hương Đô','42'),
('18502','Xã Hà Linh','42'),
('18523','Xã Hương Bình','42'),
('18547','Xã Phúc Trạch','42'),
('18544','Xã Hương Xuân','42'),
('18196','Xã Sơn Kim 1','42'),
('18199','Xã Sơn Kim 2','42');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('18880','Phường Đồng Hới','44'),
('18859','Phường Đồng Thuận','44'),
('18871','Phường Đồng Sơn','44'),
('19093','Xã Nam Gianh','44'),
('19075','Xã Nam Ba Đồn','44'),
('19009','Phường Ba Đồn','44'),
('19066','Phường Bắc Gianh','44'),
('18904','Xã Dân Hóa','44'),
('18922','Xã Kim Điền','44'),
('18943','Xã Kim Phú','44'),
('18901','Xã Minh Hóa','44'),
('18919','Xã Tân Thành','44'),
('18958','Xã Tuyên Lâm','44'),
('18952','Xã Tuyên Sơn','44'),
('18949','Xã Đồng Lê','44'),
('18985','Xã Tuyên Phú','44'),
('18991','Xã Tuyên Bình','44'),
('18997','Xã Tuyên Hóa','44'),
('19051','Xã Tân Gianh','44'),
('19030','Xã Trung Thuần','44'),
('19057','Xã Quảng Trạch','44'),
('19033','Xã Hòa Trạch','44'),
('19021','Xã Phú Trạch','44'),
('19147','Xã Thượng Trạch','44'),
('19138','Xã Phong Nha','44'),
('19126','Xã Bắc Trạch','44'),
('19159','Xã Đông Trạch','44'),
('19111','Xã Hoàn Lão','44'),
('19141','Xã Bố Trạch','44'),
('19198','Xã Nam Trạch','44'),
('19207','Xã Quảng Ninh','44'),
('19225','Xã Ninh Châu','44'),
('19237','Xã Trường Ninh','44'),
('19204','Xã Trường Sơn','44'),
('19249','Xã Lệ Thủy','44'),
('19255','Xã Cam Hồng','44'),
('19288','Xã Sen Ngư','44'),
('19291','Xã Tân Mỹ','44'),
('19309','Xã Trường Phú','44'),
('19246','Xã Lệ Ninh','44'),
('19318','Xã Kim Ngân','44'),
('19333','Phường Đông Hà','44'),
('19351','Phường Nam Đông Hà','44'),
('19360','Phường Quảng Trị','44'),
('19363','Xã Vĩnh Linh','44'),
('19414','Xã Cửa Tùng','44'),
('19372','Xã Vĩnh Hoàng','44'),
('19405','Xã Vĩnh Thủy','44'),
('19366','Xã Bến Quan','44'),
('19537','Xã Cồn Tiên','44'),
('19496','Xã Cửa Việt','44'),
('19495','Xã Gio Linh','44'),
('19501','Xã Bến Hải','44'),
('19435','Xã Hướng Lập','44'),
('19441','Xã Hướng Phùng','44'),
('19429','Xã Khe Sanh','44'),
('19462','Xã Tân Lập','44'),
('19432','Xã Lao Bảo','44'),
('19489','Xã Lìa','44'),
('19483','Xã A Dơi','44'),
('19594','Xã La Lay','44'),
('19588','Xã Tà Rụt','44'),
('19564','Xã Đakrông','44'),
('19567','Xã Ba Lòng','44'),
('19555','Xã Hướng Hiệp','44'),
('19597','Xã Cam Lộ','44'),
('19603','Xã Hiếu Giang','44'),
('19624','Xã Triệu Phong','44'),
('19669','Xã Ái Tử','44'),
('19645','Xã Triệu Bình','44'),
('19654','Xã Triệu Cơ','44'),
('19639','Xã Nam Cửa Việt','44'),
('19681','Xã Diên Sanh','44'),
('19741','Xã Mỹ Thủy','44'),
('19702','Xã Hải Lăng','44'),
('19699','Xã Vĩnh Định','44'),
('19735','Xã Nam Hải Lăng','44'),
('19742','Đặc khu Cồn Cỏ','44');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('19900','Phường Thuận An','46'),
('20014','Phường Hóa Châu','46'),
('19930','Phường Mỹ Thượng','46'),
('19777','Phường Vỹ Dạ','46'),
('19789','Phường Thuận Hóa','46'),
('19815','Phường An Cựu','46'),
('19813','Phường Thủy Xuân','46'),
('19774','Phường Kim Long','46'),
('19804','Phường Hương An','46'),
('19753','Phường Phú Xuân','46'),
('19996','Phường Hương Trà','46'),
('20017','Phường Kim Trà','46'),
('19969','Phường Thanh Thủy','46'),
('19975','Phường Hương Thủy','46'),
('19960','Phường Phú Bài','46'),
('19819','Phường Phong Điền','46'),
('19858','Phường Phong Thái','46'),
('19831','Phường Phong Dinh','46'),
('19828','Phường Phong Phú','46'),
('19873','Phường Phong Quảng','46'),
('19885','Xã Đan Điền','46'),
('19867','Xã Quảng Điền','46'),
('19945','Xã Phú Vinh','46'),
('19918','Xã Phú Hồ','46'),
('19942','Xã Phú Vang','46'),
('20122','Xã Vinh Lộc','46'),
('20131','Xã Hưng Lộc','46'),
('20140','Xã Lộc An','46'),
('20107','Xã Phú Lộc','46'),
('20137','Xã Chân Mây - Lăng Cô','46'),
('20182','Xã Long Quảng','46'),
('20179','Xã Nam Đông','46'),
('20161','Xã Khe Tre','46'),
('20035','Xã Bình Điền','46'),
('20056','Xã A Lưới 1','46'),
('20044','Xã A Lưới 2','46'),
('20071','Xã A Lưới 3','46'),
('20101','Xã A Lưới 4','46'),
('20050','Xã A Lưới 5','46'),
('19909','Phường Dương Nỗ','46');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('20242','Phường Hải Châu','48'),
('20257','Phường Hòa Cường','48'),
('20209','Phường Thanh Khê','48'),
('20305','Phường An Khê','48'),
('20275','Phường An Hải','48'),
('20263','Phường Sơn Trà','48'),
('20285','Phường Ngũ Hành Sơn','48'),
('20200','Phường Hòa Khánh','48'),
('20194','Phường Hải Vân','48'),
('20197','Phường Liên Chiểu','48'),
('20260','Phường Cẩm Lệ','48'),
('20314','Phường Hòa Xuân','48'),
('20320','Xã Hòa Vang','48'),
('20332','Xã Hòa Tiến','48'),
('20308','Xã Bà Nà','48'),
('20333','Đặc khu Hoàng Sa','48'),
('20965','Xã Núi Thành','48'),
('21004','Xã Tam Mỹ','48'),
('20984','Xã Tam Anh','48'),
('20977','Xã Đức Phú','48'),
('20971','Xã Tam Xuân','48'),
('20992','Xã Tam Hải','48'),
('20341','Phường Tam Kỳ','48'),
('20356','Phường Quảng Phú','48'),
('20350','Phường Hương Trà','48'),
('20335','Phường Bàn Thạch','48'),
('20380','Xã Tây Hồ','48'),
('20364','Xã Chiên Đàn','48'),
('20392','Xã Phú Ninh','48'),
('20875','Xã Lãnh Ngọc','48'),
('20854','Xã Tiên Phước','48'),
('20878','Xã Thạnh Bình','48'),
('20857','Xã Sơn Cẩm Hà','48'),
('20908','Xã Trà Liên','48'),
('20929','Xã Trà Giáp','48'),
('20923','Xã Trà Tân','48'),
('20920','Xã Trà Đốc','48'),
('20900','Xã Trà My','48'),
('20944','Xã Nam Trà My','48'),
('20941','Xã Trà Tập','48'),
('20959','Xã Trà Vân','48'),
('20950','Xã Trà Linh','48'),
('20938','Xã Trà Leng','48'),
('20791','Xã Thăng Bình','48'),
('20794','Xã Thăng An','48'),
('20836','Xã Thăng Trường','48'),
('20848','Xã Thăng Điền','48'),
('20827','Xã Thăng Phú','48'),
('20818','Xã Đồng Dương','48'),
('20662','Xã Quế Sơn Trung','48'),
('20641','Xã Quế Sơn','48'),
('20650','Xã Xuân Phú','48'),
('20656','Xã Nông Sơn','48'),
('20669','Xã Quế Phước','48'),
('20635','Xã Duy Nghĩa','48'),
('20599','Xã Nam Phước','48'),
('20623','Xã Duy Xuyên','48'),
('20611','Xã Thu Bồn','48'),
('20551','Phường Điện Bàn','48'),
('20579','Phường Điện Bàn Đông','48'),
('20575','Phường An Thắng','48'),
('20557','Phường Điện Bàn Bắc','48'),
('20569','Xã Điện Bàn Tây','48'),
('20587','Xã Gò Nổi','48'),
('20410','Phường Hội An','48'),
('20413','Phường Hội An Đông','48'),
('20401','Phường Hội An Tây','48'),
('20434','Xã Tân Hiệp','48'),
('20500','Xã Đại Lộc','48'),
('20515','Xã Hà Nha','48'),
('20506','Xã Thượng Đức','48'),
('20539','Xã Vu Gia','48'),
('20542','Xã Phú Thuận','48'),
('20695','Xã Thạnh Mỹ','48'),
('20710','Xã Bến Giằng','48'),
('20707','Xã Nam Giang','48'),
('20716','Xã Đắc Pring','48'),
('20704','Xã La Dêê','48'),
('20698','Xã La Êê','48'),
('20485','Xã Sông Vàng','48'),
('20476','Xã Sông Kôn','48'),
('20467','Xã Đông Giang','48'),
('20494','Xã Bến Hiên','48'),
('20458','Xã Avương','48'),
('20455','Xã Tây Giang','48'),
('20443','Xã Hùng Sơn','48'),
('20779','Xã Hiệp Đức','48'),
('20767','Xã Việt An','48'),
('20770','Xã Phước Trà','48'),
('20722','Xã Khâm Đức','48'),
('20734','Xã Phước Năng','48'),
('20740','Xã Phước Chánh','48'),
('20752','Xã Phước Thành','48'),
('20728','Xã Phước Hiệp','48');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('21211','Xã Tịnh Khê','51'),
('21172','Phường Trương Quang Trọng','51'),
('21034','Xã An Phú','51'),
('21025','Phường Cẩm Thành','51'),
('21028','Phường Nghĩa Lộ','51'),
('21451','Phường Trà Câu','51'),
('21457','Xã Nguyễn Nghiêm','51'),
('21439','Phường Đức Phổ','51'),
('21472','Xã Khánh Cường','51'),
('21478','Phường Sa Huỳnh','51'),
('21085','Xã Bình Minh','51'),
('21100','Xã Bình Chương','51'),
('21040','Xã Bình Sơn','51'),
('21061','Xã Vạn Tường','51'),
('21109','Xã Đông Sơn','51'),
('21196','Xã Trường Giang','51'),
('21205','Xã Ba Gia','51'),
('21220','Xã Sơn Tịnh','51'),
('21181','Xã Thọ Phong','51'),
('21235','Xã Tư Nghĩa','51'),
('21238','Xã Vệ Giang','51'),
('21250','Xã Nghĩa Giang','51'),
('21244','Xã Trà Giang','51'),
('21364','Xã Nghĩa Hành','51'),
('21385','Xã Đình Cương','51'),
('21388','Xã Thiện Tín','51'),
('21370','Xã Phước Giang','51'),
('21409','Xã Long Phụng','51'),
('21421','Xã Mỏ Cày','51'),
('21400','Xã Mộ Đức','51'),
('21433','Xã Lân Phong','51'),
('21115','Xã Trà Bồng','51'),
('21127','Xã Đông Trà Bồng','51'),
('21154','Xã Tây Trà','51'),
('21124','Xã Thanh Bồng','51'),
('21136','Xã Cà Đam','51'),
('21157','Xã Tây Trà Bồng','51'),
('21292','Xã Sơn Hạ','51'),
('21307','Xã Sơn Linh','51'),
('21289','Xã Sơn Hà','51'),
('21319','Xã Sơn Thủy','51'),
('21325','Xã Sơn Kỳ','51'),
('21340','Xã Sơn Tây','51'),
('21334','Xã Sơn Tây Thượng','51'),
('21343','Xã Sơn Tây Hạ','51'),
('21361','Xã Minh Long','51'),
('21349','Xã Sơn Mai','51'),
('21529','Xã Ba Vì','51'),
('21523','Xã Ba Tô','51'),
('21499','Xã Ba Dinh','51'),
('21484','Xã Ba Tơ','51'),
('21490','Xã Ba Vinh','51'),
('21496','Xã Ba Động','51'),
('21520','Xã Đặng Thùy Trâm','51'),
('21538','Xã Ba Xa','51'),
('21548','Đặc khu Lý Sơn','51'),
('23293','Phường Kon Tum','51'),
('23284','Phường Đăk Cấm','51'),
('23302','Phường Đăk Bla','51'),
('23317','Xã Ngọk Bay','51'),
('23326','Xã Ia Chim','51'),
('23332','Xã Đăk Rơ Wa','51'),
('23504','Xã Đăk Pxi','51'),
('23512','Xã Đăk Mar','51'),
('23510','Xã Đăk Ui','51'),
('23515','Xã Ngọk Réo','51'),
('23500','Xã Đăk Hà','51'),
('23428','Xã Ngọk Tụ','51'),
('23401','Xã Đăk Tô','51'),
('23430','Xã Kon Đào','51'),
('23416','Xã Đăk Sao','51'),
('23419','Xã Đăk Tờ Kan','51'),
('23425','Xã Tu Mơ Rông','51'),
('23446','Xã Măng Ri','51'),
('23377','Xã Bờ Y','51'),
('23392','Xã Sa Loong','51'),
('23383','Xã Dục Nông','51'),
('23356','Xã Xốp','51'),
('23365','Xã Ngọc Linh','51'),
('23344','Xã Đăk Plô','51'),
('23341','Xã Đăk Pék','51'),
('23374','Xã Đăk Môn','51'),
('23527','Xã Sa Thầy','51'),
('23534','Xã Sa Bình','51'),
('23548','Xã Ya Ly','51'),
('23538','Xã Ia Tơi','51'),
('23485','Xã Đăk Kôi','51'),
('23497','Xã Kon Braih','51'),
('23479','Xã Đăk Rve','51'),
('23473','Xã Măng Đen','51'),
('23455','Xã Măng Bút','51'),
('23476','Xã Kon Plông','51'),
('23368','Xã Đăk Long','51'),
('23530','Xã Rờ Kơi','51'),
('23536','Xã Mô Rai','51'),
('23535','Xã Ia Đal','51');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('21583','Phường Quy Nhơn','52'),
('21601','Phường Quy Nhơn Đông','52'),
('21589','Phường Quy Nhơn Tây','52'),
('21592','Phường Quy Nhơn Nam','52'),
('21553','Phường Quy Nhơn Bắc','52'),
('21907','Phường Bình Định','52'),
('21910','Phường An Nhơn','52'),
('21934','Phường An Nhơn Đông','52'),
('21943','Phường An Nhơn Nam','52'),
('21925','Phường An Nhơn Bắc','52'),
('21940','Xã An Nhơn Tây','52'),
('21640','Phường Bồng Sơn','52'),
('21664','Phường Hoài Nhơn','52'),
('21637','Phường Tam Quan','52'),
('21670','Phường Hoài Nhơn Đông','52'),
('21661','Phường Hoài Nhơn Tây','52'),
('21673','Phường Hoài Nhơn Nam','52'),
('21655','Phường Hoài Nhơn Bắc','52'),
('21853','Xã Phù Cát','52'),
('21892','Xã Xuân An','52'),
('21901','Xã Ngô Mây','52'),
('21880','Xã Cát Tiến','52'),
('21859','Xã Đề Gi','52'),
('21871','Xã Hòa Hội','52'),
('21868','Xã Hội Sơn','52'),
('21730','Xã Phù Mỹ','52'),
('21769','Xã An Lương','52'),
('21733','Xã Bình Dương','52'),
('21751','Xã Phù Mỹ Đông','52'),
('21757','Xã Phù Mỹ Tây','52'),
('21775','Xã Phù Mỹ Nam','52'),
('21739','Xã Phù Mỹ Bắc','52'),
('21952','Xã Tuy Phước','52'),
('21970','Xã Tuy Phước Đông','52'),
('21985','Xã Tuy Phước Tây','52'),
('21964','Xã Tuy Phước Bắc','52'),
('21808','Xã Tây Sơn','52'),
('21820','Xã Bình Khê','52'),
('21835','Xã Bình Phú','52'),
('21817','Xã Bình Hiệp','52'),
('21829','Xã Bình An','52'),
('21688','Xã Hoài Ân','52'),
('21715','Xã Ân Tường','52'),
('21727','Xã Kim Sơn','52'),
('21703','Xã Vạn Đức','52'),
('21697','Xã Ân Hảo','52'),
('21994','Xã Vân Canh','52'),
('22006','Xã Canh Vinh','52'),
('21997','Xã Canh Liên','52'),
('21786','Xã Vĩnh Thạnh','52'),
('21796','Xã Vĩnh Thịnh','52'),
('21805','Xã Vĩnh Quang','52'),
('21787','Xã Vĩnh Sơn','52'),
('21628','Xã An Hòa','52'),
('21609','Xã An Lão','52'),
('21616','Xã An Vinh','52'),
('21622','Xã An Toàn','52'),
('23575','Phường Pleiku','52'),
('23586','Phường Hội Phú','52'),
('23584','Phường Thống Nhất','52'),
('23563','Phường Diên Hồng','52'),
('23602','Phường An Phú','52'),
('23590','Xã Biển Hồ','52'),
('23611','Xã Gào','52'),
('23734','Xã Ia Ly','52'),
('23722','Xã Chư Păh','52'),
('23728','Xã Ia Khươl','52'),
('23749','Xã Ia Phí','52'),
('23887','Xã Chư Prông','52'),
('23896','Xã Bàu Cạn','52'),
('23911','Xã Ia Boòng','52'),
('23935','Xã Ia Lâu','52'),
('23926','Xã Ia Pia','52'),
('23908','Xã Ia Tôr','52'),
('23941','Xã Chư Sê','52'),
('23947','Xã Bờ Ngoong','52'),
('23977','Xã Ia Ko','52'),
('23954','Xã Al Bá','52'),
('23942','Xã Chư Pưh','52'),
('23986','Xã Ia Le','52'),
('23971','Xã Ia Hrú','52'),
('23617','Phường An Khê','52'),
('23614','Phường An Bình','52'),
('23629','Xã Cửu An','52'),
('23995','Xã Đak Pơ','52'),
('24007','Xã Ya Hội','52'),
('23638','Xã Kbang','52'),
('23674','Xã Kông Bơ La','52'),
('23668','Xã Tơ Tung','52'),
('23647','Xã Sơn Lang','52'),
('23644','Xã Đak Rong','52'),
('23824','Xã Kông Chro','52'),
('23833','Xã Ya Ma','52'),
('23830','Xã Chư Krey','52'),
('23839','Xã SRó','52'),
('23842','Xã Đăk Song','52'),
('23851','Xã Chơ Long','52'),
('24044','Phường Ayun Pa','52'),
('24065','Xã Ia Rbol','52'),
('24073','Xã Ia Sao','52'),
('24043','Xã Phú Thiện','52'),
('24049','Xã Chư A Thai','52'),
('24061','Xã Ia Hiao','52'),
('24013','Xã Pờ Tó','52'),
('24022','Xã Ia Pa','52'),
('24028','Xã Ia Tul','52'),
('24076','Xã Phú Túc','52'),
('24100','Xã Ia Dreh','52'),
('24112','Xã Ia Rsai','52'),
('24109','Xã Uar','52'),
('23677','Xã Đak Đoa','52'),
('23701','Xã Kon Gang','52'),
('23710','Xã Ia Băng','52'),
('23714','Xã KDang','52'),
('23683','Xã Đak Sơmei','52'),
('23794','Xã Mang Yang','52'),
('23812','Xã Lơ Pang','52'),
('23818','Xã Kon Chiêng','52'),
('23799','Xã Hra','52'),
('23798','Xã Ayun','52'),
('23764','Xã Ia Grai','52'),
('23776','Xã Ia Krái','52'),
('23767','Xã Ia Hrung','52'),
('23857','Xã Đức Cơ','52'),
('23869','Xã Ia Dơk','52'),
('23866','Xã Ia Krêl','52'),
('21607','Xã Nhơn Châu','52'),
('23917','Xã Ia Púch','52'),
('23737','Xã Ia Mơ','52'),
('23881','Xã Ia Pnôn','52'),
('23884','Xã Ia Nan','52'),
('23872','Xã Ia Dom','52'),
('23788','Xã Ia Chia','52'),
('23782','Xã Ia O','52'),
('23650','Xã Krong','52');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('22366','Phường Nha Trang','56'),
('22333','Phường Bắc Nha Trang','56'),
('22390','Phường Tây Nha Trang','56'),
('22402','Phường Nam Nha Trang','56'),
('22411','Phường Bắc Cam Ranh','56'),
('22420','Phường Cam Ranh','56'),
('22432','Phường Cam Linh','56'),
('22423','Phường Ba Ngòi','56'),
('22480','Xã Nam Cam Ranh','56'),
('22546','Xã Bắc Ninh Hòa','56'),
('22528','Phường Ninh Hòa','56'),
('22576','Xã Tân Định','56'),
('22561','Phường Đông Ninh Hòa','56'),
('22591','Phường Hòa Thắng','56'),
('22597','Xã Nam Ninh Hòa','56'),
('22552','Xã Tây Ninh Hòa','56'),
('22558','Xã Hòa Trí','56'),
('22504','Xã Đại Lãnh','56'),
('22498','Xã Tu Bông','56'),
('22516','Xã Vạn Thắng','56'),
('22489','Xã Vạn Ninh','56'),
('22525','Xã Vạn Hưng','56'),
('22651','Xã Diên Khánh','56'),
('22678','Xã Diên Lạc','56'),
('22657','Xã Diên Điền','56'),
('22660','Xã Diên Lâm','56'),
('22672','Xã Diên Thọ','56'),
('22702','Xã Suối Hiệp','56'),
('22453','Xã Cam Lâm','56'),
('22708','Xã Suối Dầu','56'),
('22435','Xã Cam Hiệp','56'),
('22465','Xã Cam An','56'),
('22615','Xã Bắc Khánh Vĩnh','56'),
('22612','Xã Trung Khánh Vĩnh','56'),
('22624','Xã Tây Khánh Vĩnh','56'),
('22648','Xã Nam Khánh Vĩnh','56'),
('22609','Xã Khánh Vĩnh','56'),
('22714','Xã Khánh Sơn','56'),
('22720','Xã Tây Khánh Sơn','56'),
('22732','Xã Đông Khánh Sơn','56'),
('22736','Đặc khu Trường Sa','56'),
('22759','Phường Phan Rang','56'),
('22780','Phường Đông Hải','56'),
('22834','Phường Ninh Chử','56'),
('22741','Phường Bảo An','56'),
('22738','Phường Đô Vinh','56'),
('22870','Xã Ninh Phước','56'),
('22891','Xã Phước Hữu','56'),
('22873','Xã Phước Hậu','56'),
('22897','Xã Thuận Nam','56'),
('22909','Xã Cà Ná','56'),
('22900','Xã Phước Hà','56'),
('22888','Xã Phước Dinh','56'),
('22852','Xã Ninh Hải','56'),
('22861','Xã Xuân Hải','56'),
('22846','Xã Vĩnh Hải','56'),
('22849','Xã Thuận Bắc','56'),
('22840','Xã Công Hải','56'),
('22810','Xã Ninh Sơn','56'),
('22813','Xã Lâm Sơn','56'),
('22828','Xã Anh Dũng','56'),
('22822','Xã Mỹ Sơn','56'),
('22801','Xã Bác Ái Đông','56'),
('22795','Xã Bác Ái','56'),
('22786','Xã Bác Ái Tây','56');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('24175','Xã Hòa Phú','66'),
('24133','Phường Buôn Ma Thuột','66'),
('24163','Phường Tân An','66'),
('24121','Phường Tân Lập','66'),
('24154','Phường Thành Nhất','66'),
('24169','Phường Ea Kao','66'),
('24328','Xã Ea Drông','66'),
('24305','Phường Buôn Hồ','66'),
('24340','Phường Cư Bao','66'),
('24211','Xã Ea Súp','66'),
('24217','Xã Ea Rốk','66'),
('24229','Xã Ea Bung','66'),
('24221','Xã Ia Rvê','66'),
('24214','Xã Ia Lốp','66'),
('24241','Xã Ea Wer','66'),
('24250','Xã Ea Nuôl','66'),
('24235','Xã Buôn Đôn','66'),
('24265','Xã Ea Kiết','66'),
('24286','Xã Ea M’Droh','66'),
('24259','Xã Quảng Phú','66'),
('24301','Xã Cuôr Đăng','66'),
('24280','Xã Cư M’gar','66'),
('24277','Xã Ea Tul','66'),
('24316','Xã Pơng Drang','66'),
('24310','Xã Krông Búk','66'),
('24313','Xã Cư Pơng','66'),
('24208','Xã Ea Khăl','66'),
('24181','Xã Ea Drăng','66'),
('24193','Xã Ea Wy','66'),
('24184','Xã Ea H’Leo','66'),
('24187','Xã Ea Hiao','66'),
('24343','Xã Krông Năng','66'),
('24346','Xã Dliê Ya','66'),
('24352','Xã Tam Giang','66'),
('24364','Xã Phú Xuân','66'),
('24490','Xã Krông Pắc','66'),
('24505','Xã Ea Knuếc','66'),
('24526','Xã Tân Tiến','66'),
('24502','Xã Ea Phê','66'),
('24496','Xã Ea Kly','66'),
('24529','Xã Vụ Bổn','66'),
('24373','Xã Ea Kar','66'),
('24403','Xã Ea Ô','66'),
('24376','Xã Ea Knốp','66'),
('24406','Xã Cư Yang','66'),
('24400','Xã Ea Păl','66'),
('24412','Xã M’Drắk','66'),
('24433','Xã Ea Riêng','66'),
('24436','Xã Cư M’ta','66'),
('24444','Xã Krông Á','66'),
('24415','Xã Cư Prao','66'),
('24445','Xã Ea Trang','66'),
('24472','Xã Hòa Sơn','66'),
('24454','Xã Dang Kang','66'),
('24448','Xã Krông Bông','66'),
('24484','Xã Yang Mao','66'),
('24478','Xã Cư Pui','66'),
('24580','Xã Liên Sơn Lắk','66'),
('24595','Xã Đắk Liêng','66'),
('24607','Xã Nam Ka','66'),
('24598','Xã Đắk Phơi','66'),
('24604','Xã Krông Nô','66'),
('24540','Xã Ea Ning','66'),
('24561','Xã Dray Bhăng','66'),
('24544','Xã Ea Ktur','66'),
('24538','Xã Krông Ana','66'),
('24568','Xã Dur Kmăl','66'),
('24559','Xã Ea Na','66'),
('22015','Phường Tuy Hòa','66'),
('22240','Phường Phú Yên','66'),
('22045','Phường Bình Kiến','66'),
('22075','Xã Xuân Thọ','66'),
('22060','Xã Xuân Cảnh','66'),
('22057','Xã Xuân Lộc','66'),
('22076','Phường Xuân Đài','66'),
('22051','Phường Sông Cầu','66'),
('22291','Xã Hòa Xuân','66'),
('22258','Phường Đông Hòa','66'),
('22261','Phường Hòa Hiệp','66'),
('22114','Xã Tuy An Bắc','66'),
('22120','Xã Tuy An Đông','66'),
('22147','Xã Ô Loan','66'),
('22153','Xã Tuy An Nam','66'),
('22132','Xã Tuy An Tây','66'),
('22319','Xã Phú Hòa 1','66'),
('22303','Xã Phú Hòa 2','66'),
('22255','Xã Tây Hòa','66'),
('22276','Xã Hòa Thịnh','66'),
('22285','Xã Hòa Mỹ','66'),
('22250','Xã Sơn Thành','66'),
('22165','Xã Sơn Hòa','66'),
('22177','Xã Vân Hòa','66'),
('22171','Xã Tây Sơn','66'),
('22192','Xã Suối Trai','66'),
('22237','Xã Ea Ly','66'),
('22225','Xã Ea Bá','66'),
('22222','Xã Đức Bình','66'),
('22207','Xã Sông Hinh','66'),
('22090','Xã Xuân Lãnh','66'),
('22096','Xã Phú Mỡ','66'),
('22111','Xã Xuân Phước','66'),
('22081','Xã Đồng Xuân','66');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('24781','Phường Xuân Hương - Đà Lạt','68'),
('24787','Phường Cam Ly - Đà Lạt','68'),
('24778','Phường Lâm Viên - Đà Lạt','68'),
('24805','Phường Xuân Trường - Đà Lạt','68'),
('24846','Phường Lang Biang - Đà Lạt','68'),
('24823','Phường 1 Bảo Lộc','68'),
('24820','Phường 2 Bảo Lộc','68'),
('24841','Phường 3 Bảo Lộc','68'),
('24829','Phường B''Lao','68'),
('24848','Xã Lạc Dương','68'),
('24931','Xã Đơn Dương','68'),
('24943','Xã Ka Đô','68'),
('24955','Xã Quảng Lập','68'),
('24934','Xã D''Ran','68'),
('24967','Xã Hiệp Thạnh','68'),
('24958','Xã Đức Trọng','68'),
('24976','Xã Tân Hội','68'),
('24991','Xã Tà Hine','68'),
('24988','Xã Tà Năng','68'),
('24871','Xã Đinh Văn Lâm Hà','68'),
('24895','Xã Phú Sơn Lâm Hà','68'),
('24883','Xã Nam Hà Lâm Hà','68'),
('24868','Xã Nam Ban Lâm Hà','68'),
('24916','Xã Tân Hà Lâm Hà','68'),
('24907','Xã Phúc Thọ Lâm Hà','68'),
('24886','Xã Đam Rông 1','68'),
('24877','Xã Đam Rông 2','68'),
('24875','Xã Đam Rông 3','68'),
('24853','Xã Đam Rông 4','68'),
('25000','Xã Di Linh','68'),
('25036','Xã Hòa Ninh','68'),
('25042','Xã Hòa Bắc','68'),
('25007','Xã Đinh Trang Thượng','68'),
('25018','Xã Bảo Thuận','68'),
('25051','Xã Sơn Điền','68'),
('25015','Xã Gia Hiệp','68'),
('25054','Xã Bảo Lâm 1','68'),
('25084','Xã Bảo Lâm 2','68'),
('25093','Xã Bảo Lâm 3','68'),
('25063','Xã Bảo Lâm 4','68'),
('25057','Xã Bảo Lâm 5','68'),
('25099','Xã Đạ Huoai','68'),
('25105','Xã Đạ Huoai 2','68'),
('25114','Xã Đạ Huoai 3','68'),
('25126','Xã Đạ Tẻh','68'),
('25138','Xã Đạ Tẻh 2','68'),
('25135','Xã Đạ Tẻh 3','68'),
('25159','Xã Cát Tiên','68'),
('25180','Xã Cát Tiên 2','68'),
('25162','Xã Cát Tiên 3','68'),
('22933','Phường Hàm Thắng','68'),
('22960','Phường Bình Thuận','68'),
('22918','Phường Mũi Né','68'),
('22924','Phường Phú Thủy','68'),
('22945','Phường Phan Thiết','68'),
('22954','Phường Tiến Thành','68'),
('23235','Phường La Gi','68'),
('23231','Phường Phước Hội','68'),
('22963','Xã Tuyên Quang','68'),
('23246','Xã Tân Hải','68'),
('22981','Xã Vĩnh Hảo','68'),
('22969','Xã Liên Hương','68'),
('22978','Xã Tuy Phong','68'),
('22972','Xã Phan Rí Cửa','68'),
('23005','Xã Bắc Bình','68'),
('23041','Xã Hồng Thái','68'),
('23020','Xã Hải Ninh','68'),
('23008','Xã Phan Sơn','68'),
('23023','Xã Sông Lũy','68'),
('23032','Xã Lương Sơn','68'),
('23053','Xã Hòa Thắng','68'),
('23074','Xã Đông Giang','68'),
('23065','Xã La Dạ','68'),
('23089','Xã Hàm Thuận Bắc','68'),
('23059','Xã Hàm Thuận','68'),
('23086','Xã Hồng Sơn','68'),
('23095','Xã Hàm Liêm','68'),
('23122','Xã Hàm Thạnh','68'),
('23128','Xã Hàm Kiệm','68'),
('23143','Xã Tân Thành','68'),
('23110','Xã Hàm Thuận Nam','68'),
('23134','Xã Tân Lập','68'),
('23230','Xã Tân Minh','68'),
('23236','Xã Hàm Tân','68'),
('23266','Xã Sơn Mỹ','68'),
('23152','Xã Bắc Ruộng','68'),
('23158','Xã Nghị Đức','68'),
('23173','Xã Đồng Kho','68'),
('23149','Xã Tánh Linh','68'),
('23188','Xã Suối Kiết','68'),
('23200','Xã Nam Thành','68'),
('23191','Xã Đức Linh','68'),
('23194','Xã Hoài Đức','68'),
('23227','Xã Trà Tân','68'),
('23272','Đặc khu Phú Quý','68'),
('24611','Phường Bắc Gia Nghĩa','68'),
('24615','Phường Nam Gia Nghĩa','68'),
('24617','Phường Đông Gia Nghĩa','68'),
('24646','Xã Đắk Wil','68'),
('24649','Xã Nam Dong','68'),
('24640','Xã Cư Jút','68'),
('24682','Xã Thuận An','68'),
('24664','Xã Đức Lập','68'),
('24670','Xã Đắk Mil','68'),
('24678','Xã Đắk Sắk','68'),
('24697','Xã Nam Đà','68'),
('24688','Xã Krông Nô','68'),
('24703','Xã Nâm Nung','68'),
('24712','Xã Quảng Phú','68'),
('24718','Xã Đắk Song','68'),
('24717','Xã Đức An','68'),
('24722','Xã Thuận Hạnh','68'),
('24730','Xã Trường Xuân','68'),
('24637','Xã Tà Đùng','68'),
('24631','Xã Quảng Khê','68'),
('24748','Xã Quảng Tân','68'),
('24739','Xã Tuy Đức','68'),
('24733','Xã Kiến Đức','68'),
('24751','Xã Nhân Cơ','68'),
('24760','Xã Quảng Tín','68'),
('24985','Xã Ninh Gia','68'),
('24620','Xã Quảng Hòa','68'),
('24616','Xã Quảng Sơn','68'),
('24736','Xã Quảng Trực','68');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('26068','Phường Biên Hòa','75'),
('26041','Phường Trấn Biên','75'),
('26017','Phường Tam Hiệp','75'),
('26020','Phường Long Bình','75'),
('25993','Phường Trảng Dài','75'),
('26005','Phường Hố Nai','75'),
('26380','Phường Long Hưng','75'),
('26491','Xã Đại Phước','75'),
('26485','Xã Nhơn Trạch','75'),
('26503','Xã Phước An','75'),
('26422','Xã Phước Thái','75'),
('26413','Xã Long Phước','75'),
('26389','Xã Bình An','75'),
('26368','Xã Long Thành','75'),
('26383','Xã An Phước','75'),
('26296','Xã An Viễn','75'),
('26278','Xã Bình Minh','75'),
('26248','Xã Trảng Bom','75'),
('26254','Xã Bàu Hàm','75'),
('26281','Xã Hưng Thịnh','75'),
('26326','Xã Dầu Giây','75'),
('26311','Xã Gia Kiệm','75'),
('26299','Xã Thống Nhất','75'),
('26089','Phường Bình Lộc','75'),
('26098','Phường Bảo Vinh','75'),
('26104','Phường Xuân Lập','75'),
('26080','Phường Long Khánh','75'),
('26113','Phường Hàng Gòn','75'),
('26332','Xã Xuân Quế','75'),
('26347','Xã Xuân Đường','75'),
('26341','Xã Cẩm Mỹ','75'),
('26362','Xã Sông Ray','75'),
('26359','Xã Xuân Đông','75'),
('26461','Xã Xuân Định','75'),
('26458','Xã Xuân Phú','75'),
('26425','Xã Xuân Lộc','75'),
('26446','Xã Xuân Hòa','75'),
('26434','Xã Xuân Thành','75'),
('26428','Xã Xuân Bắc','75'),
('26227','Xã La Ngà','75'),
('26206','Xã Định Quán','75'),
('26215','Xã Phú Vinh','75'),
('26221','Xã Phú Hòa','75'),
('26134','Xã Tà Lài','75'),
('26122','Xã Nam Cát Tiên','75'),
('26116','Xã Tân Phú','75'),
('26158','Xã Phú Lâm','75'),
('26170','Xã Trị An','75'),
('26179','Xã Tân An','75'),
('26188','Phường Tân Triều','75'),
('25441','Phường Minh Hưng','75'),
('25432','Phường Chơn Thành','75'),
('25450','Xã Nha Bích','75'),
('25351','Xã Tân Quan','75'),
('25345','Xã Tân Hưng','75'),
('25357','Xã Tân Khai','75'),
('25349','Xã Minh Đức','75'),
('25326','Phường Bình Long','75'),
('25333','Phường An Lộc','75'),
('25294','Xã Lộc Thành','75'),
('25270','Xã Lộc Ninh','75'),
('25303','Xã Lộc Hưng','75'),
('25279','Xã Lộc Tấn','75'),
('25280','Xã Lộc Thạnh','75'),
('25292','Xã Lộc Quang','75'),
('25318','Xã Tân Tiến','75'),
('25308','Xã Thiện Hưng','75'),
('25309','Xã Hưng Phước','75'),
('25267','Xã Phú Nghĩa','75'),
('25231','Xã Đa Kia','75'),
('25220','Phường Phước Bình','75'),
('25217','Phường Phước Long','75'),
('25246','Xã Bình Tân','75'),
('25255','Xã Long Hà','75'),
('25252','Xã Phú Riềng','75'),
('25261','Xã Phú Trung','75'),
('25210','Phường Đồng Xoài','75'),
('25195','Phường Bình Phước','75'),
('25387','Xã Thuận Lợi','75'),
('25390','Xã Đồng Tâm','75'),
('25378','Xã Tân Lợi','75'),
('25363','Xã Đồng Phú','75'),
('25420','Xã Phước Sơn','75'),
('25417','Xã Nghĩa Trung','75'),
('25396','Xã Bù Đăng','75'),
('25402','Xã Thọ Sơn','75'),
('25399','Xã Đak Nhau','75'),
('25405','Xã Bom Bo','75'),
('26374','Phường Tam Phước','75'),
('26377','Phường Phước Tân','75'),
('26209','Xã Thanh Sơn','75'),
('26119','Xã Đak Lua','75'),
('26173','Xã Phú Lý','75'),
('25222','Xã Bù Gia Mập','75'),
('25225','Xã Đăk Ơ','75');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('26506','Phường Vũng Tàu','79'),
('26526','Phường Tam Thắng','79'),
('26536','Phường Rạch Dừa','79'),
('26542','Phường Phước Thắng','79'),
('26560','Phường Bà Rịa','79'),
('26566','Phường Long Hương','79'),
('26704','Phường Phú Mỹ','79'),
('26572','Phường Tam Long','79'),
('26725','Phường Tân Thành','79'),
('26713','Phường Tân Phước','79'),
('26710','Phường Tân Hải','79'),
('26728','Xã Châu Pha','79'),
('26575','Xã Ngãi Giao','79'),
('26590','Xã Bình Giã','79'),
('26608','Xã Kim Long','79'),
('26596','Xã Châu Đức','79'),
('26584','Xã Xuân Sơn','79'),
('26617','Xã Nghĩa Thành','79'),
('26620','Xã Hồ Tràm','79'),
('26632','Xã Xuyên Mộc','79'),
('26641','Xã Hòa Hội','79'),
('26638','Xã Bàu Lâm','79'),
('26686','Xã Phước Hải','79'),
('26662','Xã Long Hải','79'),
('26680','Xã Đất Đỏ','79'),
('26659','Xã Long Điền','79'),
('26732','Đặc khu Côn Đảo','79'),
('25951','Phường Đông Hòa','79'),
('25942','Phường Dĩ An','79'),
('25945','Phường Tân Đông Hiệp','79'),
('25978','Phường Thuận An','79'),
('25969','Phường Thuận Giao','79'),
('25987','Phường Bình Hòa','79'),
('25966','Phường Lái Thiêu','79'),
('25975','Phường An Phú','79'),
('25760','Phường Bình Dương','79'),
('25771','Phường Chánh Hiệp','79'),
('25747','Phường Thủ Dầu Một','79'),
('25750','Phường Phú Lợi','79'),
('25912','Phường Vĩnh Tân','79'),
('25915','Phường Bình Cơ','79'),
('25888','Phường Tân Uyên','79'),
('25920','Phường Tân Hiệp','79'),
('25891','Phường Tân Khánh','79'),
('25849','Phường Hòa Lợi','79'),
('25768','Phường Phú An','79'),
('25843','Phường Tây Nam','79'),
('25840','Phường Long Nguyên','79'),
('25813','Phường Bến Cát','79'),
('25837','Phường Chánh Phú Hòa','79'),
('25906','Xã Bắc Tân Uyên','79'),
('25909','Xã Thường Tân','79'),
('25867','Xã An Long','79'),
('25864','Xã Phước Thành','79'),
('25882','Xã Phước Hòa','79'),
('25858','Xã Phú Giáo','79'),
('25819','Xã Trừ Văn Thố','79'),
('25822','Xã Bàu Bàng','79'),
('25780','Xã Minh Thạnh','79'),
('25792','Xã Long Hòa','79'),
('25777','Xã Dầu Tiếng','79'),
('25807','Xã Thanh An','79'),
('26740','Phường Sài Gòn','79'),
('26737','Phường Tân Định','79'),
('26743','Phường Bến Thành','79'),
('26758','Phường Cầu Ông Lãnh','79'),
('27154','Phường Bàn Cờ','79'),
('27139','Phường Xuân Hòa','79'),
('27142','Phường Nhiêu Lộc','79'),
('27259','Phường Xóm Chiếu','79'),
('27265','Phường Khánh Hội','79'),
('27286','Phường Vĩnh Hội','79'),
('27301','Phường Chợ Quán','79'),
('27316','Phường An Đông','79'),
('27343','Phường Chợ Lớn','79'),
('27367','Phường Bình Tây','79'),
('27373','Phường Bình Tiên','79'),
('27364','Phường Bình Phú','79'),
('27349','Phường Phú Lâm','79'),
('27478','Phường Tân Thuận','79'),
('27484','Phường Phú Thuận','79'),
('27487','Phường Tân Mỹ','79'),
('27475','Phường Tân Hưng','79'),
('27418','Phường Chánh Hưng','79'),
('27427','Phường Phú Định','79'),
('27424','Phường Bình Đông','79'),
('27169','Phường Diên Hồng','79'),
('27190','Phường Vườn Lài','79'),
('27163','Phường Hòa Hưng','79'),
('27238','Phường Minh Phụng','79'),
('27232','Phường Bình Thới','79'),
('27211','Phường Hòa Bình','79'),
('27226','Phường Phú Thọ','79'),
('26791','Phường Đông Hưng Thuận','79'),
('26785','Phường Trung Mỹ Tây','79'),
('26782','Phường Tân Thới Hiệp','79'),
('26773','Phường Thới An','79'),
('26767','Phường An Phú Đông','79'),
('27460','Phường An Lạc','79'),
('27457','Phường Tân Tạo','79'),
('27442','Phường Bình Tân','79'),
('27448','Phường Bình Trị Đông','79'),
('27439','Phường Bình Hưng Hòa','79'),
('26944','Phường Gia Định','79'),
('26929','Phường Bình Thạnh','79'),
('26905','Phường Bình Lợi Trung','79'),
('26956','Phường Thạnh Mỹ Tây','79'),
('26911','Phường Bình Quới','79'),
('26890','Phường Hạnh Thông','79'),
('26876','Phường An Nhơn','79'),
('26884','Phường Gò Vấp','79'),
('26878','Phường An Hội Đông','79'),
('26898','Phường Thông Tây Hội','79'),
('26882','Phường An Hội Tây','79'),
('27043','Phường Đức Nhuận','79'),
('27058','Phường Cầu Kiệu','79'),
('27073','Phường Phú Nhuận','79'),
('26977','Phường Tân Sơn Hòa','79'),
('26968','Phường Tân Sơn Nhất','79'),
('26995','Phường Tân Hòa','79'),
('26983','Phường Bảy Hiền','79'),
('27004','Phường Tân Bình','79'),
('27007','Phường Tân Sơn','79'),
('27013','Phường Tây Thạnh','79'),
('27019','Phường Tân Sơn Nhì','79'),
('27022','Phường Phú Thọ Hòa','79'),
('27031','Phường Tân Phú','79'),
('27028','Phường Phú Thạnh','79'),
('26809','Phường Hiệp Bình','79'),
('26824','Phường Thủ Đức','79'),
('26803','Phường Tam Bình','79'),
('26800','Phường Linh Xuân','79'),
('26842','Phường Tăng Nhơn Phú','79'),
('26833','Phường Long Bình','79'),
('26857','Phường Long Phước','79'),
('26860','Phường Long Trường','79'),
('27112','Phường Cát Lái','79'),
('27097','Phường Bình Trưng','79'),
('26848','Phường Phước Long','79'),
('27094','Phường An Khánh','79'),
('27601','Xã Vĩnh Lộc','79'),
('27604','Xã Tân Vĩnh Lộc','79'),
('27610','Xã Bình Lợi','79'),
('27595','Xã Tân Nhựt','79'),
('27637','Xã Bình Chánh','79'),
('27628','Xã Hưng Long','79'),
('27619','Xã Bình Hưng','79'),
('27667','Xã Bình Khánh','79'),
('27673','Xã An Thới Đông','79'),
('27664','Xã Cần Giờ','79'),
('27553','Xã Củ Chi','79'),
('27496','Xã Tân An Hội','79'),
('27526','Xã Thái Mỹ','79'),
('27508','Xã An Nhơn Tây','79'),
('27511','Xã Nhuận Đức','79'),
('27541','Xã Phú Hòa Đông','79'),
('27544','Xã Bình Mỹ','79'),
('27568','Xã Đông Thạnh','79'),
('27559','Xã Hóc Môn','79'),
('27577','Xã Xuân Thới Sơn','79'),
('27592','Xã Bà Điểm','79'),
('27655','Xã Nhà Bè','79'),
('27658','Xã Hiệp Phước','79'),
('26545','Xã Long Sơn','79'),
('26647','Xã Hòa Hiệp','79'),
('26656','Xã Bình Châu','79'),
('25846','Phường Thới Hòa','79'),
('27676','Xã Thạnh An','79');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('27727','Xã Hưng Điền','80'),
('27736','Xã Vĩnh Thạnh','80'),
('27721','Xã Tân Hưng','80'),
('27748','Xã Vĩnh Châu','80'),
('27775','Xã Tuyên Bình','80'),
('27757','Xã Vĩnh Hưng','80'),
('27763','Xã Khánh Hưng','80'),
('27817','Xã Tuyên Thạnh','80'),
('27793','Xã Bình Hiệp','80'),
('27787','Phường Kiến Tường','80'),
('27811','Xã Bình Hòa','80'),
('27823','Xã Mộc Hóa','80'),
('27841','Xã Hậu Thạnh','80'),
('27838','Xã Nhơn Hòa Lập','80'),
('27856','Xã Nhơn Ninh','80'),
('27826','Xã Tân Thạnh','80'),
('27868','Xã Bình Thành','80'),
('27877','Xã Thạnh Phước','80'),
('27865','Xã Thạnh Hóa','80'),
('27889','Xã Tân Tây','80'),
('28036','Xã Thủ Thừa','80'),
('28066','Xã Mỹ An','80'),
('28051','Xã Mỹ Thạnh','80'),
('28072','Xã Tân Long','80'),
('27907','Xã Mỹ Quý','80'),
('27898','Xã Đông Thành','80'),
('27925','Xã Đức Huệ','80'),
('27943','Xã An Ninh','80'),
('27952','Xã Hiệp Hòa','80'),
('27931','Xã Hậu Nghĩa','80'),
('27979','Xã Hòa Khánh','80'),
('27964','Xã Đức Lập','80'),
('27976','Xã Mỹ Hạnh','80'),
('27937','Xã Đức Hòa','80'),
('27994','Xã Thạnh Lợi','80'),
('28015','Xã Bình Đức','80'),
('28003','Xã Lương Hòa','80'),
('27991','Xã Bến Lức','80'),
('28018','Xã Mỹ Yên','80'),
('28126','Xã Long Cang','80'),
('28114','Xã Rạch Kiến','80'),
('28132','Xã Mỹ Lệ','80'),
('28138','Xã Tân Lân','80'),
('28108','Xã Cần Đước','80'),
('28144','Xã Long Hựu','80'),
('28165','Xã Phước Lý','80'),
('28177','Xã Mỹ Lộc','80'),
('28159','Xã Cần Giuộc','80'),
('28201','Xã Phước Vĩnh Tây','80'),
('28207','Xã Tân Tập','80'),
('28093','Xã Vàm Cỏ','80'),
('28075','Xã Tân Trụ','80'),
('28087','Xã Nhựt Tảo','80'),
('28225','Xã Thuận Mỹ','80'),
('28243','Xã An Lục Long','80'),
('28210','Xã Tầm Vu','80'),
('28222','Xã Vĩnh Công','80'),
('27694','Phường Long An','80'),
('27712','Phường Tân An','80'),
('27715','Phường Khánh Hậu','80'),
('25459','Phường Tân Ninh','80'),
('25480','Phường Bình Minh','80'),
('25567','Phường Ninh Thạnh','80'),
('25630','Phường Long Hoa','80'),
('25645','Phường Hòa Thành','80'),
('25633','Phường Thanh Điền','80'),
('25708','Phường Trảng Bàng','80'),
('25732','Phường An Tịnh','80'),
('25654','Phường Gò Dầu','80'),
('25672','Phường Gia Lộc','80'),
('25711','Xã Hưng Thuận','80'),
('25729','Xã Phước Chỉ','80'),
('25657','Xã Thạnh Đức','80'),
('25663','Xã Phước Thạnh','80'),
('25666','Xã Truông Mít','80'),
('25579','Xã Lộc Ninh','80'),
('25573','Xã Cầu Khởi','80'),
('25552','Xã Dương Minh Châu','80'),
('25522','Xã Tân Đông','80'),
('25516','Xã Tân Châu','80'),
('25549','Xã Tân Phú','80'),
('25525','Xã Tân Hội','80'),
('25534','Xã Tân Thành','80'),
('25531','Xã Tân Hòa','80'),
('25489','Xã Tân Lập','80'),
('25486','Xã Tân Biên','80'),
('25498','Xã Thạnh Bình','80'),
('25510','Xã Trà Vong','80'),
('25591','Xã Phước Vinh','80'),
('25606','Xã Hòa Hội','80'),
('25621','Xã Ninh Điền','80'),
('25585','Xã Châu Thành','80'),
('25588','Xã Hảo Đước','80'),
('25684','Xã Long Chữ','80'),
('25702','Xã Long Thuận','80'),
('25681','Xã Bến Cầu','80');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('28261','Phường Mỹ Tho','82'),
('28249','Phường Đạo Thạnh','82'),
('28273','Phường Mỹ Phong','82'),
('28270','Phường Thới Sơn','82'),
('28285','Phường Trung An','82'),
('28306','Phường Gò Công','82'),
('28297','Phường Long Thuận','82'),
('28729','Phường Sơn Qui','82'),
('28315','Phường Bình Xuân','82'),
('28435','Phường Mỹ Phước Tây','82'),
('28436','Phường Thanh Hòa','82'),
('28439','Phường Cai Lậy','82'),
('28477','Phường Nhị Quý','82'),
('28468','Xã Tân Phú','82'),
('28426','Xã Thanh Hưng','82'),
('28429','Xã An Hữu','82'),
('28414','Xã Mỹ Lợi','82'),
('28405','Xã Mỹ Đức Tây','82'),
('28378','Xã Mỹ Thiện','82'),
('28366','Xã Hậu Mỹ','82'),
('28393','Xã Hội Cư','82'),
('28360','Xã Cái Bè','82'),
('28471','Xã Bình Phú','82'),
('28501','Xã Hiệp Đức','82'),
('28516','Xã Ngũ Hiệp','82'),
('28504','Xã Long Tiên','82'),
('28456','Xã Mỹ Thành','82'),
('28444','Xã Thạnh Phú','82'),
('28321','Xã Tân Phước 1','82'),
('28327','Xã Tân Phước 2','82'),
('28345','Xã Tân Phước 3','82'),
('28336','Xã Hưng Thạnh','82'),
('28525','Xã Tân Hương','82'),
('28519','Xã Châu Thành','82'),
('28537','Xã Long Hưng','82'),
('28543','Xã Long Định','82'),
('28576','Xã Vĩnh Kim','82'),
('28582','Xã Kim Sơn','82'),
('28564','Xã Bình Trưng','82'),
('28603','Xã Mỹ Tịnh An','82'),
('28615','Xã Lương Hòa Lạc','82'),
('28627','Xã Tân Thuận Bình','82'),
('28594','Xã Chợ Gạo','82'),
('28633','Xã An Thạnh Thủy','82'),
('28648','Xã Bình Ninh','82'),
('28651','Xã Vĩnh Bình','82'),
('28660','Xã Đồng Sơn','82'),
('28663','Xã Phú Thành','82'),
('28687','Xã Long Bình','82'),
('28678','Xã Vĩnh Hựu','82'),
('28747','Xã Gò Công Đông','82'),
('28738','Xã Tân Điền','82'),
('28702','Xã Tân Hòa','82'),
('28723','Xã Tân Đông','82'),
('28720','Xã Gia Thuận','82'),
('28693','Xã Tân Thới','82'),
('28696','Xã Tân Phú Đông','82'),
('29926','Xã Tân Hồng','82'),
('29938','Xã Tân Thành','82'),
('29929','Xã Tân Hộ Cơ','82'),
('29944','Xã An Phước','82'),
('29954','Phường An Bình','82'),
('29955','Phường Hồng Ngự','82'),
('29978','Phường Thường Lạc','82'),
('29971','Xã Thường Phước','82'),
('29983','Xã Long Khánh','82'),
('29992','Xã Long Phú Thuận','82'),
('30019','Xã An Hòa','82'),
('30010','Xã Tam Nông','82'),
('30034','Xã Phú Thọ','82'),
('30001','Xã Tràm Chim','82'),
('30025','Xã Phú Cường','82'),
('30028','Xã An Long','82'),
('30130','Xã Thanh Bình','82'),
('30157','Xã Tân Thạnh','82'),
('30163','Xã Bình Thành','82'),
('30154','Xã Tân Long','82'),
('30037','Xã Tháp Mười','82'),
('30073','Xã Thanh Mỹ','82'),
('30055','Xã Mỹ Quí','82'),
('30061','Xã Đốc Binh Kiều','82'),
('30046','Xã Trường Xuân','82'),
('30043','Xã Phương Thịnh','82'),
('30088','Xã Phong Mỹ','82'),
('30085','Xã Ba Sao','82'),
('30076','Xã Mỹ Thọ','82'),
('30118','Xã Bình Hàng Trung','82'),
('30112','Xã Mỹ Hiệp','82'),
('29869','Phường Cao Lãnh','82'),
('29884','Phường Mỹ Ngãi','82'),
('29888','Phường Mỹ Trà','82'),
('30178','Xã Mỹ An Hưng','82'),
('30184','Xã Tân Khánh Trung','82'),
('30169','Xã Lấp Vò','82'),
('30226','Xã Lai Vung','82'),
('30208','Xã Hòa Long','82'),
('30235','Xã Phong Hòa','82'),
('29905','Phường Sa Đéc','82'),
('30214','Xã Tân Dương','82'),
('30244','Xã Phú Hựu','82'),
('30253','Xã Tân Nhuận Đông','82'),
('30259','Xã Tân Phú Trung','82');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('29641','Xã Cái Nhum','86'),
('29653','Xã Tân Long Hội','86'),
('29623','Xã Nhơn Phú','86'),
('29638','Xã Bình Phước','86'),
('29584','Xã An Bình','86'),
('29602','Xã Long Hồ','86'),
('29611','Xã Phú Quới','86'),
('29590','Phường Thanh Đức','86'),
('29551','Phường Long Châu','86'),
('29557','Phường Phước Hậu','86'),
('29593','Phường Tân Hạnh','86'),
('29566','Phường Tân Ngãi','86'),
('29677','Xã Quới Thiện','86'),
('29659','Xã Trung Thành','86'),
('29698','Xã Trung Ngãi','86'),
('29668','Xã Quới An','86'),
('29683','Xã Trung Hiệp','86'),
('29701','Xã Hiếu Phụng','86'),
('29713','Xã Hiếu Thành','86'),
('29857','Xã Lục Sĩ Thành','86'),
('29821','Xã Trà Ôn','86'),
('29836','Xã Trà Côn','86'),
('29845','Xã Vĩnh Xuân','86'),
('29830','Xã Hòa Bình','86'),
('29734','Xã Hòa Hiệp','86'),
('29719','Xã Tam Bình','86'),
('29767','Xã Ngãi Tứ','86'),
('29740','Xã Song Phú','86'),
('29728','Xã Cái Ngang','86'),
('29800','Xã Tân Quới','86'),
('29785','Xã Tân Lược','86'),
('29788','Xã Mỹ Thuận','86'),
('29771','Phường Bình Minh','86'),
('29770','Phường Cái Vồn','86'),
('29812','Phường Đông Thành','86'),
('29263','Phường Long Đức','86'),
('29242','Phường Trà Vinh','86'),
('29254','Phường Nguyệt Hóa','86'),
('29398','Phường Hòa Thuận','86'),
('29275','Xã An Trường','86'),
('29278','Xã Tân An','86'),
('29266','Xã Càng Long','86'),
('29302','Xã Nhị Long','86'),
('29287','Xã Bình Phú','86'),
('29386','Xã Song Lộc','86'),
('29374','Xã Châu Thành','86'),
('29407','Xã Hưng Mỹ','86'),
('29410','Xã Hòa Minh','86'),
('29413','Xã Long Hòa','86'),
('29308','Xã Cầu Kè','86'),
('29329','Xã Phong Thạnh','86'),
('29317','Xã An Phú Tân','86'),
('29335','Xã Tam Ngãi','86'),
('29371','Xã Tân Hòa','86'),
('29362','Xã Hùng Hòa','86'),
('29341','Xã Tiểu Cần','86'),
('29365','Xã Tập Ngãi','86'),
('29419','Xã Mỹ Long','86'),
('29431','Xã Vinh Kim','86'),
('29416','Xã Cầu Ngang','86'),
('29446','Xã Nhị Trường','86'),
('29455','Xã Hiệp Mỹ','86'),
('29476','Xã Lưu Nghiệp Anh','86'),
('29491','Xã Đại An','86'),
('29489','Xã Hàm Giang','86'),
('29461','Xã Trà Cú','86'),
('29506','Xã Long Hiệp','86'),
('29467','Xã Tập Sơn','86'),
('29512','Phường Duyên Hải','86'),
('29516','Phường Trường Long Hòa','86'),
('29518','Xã Long Hữu','86'),
('29513','Xã Long Thành','86'),
('29536','Xã Đông Hải','86'),
('29533','Xã Long Vĩnh','86'),
('29497','Xã Đôn Châu','86'),
('29530','Xã Ngũ Lạc','86'),
('28777','Phường An Hội','86'),
('28756','Phường Phú Khương','86'),
('28789','Phường Bến Tre','86'),
('28783','Phường Sơn Đông','86'),
('28858','Phường Phú Tân','86'),
('28810','Xã Phú Túc','86'),
('28807','Xã Giao Long','86'),
('28861','Xã Tiên Thủy','86'),
('28840','Xã Tân Phú','86'),
('28879','Xã Phú Phụng','86'),
('28870','Xã Chợ Lách','86'),
('28894','Xã Vĩnh Thành','86'),
('28901','Xã Hưng Khánh Trung','86'),
('28915','Xã Phước Mỹ Trung','86'),
('28921','Xã Tân Thành Bình','86'),
('28948','Xã Nhuận Phú Tân','86'),
('28945','Xã Đồng Khởi','86'),
('28903','Xã Mỏ Cày','86'),
('28969','Xã Thành Thới','86'),
('28957','Xã An Định','86'),
('28981','Xã Hương Mỹ','86'),
('29194','Xã Đại Điền','86'),
('29191','Xã Quới Điền','86'),
('29182','Xã Thạnh Phú','86'),
('29224','Xã An Qui','86'),
('29221','Xã Thạnh Hải','86'),
('29227','Xã Thạnh Phong','86'),
('29167','Xã Tân Thủy','86'),
('29125','Xã Bảo Thạnh','86'),
('29110','Xã Ba Tri','86'),
('29137','Xã Tân Xuân','86'),
('29122','Xã Mỹ Chánh Hòa','86'),
('29143','Xã An Ngãi Trung','86'),
('29158','Xã An Hiệp','86'),
('29044','Xã Hưng Nhượng','86'),
('28984','Xã Giồng Trôm','86'),
('29029','Xã Tân Hào','86'),
('29020','Xã Phước Long','86'),
('28993','Xã Lương Phú','86'),
('28996','Xã Châu Hòa','86'),
('28987','Xã Lương Hòa','86'),
('29107','Xã Thới Thuận','86'),
('29104','Xã Thạnh Phước','86'),
('29050','Xã Bình Đại','86'),
('29089','Xã Thạnh Trị','86'),
('29077','Xã Lộc Thuận','86'),
('29083','Xã Châu Hưng','86'),
('29062','Xã Phú Thuận','86');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('30313','Xã Mỹ Hòa Hưng','91'),
('30307','Phường Long Xuyên','91'),
('30292','Phường Bình Đức','91'),
('30301','Phường Mỹ Thới','91'),
('30316','Phường Châu Đốc','91'),
('30325','Phường Vĩnh Tế','91'),
('30337','Xã An Phú','91'),
('30367','Xã Vĩnh Hậu','91'),
('30346','Xã Nhơn Hội','91'),
('30341','Xã Khánh Bình','91'),
('30352','Xã Phú Hữu','91'),
('30388','Xã Tân An','91'),
('30403','Xã Châu Phong','91'),
('30385','Xã Vĩnh Xương','91'),
('30376','Phường Tân Châu','91'),
('30377','Phường Long Phú','91'),
('30406','Xã Phú Tân','91'),
('30436','Xã Phú An','91'),
('30445','Xã Bình Thạnh Đông','91'),
('30409','Xã Chợ Vàm','91'),
('30430','Xã Hòa Lạc','91'),
('30421','Xã Phú Lâm','91'),
('30463','Xã Châu Phú','91'),
('30469','Xã Mỹ Đức','91'),
('30478','Xã Vĩnh Thạnh Trung','91'),
('30487','Xã Bình Mỹ','91'),
('30481','Xã Thạnh Mỹ Tây','91'),
('30526','Xã An Cư','91'),
('30538','Xã Núi Cấm','91'),
('30520','Phường Tịnh Biên','91'),
('30502','Phường Thới Sơn','91'),
('30505','Phường Chi Lăng','91'),
('30547','Xã Ba Chúc','91'),
('30544','Xã Tri Tôn','91'),
('30577','Xã Ô Lâm','91'),
('30580','Xã Cô Tô','91'),
('30568','Xã Vĩnh Gia','91'),
('30589','Xã An Châu','91'),
('30607','Xã Bình Hòa','91'),
('30595','Xã Cần Đăng','91'),
('30619','Xã Vĩnh Hanh','91'),
('30604','Xã Vĩnh An','91'),
('30628','Xã Chợ Mới','91'),
('30643','Xã Cù Lao Giêng','91'),
('30673','Xã Hội An','91'),
('30631','Xã Long Điền','91'),
('30658','Xã Nhơn Mỹ','91'),
('30664','Xã Long Kiến','91'),
('30682','Xã Thoại Sơn','91'),
('30688','Xã Óc Eo','91'),
('30709','Xã Định Mỹ','91'),
('30685','Xã Phú Hòa','91'),
('30697','Xã Vĩnh Trạch','91'),
('30691','Xã Tây Phú','91'),
('31064','Xã Vĩnh Bình','91'),
('31069','Xã Vĩnh Thuận','91'),
('31051','Xã Vĩnh Phong','91'),
('31012','Xã Vĩnh Hòa','91'),
('31027','Xã U Minh Thượng','91'),
('31024','Xã Đông Hòa','91'),
('31031','Xã Tân Thạnh','91'),
('31036','Xã Đông Hưng','91'),
('31018','Xã An Minh','91'),
('31042','Xã Vân Khánh','91'),
('30988','Xã Tây Yên','91'),
('31006','Xã Đông Thái','91'),
('30985','Xã An Biên','91'),
('30958','Xã Định Hòa','91'),
('30952','Xã Gò Quao','91'),
('30970','Xã Vĩnh Hòa Hưng','91'),
('30982','Xã Vĩnh Tuy','91'),
('30904','Xã Giồng Riềng','91'),
('30910','Xã Thạnh Hưng','91'),
('30943','Xã Long Thạnh','91'),
('30934','Xã Hòa Hưng','91'),
('30928','Xã Ngọc Chúc','91'),
('30949','Xã Hòa Thuận','91'),
('30856','Xã Tân Hội','91'),
('30850','Xã Tân Hiệp','91'),
('30874','Xã Thạnh Đông','91'),
('30886','Xã Thạnh Lộc','91'),
('30880','Xã Châu Thành','91'),
('30898','Xã Bình An','91'),
('30817','Xã Hòn Đất','91'),
('30835','Xã Sơn Kiên','91'),
('30838','Xã Mỹ Thuận','91'),
('30823','Xã Bình Sơn','91'),
('30826','Xã Bình Giang','91'),
('30796','Xã Giang Thành','91'),
('30793','Xã Vĩnh Điều','91'),
('30790','Xã Hòa Điền','91'),
('30787','Xã Kiên Lương','91'),
('30811','Xã Sơn Hải','91'),
('30814','Xã Hòn Nghệ','91'),
('31108','Đặc khu Kiên Hải','91'),
('30760','Phường Vĩnh Thông','91'),
('30742','Phường Rạch Giá','91'),
('30769','Phường Hà Tiên','91'),
('30766','Phường Tô Châu','91'),
('30781','Xã Tiên Hải','91'),
('31078','Đặc khu Phú Quốc','91'),
('31105','Đặc khu Thổ Châu','91');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('31135','Phường Ninh Kiều','92'),
('31120','Phường Cái Khế','92'),
('31147','Phường Tân An','92'),
('31150','Phường An Bình','92'),
('31174','Phường Thới An Đông','92'),
('31168','Phường Bình Thủy','92'),
('31183','Phường Long Tuyền','92'),
('31186','Phường Cái Răng','92'),
('31201','Phường Hưng Phú','92'),
('31153','Phường Ô Môn','92'),
('31157','Phường Thới Long','92'),
('31162','Phường Phước Thới','92'),
('31217','Phường Trung Nhứt','92'),
('31207','Phường Thốt Nốt','92'),
('31228','Phường Thuận Hưng','92'),
('31213','Phường Tân Lộc','92'),
('31299','Xã Phong Điền','92'),
('31315','Xã Nhơn Ái','92'),
('31309','Xã Trường Long','92'),
('31258','Xã Thới Lai','92'),
('31282','Xã Đông Thuận','92'),
('31294','Xã Trường Xuân','92'),
('31288','Xã Trường Thành','92'),
('31261','Xã Cờ Đỏ','92'),
('31273','Xã Đông Hiệp','92'),
('31249','Xã Thạnh Phú','92'),
('31264','Xã Thới Hưng','92'),
('31255','Xã Trung Hưng','92'),
('31232','Xã Vĩnh Thạnh','92'),
('31237','Xã Vĩnh Trinh','92'),
('31231','Xã Thạnh An','92'),
('31246','Xã Thạnh Quới','92'),
('31338','Xã Hỏa Lựu','92'),
('31321','Phường Vị Thanh','92'),
('31333','Phường Vị Tân','92'),
('31441','Xã Vị Thủy','92'),
('31453','Xã Vĩnh Thuận Đông','92'),
('31465','Xã Vị Thanh 1','92'),
('31459','Xã Vĩnh Tường','92'),
('31489','Xã Vĩnh Viễn','92'),
('31495','Xã Xà Phiên','92'),
('31492','Xã Lương Tâm','92'),
('31473','Phường Long Bình','92'),
('31471','Phường Long Mỹ','92'),
('31480','Phường Long Phú 1','92'),
('31360','Xã Thạnh Xuân','92'),
('31342','Xã Tân Hòa','92'),
('31348','Xã Trường Long Tây','92'),
('31366','Xã Châu Thành','92'),
('31369','Xã Đông Phước','92'),
('31378','Xã Phú Hữu','92'),
('31411','Phường Đại Thành','92'),
('31340','Phường Ngã Bảy','92'),
('31399','Xã Tân Bình','92'),
('31393','Xã Hòa An','92'),
('31426','Xã Phương Bình','92'),
('31432','Xã Tân Phước Hưng','92'),
('31396','Xã Hiệp Hưng','92'),
('31420','Xã Phụng Hiệp','92'),
('31408','Xã Thạnh Hòa','92'),
('31510','Phường Phú Lợi','92'),
('31507','Phường Sóc Trăng','92'),
('31684','Phường Mỹ Xuyên','92'),
('31717','Xã Hòa Tú','92'),
('31726','Xã Gia Hòa','92'),
('31708','Xã Nhu Gia','92'),
('31723','Xã Ngọc Tố','92'),
('31654','Xã Trường Khánh','92'),
('31645','Xã Đại Ngãi','92'),
('31666','Xã Tân Thạnh','92'),
('31639','Xã Long Phú','92'),
('31552','Xã Nhơn Mỹ','92'),
('31537','Xã Phong Nẫm','92'),
('31531','Xã An Lạc Thôn','92'),
('31528','Xã Kế Sách','92'),
('31540','Xã Thới An Hội','92'),
('31561','Xã Đại Hải','92'),
('31569','Xã Phú Tâm','92'),
('31594','Xã An Ninh','92'),
('31582','Xã Thuận Hòa','92'),
('31570','Xã Hồ Đắc Kiện','92'),
('31567','Xã Mỹ Tú','92'),
('31579','Xã Long Hưng','92'),
('31603','Xã Mỹ Phước','92'),
('31591','Xã Mỹ Hương','92'),
('31795','Xã Vĩnh Hải','92'),
('31810','Xã Lai Hòa','92'),
('31804','Phường Vĩnh Phước','92'),
('31783','Phường Vĩnh Châu','92'),
('31789','Phường Khánh Hòa','92'),
('31741','Xã Tân Long','92'),
('31732','Phường Ngã Năm','92'),
('31753','Phường Mỹ Quới','92'),
('31756','Xã Phú Lộc','92'),
('31777','Xã Vĩnh Lợi','92'),
('31759','Xã Lâm Tân','92'),
('31699','Xã Thạnh Thới An','92'),
('31687','Xã Tài Văn','92'),
('31675','Xã Liêu Tú','92'),
('31679','Xã Lịch Hội Thượng','92'),
('31673','Xã Trần Đề','92'),
('31615','Xã An Thạnh','92'),
('31633','Xã Cù Lao Dung','92');

INSERT INTO sys_division_2025 (local_id, subdiv_name, division_local_id) VALUES
('32002','Phường An Xuyên','96'),
('32014','Phường Lý Văn Lâm','96'),
('32025','Phường Tân Thành','96'),
('32041','Phường Hòa Thành','96'),
('32167','Xã Tân Thuận','96'),
('32188','Xã Tân Tiến','96'),
('32155','Xã Tạ An Khương','96'),
('32161','Xã Trần Phán','96'),
('32185','Xã Thanh Tùng','96'),
('32152','Xã Đầm Dơi','96'),
('32182','Xã Quách Phẩm','96'),
('32047','Xã U Minh','96'),
('32044','Xã Nguyễn Phích','96'),
('32062','Xã Khánh Lâm','96'),
('32059','Xã Khánh An','96'),
('32244','Xã Phan Ngọc Hiển','96'),
('32248','Xã Đất Mũi','96'),
('32236','Xã Tân Ân','96'),
('32110','Xã Khánh Bình','96'),
('32104','Xã Đá Bạc','96'),
('32119','Xã Khánh Hưng','96'),
('32098','Xã Sông Đốc','96'),
('32095','Xã Trần Văn Thời','96'),
('32065','Xã Thới Bình','96'),
('32071','Xã Trí Phải','96'),
('32083','Xã Tân Lộc','96'),
('32092','Xã Hồ Thị Kỷ','96'),
('32069','Xã Biển Bạch','96'),
('32201','Xã Đất Mới','96'),
('32191','Xã Năm Căn','96'),
('32206','Xã Tam Giang','96'),
('32212','Xã Cái Đôi Vàm','96'),
('32227','Xã Nguyễn Việt Khái','96'),
('32218','Xã Phú Tân','96'),
('32214','Xã Phú Mỹ','96'),
('32134','Xã Lương Thế Trân','96'),
('32137','Xã Tân Hưng','96'),
('32140','Xã Hưng Mỹ','96'),
('32128','Xã Cái Nước','96'),
('31825','Phường Bạc Liêu','96'),
('31834','Phường Vĩnh Trạch','96'),
('31840','Phường Hiệp Thành','96'),
('31942','Phường Giá Rai','96'),
('31951','Phường Láng Tròn','96'),
('31957','Xã Phong Thạnh','96'),
('31843','Xã Hồng Dân','96'),
('31858','Xã Vĩnh Lộc','96'),
('31864','Xã Ninh Thạnh Lợi','96'),
('31849','Xã Ninh Quới','96'),
('31972','Xã Gành Hào','96'),
('31993','Xã Định Thành','96'),
('31988','Xã An Trạch','96'),
('31985','Xã Long Điền','96'),
('31975','Xã Đông Hải','96'),
('31891','Xã Hòa Bình','96'),
('31918','Xã Vĩnh Mỹ','96'),
('31927','Xã Vĩnh Hậu','96'),
('31867','Xã Phước Long','96'),
('31876','Xã Vĩnh Phước','96'),
('31885','Xã Phong Hiệp','96'),
('31882','Xã Vĩnh Thanh','96'),
('31900','Xã Vĩnh Lợi','96'),
('31906','Xã Hưng Hội','96'),
('31894','Xã Châu Thới','96');

-- Cap nhat quan/huyen phuong/xa cu cua tat ca cac tinh thanh co trong danh sach tren
UPDATE sys_division_sub SET namespaceset = 1 WHERE divisionid IN (SELECT divisionid FROM sys_division WHERE country_iso3 = 'VNM' AND namespaceset & 1 > 0);

INSERT INTO sys_division_sub(divisionid, subdiv_cd, subdiv_name, l2subdiv_cd, subdiv_class, namespaceset)
SELECT divisionid, v.local_id, v.subdiv_name, '00000', CASE WHEN v.subdiv_name LIKE 'Phường%' THEN 'Phường' WHEN v.subdiv_name LIKE 'Xã%' THEN 'Xã' WHEN v.subdiv_name LIKE 'Đặc%' THEN 'Đặc khu' END, 2 FROM sys_division d 
JOIN sys_division_2025 v ON d.local_id = v.division_local_id
WHERE country_iso3 = 'VNM' AND namespaceset & 2 > 0;

INSERT INTO sys_division_sub(divisionid, subdiv_cd, subdiv_name, l2subdiv_cd, namespaceset)
SELECT divisionid, '000', '00000', '(không có cấp dưới)', 2 FROM sys_division d 
WHERE country_iso3 = 'VNM' AND namespaceset & 2 > 0;

UPDATE sys_prefix SET namespaceset = namespaceset | 1 WHERE namespaceset = 0;

UPDATE sys_prefix SET namespaceset = 3 WHERE country_code = 'VNM' AND unit_level = 1
    AND TRIM(prefix) IN ('TP.','TP','Thanh pho','Thành phố','Tinh','Tỉnh');

INSERT OR IGNORE INTO sys_prefix (prefix, unit_level, country_code, "name", namespaceset) VALUES
('P.',2,'VNM','Phường', 2),
('Phuong',2,'VNM','Phường', 2),
('Phường',2,'VNM','Phường', 2),
('X.',2,'VNM','Xã', 2),
('Xa',2,'VNM','Xã', 2),
('Xã',2,'VNM','Xã', 2),
('ĐK',2,'VNM','Đặc khu', 2),
('Đặc khu',2,'VNM','Đặc khu', 2),
('Dac khu',2,'VNM','Đặc khu', 2);

INSERT OR IGNORE INTO special_division (divisionid, division_name) VALUES(4, 'TP HCM'),(1, 'TP HN'),(34, 'Tỉnh Thừa Thiên-Huế');