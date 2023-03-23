DROP TABLE ouis;
DROP TABLE manufacturers;
DROP TABLE countries;
CREATE TABLE countries (
  Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  NameEn Text NOT NULL,
  NameRu Text NOT NULL,
  A2 Text NOT NULL,
  A3 Text NOT NULL,
  ISOCode Text);
CREATE TABLE manufacturers (
  Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  NameEn Text NOT NULL,
  NameRu Text NOT NULL,
  Address Text NOT NULL,
  Country Int NOT NULL,
    CONSTRAINT FK_Manufacturers_Country FOREIGN KEY (Country) REFERENCES countries(Id));
CREATE TABLE ouis (
  Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  Mask Int NOT NULL,
  Manufacturer Int NOT NULL,
    CONSTRAINT FK_Ouis_Manufacturer FOREIGN KEY (Manufacturer) REFERENCES manufacturers(Id));

 INSERT INTO countries ( 
   NameEn, NameRu,
   A2, A3, ISOCode)
 VALUES (
    '', '', '', '', '000'), (
	'Australia',				'Австралия','AU','AUS','036'), (
	'Austria',					'Австрия', 'AT', 'AUT', '040'), (
	'Azerbaijan',				'Азербайджан','AZ','AZE','031'), (
	'Albania', 					'Албания', 'AL', 'ALB', '008'), (
	'Algeria', 					'Алжир', 'DZ', 'DZA', '012'), (
	'Anguilla', 'Ангилья о. (GB)', 'AI', 'AIA', '660'), (
	'Angola', 'Ангола', 'AO', 'AGO', '024'), (
	'Andorra', 'Андорра', 'AD', 'AND', '020'), (
	'Antarctic', 'Антарктика', 'AQ', 'ATA', '010'), (
	'Antigua and Barbuda', 'Антигуа и Барбуда', 'AG', 'ATG', '028'), (
	'Netherlands'' An lles', 'Антильские о‐ва (NL)', 'AN', 'ANT', '530'), (
	'Argentina', 'Аргентина', 'AR', 'ARG', '032'), (
	'Armenia', 'Армения', 'AM', 'ARM', '051'), (
	'Aruba', 'Аруба', 'AW', 'ABW', '533'), (
	'Afghanistan', 'Афганистан', 'AF', 'AFG', '004'), (
	'Bahamas', 'Багамы', 'BS', 'BHS', '044'), (
	'Bangladesh', 'Бангладеш', 'BD', 'BGD', '050'), (
	'Barbados', 'Барбадос', 'BB', 'BB', '052'), (
	'Bahrain', 'Бахрейн', 'BH', 'BHR', '048'), (
	'Belarus', 'Беларусь', 'BY', 'BLR', '112'), (
	'Belize', 'Белиз', 'BZ', 'BLZ', '084'), (
	'Belgium', 'Бельгия', 'BE', 'BEL', '056'), (
	'Benin', 'Бенин', 'BJ', 'BEN', '204'), (
	'Bermuda', 'Бермуды', 'BM', 'BMU', '060'), (
	'Bouvet Island', 'Бове о. (NO)', 'BV', 'BVT', '074'), (
	'Bulgaria', 'Болгария', 'BG', 'BGR', '100'), (
	'Bolivia', 'Боливия', 'BO', 'BOL', '068'), (
	'Bosnia & Herzegovina', 'Босния и Герцеговина', 'BA', 'BIH', '070'), (
	'Botswana', 'Ботсвана', 'BW', 'BWA', '072'), (
	'Brazil', 'Бразилия', 'BR', 'BRA', '076'), (
	'Brunei Darussalam', 'Бруней Дарассалам', 'BN', 'BRN', '096'), (
	'Burkina‐Faso', 'Буркина‐Фасо', 'BF', 'BFA', '854'), (
	'Burundi', 'Бурунди', 'BI', 'BDI', '108'), (
	'Bhutan', 'Бутан', 'BT', 'BTN', '064'), (
	'Vanuatu', 'Вануату', 'VU', 'VUT', '548'), (
	'Vatican (Holy See)', 'Ватикан', 'VA', 'VAT', '336'), (
	'Great Britain (United Kingdom)', 'Великобритания', 'GB', 'GBR', '826'), (
	'Hungary', 'Венгрия', 'HU', 'HUN', '348'), (
	'Venezuela', 'Венесуэла', 'VE', 'VEN', '862'), (
	'Virgin Islands, British', 'Виргинские о‐ва (GB)', 'VG', 'VGB', '092'), (
	'Virgin Islands, US', 'Виргинские о‐ва (US)', 'VI', 'VIR', '850'), (
	'American Samoa', 'Восточное Самоа (US)', 'AS', 'ASM', '016'), (
	'East Timor', 'Восточный Тимор', 'TP', 'TMP', '626'), (
	'Viet Nam', 'Вьетнам', 'VN', 'VNM', '704'), (
	'Gabon', 'Габон', 'GA', 'GAB', '266'), (
	'Haiti', 'Гаити', 'HT', 'HTI', '332'), (
	'Guyana', 'Гайана', 'GY', 'GUY', '328'), (
	'Gambia', 'Гамбия', 'GM', 'GMB', '270'), (
	'Ghana', 'Гана', 'GH', 'GHA', '288'), (
	'Guadeloupe', 'Гваделупа', 'GP', 'GLP', '312'), (
	'Guatemala', 'Гватемала', 'GT', 'GTM', '320'), (
	'Guinea', 'Гвинея', 'GN', 'GIN', '324'), (
	'Guinea‐Bissau', 'Гвинея‐Бисау', 'GW', 'GNB', '624'), (
	'Germany', 'Германия', 'DE', 'DEU', '276'), (
	'Gibraltar', 'Гибралтар', 'GI', 'GIB', '292'), (
	'Honduras', 'Гондурас', 'HN', 'HND', '340'), (
	'Hong Kong', 'Гонконг (CN', 'HK', 'HKG', '344'), (
	'Grenada', 'Гренада', 'GD', 'GRD', '308'), (
	'Greenland', 'Гренландия (DK)', 'GL', 'GRL', '304'), (
	'Greece', 'Греция', 'GR', 'GRC', '300'), (
	'Georgia', 'Грузия', 'GE', 'GEO', '268'), (
	'Guam', 'Гуам', 'GU', 'GUM', '316'), (
	'Denmark', 'Дания', 'DK', 'DNK', '208'), (
	'Congo, Democratic Republic of the', 'Демократическая Республика Конго', 'CD', 'COD', '180'), (
	'Djibouti', 'Джибути', 'DJ', 'DJI', '262'), (
	'Dominica', 'Доминика', 'DM', 'DMA', '212'), (
	'Dominican Republic', 'Доминиканская Республика', 'DO', 'DOM', '214'), (
	'Egypt', 'Египет', 'EG', 'EGY', '818'), (
	'Zambia', 'Замбия', 'ZM', 'ZMB', '894'), (
	'Western Sahara', 'Западная Сахара', 'EH', 'ESH', '732'), (
	'Zimbabwe', 'Зимбабве', 'ZW', 'ZWE', '716'), (
	'Israel', 'Израиль', 'IL', 'ISR', '376'), (
	'India', 'Индия', 'IN', 'IND', '356'), (
	'Indonesia', 'Индонезия', 'ID', 'IDN', '360'), (
	'Jordan', 'Иордания', 'JO', 'JOR', '400'), (
	'Iraq', 'Ирак', 'IQ', 'IRQ', '368'), (
	'Iran', 'Иран', 'IR', 'IRN', '364'), (
	'Ireland', 'Ирландия', 'IE', 'IRL', '372'), (
	'Iceland', 'Исландия', 'IS', 'ISL', '352'), (
	'Spain', 'Испания', 'ES', 'ESP', '724'), (
	'Italy', 'Италия', 'IT', 'ITA', '380'), (
	'Yemen', 'Йемен', 'YE', 'YEM', '887'), (
	'Cape Verde', 'Кабо‐Верде', 'CV', 'CPV', '132'), (
	'Kazakhstan', 'Казахстан', 'KZ', 'KAZ', '398'), (
	'Cayman Islands', 'Каймановы о‐ва (GB)', 'KY', 'CYM', '136'), (
	'Cambodia', 'Камбоджа', 'KH', 'KHM', '116'), (
	'Cameroon', 'Камерун', 'CM', 'CMR', '120'), (
	'Canada', 'Канада', 'CA', 'CAN', '124'), (
	'Qatar', 'Катар', 'QA', 'QAT', '634'), (
	'Kenya', 'Кения', 'KE', 'KEN', '404'), (
	'Cyprus', 'Кипр', 'CY', 'CYP', '196'), (
	'Kirghizstan', 'Киргизстан', 'KG', 'KGZ', '417'), (
	'Kiribati', 'Кирибати', 'KI', 'KIR', '296'), (
	'China', 'Китай', 'CN', 'CHN', '156'), (
	'Cocos (Keeling) Islands', 'Кокосовые (Киилинг) о‐ва (AU)', 'CC', 'CCK', '166'), (
	'Colombia', 'Колумбия', 'CO', 'COL', '170'), (
	'Comoros', 'Коморские о‐ва', 'KM', 'COM', '174'), (
	'Congo', 'Конго', 'CG', 'COG', '178'), (
	'Costa Rica', 'Коста‐Рика', 'CR', 'CRI', '188'), (
	'Cote d''Ivoire', 'Кот‐д''Ивуар', 'CI', 'CIV', '384'), (
	'Cuba', 'Куба', 'CU', 'CUB', '192'), (
	'Kuwait', 'Кувейт', 'KW', 'KWT', '414'), (
	'Cook Islands', 'Кука о‐ва (NZ)', 'CK', 'COK', '184'), (
	'Lao People''s Democratic Republic', 'Лаос', 'LA', 'LAO', '418'), (
	'Latvia', 'Латвия', 'LV', 'LVA', '428'), (
	'Lesotho', 'Лесото', 'LS', 'LSO', '426'), (
	'Liberia', 'Либерия', 'LR', 'LBR', '430'), (
	'Lebanon', 'Ливан', 'LB', 'LBN', '422'), (
	'Libyan Arab Jamahiriya', 'Ливия', 'LY', 'LBY', '434'), (
	'Lithuania', 'Литва', 'LT', 'LTU', '440'), (
	'Liechtenstein', 'Лихтенштейн', 'LI', 'LIE', '438'), (
	'Luxembourg', 'Люксембург', 'LU', 'LUX', '442'), (
	'Mauritius', 'Маврикий', 'MU', 'MUS', '480'), (
	'Mauritania', 'Мавритания', 'MR', 'MRT', '478'), (
	'Madagascar', 'Мадагаскар', 'MG', 'MDG', '450'), (
	'Mayotte', 'Майотта о. (KM)', 'YT', 'MYT', '175'), (
	'Macau (Macao)', 'Макао (PT)', 'MO', 'MAC', '446'), (
	'Macedonia', 'Македония', 'MK', 'MKD', '807'), (
	'Malawi', 'Малави', 'MW', 'MWI', '454'), (
	'Malaysia', 'Малайзия', 'MY', 'MYS', '458'), (
	'Mali', 'Мали', 'ML', 'MLI', '466'), (
	'Maldives', 'Мальдивы', 'MV', 'MDV', '462'), (
	'Malta', 'Мальта', 'MT', 'MLT', '470'), (
	'Marocco', 'Марокко', 'MA', 'MAR', '504'), (
	'Martinique', 'Мартиника', 'MQ', 'MTQ', '474'), (
	'Marshall Islands', 'Маршалловы о‐ва', 'MH', 'MHL', '584'), (
	'Mexico', 'Мексика', 'MX', 'MEX', '484'), (
	'Federated States of Micronesia', 'Микронезия (US)', 'FM', 'FSM', '583'), (
	'Mozambique', 'Мозамбик', 'MZ', 'MOZ', '508'), (
	'Moldova', 'Молдова', 'MD', 'MDA', '498'), (
	'Monaco', 'Монако', 'MC', 'MCO', '492'), (
	'Mongolia', 'Монголия', 'MN', 'MNG', '496'), (
	'Montserrat', 'Монсеррат о. (GB)', 'MS', 'MSR', '500'), (
	'Myanmar', 'Мьянма', 'MM', 'MMR', '104'), (
	'Namibia', 'Намибия', 'NA', 'NAM', '516'), (
	'Nauru', 'Науру', 'NR', 'NRU', '520'), (
	'Nepal', 'Непал', 'NP', 'NPL', '524'), (
	'Niger', 'Нигер', 'NE', 'NER', '562'), (
	'Nigeria', 'Нигерия', 'NG', 'NGA', '566'), (
	'Netherlands', 'Нидерланды', 'NL', 'NLD', '528'), (
	'Nicaragua', 'Никарагуа', 'NI', 'NIC', '558'), (
	'Niue', 'Ниуэ о. (NZ)', 'NU', 'NIU', '570'), (
	'New Zealand', 'Новая Зеландия', 'NZ', 'NZL', '554'), (
	'New Caledonia', 'Новая Каледония о. (FR)', 'NC', 'NCL', '540'), (
	'Norway', 'Норвегия', 'NO', 'NOR', '578'), (
	'Norfolk Island', 'Норфолк о. (AU)', 'NF', 'NFK', '574'), (
	'United Arab Emirates', 'Объединенные Арабские Эмираты', 'AE', 'ARE', '784'), (
	'Oman', 'Оман', 'OM', 'OMN', '512'), (
	'Pakistan', 'Пакистан', 'PK', 'PAK', '586'), (
	'Palau', 'Палау (US)', 'PW', 'PLW', '585'), (
	'Pales nian Territory (occupied)', 'Палестинская автономия', 'PS', 'PSE', '275'), (
	'Panama', 'Панама', 'PA', 'PAN', '591'), (
	'Papua New Guinea', 'Папуа‐Новая Гвинея', 'PG', 'PNG', '598'), (
	'Paraguay', 'Парагвай', 'PY', 'PRY', '600'), (
	'Peru', 'Перу', 'PE', 'PER', '604'), (
	'Pitcairn', 'Питкэрн о-ва (GB)', 'PN', 'PCN', '612'), (
	'Poland', 'Польша', 'PL', 'POL', '616'), (
	'Portugal', 'Португалия', 'PT', 'PRT', '620'), (
	'Puerto Rico', 'Пуэрто‐Рико (US)', 'PR', 'PRI', '630'), (
	'Reunion', 'Реюньон о. (FR)', 'RE', 'REU', '638'), (
	'Christmas Island', 'Рождества о. (AU)', 'CX', 'CXR', '162'), (
	'Russia (Russian Federation)', 'Россия', 'RU', 'RUS', '643'), (
	'Rwanda', 'Руанда', 'RW', 'RWA', '646'), (
	'Romania', 'Румыния', 'RO', 'ROM', '642'), (
	'El Salvador', 'Сальвадор', 'SV', 'SLV', '222'), (
	'Samoa', 'Самоа', 'WS', 'WSM', '882'), (
	'San Marino', 'Сан Марино', 'SM', 'SMR', '674'), (
	'Sao Tomea and Principe', 'Сан‐Томе и Принсипи', 'ST', 'STP', '678'), (
	'Saudi Arabia', 'Саудовская Аравия', 'SA', 'SAU', '682'), (
	'Swaziland', 'Свазиленд', 'SZ', 'SWZ', '748'), (
	'Svalbard and Jan Mayen Islands', 'Свалбард и Ян Мейен о‐ва (NO)', 'SJ', 'SJM', '744'), (
	'St. Helena', 'Святой Елены о. (GB)', 'SH', 'SHN', '654'), (
	'Korea (North)', 'Северная Корея (КНДР)', 'KP', 'PRK', '408'), (
	'Northern Mariana Islands', 'Северные Марианские', 'MP', 'MNP', '580'), (
	'Seychelles', 'Сейшелы', 'SC', 'SYC', '690'), (
	'Saint Vincent and the Grenadines', 'Сен‐Винсент и Гренадины', 'VC', 'VCT', '670'), (
	'St. Pierre and Miquelon', 'Сен‐Пьер и Микелон (FR)', 'PM', 'SPM', '666'), (
	'Senegal', 'Сенегал', 'SN', 'SEN', '686'), (
	'Saint Kitts (Christopher) and Nevis', 'Сент‐Кристофер и Невис', 'KN', 'KNA', '659'), (
	'Saint Lucia', 'Сент‐Люсия', 'LC', 'LCA', '662'), (
	'Singapore', 'Сингапур', 'SG', 'SGP', '702'), (
	'Syria', 'Сирия', 'SY', 'SYR', '760'), (
	'Slovak Republic', 'Словакия', 'SK', 'SVK', '703'), (
	'Slovenia', 'Словения', 'SI', 'SVN', '705'), (
	'United States of America', 'Соединенные Штаты Америки', 'US', 'USA', '840'), (
	'Solomon Islands', 'Соломоновы о‐ва', 'SB', 'SLB', '090'), (
	'Somali', 'Сомали', 'SO', 'SOM', '706'), (
	'Sudan', 'Судан', 'SD', 'SDN', '736'), (
	'Surinam', 'Суринам', 'SR', 'SUR', '740'), (
	'Sierra Leone', 'Сьерра‐Леоне', 'SL', 'SLE', '694'), (
	'Tadjikistan', 'Таджикистан', 'TJ', 'TJK', '762'), (
	'Thailand', 'Таиланд', 'TH', 'THA', '764'), (
	'Taiwan', 'Тайвань', 'TW', 'TWN', '158'), (
	'Tanzania', 'Танзания', 'TZ', 'TZA', '834'), (
	'Turks and Caicos Islands', 'Теркс и Кайкос о-ва (GB)', 'TC', 'TCA', '796'), (
	'Togo', 'Того', 'TG', 'TGO', '768'), (
	'Tokelau', 'Токелау о‐ва (NZ)', 'TK', 'TKL', '772'), (
	'Tonga', 'Тонга', 'TO', 'TON', '776'), (
	'Trinidad and Tobago', 'Тринидад и Тобаго', 'TT', 'TTO', '780'), (
	'Tuvalu', 'Тувалу', 'TV', 'TUV', '798'), (
	'Tunisia', 'Тунис', 'TN', 'TUN', '788'), (
	'Turkmenistan', 'Туркменистан', 'TM', 'TKM', '795'), (
	'Turkey', 'Турция', 'TR', 'TUR', '792'), (
	'Uganda', 'Уганда', 'UG', 'UGA', '800'), (
	'Uzbekistan', 'Узбекистан', 'UZ', 'UZB', '860'), (
	'Ukraine', 'Украина', 'UA', 'UKR', '804'), (
	'Wallis and Futuna Islands', 'Уоллис и Футунао‐ва (FR)', 'WF', 'WLF', '876'), (
	'Uruguay', 'Уругвай', 'UY', 'URY', '858'), (
	'Faroe Islands', 'Фарерские о‐ва (DK)', 'FO', 'FRO', '234'), (
	'Fiji', 'Фиджи', 'FJ', 'FJI', '242'), (
	'Philippines', 'Филиппины', 'PH', 'PHL', '608'), (
	'Finland', 'Финляндия', 'FI', 'FIN', '246'), (
	'Falkland (Malvinas) Islands', 'Фолклендские (Мальвинские) о‐ва (GB/AR)', 'FK', 'FLK', '238'), (
	'France', 'Франция', 'FR', 'FRA', '250'), (
	'French Guyana', 'Французская Гвиана (FR)', 'GF', 'GUF', '254'), (
	'French Polynesia', 'Французская Полинезия', 'PF', 'PYF', '258'), (
	'Heard and McDonald Islands', 'Херд и Макдональд о-ва (AU)', 'HM', 'HMD', '334'), (
	'Croatia', 'Хорватия', 'HR', 'HRV', '191'), (
	'Central African Republic', 'Центрально-африканская Республика', 'CF', 'CAF', '140'), (
	'Chad', 'Чад', 'TD', 'TCD', '148'), (
	'Czech Republic', 'Чехия', 'CZ', 'CZE', '203'), (
	'Chili', 'Чили', 'CL', 'CHL', '152'), (
	'Switzerland', 'Швейцария', 'CH', 'CHE', '756'), (
	'Sweden', 'Швеция', 'SE', 'SWE', '752'), (
	'Sri Lanka', 'Шри‐Ланка', 'LK', 'LKA', '144'), (
	'Ecuador', 'Эквадор', 'EC', 'ECU', '218'), (
	'Equatorial Guinea', 'Экваториальная Гвинея', 'GQ', 'GNQ', '226'), (
	'Eritrea', 'Эритрия', 'ER', 'ERI', '232'), (
	'Estonia', 'Эстония', 'EE', 'EST', '233'), (
	'Ethiopia', 'Эфиопия', 'ET', 'ETH', '231'), (
	'Yugoslavia', 'Югославия', 'YU', 'YUG', '891'), (
	'South Africa', 'Южная Африка', 'ZA', 'ZAF', '710'), (
	'South Georgia and the South Sandwich Islands', 'Южная Георгия и Южные Сандвичевы о-ва', 'GS', 'SGS', '239'), (
	'Korea (South)', 'Южная Корея (Республика Корея)', 'KR', 'KOR', '410'), (
	'Jamaica', 'Ямайка', 'JM', 'JAM', '388'), (
	'Japan', 'Япония', 'JP', 'JPN', '392'), (
	'French Southern Territories', 'Французские южные территории (FR)', 'TF', 'ATF', '260'), (
	'British Indian Ocean Territory', 'Британская территория Индийского океана (GB)', 'IO', 'IOT', '086'), (
	'United States Minor Outlying Islands', 'Соединенные Штаты Америки Внешние малые острова (US)', 'UM', 'UMI', '581'), (
	'Republic of Serbia', 'Республика Сербия', 'RS', 'SRB', '688')

