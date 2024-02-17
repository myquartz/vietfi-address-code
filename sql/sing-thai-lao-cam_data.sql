

--
-- Dumping data for table `sys_country`
--

INSERT INTO sys_country (iso2, country_name, nicename, iso3, numcode, phonecode) VALUES ('KH','CAMBODIA','Cambodia','KHM',116,855) ON CONFLICT (iso3) DO NOTHING;
INSERT INTO sys_country (iso2, country_name, nicename, iso3, numcode, phonecode) VALUES ('LA','LAO PEOPLE''S DEMOCRATIC REPUBLIC','Lao People''s Democratic Republic','LAO',418,856) ON CONFLICT (iso3) DO NOTHING;
INSERT INTO sys_country (iso2, country_name, nicename, iso3, numcode, phonecode) VALUES ('SG','SINGAPORE','Singapore','SGP',702,65) ON CONFLICT (iso3) DO NOTHING;
INSERT INTO sys_country (iso2, country_name, nicename, iso3, numcode, phonecode) VALUES ('TH','THAILAND','Thailand','THA',764,66) ON CONFLICT (iso3) DO NOTHING;

--
-- Manual create for `sys_division`
--

INSERT INTO sys_division (country_iso3, division_cd, division_name)
VALUES
('SGP','SG-01', 'Central Region'),
('SGP','SG-02', 'East Region'),
('SGP','SG-03', 'North Region'),
('SGP','SG-04', 'North-East Region'),
('SGP','SG-05', 'West Region');

INSERT INTO sys_division_sub (divisionid, subdiv_cd, l2subdiv_cd, subdiv_name)
SELECT divisionid, 'SG-CE1', '00000', 'Marina East' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE2', '00000', 'Marina South' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE3', '00000', 'Museum' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE4', '00000', 'Newton' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE5', '00000', 'Orchard' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE6', '00000', 'Outram' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE7', '00000', 'River Valley' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE8', '00000', 'Singapore River' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-CE9', '00000', 'Straits View' FROM sys_division WHERE division_cd = 'SG-01'
UNION ALL
SELECT divisionid, 'SG-EA1', '00000', 'Changi' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA2', '00000', 'Bedok' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA3', '00000', 'Geylang' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA4', '00000', 'Paya Lebar' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA5', '00000', 'Tampines' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA6', '00000', 'Pasir Ris' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA7', '00000', 'Kallang/Whampoa' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA8', '00000', 'Marine Parade' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-EA9', '00000', 'Simei' FROM sys_division WHERE division_cd = 'SG-02'
UNION ALL
SELECT divisionid, 'SG-NR1', '00000', 'Lim Chu Kang' FROM sys_division WHERE division_cd = 'SG-03'
UNION ALL
SELECT divisionid, 'SG-NR2', '00000', 'Sembawang' FROM sys_division WHERE division_cd = 'SG-03'
UNION ALL
SELECT divisionid, 'SG-NR3', '00000', 'Sungei Kadut' FROM sys_division WHERE division_cd = 'SG-03'
UNION ALL
SELECT divisionid, 'SG-NR4', '00000', 'Woodlands' FROM sys_division WHERE division_cd = 'SG-03'
UNION ALL
SELECT divisionid, 'SG-NR5', '00000', 'Yishun' FROM sys_division WHERE division_cd = 'SG-03'
UNION ALL
SELECT divisionid, 'SG-NE1', '00000', 'Potong Pasir' FROM sys_division WHERE division_cd = 'SG-04'
UNION ALL
SELECT divisionid, 'SG-NE2', '00000', 'Sengkang' FROM sys_division WHERE division_cd = 'SG-04'
UNION ALL
SELECT divisionid, 'SG-NE3', '00000', 'Serangoon' FROM sys_division WHERE division_cd = 'SG-04'
UNION ALL
SELECT divisionid, 'SG-NE4', '00000', 'Punggol' FROM sys_division WHERE division_cd = 'SG-04'
UNION ALL
SELECT divisionid, 'SG-W1', '00000', 'Lim Chu Kang' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W2', '00000', 'Choa Chu Kang' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W3', '00000', 'Bukit Batok' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W4', '00000', 'Bukit Panjang' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W5', '00000', 'Clementi' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W6', '00000', 'Jurong East' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W7', '00000', 'Jurong West' FROM sys_division WHERE division_cd = 'SG-05'
UNION ALL
SELECT divisionid, 'SG-W8', '00000', 'Tengah' FROM sys_division WHERE division_cd = 'SG-05';

