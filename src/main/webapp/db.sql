-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2025 at 08:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itp4511_project_db`
--
CREATE DATABASE IF NOT EXISTS `itp4511_project_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `itp4511_project_db`;

-- --------------------------------------------------------

--
-- Table structure for table `account_type`
--

CREATE TABLE `account_type` (
  `ID` char(2) NOT NULL,
  `Type` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_type`
--

INSERT INTO `account_type` (`ID`, `Type`) VALUES
('T1', 'shop'),
('T2', 'warehouse'),
('T3', 'SeniorManagement');

-- --------------------------------------------------------

--
-- Table structure for table `country_region`
--

CREATE TABLE `country_region` (
  `ID` char(2) NOT NULL,
  `Name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `country_region`
--

INSERT INTO `country_region` (`ID`, `Name`) VALUES
('AD', 'Andorra'),
('AE', 'United Arab Emirates'),
('AF', 'Afghanistan'),
('AG', 'Antigua and Barbuda'),
('AI', 'Anguilla'),
('AL', 'Albania'),
('AM', 'Armenia'),
('AO', 'Angola'),
('AQ', 'Antarctica'),
('AR', 'Argentina'),
('AS', 'American Samoa'),
('AT', 'Austria'),
('AU', 'Australia'),
('AW', 'Aruba'),
('AX', 'Åland Islands'),
('AZ', 'Azerbaijan'),
('BA', 'Bosnia and Herzegovina'),
('BB', 'Barbados'),
('BD', 'Bangladesh'),
('BE', 'Belgium'),
('BF', 'Burkina Faso'),
('BG', 'Bulgaria'),
('BH', 'Bahrain'),
('BI', 'Burundi'),
('BJ', 'Benin'),
('BL', 'Saint Barthélemy'),
('BM', 'Bermuda'),
('BN', 'Brunei Darussalam'),
('BO', 'Bolivia'),
('BQ', 'Bonaire, Sint Eustatius and Saba'),
('BR', 'Brazil'),
('BS', 'Bahamas'),
('BT', 'Bhutan'),
('BV', 'Bouvet Island'),
('BW', 'Botswana'),
('BY', 'Belarus'),
('BZ', 'Belize'),
('CA', 'Canada'),
('CC', 'Cocos (Keeling) Islands'),
('CD', 'Congo, Democratic Republic of the'),
('CF', 'Central African Republic'),
('CG', 'Congo'),
('CH', 'Switzerland'),
('CI', 'Côte d\'Ivoire'),
('CK', 'Cook Islands'),
('CL', 'Chile'),
('CM', 'Cameroon'),
('CN', 'China'),
('CO', 'Colombia'),
('CR', 'Costa Rica'),
('CU', 'Cuba'),
('CV', 'Cabo Verde'),
('CW', 'Curaçao'),
('CX', 'Christmas Island'),
('CY', 'Cyprus'),
('CZ', 'Czechia'),
('DE', 'Germany'),
('DJ', 'Djibouti'),
('DK', 'Denmark'),
('DM', 'Dominica'),
('DO', 'Dominican Republic'),
('DZ', 'Algeria'),
('EC', 'Ecuador'),
('EE', 'Estonia'),
('EG', 'Egypt'),
('EH', 'Western Sahara'),
('ER', 'Eritrea'),
('ES', 'Spain'),
('ET', 'Ethiopia'),
('FI', 'Finland'),
('FJ', 'Fiji'),
('FK', 'Falkland Islands (Malvinas)'),
('FM', 'Micronesia, Federated States of'),
('FO', 'Faroe Islands'),
('FR', 'France'),
('GA', 'Gabon'),
('GB', 'United Kingdom'),
('GD', 'Grenada'),
('GE', 'Georgia'),
('GF', 'French Guiana'),
('GG', 'Guernsey'),
('GH', 'Ghana'),
('GI', 'Gibraltar'),
('GL', 'Greenland'),
('GM', 'Gambia'),
('GN', 'Guinea'),
('GP', 'Guadeloupe'),
('GQ', 'Equatorial Guinea'),
('GR', 'Greece'),
('GS', 'South Georgia and the South Sandwich Isl'),
('GT', 'Guatemala'),
('GU', 'Guam'),
('GW', 'Guinea-Bissau'),
('GY', 'Guyana'),
('HK', 'Hong Kong'),
('HM', 'Heard Island and McDonald Islands'),
('HN', 'Honduras'),
('HR', 'Croatia'),
('HT', 'Haiti'),
('HU', 'Hungary'),
('ID', 'Indonesia'),
('IE', 'Ireland'),
('IL', 'Israel'),
('IM', 'Isle of Man'),
('IN', 'India'),
('IO', 'British Indian Ocean Territory'),
('IQ', 'Iraq'),
('IR', 'Iran, Islamic Republic of'),
('IS', 'Iceland'),
('IT', 'Italy'),
('JE', 'Jersey'),
('JM', 'Jamaica'),
('JO', 'Jordan'),
('JP', 'Japan'),
('KE', 'Kenya'),
('KG', 'Kyrgyzstan'),
('KH', 'Cambodia'),
('KI', 'Kiribati'),
('KM', 'Comoros'),
('KN', 'Saint Kitts and Nevis'),
('KP', 'Korea, Democratic People\'s Republic of'),
('KR', 'Korea, Republic of'),
('KW', 'Kuwait'),
('KY', 'Cayman Islands'),
('KZ', 'Kazakhstan'),
('LA', 'Lao People\'s Democratic Republic'),
('LB', 'Lebanon'),
('LC', 'Saint Lucia'),
('LI', 'Liechtenstein'),
('LK', 'Sri Lanka'),
('LR', 'Liberia'),
('LS', 'Lesotho'),
('LT', 'Lithuania'),
('LU', 'Luxembourg'),
('LV', 'Latvia'),
('LY', 'Libya'),
('MA', 'Morocco'),
('MC', 'Monaco'),
('MD', 'Moldova, Republic of'),
('ME', 'Montenegro'),
('MF', 'Saint Martin (French part)'),
('MG', 'Madagascar'),
('MH', 'Marshall Islands'),
('MK', 'North Macedonia'),
('ML', 'Mali'),
('MM', 'Myanmar'),
('MN', 'Mongolia'),
('MO', 'Macao'),
('MP', 'Northern Mariana Islands'),
('MQ', 'Martinique'),
('MR', 'Mauritania'),
('MS', 'Montserrat'),
('MT', 'Malta'),
('MU', 'Mauritius'),
('MV', 'Maldives'),
('MW', 'Malawi'),
('MX', 'Mexico'),
('MY', 'Malaysia'),
('MZ', 'Mozambique'),
('NA', 'Namibia'),
('NC', 'New Caledonia'),
('NE', 'Niger'),
('NF', 'Norfolk Island'),
('NG', 'Nigeria'),
('NI', 'Nicaragua'),
('NL', 'Netherlands'),
('NO', 'Norway'),
('NP', 'Nepal'),
('NR', 'Nauru'),
('NU', 'Niue'),
('NZ', 'New Zealand'),
('OM', 'Oman'),
('PA', 'Panama'),
('PE', 'Peru'),
('PF', 'French Polynesia'),
('PG', 'Papua New Guinea'),
('PH', 'Philippines'),
('PK', 'Pakistan'),
('PL', 'Poland'),
('PM', 'Saint Pierre and Miquelon'),
('PN', 'Pitcairn'),
('PR', 'Puerto Rico'),
('PS', 'Palestine, State of'),
('PT', 'Portugal'),
('PW', 'Palau'),
('PY', 'Paraguay'),
('QA', 'Qatar'),
('RE', 'Réunion'),
('RO', 'Romania'),
('RS', 'Serbia'),
('RU', 'Russian Federation'),
('RW', 'Rwanda'),
('SA', 'Saudi Arabia'),
('SB', 'Solomon Islands'),
('SC', 'Seychelles'),
('SD', 'Sudan'),
('SE', 'Sweden'),
('SG', 'Singapore'),
('SH', 'Saint Helena, Ascension and Tristan da C'),
('SI', 'Slovenia'),
('SJ', 'Svalbard and Jan Mayen'),
('SK', 'Slovakia'),
('SL', 'Sierra Leone'),
('SM', 'San Marino'),
('SN', 'Senegal'),
('SO', 'Somalia'),
('SR', 'Suriname'),
('SS', 'South Sudan'),
('ST', 'Sao Tome and Principe'),
('SV', 'El Salvador'),
('SX', 'Sint Maarten (Dutch part)'),
('SY', 'Syrian Arab Republic'),
('SZ', 'Eswatini'),
('TC', 'Turks and Caicos Islands'),
('TD', 'Chad'),
('TF', 'French Southern Territories'),
('TG', 'Togo'),
('TH', 'Thailand'),
('TJ', 'Tajikistan'),
('TK', 'Tokelau'),
('TL', 'Timor-Leste'),
('TM', 'Turkmenistan'),
('TN', 'Tunisia'),
('TO', 'Tonga'),
('TR', 'Turkey'),
('TT', 'Trinidad and Tobago'),
('TV', 'Tuvalu'),
('TW', 'Taiwan, Province of China'),
('TZ', 'Tanzania, United Republic of'),
('UA', 'Ukraine'),
('UG', 'Uganda'),
('UM', 'United States Minor Outlying Islands'),
('US', 'United States'),
('UY', 'Uruguay'),
('UZ', 'Uzbekistan'),
('VA', 'Holy See'),
('VC', 'Saint Vincent and the Grenadines'),
('VE', 'Venezuela, Bolivarian Republic of'),
('VG', 'Virgin Islands, British'),
('VI', 'Virgin Islands, U.S.'),
('VN', 'Viet Nam'),
('VU', 'Vanuatu'),
('WF', 'Wallis and Futuna'),
('WS', 'Samoa'),
('YE', 'Yemen'),
('YT', 'Mayotte'),
('ZA', 'South Africa'),
('ZM', 'Zambia'),
('ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `fruit`
--

CREATE TABLE `fruit` (
  `ID` char(4) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `CountryRegion` char(2) NOT NULL,
  `ImgName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fruit`
--

INSERT INTO `fruit` (`ID`, `Name`, `CountryRegion`, `ImgName`) VALUES
('F001', 'Apple', 'GB', 'F001_Apple.jpg'),
('F002', 'Orange', 'CN', 'F002_Orange.jpg'),
('F003', 'Banana', 'PH', 'F003_Banana.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `ID` char(4) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` char(4) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`ID`, `Address`, `City`, `PhoneNumber`) VALUES
('S001', '1-1 Shibuya', 'C001', '+81312345678'),
('S002', '2-3 Ginza', 'C001', '+81398765432'),
('S003', '456 Minato', 'C002', '+81451234567'),
('S004', '789 Namba', 'C003', '+81612345678'),
('S005', '101 Umeda', 'C003', '+81698765432'),
('S006', '321 Nagoya Station', 'C004', '+81521234567'),
('S007', '654 Chuo', 'C005', '+81111234567'),
('S008', '987 Hakata', 'C006', '+81921234567'),
('S009', '123 Port Island', 'C007', '+81781234567'),
('S010', '456 Gion', 'C008', '+81751234567'),
('S011', '789 Shin-Kawasaki', 'C009', '+81441234567'),
('S012', '101 Omiya', 'C010', '+81481234567'),
('S013', '321 Peace Park', 'C011', '+81821234567'),
('S014', '654 Aoba', 'C012', '+81221234567'),
('S015', '987 Makuhari', 'C013', '+81431234567'),
('S016', '123 Moji', 'C014', '+81931234567'),
('S017', '456 Kurashiki', 'C015', '+81861234567'),
('S018', '789 Satsuma', 'C016', '+81961234567'),
('S019', '101 Shimizu', 'C017', '+81541234567'),
('S020', '321 Fukuroi', 'C018', '+81531234567'),
('S021', '654 Joetsu', 'C019', '+81251234567'),
('S022', '987 Kagoshima Chuo', 'C020', '+81991234567'),
('S023', '123 Times Square', 'C021', '+12125550123'),
('S024', '456 Broadway', 'C021', '+12125559876'),
('S025', '789 Hollywood Blvd', 'C022', '+13235550123'),
('S026', '101 Sunset Strip', 'C022', '+13235559876'),
('S027', '321 Michigan Ave', 'C023', '+13125550123'),
('S028', '654 Main St', 'C024', '+17135550123'),
('S029', '987 Camelback Rd', 'C025', '+16025550123'),
('S030', '123 Market St', 'C026', '+12155550123'),
('S031', '456 Alamo Plaza', 'C027', '+12105550123'),
('S032', '789 Gaslamp', 'C028', '+16195550123'),
('S033', '101 Elm St', 'C029', '+12145550123'),
('S034', '321 First St', 'C030', '+14085550123'),
('S035', '654 Congress Ave', 'C031', '+15125550123'),
('S036', '987 Riverside Dr', 'C032', '+19045550123'),
('S037', '123 Mission St', 'C033', '+14155550123'),
('S038', '456 High St', 'C034', '+16145550123'),
('S039', '789 Pike St', 'C035', '+12065550123'),
('S040', '101 16th St', 'C036', '+13035550123'),
('S041', '321 Tremont St', 'C037', '+16175550123'),
('S042', '654 Music Row', 'C038', '+16155550123'),
('S043', '987 Las Vegas Blvd', 'C039', '+17025550123'),
('S044', '123 Ocean Dr', 'C040', '+13055550123'),
('S045', '456 Biscayne Blvd', 'C040', '+13055559876'),
('S046', '10 Des Voeux Rd', 'C041', '+85221234567'),
('S047', '25 Queen\'s Rd', 'C041', '+85229876543'),
('S048', '50 Chai Wan Rd', 'C042', '+85225678901'),
('S049', '12 Repulse Bay Rd', 'C043', '+85228123456'),
('S050', '88 Hennessy Rd', 'C044', '+85228912345'),
('S051', '15 Nathan Rd', 'C045', '+85227123456'),
('S052', '30 Kwun Tong Rd', 'C046', '+85223456789'),
('S053', '45 Cheung Sha Wan Rd', 'C047', '+85227891234'),
('S054', '60 Wong Tai Sin Rd', 'C048', '+85223234567'),
('S055', '75 Mong Kok Rd', 'C049', '+85223876543'),
('S056', '90 Prince Edward Rd', 'C049', '+85223987654'),
('S057', '10 Tung Chung Rd', 'C050', '+85221098765'),
('S058', '25 Kwai Chung Rd', 'C051', '+85224234567'),
('S059', '40 Sheung Shui St', 'C052', '+85226789012'),
('S060', '55 Sai Kung Rd', 'C053', '+85227912345'),
('S061', '70 Sha Tin Centre St', 'C054', '+85226345678'),
('S062', '85 Tai Po Rd', 'C055', '+85226567890'),
('S063', '100 Tsuen Wan Market St', 'C056', '+85224901234'),
('S064', '115 Tuen Mun Heung Sze Wui Rd', 'C057', '+85224567890'),
('S065', '130 Yuen Long Main Rd', 'C058', '+85224789012');

-- --------------------------------------------------------

--
-- Table structure for table `shop_city`
--

CREATE TABLE `shop_city` (
  `ID` char(4) NOT NULL,
  `City` varchar(40) NOT NULL,
  `CountryRegionID` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shop_city`
--

INSERT INTO `shop_city` (`ID`, `City`, `CountryRegionID`) VALUES
('C001', 'Tokyo', 'JP'),
('C002', 'Yokohama', 'JP'),
('C003', 'Osaka', 'JP'),
('C004', 'Nagoya', 'JP'),
('C005', 'Sapporo', 'JP'),
('C006', 'Fukuoka', 'JP'),
('C007', 'Kobe', 'JP'),
('C008', 'Kyoto', 'JP'),
('C009', 'Kawasaki', 'JP'),
('C010', 'Saitama', 'JP'),
('C011', 'Hiroshima', 'JP'),
('C012', 'Sendai', 'JP'),
('C013', 'Chiba', 'JP'),
('C014', 'Kitakyushu', 'JP'),
('C015', 'Okayama', 'JP'),
('C016', 'Kumamoto', 'JP'),
('C017', 'Shizuoka', 'JP'),
('C018', 'Hamamatsu', 'JP'),
('C019', 'Niigata', 'JP'),
('C020', 'Kagoshima', 'JP'),
('C021', 'New York', 'US'),
('C022', 'Los Angeles', 'US'),
('C023', 'Chicago', 'US'),
('C024', 'Houston', 'US'),
('C025', 'Phoenix', 'US'),
('C026', 'Philadelphia', 'US'),
('C027', 'San Antonio', 'US'),
('C028', 'San Diego', 'US'),
('C029', 'Dallas', 'US'),
('C030', 'San Jose', 'US'),
('C031', 'Austin', 'US'),
('C032', 'Jacksonville', 'US'),
('C033', 'San Francisco', 'US'),
('C034', 'Columbus', 'US'),
('C035', 'Seattle', 'US'),
('C036', 'Denver', 'US'),
('C037', 'Boston', 'US'),
('C038', 'Nashville', 'US'),
('C039', 'Las Vegas', 'US'),
('C040', 'Miami', 'US'),
('C041', 'Central and Western', 'HK'),
('C042', 'Eastern', 'HK'),
('C043', 'Southern', 'HK'),
('C044', 'Wan Chai', 'HK'),
('C045', 'Kowloon City', 'HK'),
('C046', 'Kwun Tong', 'HK'),
('C047', 'Sham Shui Po', 'HK'),
('C048', 'Wong Tai Sin', 'HK'),
('C049', 'Yau Tsim Mong', 'HK'),
('C050', 'Islands', 'HK'),
('C051', 'Kwai Tsing', 'HK'),
('C052', 'North', 'HK'),
('C053', 'Sai Kung', 'HK'),
('C054', 'Sha Tin', 'HK'),
('C055', 'Tai Po', 'HK'),
('C056', 'Tsuen Wan', 'HK'),
('C057', 'Tuen Mun', 'HK'),
('C058', 'Yuen Long', 'HK');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` char(5) NOT NULL,
  `StaffName` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `AccountType` char(2) NOT NULL,
  `shop` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_type`
--
ALTER TABLE `account_type`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `country_region`
--
ALTER TABLE `country_region`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `fruit`
--
ALTER TABLE `fruit`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CountryRegion_fk` (`CountryRegion`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `city_fk` (`City`);

--
-- Indexes for table `shop_city`
--
ALTER TABLE `shop_city`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_shop_city_country_region` (`CountryRegionID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD KEY `type_fk` (`AccountType`),
  ADD KEY `shop_fk` (`shop`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fruit`
--
ALTER TABLE `fruit`
  ADD CONSTRAINT `CountryRegion_fk` FOREIGN KEY (`CountryRegion`) REFERENCES `country_region` (`ID`),
  ADD CONSTRAINT `Country_region_fk` FOREIGN KEY (`CountryRegion`) REFERENCES `country_region` (`ID`);

--
-- Constraints for table `shop`
--
ALTER TABLE `shop`
  ADD CONSTRAINT `city_fk` FOREIGN KEY (`City`) REFERENCES `shop_city` (`ID`);

--
-- Constraints for table `shop_city`
--
ALTER TABLE `shop_city`
  ADD CONSTRAINT `FK_shop_city_country_region` FOREIGN KEY (`CountryRegionID`) REFERENCES `country_region` (`ID`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `shop_fk` FOREIGN KEY (`shop`) REFERENCES `shop` (`ID`),
  ADD CONSTRAINT `type_fk` FOREIGN KEY (`AccountType`) REFERENCES `account_type` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