DROP TABLE IF EXISTS Protocols ;
CREATE TABLE Protocols (
	Id INTEGER PRIMARY KEY NOT NULL,
	Name Text NOT NULL,	
	Description Text NOT NULL,
	Ref Text NOT NULL);
insert into Protocols (
	Id, Name, Ref, Description
) 
values (
	0, 'HOPOPT', 'IPv6 Hop-by-Hop Option', 'RFC 8200'), (
	1, 'ICMP', 'Internet Control Message Protocol', 'RFC 792'), (
	2, 'IGMP', 'Internet Group Management Protocol', 'RFC 1112'), (
	3, 'GGP', 'Gateway-to-Gateway Protocol', 'RFC 823'), (
	4, 'IP-in-IP', 'IP in IP (encapsulation)', 'RFC 2003'), (
	5, 'ST', 'Internet Stream Protocol' ,'RFC 1190, RFC 1819'), (
	6, 'TCP', 'Transmission Control Protocol', 'RFC 793'), (
	7, 'CBT', 'Core-based trees	RFC 2189', ''), (
	8, 'EGP', 'Exterior Gateway Protocol', 'RFC 888'), (
	9, 'IGP', 'Interior Gateway Protocol (any private interior gateway, for example Cisco''s IGRP)', ''), (
	10,	'BBN-RCC-MON', 'BBN RCC Monitoring', ''), (
	11, 'NVP-II', 'Network Voice Protocol', 'RFC 741'), (
	12,	'PUP', 'Xerox PUP', ''), (
	13,	'ARGUS', 'ARGUS', ''), (
	14,	'EMCON', 'EMCON', ''), (
	15, 'XNET', 'Cross Net Debugger', 'IEN 158[2]'), (
	16, 'CHAOS', 'Chaos', ''), (
	17,	'UDP', 'User Datagram Protocol', 'RFC 768'), (
	18,	'MUX', 'Multiplexing', 'IEN 90[3]'), (
	19,	'DCN-MEAS', 'DCN Measurement Subsystems', ''), (
	20,	'HMP', 'Host Monitoring Protocol', 'RFC 869'), (
	21,	'PRM', 'Packet Radio Measurement', ''), (	
	22,	'XNS-IDP', 'XEROX NS IDP', ''), (
	23,	'TRUNK-1', 'Trunk-1', ''), (
	24,	'TRUNK-2', 'Trunk-2', ''), (
	25,	'LEAF-1', 'Leaf-1', ''), (
	26,	'LEAF-2', 'Leaf-2', ''), (
	27,	'RDP', 'Reliable Data Protocol', 'RFC 908'), (
	28,	'IRTP', 'Internet Reliable Transaction Protocol', 'RFC 938'), (
	29,	'ISO-TP4', 'ISO Transport Protocol Class 4', 'RFC 905'), (
	30,	'NETBLT', 'Bulk Data Transfer Protocol', 'RFC 998'), (
	31,	'MFE-NSP', 'MFE Network Services Protocol', ''), (
	32,	'MERIT-INP', 'MERIT Internodal Protocol', ''), (
	33,	'DCCP', 'Datagram Congestion Control Protocol', 'RFC 4340'), (
	34,	'3PC', 'Third Party Connect Protocol', ''), (
	35,	'IDPR', 'Inter-Domain Policy Routing Protocol', 'RFC 1479'), (
	36,	'XTP', 'Xpress Transport Protocol', ''), (
	37,	'DDP', 'Datagram Delivery Protocol', ''), (
	38,	'IDPR-CMTP', 'IDPR Control Message Transport Protocol', ''), (
	39,	'TP++', 'TP++ Transport Protocol', ''), (
	40,	'IL', 'IL Transport Protocol', ''), (
	41,	'IPv6', 'IPv6 Encapsulation (6to4 and 6in4)', 'RFC 2473'), (
	42,	'SDRP', 'Source Demand Routing Protocol', 'RFC 1940'), (
	43,	'IPv6-Route', 'Routing Header for IPv6', 'RFC 8200'), (
	44,	'IPv6-Frag', 'Fragment Header for IPv6', 'RFC 8200'), (
	45,	'IDRP', 'Inter-Domain Routing Protocol', ''), (
	46,	'RSVP', 'Resource Reservation Protocol', 'RFC 2205'), (
	47,	'GRE', 'Generic Routing Encapsulation', 'RFC 2784, RFC 2890'), (
	48,	'DSR', 'Dynamic Source Routing Protocol', 'RFC 4728'), (
	49,	'BNA', 'Burroughs Network Architecture', ''), (
	50,	'ESP', 'Encapsulating Security Payload', 'RFC 4303'), (
	51,	'AH', 'Authentication Header', 'RFC 4302'), (
	52,	'I-NLSP', 'Integrated Net Layer Security Protocol TUBA', ''), (
	53,	'SwIPe', 'SwIPe', 'RFC 5237'), (
	54,	'NARP', 'NBMA Address Resolution Protocol', 'RFC 1735'), (
	55,	'MOBILE', 'IP Mobility (Min Encap)', 'RFC 2004'), (
	56,	'TLSP', 'Transport Layer Security Protocol (using Kryptonet key management)', ''), (
	57,	'SKIP', 'Simple Key-Management for Internet Protocol', 'RFC 2356'), (
	58,	'IPv6-ICMP', 'ICMP for IPv6', 'RFC 4443, RFC 4884'), (
	59,	'IPv6-NoNxt', 'No Next Header for IPv6', 'RFC 8200'), (
	60,	'IPv6-Opts', 'Destination Options for IPv6', 'RFC 8200'), (
	61,	'', 'Any host internal protocol', ''), (
	62, 'CFTP', 'CFTP', ''), (
	63,	'', 'Any local network', ''), (
	64, 'SAT-EXPAK', 'SATNET and Backroom EXPAK', ''), (
	65, 'KRYPTOLAN', 'Kryptolan', ''), (	
	66, 'RVD', 'MIT Remote Virtual Disk Protocol', ''), (	
	67, 'IPPC', 'Internet Pluribus Packet Core', ''), (	
	68,	'', 'Any distributed file system', ''), (
	69, 'SAT-MON', 'SATNET Monitoring', ''), (
	70, 'VISA', 'VISA Protocol', ''), (
	71, 'IPCU', 'Internet Packet Core Utility', ''), (
	72, 'CPNX', 'Computer Protocol Network Executive', ''), (
	73, 'CPHB', 'Computer Protocol Heart Beat', ''), (
	74, 'WSN', 'Wang Span Network', ''), (
	75, 'PVP', 'Packet Video Protocol', ''), (
	76, 'BR-SAT-MON', 'Backroom SATNET Monitoring', ''), (
	77, 'SUN-ND', 'SUN ND PROTOCOL-Temporary', ''), (
	78, 'WB-MON', 'WIDEBAND Monitoring', ''), (
	79, 'WB-EXPAK', 'WIDEBAND EXPAK', ''), (
	80, 'ISO-IP', 'International Organization for Standardization Internet Protocol', ''), (
	81, 'VMTP', 'Versatile Message Transaction Protocol', 'RFC 1045'), (
	82, 'SECURE-VMTP', 'Secure Versatile Message Transaction Protocol', 'RFC 1045'), (
	83, 'VINES', 'VINES', ''), (	
	84, 'IPTM', 'Internet Protocol Traffic Manager', ''), (
	85, 'NSFNET-IGP', 'NSFNET-IGP', ''), (
	86, 'DGP', 'Dissimilar Gateway Protocol', ''), (
	87, 'TCF', 'TCF', ''), (
	88, 'EIGRP', 'EIGRP	Informational', 'RFC 7868'), (
	89, 'OSPF', 'Open Shortest Path First', 'RFC 2328'), (
	90, 'Sprite-RPC', 'Sprite RPC Protocol', ''), (
	91, 'LARP', 'Locus Address Resolution Protocol', ''), (
	92, 'MTP', 'Multicast Transport Protocol', ''), (
	93, 'AX.25', 'AX.25', ''), (
	94, 'OS', 'KA9Q NOS compatible IP over IP tunneling', ''), (
	95, 'MICP', 'Mobile Internetworking Control Protocol', ''), (
	96, 'SCC-SP', 'Semaphore Communications Sec. Pro', ''), (
	97, 'ETHERIP', 'Ethernet-within-IP Encapsulation', 'RFC 3378'), (
	98, 'ENCAP', 'Encapsulation Header', 'RFC 1241'), (
	99, '', 'Any private encryption scheme', ''), (
	100, 'GMTP', 'GMTP', ''), (
	101, 'IFMP', 'Ipsilon Flow Management Protocol', ''), (
	102, 'PNNI', 'PNNI over IP', ''), (
	103, 'PIM', 'Protocol Independent Multicast', ''), (
	104, 'ARIS', 'IBM''s ARIS (Aggregate Route IP Switching) Protocol', ''), (
	105, 'SCPS', 'SCPS (Space Communications Protocol Standards)', 'SCPS-TP[4]'), (
	106, 'QNX', 'QNX', ''), (
	107, 'A/N', 'Active Networks', ''), (
	108, 'IPComp', 'IP Payload Compression Protocol', 'RFC 3173'), (
	109, 'SNP', 'Sitara Networks Protocol', ''), (
	110, 'Compaq-Peer', 'Compaq Peer Protocol', ''), (
	111, 'IPX-in-IP', 'IPX in IP', ''), (
	112, 'VRRP', 'Virtual Router Redundancy Protocol, Common Address Redundancy Protocol (not IANA assigned)', 'RFC 5798'), (
	113, 'PGM', 'PGM Reliable Transport Protocol', 'RFC 3208'), (
	114, '', 'Any 0-hop protocol', ''), (
	115, 'L2TP', 'Layer Two Tunneling Protocol Version 3', 'RFC 3931'), (
	116, 'DDX	D-II', 'Data Exchange (DDX)', ''), (
	117, 'IATP', 'Interactive Agent Transfer Protocol', ''), (	
	118, 'STP', 'Schedule Transfer Protocol', ''), (
	119, 'SRP', 'SpectraLink Radio Protocol', ''), (
	120, 'UTI', 'Universal Transport Interface Protocol', ''), (
	121, 'SMP', 'Simple Message Protocol', ''), (
	122, 'SM', 'Simple Multicast Protocol draft-perlman-simple-multicast-03', ''), (
	123, 'PTP', 'Performance Transparency Protocol', ''), (
	124, 'IS-IS over IPv4', 'Intermediate System to Intermediate System (IS-IS) Protocol over IPv4', 'RFC 1142 and RFC 1195'), (
	125, 'FIRE', 'Flexible Intra-AS Routing Environment', ''), (
	126, 'CRTP', 'Combat Radio Transport Protocol', ''), (
	127, 'CRUDP', 'Combat Radio User Datagram', ''), (
	128, 'SSCOPMCE', 'Service-Specific Connection-Oriented Protocol in a Multilink and Connectionless Environment	ITU-T Q.2111 (1999)', ''), (
	129, 'IPLT', '', ''), (		
	130, 'SPS', 'Secure Packet Shield', ''), (
	131, 'PIPE', 'Private IP Encapsulation within IP', 'Expired I-D draft-petri-mobileip-pipe-00.txt'), (
	132, 'SCTP', 'Stream Control Transmission Protocol', 'RFC 4960'), (
	133, 'FC', 'Fibre Channel', ''), (
	134, 'RSVP-E2E-IGNORE', 'Reservation Protocol (RSVP) End-to-End Ignore', 'RFC 3175'), (
	135, 'Mobility Header', 'Mobility Extension Header for IPv6', 'RFC 6275'), (
	136, 'UDPLite', 'Lightweight User Datagram Protocol', 'RFC 3828'), (
	137, 'MPLS-in-IP', 'Multiprotocol Label Switching Encapsulated in IP', 'RFC 4023, RFC 5332'), (
	138, 'manet', 'MANET Protocols', 'RFC 5498'), (
	139, 'HIP', 'Host Identity Protocol', 'RFC 5201'), (
	140, 'Shim6', 'Site Multihoming by IPv6 Intermediation', 'RFC 5533'), (
	141, 'WESP', 'Wrapped Encapsulating Security Payload', 'RFC 5840'), (
	142, 'ROHC', 'Robust Header Compression', 'RFC 5856'), (
	143, 'Ethernet', 'IPv6 Segment Routing (TEMPORARY - registered 2020-01-31, expired 2021-01-31)', '');
