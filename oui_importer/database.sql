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
    CONSTRAINT FK_Manufacturers_Country FOREIGN KEY (Id) REFERENCES countries(Id));
CREATE TABLE ouis (
  Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  Mask Int NOT NULL,
  Manufacturer Int NOT NULL,
    CONSTRAINT FK_Ouis_Manufacturer FOREIGN KEY (Id) REFERENCES manufacturers(Id));
    
 INSERT INTO countries ( 
   NameEn, NameRu,
   A2, A3, ISOCode)
 VALUES (
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
	'United States Minor Outlying Islands', 'Соединенные Штаты Америки Внешние малые острова (US)', 'UM', 'UMI', '581')
	