-- Cambodia

INSERT INTO sys_division (country_iso3, division_cd, division_name)
VALUES
('KHM', 'KH-2', 'Banteay Meanchey'),
('KHM', 'KH-1', 'Battambang'),
('KHM', 'KH-12', 'Kampong Cham'),
('KHM', 'KH-14', 'Kampong Chhnang'),
('KHM', 'KH-5', 'Kampong Speu'),
('KHM', 'KH-6', 'Kampong Thom'),
('KHM', 'KH-7', 'Kampot'),
('KHM', 'KH-8', 'Kandal'),
('KHM', 'KH-9', 'Kep'),
('KHM', 'KH-10', 'Koh Kong'),
('KHM', 'KH-23', 'Kratié'),
('KHM', 'KH-18', 'Mondulkiri'),
('KHM', 'KH-22', 'Oddar Meanchey'),
('KHM', 'KH-15', 'Pailin'),
('KHM', 'KH-3', 'Phnom Penh'),
('KHM', 'KH-16', 'Preah Vihear'),
('KHM', 'KH-13', 'Prey Veng'),
('KHM', 'KH-4', 'Pursat'),
('KHM', 'KH-17', 'Ratanakiri'),
('KHM', 'KH-19', 'Siem Reap'),
('KHM', 'KH-11', 'Sihanoukville'),
('KHM', 'KH-20', 'Stung Treng'),
('KHM', 'KH-21', 'Svay Rieng'),
('KHM', 'KH-25', 'Takéo'),
('KHM', 'KH-24', 'Tbong Khmum')
ON CONFLICT (division_cd) DO NOTHING;

INSERT INTO sys_division (country_iso3, division_cd, division_name)
VALUES
('THA', 'TH-37', 'Amnat Charoen'),
('THA', 'TH-15', 'Ang Thong'),
('THA', 'TH-14', 'Ayutthaya'),
('THA', 'TH-10', 'Bangkok'),
('THA', 'TH-38', 'Bueng Kan'),
('THA', 'TH-31', 'Buri Ram'),
('THA', 'TH-24', 'Chachoengsao'),
('THA', 'TH-18', 'Chai Nat'),
('THA', 'TH-36', 'Chaiyaphum'),
('THA', 'TH-22', 'Chanthaburi'),
('THA', 'TH-50', 'Chiang Mai'),
('THA', 'TH-57', 'Chiang Rai'),
('THA', 'TH-20', 'Chon Buri'),
('THA', 'TH-86', 'Chumphon'),
('THA', 'TH-46', 'Kalasin'),
('THA', 'TH-62', 'Kamphaeng Phet'),
('THA', 'TH-71', 'Kanchanaburi'),
('THA', 'TH-40', 'Khon Kaen'),
('THA', 'TH-81', 'Krabi'),
('THA', 'TH-52', 'Lampang'),
('THA', 'TH-51', 'Lamphun'),
('THA', 'TH-42', 'Loei'),
('THA', 'TH-16', 'Lopburi'),
('THA', 'TH-58', 'Mae Hong Son'),
('THA', 'TH-44', 'Maha Sarakham'),
('THA', 'TH-49', 'Mukdahan'),
('THA', 'TH-26', 'Nakhon Nayok'),
('THA', 'TH-73', 'Nakhon Pathom'),
('THA', 'TH-48', 'Nakhon Phanom'),
('THA', 'TH-30', 'Nakhon Ratchasima'),
('THA', 'TH-60', 'Nakhon Sawan'),
('THA', 'TH-80', 'Nakhon Si Thammarat'),
('THA', 'TH-55', 'Nan'),
('THA', 'TH-96', 'Narathiwat'),
('THA', 'TH-39', 'Nong Bua Lam Phu'),
('THA', 'TH-43', 'Nong Khai'),
('THA', 'TH-12', 'Nonthaburi'),
('THA', 'TH-13', 'Pathum Thani'),
('THA', 'TH-94', 'Pattani'),
('THA', 'TH-82', 'Phang Nga'),
('THA', 'TH-93', 'Phatthalung'),
('THA', 'TH-56', 'Phayao')
ON CONFLICT (division_cd) DO NOTHING;