CREATE TABLE WKPorts (
	Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	Protocol Int,	--Number of protocol in IP packet
	PortNo int,
	Status int,		--Protocol status: 0 - unknown, 1 - reserved, 2 - unofficial, 3 - assigned
	Description Text
);	

insert into WKPorts (
	Protocol, PortNo, Status, Description)
values (
//Port	TCP (6)	UDP (17) SCTP (132)	DCCP (33)	Description
	  6, 0, 5, 'In programming APIs (not in communication between hosts), requests a system-allocated (dynamic) port[6]'), (
	 17, 0, 5, 'In programming APIs (not in communication between hosts), requests a system-allocated (dynamic) port[6]'), (
     32, 0, 5, 'In programming APIs (not in communication between hosts), requests a system-allocated (dynamic) port[6]'), (
    133, 0, 5, 'In programming APIs (not in communication between hosts), requests a system-allocated (dynamic) port[6]'), (
	  6, 1, 1, 'TCP Port Service Multiplexer (TCPMUX). Historic. Both TCP and UDP have been assigned to TCPMUX by IANA,[2] but by design only TCP is specified.[7]'), (
     17, 1, 3, 'TCP Port Service Multiplexer (TCPMUX). Historic. Both TCP and UDP have been assigned to TCPMUX by IANA,[2] but by design only TCP is specified.[7]'), ( 
      6, 2, 3, 'compressnet (Management Utility)[3]'), (
     17, 2, 3, 'compressnet (Management Utility)[3]'), (
      6, 3, 3, 'compressnet (Compression Process)[3]'), (
     17, 3, 3, 'compressnet (Compression Process)[3]'), (
5	Assigned			Remote Job Entry[8] was historically using socket 5 in its old socket form, while MIB PIM has identified it as TCP/5[9] and IANA has assigned both TCP and UDP 5 to it.
7	Yes			Echo Protocol[10][11]
9	Yes	Yes[12]	Assigned	Discard Protocol[13]
No	Unofficial			Wake-on-LAN[14]
11	Yes			Active Users (systat service)[15][16]
13	Yes			Daytime Protocol[17]
15	Unofficial	No			Previously netstat service[2][15]
17	Yes			Quote of the Day (QOTD)[18]
18	Yes			Message Send Protocol[19][20]
19	Yes			Character Generator Protocol (CHARGEN)[21]
20	Yes	Assigned	Yes[12]		File Transfer Protocol (FTP) data transfer[11]
21	Yes	Assigned	Yes[12]		File Transfer Protocol (FTP) control (command)[11][12][22][23]
22	Yes	Assigned	Yes[12]		Secure Shell (SSH),[11] secure logins, file transfers (scp, sftp) and port forwarding
23	Yes	Assigned			Telnet protocol—unencrypted text communications[11][24]
25	Yes	Assigned			Simple Mail Transfer Protocol (SMTP),[11][25] used for email routing between mail servers
27	Assigned			nsw-fe (NSW User System FE)[3]
28	Unofficial				Palo Alto Networks' Panorama High Availability (HA) sync encrypted port.[26]
29	Assigned			msg-icp (MSG ICP)[3]
31	Assigned			msg-auth (MSG Authentication)[3]
33	Assigned			dsp (Display Support Protocol)[3]
37	Yes			Time Protocol[27]
38	Assigned			rap (Route Access Protocol)[3]
38	Assigned			rlp (Resource Location Protocol)[3]
41	Assigned			graphics (Graphics)[3]
42	Assigned	Yes			Host Name Server Protocol[28]
43	Yes	Assigned			WHOIS protocol[29][30][31]
44	Assigned			mpm-flags (MPM FLAGS Protocol)[3]
45	Assigned			mpm (Message Processing Module [recv])[3]
46	Assigned			mpm-snd (MPM [default send])[3]
47	Reserved	Reserved			
48	Assigned			auditd (Digital Audit Daemon)[3]
49	Yes			TACACS Login Host protocol.[32] TACACS+, still in draft which is an improved but distinct version of TACACS, only uses TCP 49.[33]
50	Assigned			re-mail-ck (Remote Mail Checking Protocol)[3]
51	Reserved	Reserved			Historically used for Interface Message Processor logical address management,[34] entry has been removed by IANA on 2013-05-25
52	Assigned			Xerox Network Systems (XNS) Time Protocol. Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP.[35]
53	Yes	Yes			Domain Name System (DNS)[36][11]
54	Assigned			Xerox Network Systems (XNS) Clearinghouse (Name Server). Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP.[35]
55	Assigned			isi-gl (ISI Graphics Language)[3]
56	Assigned			Xerox Network Systems (XNS) Authentication Protocol. Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP.[35]
58	Assigned			Xerox Network Systems (XNS) Mail. Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP.[35]
61	Reserved	Reserved			Historically assigned to the NIFTP-Based Mail protocol,[37] but was never documented in the related IEN.[38] The port number entry was removed from IANA's registry on 2017-05-18.[2]
62	Assigned			acas (ACA Services)[3]
63	Assigned			whoispp (whois++)[3]
64	Assigned			covia (Communications Integrator (CI))[3]
65	Assigned			tacacs-ds (TACACS-Database Service)[3]
66	Assigned			sql-net (Oracle SQL*NET)[3]
67	Assigned	Yes			Bootstrap Protocol (BOOTP) server;[11] also used by Dynamic Host Configuration Protocol (DHCP)
68	Assigned	Yes			Bootstrap Protocol (BOOTP) client;[11] also used by Dynamic Host Configuration Protocol (DHCP)
69	Assigned	Yes			Trivial File Transfer Protocol (TFTP)[11][39][40][41]
70	Yes	Assigned			Gopher protocol[42]
71–74	Yes	Yes			NETRJS protocol[43][44][45]
76	Assigned			deos (Distributed External Object Store)[3]
78	Assigned			vettcp (vettcp)[3]
79	Yes	Assigned			Finger protocol[11][46][47]
80	Yes	Yes	Yes[12]		Hypertext Transfer Protocol (HTTP)[48][49] uses TCP in versions 1.x and 2. HTTP/3 uses QUIC,[50] a transport protocol on top of UDP.
81	Unofficial				TorPark onion routing[verification needed]
82	Assigned			xfer (XFER Utility)[3]
82		Unofficial			TorPark control[verification needed]
83	Assigned			mit-ml-dev (MIT ML Device)[3]
84	Assigned			ctf (Common Trace Facility)[3]
85	Assigned			mit-ml-dev (MIT ML Device)[3]
86	Assigned			mfcobol (Micro Focus Cobol)[3]
88	Yes	Yes			Kerberos[11][51][52] authentication system
89	Assigned			su-mit-tg (SU/MIT Telnet Gateway)[3]
90	Assigned			dnsix (DNSIX Security Attribute Token Map)[3]
90	Unofficial	Unofficial			PointCast (dotcom)[2]
91	Assigned			mit-dov (MIT Dover Spooler)[3]
92	Assigned			npp (Network Printing Protocol)[3]
93	Assigned			dcp (Device Control Protocol)[3]
94	Assigned			objcall (Tivoli Object Dispatcher)[3]
95	Yes	Assigned			SUPDUP, terminal-independent remote login[53]
96	Assigned			dixie (DIXIE Protocol Specification)[3]
97	Assigned			swift-rvf (Swift Remote Virtual File Protocol)[3]
98	Assigned			tacnews (TAC News)[3]
99	Assigned			metagram (Metagram Relay)[3]
101	Yes	Assigned			NIC host name[54]
102	Yes	Assigned			ISO Transport Service Access Point (TSAP) Class 0 protocol;[55][56]
104	Yes	Yes			Digital Imaging and Communications in Medicine (DICOM; also port 11112)
105	Yes	Yes			CCSO Nameserver[57]
106	Unofficial	No			macOS Server, (macOS) password server[11]
107	Yes	Yes			Remote User Telnet Service (RTelnet)[58]
108	Yes	Yes			IBM Systems Network Architecture (SNA) gateway access server
109	Yes	Assigned			Post Office Protocol, version 2 (POP2)[59]
110	Yes	Assigned			Post Office Protocol, version 3 (POP3)[11][60][61]
111	Yes	Yes			Open Network Computing Remote Procedure Call (ONC RPC, sometimes referred to as Sun RPC)
113	Yes	No			Ident, authentication service/identification protocol,[11][62] used by IRC servers to identify users
Yes	Assigned			Authentication Service (auth), the predecessor to identification protocol. Used to determine a user's identity of a particular TCP connection.[63]
115	Yes	Assigned			Simple File Transfer Protocol[64]
117	Yes	Yes			UUCP Mapping Project (path service)[citation needed]
118	Yes	Yes			Structured Query Language (SQL) Services[jargon]
119	Yes	Assigned			Network News Transfer Protocol (NNTP),[11] retrieval of newsgroup messages[65][66]
123	Assigned	Yes			Network Time Protocol (NTP), used for time synchronization[11]
126	Yes	Yes			Formerly Unisys Unitary Login, renamed by Unisys to NXEdit. Used by Unisys Programmer's Workbench for Clearpath MCP, an IDE for Unisys MCP software development
135	Yes	Yes			DCE endpoint resolution
Yes	Yes			Microsoft EPMAP (End Point Mapper), also known as DCE/RPC Locator service,[67] used to remotely manage services including DHCP server, DNS server and WINS. Also used by DCOM
137	Yes	Yes			NetBIOS Name Service, used for name registration and resolution[68][69]
138	Assigned	Yes			NetBIOS Datagram Service[11][68][69]
139	Yes	Assigned			NetBIOS Session Service[68][69]
143	Yes	Assigned			Internet Message Access Protocol (IMAP),[11] management of electronic mail messages on a server[70]
151	Assigned			HEMS
152	Yes	Yes			Background File Transfer Program (BFTP)[71][importance?]
153	Yes	Yes			Simple Gateway Monitoring Protocol (SGMP), a protocol for remote inspection and alteration of gateway management information[72]
156	Yes	Yes			Structured Query Language (SQL) Service[jargon]
158	Yes	Yes			Distributed Mail System Protocol (DMSP, sometimes referred to as Pcmail)[73][importance?]
161	Assigned	Yes			Simple Network Management Protocol (SNMP)[74][citation needed][11]
162	Yes	Yes			Simple Network Management Protocol Trap (SNMPTRAP)[74][75][citation needed]
165	Assigned			Xerox
169	Assigned			SEND
170	Yes	Yes			Network PostScript print server
177	Yes	Yes			X Display Manager Control Protocol (XDMCP), used for remote logins to an X Display Manager server[76][self-published source]
179	Yes	Assigned	Yes[12]		Border Gateway Protocol (BGP),[77] used to exchange routing and reachability information among autonomous systems (AS) on the Internet
180	Assigned			ris
194	Yes	Yes			Internet Relay Chat (IRC)[78]
199	Yes	Yes			SNMP Unix Multiplexer (SMUX)[79]
201	Yes	Yes			AppleTalk Routing Maintenance
209	Yes	Assigned			Quick Mail Transfer Protocol[80][self-published source]
210	Yes	Yes			ANSI Z39.50
213	Yes	Yes			Internetwork Packet Exchange (IPX)
218	Yes	Yes			Message posting protocol (MPP)
220	Yes	Yes			Internet Message Access Protocol (IMAP), version 3
225–241	Reserved	Reserved			
249–255	Reserved	Reserved			
259	Yes	Yes			Efficient Short Remote Operations (ESRO)
262	Yes	Yes			Arcisdms
264	Yes	Yes			Border Gateway Multicast Protocol (BGMP)
280	Yes	Yes			http-mgmt
300	Unofficial				ThinLinc Web Access
308	Yes				Novastor Online Backup
311	Yes	Assigned			macOS Server Admin[11] (officially AppleShare IP Web administration[2])
312	Unofficial	No			macOS Xsan administration[11]
318	Yes	Yes			PKIX Time Stamp Protocol (TSP)
319		Yes			Precision Time Protocol (PTP) event messages
320		Yes			Precision Time Protocol (PTP) general messages
350	Yes	Yes			Mapping of Airline Traffic over Internet Protocol (MATIP) type A
351	Yes	Yes			MATIP type B
356	Yes	Yes			cloanto-net-1 (used by Cloanto Amiga Explorer and VMs)
366	Yes	Yes			On-Demand Mail Relay (ODMR)
369	Yes	Yes			Rpc2portmap
370	Yes	Yes			codaauth2, Coda authentication server
Yes			securecast1, outgoing packets to NAI's SecureCast servers[81]As of 2000
371	Yes	Yes			ClearCase albd
376	Yes	Yes			Amiga Envoy Network Inquiry Protocol
383	Yes	Yes			HP data alarm manager
384	Yes	Yes			A Remote Network Server System
387	Yes	Yes			AURP (AppleTalk Update-based Routing Protocol)[82]
388	Yes	Assigned			Unidata LDM near real-time data distribution protocol[83][self-published source][84][self-published source]
389	Yes	Assigned			Lightweight Directory Access Protocol (LDAP)[11]
399	Yes	Yes			Digital Equipment Corporation DECnet+ (Phase V) over TCP/IP (RFC1859)
401	Yes	Yes			Uninterruptible power supply (UPS)
427	Yes	Yes			Service Location Protocol (SLP)[11]
433	Yes	Yes			NNTP, part of Network News Transfer Protocol
434	Yes	Yes			Mobile IP Agent (RFC 5944)
443	Yes	Yes	Yes[12]		Hypertext Transfer Protocol Secure (HTTPS)[48][49] uses TCP in versions 1.x and 2. HTTP/3 uses QUIC,[50] a transport protocol on top of UDP.
444	Yes	Yes			Simple Network Paging Protocol (SNPP), RFC 1568
445	Yes	Yes			Microsoft-DS (Directory Services) Active Directory,[85] Windows shares
Yes	Assigned			Microsoft-DS (Directory Services) SMB[11] file sharing
464	Yes	Yes			Kerberos Change/Set password
465[note 1]	Yes	No			SMTP over implicit SSL (obsolete)[86]
Yes	No			URL Rendezvous Directory for Cisco SSM (primary usage assignment)[87]
Yes	No			Authenticated SMTP[11] over TLS/SSL (SMTPS) (alternative usage assignment)[88]
475	Yes	Yes			tcpnethaspsrv, Aladdin Knowledge Systems Hasp services
476–490	Unofficial	Unofficial			Centro Software ERP ports
491	Unofficial				GO-Global remote access and application publishing software
497	Yes	Yes			Retrospect
500	Assigned	Yes			Internet Security Association and Key Management Protocol (ISAKMP) / Internet Key Exchange (IKE)[11]
502	Yes	Yes			Modbus Protocol
504	Yes	Yes			Citadel, multiservice protocol for dedicated clients for the Citadel groupware system
510	Yes	Yes			FirstClass Protocol (FCP), used by FirstClass client/server groupware system
512	Yes				Rexec, Remote Process Execution
Yes			comsat, together with biff
513	Yes				rlogin
Yes			Who[89]
514	Unofficial				Remote Shell, used to execute non-interactive commands on a remote system (Remote Shell, rsh, remsh)
No	Yes			Syslog,[11] used for system logging
515	Yes	Assigned			Line Printer Daemon (LPD),[11] print service
517		Yes			Talk
518		Yes			NTalk
520	Yes				efs, extended file name server
Yes			Routing Information Protocol (RIP)
521		Yes			Routing Information Protocol Next Generation (RIPng)
524	Yes	Yes			NetWare Core Protocol (NCP) is used for a variety things such as access to primary NetWare server resources, Time Synchronization, etc.
525		Yes			Timed, Timeserver
530	Yes	Yes			Remote procedure call (RPC)
532	Yes	Assigned			netnews[11]
533		Yes			netwall, for emergency broadcasts
540	Yes				Unix-to-Unix Copy Protocol (UUCP)
542	Yes	Yes			commerce (Commerce Applications)
543	Yes				klogin, Kerberos login
544	Yes				kshell, Kerberos Remote shell
546	Yes	Yes			DHCPv6 client
547	Yes	Yes			DHCPv6 server
548	Yes	Assigned			Apple Filing Protocol (AFP) over TCP[11]
550	Yes	Yes			new-rwho, new-who[89]
554	Yes	Yes			Real Time Streaming Protocol (RTSP)[11]
556	Yes				Remotefs, RFS, rfs_server
560		Yes			rmonitor, Remote Monitor
561		Yes			monitor
563	Yes	Yes			NNTP over TLS/SSL (NNTPS)
564	Unofficial				9P (Plan 9)
585	No	No			Previously assigned for use of Internet Message Access Protocol over TLS/SSL (IMAPS), now deregistered in favour of port 993.[90]
587	Yes	Assigned			email message submission[11][91] (SMTP)
591	Yes				FileMaker 6.0 (and later) Web Sharing (HTTP Alternate, also see port 80)
593	Yes	Yes			HTTP RPC Ep Map, Remote procedure call over Hypertext Transfer Protocol, often used by Distributed Component Object Model services and Microsoft Exchange Server
601	Yes				Reliable Syslog Service — used for system logging
604	Yes				TUNNEL profile,[92] a protocol for BEEP peers to form an application layer tunnel
623		Yes			ASF Remote Management and Control Protocol (ASF-RMCP) & IPMI Remote Management Protocol
625	Unofficial	No			Open Directory Proxy (ODProxy)[11]
631	Yes	Yes			Internet Printing Protocol (IPP)[11]
Unofficial	Unofficial			Common Unix Printing System (CUPS) administration console (extension to IPP)
635	Yes	Yes			RLZ DBase
636	Yes	Assigned			Lightweight Directory Access Protocol over TLS/SSL (LDAPS)[11]
639	Yes	Yes			Multicast Source Discovery Protocol, MSDP
641	Yes	Yes			SupportSoft Nexus Remote Command (control/listening), a proxy gateway connecting remote control traffic
643	Yes	Yes			SANity
646	Yes	Yes			Label Distribution Protocol (LDP), a routing protocol used in MPLS networks
647	Yes				DHCP Failover protocol[93]
648	Yes				Registry Registrar Protocol (RRP)[94]
651	Yes	Yes			IEEE-MMS
653	Yes	Yes			SupportSoft Nexus Remote Command (data), a proxy gateway connecting remote control traffic
654	Yes				Media Management System (MMS) Media Management Protocol (MMP)[95]
655	Yes	Yes			Tinc VPN daemon
657	Yes	Yes			IBM RMC (Remote monitoring and Control) protocol, used by System p5 AIX Integrated Virtualization Manager (IVM)[96] and Hardware Management Console to connect managed logical partitions (LPAR) to enable dynamic partition reconfiguration
660	Yes	Assigned			macOS Server administration,[2] version 10.4 and earlier[11]
666	Yes	Yes			Doom, the first online first-person shooter
Unofficial				airserv-ng, aircrack-ng's server for remote-controlling wireless devices
674	Yes				Application Configuration Access Protocol (ACAP)
688	Yes	Yes			REALM-RUSD (ApplianceWare Server Appliance Management Protocol)
690	Yes	Yes			Velneo Application Transfer Protocol (VATP)
691	Yes				MS Exchange Routing
694	Yes	Yes			Linux-HA high-availability heartbeat
695	Yes				IEEE Media Management System over SSL (IEEE-MMS-SSL)[97]
698		Yes			Optimized Link State Routing (OLSR)
700	Yes				Extensible Provisioning Protocol (EPP), a protocol for communication between domain name registries and registrars (RFC 5734)
701	Yes				Link Management Protocol (LMP),[98] a protocol that runs between a pair of nodes and is used to manage traffic engineering (TE) links
702	Yes				IRIS[99][100] (Internet Registry Information Service) over BEEP (Blocks Extensible Exchange Protocol)[101] (RFC 3983)
706	Yes				Secure Internet Live Conferencing (SILC)
711	Yes				Cisco Tag Distribution Protocol[102][103][104]—being replaced by the MPLS Label Distribution Protocol[105]
712	Yes				Topology Broadcast based on Reverse-Path Forwarding routing protocol (TBRPF; RFC 3684)
749	Yes	Yes			Kerberos administration[11]
750		Yes			kerberos-iv, Kerberos version IV
751	Unofficial	Unofficial			kerberos_master, Kerberos authentication
752		Unofficial			passwd_server, Kerberos password (kpasswd) server
753	Yes	Yes			Reverse Routing Header (RRH)[106]
Unofficial			userreg_server, Kerberos userreg server
754	Yes	Yes			tell send
Unofficial				krb5_prop, Kerberos v5 slave propagation
760	Unofficial	Unofficial			krbupdate [kreg], Kerberos registration
782	Unofficial				Conserver serial-console management server
783	Unofficial				SpamAssassin spamd daemon
800	Yes	Yes			mdbs-daemon
802	Yes	Yes			MODBUS/TCP Security[107]
808	Unofficial				Microsoft Net.TCP Port Sharing Service
829	Yes	Assigned			Certificate Management Protocol[108]
830	Yes	Yes			NETCONF over SSH
831	Yes	Yes			NETCONF over BEEP
832	Yes	Yes			NETCONF for SOAP over HTTPS
833	Yes	Yes			NETCONF for SOAP over BEEP
843	Unofficial				Adobe Flash[109]
847	Yes				DHCP Failover protocol
848	Yes	Yes			Group Domain Of Interpretation (GDOI) protocol
853	Yes				DNS over TLS (RFC 7858)
Yes			DNS over QUIC or DNS over DTLS[110]
860	Yes				iSCSI (RFC 3720)
861	Yes	Yes			OWAMP control (RFC 4656)
862	Yes	Yes			TWAMP control (RFC 5357)
873	Yes				rsync file synchronization protocol
888	Unofficial				cddbp, CD DataBase (CDDB) protocol (CDDBP)
Unofficial				IBM Endpoint Manager Remote Control
897	Unofficial	Unofficial			Brocade SMI-S RPC
898	Unofficial	Unofficial			Brocade SMI-S RPC SSL
902	Unofficial	Unofficial			VMware ESXi[111][112]
903	Unofficial				VMware ESXi[111][112]
953	Yes	Reserved			BIND remote name daemon control (RNDC)[113][114]
981	Unofficial				Remote HTTPS management for firewall devices running embedded Check Point VPN-1 software[115]
987		Unofficial			Sony PlayStation Wake On Lan
Unofficial				Microsoft Remote Web Workplace, a feature of Windows Small Business Server[116]
988	Unofficial				Lustre (file system)[117] Protocol (data).
989	Yes	Yes			FTPS Protocol (data), FTP over TLS/SSL
990	Yes	Yes			FTPS Protocol (control), FTP over TLS/SSL
991	Yes	Yes			Netnews Administration System (NAS)[118]
992	Yes	Yes			Telnet protocol over TLS/SSL
993	Yes	Assigned			Internet Message Access Protocol over TLS/SSL (IMAPS)[11]
994	Reserved	Reserved			Previously assigned to Internet Relay Chat over TLS/SSL (IRCS), but was not used in common practice.
995	Yes	Yes			Post Office Protocol 3 over TLS/SSL (POP3S)[11]
1010	Unofficial				ThinLinc web-based administration interface[119]
1011–1020	Reserved	Reserved			
1023	Reserved	Reserved			[2]
Unofficial	Unofficial			z/OS Network File System (NFS) (potentially ports 991–1023)
)