INSERT INTO sys_division (country_iso3, division_cd, division_name)
VALUES
('THA', 'TH-67', 'Phetchabun'),
('THA', 'TH-76', 'Phetchaburi'),
('THA', 'TH-66', 'Phichit'),
('THA', 'TH-65', 'Phitsanulok'),
('THA', 'TH-54', 'Phrae'),
('THA', 'TH-83', 'Phuket'),
('THA', 'TH-25', 'Prachin Buri'),
('THA', 'TH-77', 'Prachuap Khiri Khan'),
('THA', 'TH-85', 'Ranong'),
('THA', 'TH-70', 'Ratchaburi'),
('THA', 'TH-21', 'Rayong'),
('THA', 'TH-45', 'Roi Et'),
('THA', 'TH-27', 'Sa Kaeo'),
('THA', 'TH-47', 'Sakon Nakhon'),
('THA', 'TH-11', 'Samut Prakan'),
('THA', 'TH-74', 'Samut Sakhon'),
('THA', 'TH-75', 'Samut Songkhram'),
('THA', 'TH-19', 'Saraburi'),
('THA', 'TH-91', 'Satun'),
('THA', 'TH-17', 'Sing Buri'),
('THA', 'TH-33', 'Sisaket'),
('THA', 'TH-90', 'Songkhla'),
('THA', 'TH-64', 'Sukhothai'),
('THA', 'TH-72', 'Suphan Buri'),
('THA', 'TH-84', 'Surat Thani'),
('THA', 'TH-32', 'Surin'),
('THA', 'TH-63', 'Tak'),
('THA', 'TH-92', 'Trang'),
('THA', 'TH-23', 'Trat'),
('THA', 'TH-34', 'Ubon Ratchathani'),
('THA', 'TH-41', 'Udon Thani'),
('THA', 'TH-61', 'Uthai Thani'),
('THA', 'TH-53', 'Uttaradit'),
('THA', 'TH-95', 'Yala'),
('THA', 'TH-35', 'Yasothon')
ON CONFLICT (division_cd) DO NOTHING;

INSERT INTO sys_division (country_iso3, division_cd, division_name)
VALUES
('LAO', 'LA-VI', 'Vientiane Prefecture'),
('LAO', 'LA-VT', 'Vientiane Province'),
('LAO', 'LA-XA', 'Xaignabouli Province'),
('LAO', 'LA-XI', 'Xiangkhouang Province'),
('LAO', 'LA-AT', 'Attapeu Province'),
('LAO', 'LA-BK', 'Bokeo Province'),
('LAO', 'LA-BL', 'Bolikhamsai Province'),
('LAO', 'LA-CH', 'Champasak Province'),
('LAO', 'LA-HO', 'Houaphanh Province'),
('LAO', 'LA-KH', 'Khammouane Province'),
('LAO', 'LA-LM', 'Luang Namtha Province'),
('LAO', 'LA-LP', 'Luang Prabang Province'),
('LAO', 'LA-OU', 'Oudomxay Province'),
('LAO', 'LA-PH', 'Phongsaly Province'),
('LAO', 'LA-SL', 'Salavan Province'),
('LAO', 'LA-SV', 'Savannakhet Province'),
('LAO', 'LA-XA', 'Xaignabouli Province'),
('LAO', 'LA-XI', 'Xiangkhouang Province')
ON CONFLICT (division_cd) DO NOTHING;
