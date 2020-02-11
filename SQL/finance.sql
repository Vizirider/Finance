-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Gép: localhost
-- Létrehozás ideje: 2020. Feb 11. 14:13
-- Kiszolgáló verziója: 5.5.60-MariaDB
-- PHP verzió: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `finance`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `catalogue`
--

CREATE TABLE IF NOT EXISTS `catalogue` (
  `id` int(11) NOT NULL,
  `seller` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `address` varchar(100) NOT NULL,
  `discount_rate` varchar(23) NOT NULL DEFAULT 'egyéb',
  `valid_from` date DEFAULT NULL,
  `valid_till` date DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `url` varchar(100) NOT NULL,
  `description` text
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `catalogue`
--

INSERT INTO `catalogue` (`id`, `seller`, `category_id`, `site_id`, `address`, `discount_rate`, `valid_from`, `valid_till`, `active`, `uploaded_at`, `url`, `description`) VALUES
(1, '​Diófa Vendéglő', 1, 6, '8000 Székesfehérvár, Kadocsa u. 32/a', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.diofaetterem.hu/', NULL),
(2, 'Bakony Taxi Egyesület', 2, 1, 'Veszprém', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.bakonytaxi.hu/', NULL),
(3, 'Borháló Veszprém', 1, 1, '8200 Veszprém, Kossuth Lajos u. 5', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'https://www.borhalo.com/veszprem', NULL),
(4, 'Johnny''s Bistro Veszprém', 1, 1, '8200 Veszprém\r\nKossuth Lajos u 21.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.johnnys.hu/veszprem/', NULL),
(5, 'Fricska', 1, 1, '8200 Veszprém, Miklós u. 10', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'https://www.facebook.com/Fricskaetteremlakas/', NULL),
(6, 'BORzsongó Veszprém', 1, 1, '8200 Veszprém, Szent István u. 43', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'https://www.facebook.com/borzsongo/', NULL),
(7, 'Pizzéria-Lucifer II. Söröző', 1, 1, '8200  Veszprém, Török Ignác u. 16', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.luciferpizzeria.hu/', NULL),
(8, 'Móres Bárkonyha', 1, 7, '6720 Szeged, Híd utca 6.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.moresbarkonyha.hu/', NULL),
(9, 'Makkos Bistro', 1, 7, '6723 Szeged, Makkosházi krt 6.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/Makkos-Bisztr%C3%B3-1188895331189603/', NULL),
(10, 'Magyaros Ételbár', 1, 7, '6724 Szeged, Árkád bevásárlóközpont', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/etelbar.magyaros/', NULL),
(11, 'Kertész Csárda', 1, 6, '8000 Székesfehérvár, Iszkaszentgyörgyi út 2.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.kerteszcsarda.hu/', NULL),
(12, 'Salvator Bajor Étterem', 1, 6, '8000 Székesfehérvár, Ányos Pál u. 3.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.salvatoretterem.hu/', NULL),
(13, 'Rosetta Étterem', 1, 6, '8000 Székesfehérvár, Szent István tér 14.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'https://rosetta.hu/', NULL),
(14, 'Copy Fehérvár\r\n', 4, 6, '8000 Székesfehérvár, Palotai út 25.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'http://www.copyfehervar.hu/', NULL),
(15, 'Decathlon', 6, 1, '8000 Székesfehérvár, Holland fasor 3.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'https://www.decathlon.hu/', NULL),
(16, 'Eubycar sofőrszolgálat', 2, 4, 'Budapest', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/eubycar/?ref=ts&amp;fref=ts', NULL),
(17, 'Láng Autó Kft.', 2, 4, '1138 Budapest, Váci út 156.', '30%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.langauto.hu/', NULL),
(18, 'PistiVisz', 2, 5, 'Budapest, Debrecen', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'pistivisz.webnode.hu/kapcsolat/', NULL),
(19, 'Praktiker', 17, 5, 'Budapest, Debrecen, Szeged, Pécs', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.praktikerwebshop.hu/', NULL),
(20, 'Indiso Speleo sóterápia', 3, 5, 'Budapest, Debrecen, Szeged', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', ' indiso.hu/', NULL),
(21, 'Postershop.hu ', 4, 5, 'Budapest, Debrecen és online', '10-15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.postershop.hu/', NULL),
(22, 'Deboti Vitorlás Sportegyesület', 5, 5, '3433 Nyékládháza, Zsálya utca 5.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'deboti.iwk.hu/', NULL),
(23, 'Fővárosi Cirkusz', 5, 4, '1146 Budapest, Állatkerti krt. 12/a.', '25%', NULL, NULL, 1, '2019-09-06 06:25:24', 'fnc.hu/', NULL),
(24, 'Krea-Túra Hegymászás', 5, 4, '1112 Budapest, Kérő u. 6. FSZ.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'krea-tura.hu/', NULL),
(25, 'Aphrodite Hotel Zalakaros', 6, 5, '8749 Zalakaros, Sport u. 10.', '50%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.wellnesshotelaphrodite.hu/', NULL),
(26, 'Balneo Hotel Zsori  ', 6, 5, '3400 Mezőkövesd, Fülemüle utca ', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.balneohotel.hu/', NULL),
(27, 'Balneum Hotel', 6, 5, '5350 Tiszafüred, Húszöles út 27. ', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'balneum.hu/', NULL),
(28, 'Baglas Vendégház - Jacuzzival a Balatonnál', 6, 5, ' 8713 Kéthely, Jókai utca 6.', '8%', NULL, NULL, 1, '2019-09-06 06:25:24', 'baglasvendeghaz.ewk.hu/', NULL),
(29, 'Erdőspuszta Club Hotel Debrecen ', 6, 5, '4002 Debrecen, Diószegi - Panoráma út', 'egyedi', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.erdospuszta-clubhotel.hu/', NULL),
(30, 'Erzsébet Park Hotel Parádfürdő', 6, 5, '3244 Parádfürdő, Kossuth Lajos út 372.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.erzsebetparkhotel.hu/', NULL),
(31, 'Eurovelo6 Stop', 6, 5, '6320 Solt, Árnyas utca 34.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.booking.com/hotel/hu/eurovelo6-stop.hu.html', NULL),
(32, 'Grand Tours Utazási Iroda', 6, 5, '4024 Debrecen, Vár u. 10.', '8%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.grandtours.hu/', NULL),
(33, 'Főnix Üdülőház', 6, 5, '8621 Zamárdi, Batthyány u. 30.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.fonixudulohaz.hu/', NULL),
(34, 'Hercegasszony Birtok', 6, 5, '5400 Mezőtúr, Hercegasszony útja 1.', '12%', NULL, NULL, 1, '2019-09-06 06:25:24', 'hercegasszony.hu/', NULL),
(35, 'Hotel Atlantis', 6, 5, '4200 Hajdúszoboszló, Damjanich u. 10.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'hotelatlantis.hu/', NULL),
(36, 'Hotel Azúr Siófok', 6, 5, '8600 Siófok, Erkel Ferenc utca 2/C.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.hotelazur.hu/hu/azur', NULL),
(37, 'Hotel Vécsecity   ', 6, 5, '3874 Hernádvécse, Béke tér', ' egyedi', NULL, NULL, 1, '2019-09-06 06:25:24', 'vecsecity.hu/', NULL),
(38, 'Maja Apartman', 6, 5, '5700 Gyula, Szent László u. 1.', '12%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.majaapartman.hu/', NULL),
(39, 'Malom Hotel Debrecen', 6, 5, '4027 Debrecen, Böszörményi út 1.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.malomhoteldebrecen.hu/', NULL),
(40, 'Puchner Birtok és Kastélyszálló', 6, 5, '7346 Bikal, Rákóczi u. 22.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'puchner.hu/', NULL),
(41, 'Residence Conference & Wellness Hotel', 6, 5, '8600 Siófok, Erkel Ferenc u. 49.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'balaton.hotel-residence.hu/hu/', NULL),
(42, 'Residence Conference & Wellness Hotel', 6, 5, '3233 Mátraháza, Üdülőtelep 2.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'ozon.hotel-residence.hu/hu/', NULL),
(43, 'Thermál Hotel Visegrád', 6, 5, '20025 Visegrád, Lepence-völgy hrsz.:1213', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'thv.hu/', NULL),
(44, 'Teleki-Degenfeld Kastélyszálló', 6, 5, ' 3044 Szirák, Petőfi u. 26.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.kastelyszirak.hu/hu/', NULL),
(45, 'Vital Hotel Nautis Balaton', 6, 5, '2483 Gárdony, Holdfény sétány 9.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.hotelnautis.hu/', NULL),
(46, 'Aquasana', 7, 5, '6000 Kecskemét, Szirom utca 32/B', '9%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.vizbaratok.hu/', NULL),
(47, 'Géczy Gábor pszichológus', 7, 5, 'Budapest, Debrecen, Szeged', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'lelekor.hu/kapcsolat/', NULL),
(48, 'Jázmin Thai Masszázs Szalonok', 7, 5, 'Budapest, Debrecen', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.jazmin-thai-masszazs.hu/', NULL),
(49, 'Matrackuckó', 7, 5, 'Budapest, Debrecen, Pécs, Szeged', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.agy-matrac.hu/', NULL),
(50, 'Minden Nőnek', 7, 5, '1103 Budapest, Gyömrői út 150.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.mindennonek.hu/', NULL),
(51, 'PiroPanni', 7, 5, '4002 Debrecen, Rőzse 13.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'facebook.com/piropanni', NULL),
(52, 'Szalmás Photo', 7, 5, '3571 Alsózsolca, Rózsa utca 11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'szalmasphoto.hu/', NULL),
(53, 'Zema Ékszer', 7, 5, '4090 Polgár, Hősök út 107.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.zemajewels.hu/', NULL),
(54, 'Avalon Autókölcsönző és Autójavító', 2, 4, '1142 Budapest, Tengerszem u. 106', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.avalon-service.hu/', NULL),
(55, 'Carcare', 2, 4, '1117 Budapest, Gábor Dénes u. 2 Infopark ', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.carcare.hu/', NULL),
(56, 'Cribmoto Szerviz', 2, 4, '1116 Budapest, Hengermalom út 15-17.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/cribmoto/', NULL),
(57, 'Dentinn fogászat', 3, 4, '1097 Budapest, Vaskapu u. 10-14. A. ép. 103', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/DENTINN', NULL),
(58, 'VitaHelp', 3, 4, ' 1125 Budapest, Zsolna utca 27.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.vitahelp.hu/', NULL),
(59, 'Viza Optika ', 3, 4, '1138 Budapest, Viza utca 7/A (B103.)', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.vizaoptika.hu/kapcsolat/', NULL),
(60, 'Nightingale Optics  ', 3, 4, '1027 Budapest, Fő utca 62-64.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'csaloganyoptika.hu/home/', NULL),
(61, 'Napi Masszás', 3, 4, '1117 Budapest', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/napimasszazsbudapest/', NULL),
(62, 'Füvész Bár', 1, 4, '1072 Budapest, Nagy Diófa utca 25.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/FuveszBar', NULL),
(63, 'Nestlé Shop', 1, 4, '1097 Budapest, Lechner Ödön fasor 7.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.nestle.hu/info', NULL),
(64, 'CrossFit Trafo', 8, 4, '1089 Budapest, Korányi Sándoru. 3/b.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.crossfittrafo.com/', NULL),
(65, 'RX Nation', 8, 4, '1134 Budapest Kassák Lajos u. 78.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'rxnation.hu/', NULL),
(66, 'BarCraft', 5, 4, '1065 Budapest Bajcsy Zsilinszky u. 59.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'barcraft.hu/index', NULL),
(67, 'Gepida Factory Store', 5, 4, '1134 Budapest, Bartók Béla út 39. ', '5-20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'gepida.hu/store/', NULL),
(68, 'M&M Bike Hungary Kft.', 5, 4, '1131 Budapest, Reitter Ferenc u. 158.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'mmbike.hu/', NULL),
(69, 'Oktogon Tánc Centrum  ', 5, 4, '1062 Budapest, Aradi u. 1. (Oktogon)', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'tanciskola.hu/', NULL),
(70, 'TandT Sport', 5, 4, ' 1037 Budapest, Csillaghegyi út 36.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'tandtsport.hu/', NULL),
(71, 'Bad Chicken VR Center', 5, 4, '1068 Budapest Váci út 1-3. (WestEnd)  ', '30%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.nelegyelcsirke.hu/', NULL),
(72, '4 Side Copy', 7, 4, '1191 Budapest, Áruház 1-3', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.4sidecopy.hu/', NULL),
(73, 'Vadas János Coach', 7, 4, '1024 Budapest Margit körút 29/A', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.vadasjanos.hu/', NULL),
(74, 'A hely', 1, 3, '4032 Debrecen, Jerikó u. 9-11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/pg/ahelydebrecen/about/?ref=page_internal', NULL),
(75, 'Barabás Étterem', 1, 3, '4024 Debrecen Vár utca 11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.barabasetterem.hu/', NULL),
(76, 'Belga', 1, 3, '4024 Debrecen, Piac u. 29.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'belgaetterem.hu/', NULL),
(77, 'Borháló Debrecen', 1, 3, '4026 Debrecen, Péterfia utca 29.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.borhalo.com/debrecen-peterfia', NULL),
(78, 'Campus Étterem', 1, 3, '4028 Debrecen, Kassai út 26.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'campusetterem.hu/', NULL),
(79, 'Derby Pub', 1, 3, '4024 Debrecen, Piac utca 11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/DERBY-PUB-318856034967339/timeline/', NULL),
(80, 'Desszert Álom Tortaműhely', 1, 3, '4031 Debrecen, Széchenyi u. 80.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/tortamuhelydebrecen/', NULL),
(81, 'Don Pepe', 1, 3, '4031 Debrecen, Kishegyesi út 1.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.donpepe.hu/', NULL),
(82, 'Döner Ételbár', 1, 3, '4025 Debrecen, Segner tér 7/a', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'doneretelbar.hu/', NULL),
(83, 'Eat Up Ételbár', 1, 3, '4025 Debrecen, Hatvan utca 8-10.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.eatup.hu/', NULL),
(84, 'Fandango Sport Pub', 1, 3, '4027 Debrecen, Ibolya u. 1.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'fandangosportpub.hu/', NULL),
(85, 'Garda Étterem - Pizzéria ', 1, 3, '4032 Debrecen', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.gardapizza.hu/', NULL),
(86, 'Govinda Étterem', 1, 3, '4028 Debrecen, Magyari utca 2.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.govindadebrecen.hu/', NULL),
(87, 'Hotel Platán', 1, 3, '4030 Debrecen, Somlyai út 10.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'platanhotel.eu/', NULL),
(88, 'Hotel Óbester', 1, 3, '4026 Debrecen, Péterfia u. 49.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'hotelobester.hu/', NULL),
(89, 'Király Pizza Debrecen', 1, 3, '4002 Debrecen, Köntös Gát sor 8.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'kiralypizza.com/kapcsolat/', NULL),
(90, 'Kismandula Cukrászda', 1, 3, '4024 Debrecen, Liszt Ferenc u. 10.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.kismandula.hu/', NULL),
(91, 'Krúdy Étterem', 1, 3, '4032 Debrecen, Medgyessy sétány 4.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.villahotel.hu/', NULL),
(92, 'Kurucz Hentes és Lacipecsenye', 1, 3, '4029 Debrecen, Csapó utca 102.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'kurucz.hu/', NULL),
(93, 'Leroy Cafe', 1, 3, '4024 Debrecen, Csapó u. 30 (Fórum)', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.leroydebrecen.hu/', NULL),
(94, 'Mandula Café', 1, 3, '4026 Debrecen, Bethlen utca 46.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'kismandula.hu/', NULL),
(95, 'Mandula Cukrászda', 1, 3, '4024 Debrecen, Ember Pál u. 23.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'kismandula.hu/', NULL),
(96, 'Marbell Bistro', 1, 3, '4025 Debrecen, Révész tér 2.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/marbellbistro/?fref=ts', NULL),
(97, 'Maszek Utcabár', 1, 3, '4025 Debrecen, Simonffy utca 2/A', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.maszekdebrecen.hu/', NULL),
(98, 'Mázli Tortaműhely', 1, 3, '4031 Debrecen Trombitás u. 12.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/email/unreachable/%23!/mazlitorta?fref=ts', NULL),
(99, 'Melange', 1, 3, '4032 Debrecen, Egyetem sgrt. 56.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'melangekavehaz.hu/', NULL),
(100, 'Pálma Étterem', 1, 3, '4028 Debrecen, Simonyi út 44.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.palmapub.hu/', NULL),
(101, 'Petra`z Egészséges Gyorsétterem', 1, 3, '4026 Debrecen, Péterfia u. 18.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/Petraz-Debrecen-1791136181174154/?fref=ts', NULL),
(102, 'Pikoló söröző', 1, 3, '4028 Debrecen, Kassai út 10.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/pikolosorozo23?hc_location=timeline', NULL),
(103, 'Pizza Bár', 1, 3, '4032 Debrecen, Doberdó u. 1.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.pizzabar.net/', NULL),
(104, 'Pizza Valentino la Caffe', 1, 3, '4029 Debrecen, Csapó utca 51.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.pizzavalentino.hu/', NULL),
(105, 'Pizza Via', 1, 3, '4025 Debrecen, Arany János u. 2.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'pizzavia.hu/', NULL),
(106, 'Régi Posta', 1, 3, '4025 Debrecen, Széchenyi u. 6.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'regiposta.hu/', NULL),
(107, 'Station Bowling', 1, 3, '4025 Debrecen, Petőfi tér 10.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'bowlingdebrecen.hu/', NULL),
(108, 'Stay Söröző', 1, 3, '4024 Debrecen, Rózsa utca', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/staybeerbar/?fref=ts', NULL),
(109, 'Tornádó Gyros', 1, 3, '4029 Debrecen, Csapó u. 129.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'hu-hu.facebook.com/tornadogyros/', NULL),
(110, 'Volt egyszer Kávézó', 1, 3, '4024 Debrecen, Piac u. 16.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/pages/category/Cafe/Volt-egyszer-196863703817700/', NULL),
(111, 'Wok to Box', 1, 3, '4025 Debrecen, Simonffy u. 1.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'rendeles.woktobox.hu/', NULL),
(112, 'Akku 96 Kft.', 2, 3, '4031 Debrecen, Széchenyi u. 109/B', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.akku96.hu/', NULL),
(113, 'Auto Bianco', 2, 3, '4024 Debrecen, Sumen u. 10.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(114, 'Automobil', 2, 3, '4034 Debrecen, Veresegyházi 5/B', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'autossuli.blogspot.hu/', NULL),
(115, 'Contakt Gumiszervíz', 2, 3, '4029 Debrecen, Böszörményi út 159.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/autocontakt/', NULL),
(116, 'Daku autoklinika', 2, 3, '4033 Debrecen, Herpay Gábor u. 5.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.daku-autoklinika.hu/', NULL),
(117, 'Fontana Mosó', 2, 3, '4031 Debrecen, Köntösgát sor 8.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/frissauto/?fref=ts', NULL),
(118, 'El-Szállít', 2, 3, '4027 Debrecen, Füredi út 98.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.el-szallit.hu/', NULL),
(119, 'Green Line Clean', 2, 3, ' 4034 Debrecen, Vágóhíd utca 2.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'debrecen.greenlineclean.hu/', NULL),
(120, 'Kristály Autokozmetika', 2, 3, ' 4031 Debrecen, István út 12.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/kristalymoso', NULL),
(121, 'Perfect Autó és Motor Kozmetika', 2, 3, '4032 Debrecen, Füredi út 27. ', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'nyitva.hu/debrecen/perfekt-aut%C3%B3mos%C3%B3-debrecen-malompark-bev%C3%A1s%C3%A1rl%C3%B3k%C3%B6zpon', NULL),
(122, 'Agrárius', 17, 3, '4030 Debrecen, Diószegi út 36.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'mezogazdasagi-bolt.hu/', NULL),
(123, 'Eurosmart Bt.', 17, 3, '4025 Debrecen, Hatvan u. 53.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.eurosmart.hu/', NULL),
(124, 'KIKA', 17, 3, '4031 Debrecen, Kishatár u. 32.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.kika.hu/', NULL),
(125, 'Ligetszépe', 17, 3, '4032 Debrecen, Szabó Lőrint u. 39/A', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/Ligetsz%C3%A9pe-Vir%C3%A1g-%C3%A9s-Aj%C3%A1nd%C3%A9k%C3%BCzlet-417065835452392/', NULL),
(126, 'Derektamasz.hu', 3, 3, 'weboldal', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/email/unreachable/%23!/derektamasz?fref=ts', NULL),
(127, 'Kulcsár László masszőr', 3, 3, '4032 Debrecen, Kaffka Margit u. 16/1.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(128, 'Medora Masszázs Stúdió', 3, 3, '4025 Debrecen, Simonffy u. 4.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.medora.hu/', NULL),
(129, 'Okula Optika', 3, 3, ' 4025 Debrecen, Erzsébet u. 2.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.okula-optika.hu/', NULL),
(130, 'Papp Optika', 3, 3, '4200 Hajdúszoboszló, Kabai útfél (Tesco)', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'pappoptika.hu/', NULL),
(131, 'Zhineng Chikung & Taiji ', 3, 3, '4024 Debrecen, Rákóczi u. 40.  ', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.zhinengchikung.hu/', NULL),
(132, 'Napfény Fotó', 4, 3, '4033 Debrecen, Veres Péter u. 67.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(133, 'Trilite Studió', 4, 3, '4025 Debrecen, hatvan u. 37. fsz. 3.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.trilite.hu/', NULL),
(134, 'Lansoft Kft.  ', 9, 3, '4025 Debrecen, Külső Vásártér 18.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.lansoft.hu/', NULL),
(135, 'Crystal Antikvárium és Aukciósház', 10, 3, '4029 Debrecen, Cegléd utca 11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(136, 'Líra Könyvesbolt', 10, 3, '4025 Debrecen, Piac u. 57.', '7%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(137, 'Intersport Debrecen', 11, 3, '4031 Debrecen, Kishatár út 1. ', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.intersport.hu/standorte/standortdetails.html?outletId=388', NULL),
(138, 'Ilona ruhajavító', 11, 3, '4034 Debrecen, Csűry Bálint u. 25.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/Ilona-Ruhajav%C3%ADt%C3%B3-1784551388446519/', NULL),
(139, 'Mazsola Divat ', 11, 3, '4026 Debrecen, Kálvin tér 4/B ', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.varoskozpont.hu/city/debrecen/vasarlas/mazsola-divat/', NULL),
(140, 'Norizz Fashion', 11, 3, ' 4024 Debrecen Kálvin tér 3/B', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/norizzofficial/', NULL),
(141, 'Aquaticum Debrecen', 5, 3, '4032 Debrecen, Nagyerdei park 1.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.aquaticum.hu/', NULL),
(142, 'Bike Pótkerék Kft.', 5, 3, '4027 Debrecen, Böszörményi u. 1', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.bikepotkerek.hu/index.html', NULL),
(143, 'Csóra biciklibolt', 5, 3, '4028 Debrecen, Árpád tér 8.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(144, 'Equinor Lovasudvar', 5, 3, '4271 Mikepércs, Báthory G. u. 7.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/debrecenilovaglas/', NULL),
(145, 'Exit the Room', 5, 3, '4026 Debrecen, Péterfia utca 39.', '25%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.exittheroom.hu/debrecen', NULL),
(146, 'Gyöngy Bike', 5, 3, '4034 Debrecen, Vámospércsi u. 66.', '5-15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.gyongybike.hu/', NULL),
(147, 'Horgászok Háza', 5, 3, '4031 Debrecen, Bartók Béla u. 17.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'pergetoaruhaz.hu/', NULL),
(148, 'Kamilla Gyógyfürdő', 5, 3, '4060 Balmazújváros, Kastélykert u. 1-3.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.kamillafurdo.hu/', NULL),
(149, 'Nyomásutána', 5, 3, '4026 Debrecen, Cserepes utca 16.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'nyomasutana.hu/en', NULL),
(150, 'Paintball tanya', 5, 3, 'Debrecen - Haláp 01765/4 hrsz.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'paintballtanya.hu/', NULL),
(151, 'VR World Debrecen ', 5, 3, '4025 Debrecen, Miklós u. 14. ', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.vrwdebrecen.hu/', NULL),
(152, 'Baumann Reisen', 6, 3, '4024 Debrecen, Batthyány u. 3.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'baumannreisenhungary.hu/', NULL),
(153, 'Kadarcsi Csárda', 6, 3, '4064 Nagyhegyes külterület', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/KadarcsiCsarda', NULL),
(154, 'Hotel Kamilla', 6, 3, '4060 Balmazújváros, Kastélykert u. 1', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'hotelkamilla.hu/', NULL),
(155, 'Hotel Platán', 6, 3, '4030 Debrecen, Somlyai u. 10.', '12%', NULL, NULL, 1, '2019-09-06 06:25:24', 'platanhotel.eu/', NULL),
(156, 'Némethy Panzió Debrecen', 6, 3, '4026 Debrecen, Péterfia u. 50.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.nemethypanzio.hu/bemutatkozas', NULL),
(157, 'Bacsa Viktória Kozmetikus', 12, 3, '4025 Debrecen, Hatvan utca 6.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/bacsaviktoriakozmetikus/?fref=ts', NULL),
(158, 'Bónusz Szépségszalon', 12, 3, '4025 Debrecen, Hatvan utca 6.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/B%C3%B3nusz-Szalon-162476763883168/', NULL),
(159, 'Dream Szépségszalon', 12, 3, '4024 Debrecen, Piac utca 40 fsz/1', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/dreamszepsegszalondebrecen/?ref=ts&amp;fref=ts', NULL),
(160, 'Heaven Studio', 12, 3, '4034 Debrecen, Lion Office Irodapark', '12%', NULL, NULL, 1, '2019-09-06 06:25:24', 'heavenstudio.hu/', NULL),
(161, 'Jázmin Masszázs', 12, 3, '4030 Debrecen, Epreskert u. 2.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.jazmin-thai-masszazs.hu/', NULL),
(162, 'Nett-Tus Make Up Shop', 12, 3, '4024 Debrecen Kálvin Tér 3/A', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/netttus/', NULL),
(163, 'Nyugtató Érintés Masszázs', 12, 3, '4028 Debrecen Korház u. 7. II. em', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.nyugtatoerintes.hu/bemutatkozas.php', NULL),
(164, 'Masszázs Patika', 12, 3, '4026 Debrecen, Péterfia u. 47. 4-es ajt', '25%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.masszazspatika.hu/', NULL),
(165, 'MegaSun Szolárium', 12, 3, '4024 Debrecen, Szent Anna u. 38.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/megaSunSzolariumDebrecen', NULL),
(166, 'PanGrina fodrászkellék üzlet', 12, 3, '4032 Debrecen, Ötvenhatosok tere 6/A.', '25%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/PanGrina.fodraszkellek/', NULL),
(167, 'Relax Kozmetika', 12, 3, '4026 Debrecen, Garai u. 2.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'kozmetika-debrecen.hu/', NULL),
(168, 'Sunset Szolárium', 12, 3, '4026 Debrecen, Csemete u. 36-38.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/sunset.szolariumstudio', NULL),
(169, 'Stílustanácsadás Fehér Tündével', 12, 3, '4028 Debrecen, Hadházi út 38.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.stilusessiker.hu/', NULL),
(170, 'Apolló Mozi  ', 13, 3, ' 4025 Debrecen, Miklós u. 1.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'apollomozi.hu/', NULL),
(171, 'Nagyerdei Szabadtéri Színpad', 13, 3, '4028 Debrecen, Nagyerdei krt. 6.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.debreceniszabadteri.hu/', NULL),
(172, 'Anjou Udvari Lovagkör Kardvívó Sportegyesület', 8, 3, '4032 Debrecen, Illyés u. 9.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/anjoulovag/', NULL),
(173, 'Bujinkan Hoshi Dojo', 8, 3, '4024 Debrecen, Batthyány u. 8.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/hoshidojo', NULL),
(174, 'Debreceni Lövészsuli Sportegy', 8, 3, '4032 Debrecen, Oláh Gábor u. 5.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.loveszsuli.hu/', NULL),
(175, 'Úszó Teknősök Sportegyesület ', 8, 3, ' 4029 Debrecen, Domb u. 1.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'dute.hu/', NULL),
(176, 'EnerGym Fitness', 8, 3, '4032 Debrecen, Nagyerdei Park 1.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.energym.hu/hu/', NULL),
(177, 'Eskrima Önvédelem', 8, 3, '4032 Debrecen, Füredi út 76.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'eskrimadebrecen.hu/', NULL),
(178, 'Mandala jóga', 8, 3, '4024 Debrecen, Rákóczi u. 40.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'mandalajogadebrecen.hu/', NULL),
(179, 'New York Fittness', 8, 3, '4025 Debrecen, Piac u. 45-47.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'newyorkfitness.eu/?page_id=133', NULL),
(180, 'Shape Power - Plate Studio', 8, 3, '4026 Debrecen, Péterfia u. 18.', '30%', NULL, NULL, 1, '2019-09-06 06:25:24', 'shapepowerplate.hu/', NULL),
(181, 'Speedbody Fitness', 8, 3, '4032 Debrecen, Böszörményi út 147.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/speedbody.debrecen', NULL),
(182, 'Sólyom íjászbolt', 8, 3, '4028 Debrecen, Hadházi út 78.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.solyomijaszbolt.hu/', NULL),
(183, 'Vezér Fitness', 8, 3, '4032 Debrecen, Böszörményi út 150.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.vezerfitness.hu/', NULL),
(184, 'Wing Tzun Kung - Fu', 8, 3, '4031 Debrecen, Kishegyesi u. 150/B', '25%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(185, 'Agroang Business Fordítás és Magánoktatás', 7, 3, '4031 Debrecen, Szoboszlói út 50. II/36', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/agroangforditas/?fref=ts', NULL),
(186, 'Aranyvirág Ékszerszalon', 7, 3, '4024 Debrecen, Csapó utca 43.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'aranyviragekszer.hu/', NULL),
(187, 'Bányai Ékszer', 7, 3, '4024 Debrecen, Batthyány u. 14.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'banyaiekszer.hu/', NULL),
(188, 'Business West Nyelviskola ', 7, 3, '4024 Debrecen', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.nyelvtanulas.net/', NULL),
(189, 'CsinCsin', 7, 3, '4031 Debrecen, István út 71. 1/3', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'csincsin.hu/', NULL),
(190, 'Debreceni Nyelviskola', 7, 3, '4026 Debrecen, Bethlen u. 39. fsz. 5.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.debreceninyelviskola.hu/', NULL),
(191, 'Debtoys', 7, 3, '4034 Debrecen, Asztalos utca 35/4.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.mesesjatekok.hu/', NULL),
(192, 'Dream Party & Ceremony Rendezvényszervezés', 7, 3, '4034 Debrecen', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.dreamparty.hu/', NULL),
(193, 'Escargots Enflammés Tűzzsonglőrök', 7, 3, '4031 Debrecen, Derék u. 84.', '30%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/flamingsnails/', NULL),
(194, 'Főnix Rendezvényszervező Kft.', 7, 3, '4026 Debrecen, Hunyadi u. 1-3', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.fonixinfo.hu/', NULL),
(195, 'Fejhallgato Plaza', 7, 3, '4028 Debrecen, Árpád tér 16-18.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.fejhallgatoplaza.hu/', NULL),
(196, 'Hegyikristály Ásványbolt', 7, 3, '4025 Debrecen, Széchenyi u. 1.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'asvany-ekszer.hu/', NULL),
(197, 'Helen Doron Early English', 7, 3, '4026 Debrecen Darabos utca 33.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'debrecen.helendoron.hu/', NULL),
(198, 'Humán-Ép Ingatlanforgalmazó Kft.', 7, 3, '4032 Debrecen, Füredi út 98.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.humanep.com/', NULL),
(199, 'Jáde Gyógynövény bolt', 7, 3, '4024 Debrecen, Kossuth u. 8.', '10-20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'gyogynovenywebshop.hu/?fbclid=IwAR3TskA90YcdrMioLXIcGEdbyw6GD-YgJ_Ze5gmGZKB1fbZeLJDcOzTnL-w', NULL),
(200, 'Kiselefánt Kreatív Hobby', 7, 3, '024 Debrecen, Batthyány utca 1. ', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/kiselefantbolt', NULL),
(201, 'Levitex Kft.', 7, 3, '025 Debrecen, Bajcsi Zsilinszky u. 18/9b', '8%', NULL, NULL, 1, '2019-09-06 06:25:24', 'lakastextil.j9.hu/debrecen/levitex-kft/', NULL),
(202, 'Lilakert Gyermekfelügyelet', 7, 3, '4032 Debrecen, Poroszlay út 14.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.lilakert.com/', NULL),
(203, 'Link Global Business Solutions Kft.', 7, 3, '?4033 Debrecen Gábor Áron u. 75/1', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.linkgbs.com/hu/', NULL),
(204, 'Mithra Alapítvány - napközis táborok', 7, 3, '4025 Debrecen, Hatvan u. 33 1/4', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(205, 'Posta Beáta Grafikusművész', 7, 3, '4060 Balmazújváros, Bethlen u. 33.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'postabeata.hu/', NULL),
(206, 'Setét Ferenc - Kárpitos', 7, 3, '4461 Nyírtelek, Felsősóskút 57.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(207, 'Tropicalfish (Veréb és Kátó Kft.)', 7, 3, '4024 Debrecen, Piac u. 38.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'tropicalfish.hu/', NULL),
(208, 'Vahúr Állateledel Bolt', 7, 3, '4032 Debrecen, Jerikó u. 34.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'vahurbolt.hu/', NULL),
(209, 'Wedding Paper', 7, 3, '4220 Hajdúböszörmény, Szent István tér 2.', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'weddingpaper.hu/', NULL),
(210, 'Wishy Washy Mosoda', 7, 3, '4032 Debrecen Németh László u. 38.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'wishywashy.hu/', NULL),
(211, 'Donkey Pizza', 1, 2, '7623, Bajcsy-Zsilinszky u.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/pizzadonkeypecs/', NULL),
(212, 'DZ Streetfood', 1, 2, '7621 Pécs, Mátyás király u. 1.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/DZ-Street-Food-743812909138279/', NULL),
(213, 'Frei Café', 1, 2, '7621 Pécs, Király u. 7.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/cafefreipecs/?fref=ts', NULL),
(214, 'Gyros Torony', 1, 2, '7621 Pécs, Bajcsy-Zsilinszky u. 4-6.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/pages/category/Restaurant/Gyros-Torony-2018859128143303/', NULL),
(215, 'Kovács Pékség', 1, 2, '7621 Pécs, Jókai u. 21.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/kovacspekseg/', NULL),
(216, 'Repeta Gyorsétterem', 1, 2, '7623 Pécs, Nagy Lajos kir. u. 10. ', '5%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.repetagyros.hu/', NULL),
(217, 'Trafik Lokál', 1, 2, '7621 Pécs. Penczel u. 22.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/trafikapollo/', NULL),
(218, 'Domdon Autó', 2, 2, '7632 Pécs, Littke József u. 19.', '25-40%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(219, 'Fehér Optika', 3, 2, '7621 Pécs, Ferencesek utcája 1. (Jókai tér felől)', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.feheroptika.hu/', NULL),
(220, 'Hatha Jóga Stúdió ', 3, 2, '7621 Pécs, Apáca utca 3. ', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/hathajogapecs/', NULL),
(221, 'Agykontroll Gyermeknek H.S.Csilla Oktató Bt.', 3, 2, '​7627 Pécs, Bittner Alajos u. 15.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(222, 'Rafting Optika', 3, 2, '7621 Pécs, Citrom utca 2-6. / Ferencesek utca', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.raftingoptika.hu/', NULL),
(223, 'Talpalda', 3, 2, '7621 Pécs, Citrom utca 8.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/pecselsotalpaldaja/?fref=ts', NULL),
(224, 'Ti-Dent Fogorvos', 3, 2, '7624 Pécs, Klimó György u. 21.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.ti-dent.hu/hu', NULL),
(225, 'Líra Könyv ', 10, 2, '7621 Pécs, Irgalmasok utcája 6.', '7%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.lira.hu/', NULL),
(226, 'Sopianae Öltöny', 11, 2, '7622 Pécs, Somogyi Béla u. 2.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(227, 'Fürge Nyuszi Focivilág', 8, 2, '7622 Pécs, Bajcsy - Zsilinszki u. 11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'furgenyuszi.hu/cms/kapcsolat', NULL),
(228, 'Mecsextrém', 5, 2, '7628 Pécs-Árpádtető, Mecsextrém Park', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.mecsextrem.hu/', NULL),
(229, 'Mosolyország / Mosolyfarm', 5, 2, '7631 Pécs Pláza / Sylven Rendezvényközpont', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'mosolyorszag.hu/', NULL),
(230, 'Platina Szerszám ', 5, 2, '7727 Palotabozsok, Petőfi S. u. 64.', '15%', NULL, NULL, 1, '2019-09-06 06:25:24', 'platinaszerszam.hu/', NULL),
(231, 'Corso Hotel Pécs', 6, 2, '7626 Pécs, Koller utca 8.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'corsohotel.hu/?lang=hu', NULL),
(232, 'Matrackuckó', 7, 2, '7626 Pécs, Király utca 62.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.agy-matrac.hu/', NULL),
(233, 'Pillangó Virágüzlet', 7, 2, '7622 Pécs, Bajcsy-Zsilinszky utca 2/1', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/Pillang%C3%B3-Vir%C3%A1g%C3%BCzlet-294997153891817/?fref=ts', NULL),
(234, 'Halász Kinga coach, kommunikációs szakember', 7, 2, '7621 Pécs, Felsővámház u. 52', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/coachpecs/', NULL),
(235, '​Csokonai Étterem', 1, 3, '​4024 Debrecen, Kossuth u. 21.', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'csokonaisorozo.hu/', NULL),
(236, 'Frei Café', 1, 3, '4024 Debrecen, Fórum (Libri) & Piac u. 20.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/cafefreidebrecen2', NULL),
(237, '​Shifu', 1, 3, '​4024 Debrecen, Batthyány u. 22', '​10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(238, 'Tommy´s Hill', 1, 3, '​4026 Debrecen, Mester u. 3.', '​egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'tommyshill.hu/', NULL),
(239, 'Termelői Portékák ALIBOR Natura Kft.', 1, 3, '​4251 Hajdúsámson, Damjanich u. 3.', '​10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(240, 'Zigi-ImpExElektornika, Kert, Barkács, Dekor, Gyenge és erős áram', 17, 3, '4271 Mikepércs, Tóth Árpád u. 5.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(241, 'Katona Borház', 1, 5, '​1056 Budapest, Irányi u. 1.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'katonaborhaz.hu/', NULL),
(242, '​Dental Network fogászat', 3, 5, '1114 Budapest Bartók Béla út 41.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'dentalnetwork.hu/hu/fogaszati_halozat', NULL),
(243, 'Alp-Favill 96 Kft.', 3, 1, '​​6724 Szeged, Kenyérgyári út 11.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(244, 'Heavy Pedál Kft.', 8, 1, '​6721 Szeged, Brüsszeli Krt. 12.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', '', NULL),
(245, '​Corpus Fitness Kettlebell', 8, 3, '4032 Debrecen, Oláh Gábor u. 5.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.corpusfitness.hu/', NULL),
(246, 'Onome Szemklinika', 3, 3, '​4024 Debrecen, Kossuth u. 3.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.onome.hu/', NULL),
(247, 'Onome Szemklinika', 3, 3, '​4031 Debrecen, Kishatár út 7. (Auchan)', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.onome.hu/', NULL),
(248, 'Onome Szemklinika', 3, 3, '4200 Hajdúszoboszló, Szilfákalja út 32.', '10%', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.onome.hu/', NULL),
(249, 'Papp Optika  ', 3, 3, 'Debrecen, Batthyány u. / Csapó u. / Kálvin tér', '20%', NULL, NULL, 1, '2019-09-06 06:25:24', 'pappoptika.hu/', NULL),
(250, 'Speedy - Fit Kft.', 8, 3, '​4028 Debrecen, Hadházi út 78.', 'egyéb', NULL, NULL, 1, '2019-09-06 06:25:24', 'www.facebook.com/speeedyfit', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Étel/Ital'),
(2, 'Autó-Motor'),
(3, 'Egészség'),
(4, 'Fotó'),
(5, 'Szabadidő'),
(6, 'Szállás, Utazás'),
(7, 'Egyéb'),
(8, 'Sport'),
(9, 'Informatika'),
(10, 'Könyv'),
(11, 'Ruha'),
(12, 'Szépségápolás'),
(13, 'Színház, Mozi'),
(14, 'Sportegyesület'),
(15, 'Magánoktatás'),
(16, 'Rendezvényszervezés'),
(17, 'Barkács, Háztartás, Szerszám');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `loan`
--

CREATE TABLE IF NOT EXISTS `loan` (
  `loan` int(11) NOT NULL,
  `product_category` int(11) NOT NULL,
  `amount` int(100) NOT NULL,
  `currency` varchar(100) NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `loan`
--

INSERT INTO `loan` (`loan`, `product_category`, `amount`, `currency`, `Date`) VALUES
(1, 1, 10000, 'HUF', '2020-02-03');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `loancategory`
--

CREATE TABLE IF NOT EXISTS `loancategory` (
  `loancategory` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `percentage` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `loancategory`
--

INSERT INTO `loancategory` (`loancategory`, `name`, `percentage`) VALUES
(1, 'személyi kölcsönök', '13,8 %'),
(2, 'lakáshitel', '4,6 %'),
(3, 'lakásfelújítás', '8,1 %'),
(4, 'autóvásárlás', '13,8 %'),
(5, 'személyi kölcsön hitelkiváltásra', '13,8 %');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `site`
--

CREATE TABLE IF NOT EXISTS `site` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `site`
--

INSERT INTO `site` (`id`, `name`) VALUES
(1, 'VESZPRÉM'),
(2, 'PÉCS'),
(3, 'DEBRECEN'),
(4, 'BUDAPEST'),
(5, 'TELEPHELYTŐL FÜGGETLEN'),
(6, 'SZÉKESFEHÉRVÁR'),
(7, 'SZEGED');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `transaction`
--

CREATE TABLE IF NOT EXISTS `transaction` (
  `transaction` int(11) NOT NULL,
  `product_category` int(11) NOT NULL,
  `income_outcome` int(100) NOT NULL,
  `currency` varchar(100) NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `transaction`
--

INSERT INTO `transaction` (`transaction`, `product_category`, `income_outcome`, `currency`, `Date`) VALUES
(1, 1, 1500, 'HUF', '2019-10-13'),
(2, 2, -20000, 'HUF', '2019-10-02'),
(3, 3, 7600, 'HUF', '2019-10-22'),
(4, 1, -4400, 'HUF', '2019-10-22'),
(5, 1, 12500, 'HUF', '2020-02-02');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL,
  `unique_id` varchar(23) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `encrypted_password` varchar(128) NOT NULL,
  `salt` varchar(16) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `is_deleted` tinyint(1) DEFAULT '0',
  `is_admin` tinyint(1) DEFAULT '0',
  `activation_token` varchar(128) NOT NULL,
  `default_site_id` int(11) NOT NULL,
  `profile_picture` mediumblob,
  `resetPasswordToken` varchar(128) DEFAULT NULL,
  `resetPasswordExpires` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `unique_id`, `name`, `email`, `encrypted_password`, `salt`, `created_at`, `updated_at`, `is_active`, `is_deleted`, `is_admin`, `activation_token`, `default_site_id`, `profile_picture`, `resetPasswordToken`, `resetPasswordExpires`) VALUES
(3, '5cb499gb-8d88-5gf8-064c', 'alice', 'alice@hobby.local', '99492aceef002c97f451900f9b9bf1e6aeb793d4ba690a72e7f7fb38ffb626adc801cd247208c0ac8a9801c6850889d941431f4e8afccef5786023faa04370c7', '81451aa2deecf246', '2019-05-08 14:52:46', '2019-09-24 14:53:52', 1, 0, 0, 'oajfu9weduedwu9asdsegw64797t4', 3, NULL, NULL, NULL),
(4, '5c7cd6df-579d-4a4d-a99a', 'Teszt Elek', 'tesztelek@hobby.local', '89bb2926150fdd43e30d265ba2421c3050b2024d73e449946f1feb2c45c9f328bd34dbfe63e77dd959fd041a970319e25062862943009282a037ffe6e7bdb442', '49f41c5e3f0030a5', '2019-09-11 13:22:01', '2019-09-11 13:22:01', 1, 0, 0, 'ba86f13bc3a7cadbbe38803f628af1cd07d29d4d', 1, 0xffd8ffe000104a46494600010100000100010000ffdb00430001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101ffdb00430101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101ffc0001108007800a003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fc44fda87e0b7c30fd8afe12defc72fd997c33ff000adbe26d86b9a2786ed3c51fdb5e22f17f95a26bf713dbeb165fd89e3ed5fc53a049f6c8a08d7ed32696f7906375a5c42e5d9bf353fe1e33fb69ff00d167ff00cc75f097ff00983afd7dff0082a27fc9a5eb3ff63bf82bff004baf2bf9a8a00fd62fd973e34fc4ff00db4fe2cdafc0dfda6bc4dff0b27e195f687ad788eefc2ffd8be1df0879bade810a5c68f7bfdb7e01d27c2dafc7f6396691fecd1eaab693eedb776f320503f4b3fe1dcbfb167fd119ff00cc8bf16fff009bcafc82ff00825cff00c9d9e93ff62478d3ff0048edebfa57a00fc9cfda87e0b7c30fd8afe12defc72fd997c33ff0adbe26d86b9a2786ed3c51fdb5e22f17f95a26bf713dbeb165fd89e3ed5fc53a049f6c8a08d7ed32696f7906375a5c42e5d9bf353fe1e33fb69ffd167ffcc75f097ff983afd7dff82a27fc9a5eb3ff0063bf82bff4baf2bf043c23fb3a7c73f1ef8774ff0016783be19f88f5ef0f6a9f6bfeced5ec21b67b4bbfb15fdde9979e4bbdd231fb3df595c5b4995044b1483a00cdc3986699665346389cd731c0e59879d58d0862330c661f074275a50a938d28d5c4d5a709549429549c69a939b8427249a8c99e6e699c64f91e1e18bceb35cbb28c2d4ad1c353c4e678ec2e070f3c44e152a42842b62ab52a72ad3a74aa4e34949cdc29d4928b8c2723efafd973e34fc4ff00db4fe2cdafc0dfda6bc4dff0b27e195f687ad788eefc2ffd8be1df0879bade810a5c68f7bfdb7e01d27c2dafc7f6396691fecd1eaab693eedb776f320503f4b3fe1dcbfb167fd119ff00cc8bf16fff009bcafcdbff00827b7c09f8c3f0b7f692d37c57f10be1febbe15f0f45e12f1558c9abea915bc766977796b025ac0cd1dc4ac249d94841b70483935fbcff00dbfa2ffd04adbfefb3fe15e3ff00ae9c17ff00457f0c7fe24194797fd46ff5af66785ff1107c3fff00a2e7847ff126c93cbfea3bcd7dfea7e59fed43f05be187ec57f096f7e397eccbe19ff856df136c35cd13c3769e28fedaf1178bfcad135fb89edf58b2fec4f1f6afe29d024fb645046bf69934b7bc831bad2e2172ecdf9a9ff0f19fdb4ffe8b3ffe63af84bffcc1d7eccffc141fc35af7c51fd9b754f09fc3ed32e3c55e219bc5be14bd8b48d2c24976f69677774f7570ab2491af970232b39dd90186324d7e0c7fc322fed35ff446bc5dff0080f67ffc9947fae9c17ff457f0c7fe24194797fd46ff005af661ff001107c3ff00fa2e7847ff00126c93cbfea3bcd7dfea7dadfb2e7c69f89ffb69fc59b5f81bfb4d789bfe164fc32bed0f5af11ddf85ff00b17c3be10f375bd0214b8d1ef7fb6fc03a4f85b5f8fec72cd23fd9a3d556d27ddb6eede640a07e967fc3b97f62cffa233ff9917e2dff00f3795f949ff04e5f08f89fc07fb6a43e13f18e8d79e1ff0010e95e08f14ff68e917ea8b7769f6dd174cd46cfcd547751f68b1bcb5ba4c31fdd4d1eec3122bfa35afa1a15e862a851c4e1ab52c461f114a9d7c3e228d4855a35e855829d2ad46ac252854a556169d3a909384e0e328c9c5a93fa9c3e230f8cc3d0c5e12bd1c5617134696230d89c3d5856c3e230f5a0aa50af42b5394e9d6a35a9b552955a73942a41a9c2528be67f939fb50fc16f861fb15fc25bdf8e5fb32f867fe15b7c4db0d7344f0dda78a3fb6bc45e2ff2b44d7ee27b7d62cbfb13c7dabf8a74093ed91411afda64d2def20c6eb4b885cbb37e6a7fc3c67f6d3ffa2cff00f98ebe12ff00f3075fafbff0544ff934bd67fec77f057fe975e57f3515a9b1fac5fb2e7c69f89ffb69fc59b5f81bfb4d789bfe164fc32bed0f5af11ddf85ff00b17c3be10f375bd0214b8d1ef7fb6fc03a4f85b5f8fec72cd23fd9a3d556d27ddb6eede640a07e967fc3b97f62cffa233ff9917e2dff00f3795f905ff04b9ff93b3d27fec48f1a7fe91dbd7f4af401f939fb50fc16f861fb15fc25bdf8e5fb32f867fe15b7c4db0d7344f0dda78a3fb6bc45e2ff002b44d7ee27b7d62cbfb13c7dabf8a74093ed91411afda64d2def20c6eb4b885cbb37e6a7fc3c67f6d3ff00a2cfff0098ebe12fff003075fafbff000544ff00934bd67fec77f057fe975e57f351401fac5fb2e7c69f89ff00b69fc59b5f81bfb4d789bfe164fc32bed0f5af11ddf85ffb17c3be10f375bd0214b8d1ef7fb6fc03a4f85b5f8fec72cd23fd9a3d556d27ddb6eede640a07e967fc3b97f62cff00a233ff009917e2dfff003795f905ff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af401f807fb387c71f893fb71fc4eb6f809fb47eb16be2df86fa868fab789aeb47d2f48d33c2b76facf87634b8d26e1758f0ddb69da9247049348cf6eb702098305991c2835fa0ff00f0ed0fd8f3fe840d6fff000bdf1a7ff2e6bf277fe0973ff2767a4ffd891e34ff00d23b7afe95e803f24bf68df81df0dbf61bf86179f1ebf670d1eebc25f1234fd6347f0cdaeb3aa6afaa78a6d1346f10cf35b6ad6e747f125d6a3a6bc971141184b87b769e039686446249fcf9ff008797fed87ff43fe89ff841782fff0094d5fac5ff000544ff00934bd67fec77f057fe975e57f351401fad9fb387c71f893fb71fc4eb6f809fb47eb16be2df86fa868fab789aeb47d2f48d33c2b76facf87634b8d26e1758f0ddb69da9247049348cf6eb702098305991c2835fabde17f867e0ef839a0d97c37f00e9f3e99e15f0e9bbfec9b1b9bfbdd4a783fb56feeb5cbedf7d7f34f773f9ba8ea77732f9d2b7968e9047b628d56bf11bfe0973ff002767a4ff00d891e34ffd23b7afdf6f13ff00c87b50fadbff00e92dbd7f34fd29ff00e4dde51ff65865ff00faa5e243f917e9a1ff0026ab21ff00b2fb2aff00d66f8c0c0a28a2bf814ff32428a28a00f8c3f6b3f0ce8ffb3f78335afdb0be175bbe8df1cb53d63c3de19bcf13ddcf3eafa6c9a35e423c37716ebe1ad524bad0e391f49d0b4f805c25909d1e37b85905c492c8df9b7ff0f2ff00db0ffe87fd13ff00082f05ff00f29abf50bfe0a35ff265b75ff63bf84fff004f5ac57f3915feaf7871ff0026eb80bfec8de16ffd51e0cff6cbc28ff9355e19ff00d903c17ffacde5e7eb67ece1f1c7e24fedc7f13adbe027ed1fac5af8b7e1bea1a3eade26bad1f4bd234cf0addbeb3e1d8d2e349b85d63c376da76a491c124d233dbadc08260c166470a0d7e83ffc3b43f63cff00a1035bff00c2f7c69ffcb9afc9dff825cffc9d9e93ff0062478d3ff48edebfa57afb23ef8fc92fda37e077c36fd86fe185e7c7afd9c347baf097c48d3f58d1fc336bacea9abea9e29b44d1bc433cd6dab5b9d1fc4975a8e9af25c4504612e1edda780e5a19118927f3e7fe1e5ffb61ff00d0ff00a27fe105e0bffe5357eb17fc1513fe4d2f59ff00b1dfc15ffa5d795fcd45007eb67ece1f1c7e24fedc7f13adbe027ed1fac5af8b7e1bea1a3eade26bad1f4bd234cf0addbeb3e1d8d2e349b85d63c376da76a491c124d233dbadc08260c166470a0d7e83ff00c3b43f63cffa1035bffc2f7c69ff00cb9afc9dff00825cff00c9d9e93ff62478d3ff0048edebfa57a00fc92fda37e077c36fd86fe185e7c7afd9c347baf097c48d3f58d1fc336bacea9abea9e29b44d1bc433cd6dab5b9d1fc4975a8e9af25c4504612e1edda780e5a19118927f3e7fe1e5ffb61ff00d0ff00a27fe105e0bffe5357eb17fc1513fe4d2f59ff00b1dfc15ffa5d795fcd45007ef8fc78f80bf0f3f60bf87775fb41fecf96faae9ff10b4ed574bf0b5b5cf8a75497c49a40d23c4934d6daa23e95731dbc6f3bc56e9e44e64dd0b6e20313cfc3ff00f0f45fdacffe82fe08ff00c22acfff00932bf51bfe0a89ff002697acff00d8efe0affd2ebcafe6a2803f5dfe02fc79f887fb7a7c43b7fd9eff00683b9d2b50f87ba8e95a9f8a6e6dbc2da5c5e1bd5ceafe1b8d6e74b74d52de5b891205927733c023c4c0aab30009afb83fe1d75fb267fd023c6fff0085adefff0021d7e5cffc12e7fe4ecf49ff00b123c69ffa476f5fd2bd007e447c78f80bf0f3f60bf87775fb41fecf96faae9ff10b4ed574bf0b5b5cf8a75497c49a40d23c4934d6daa23e95731dbc6f3bc56e9e44e64dd0b6e20313cfd01fb32fc51f16fc6af819e09f89be399ac67f13f890f89ffb525d36c934fb27fec8f1a788b40b2f26ce379161c69fa55a2c9863e64c2494e19d81c5ff0082a27fc9a5eb3ff63bf82bff004baf2b95fd837fe4d2be14fd7c79ff00ab43c695fcd3f4a7ff009377947fd96197ff00ea97890fe45fa687fc9aac87fecbecabff0059be303ebba28a2bf814ff0032428a28a00f8135df146adfb457ed6be30fd8bfe253c173f05b4bd2b4df14da58e9102e97e241abd9782bc37e27b7793c41134b3bc0354d7afdde030e1a068602c162dcded5ff000ebafd933fe811e37ffc2d6f7ff90ebe73f853ff002966f885ff0062445ffaa9fe1fd7eced7fabde1c7fc9bae02ffb23785bff00547833fdb2f0a3fe4d57867ff640f05ffeb37979f911f1e3e02fc3cfd82fe1ddd7ed07fb3e5beaba7fc42d3b55d2fc2d6d73e29d525f12690348f124d35b6a88fa55cc76f1bcef15ba7913993742db880c4f3f0fff00c3d17f6b3ffa0bf823ff0008ab3ffe4cafd46ff82a27fc9a5eb3ff0063bf82bff4baf2bf9a8afb23ef8fd77f80bf1e7e21fede9f10edff0067bfda0ee74ad43e1eea3a56a7e29b9b6f0b6971786f573abf86e35b9d2dd354b796e24481649dccf008f1302aacc0026bee0ff875d7ec99ff00408f1bff00e16b7bff00c875f973ff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af401f911f1e3e02fc3cfd82fe1ddd7ed07fb3e5beaba7fc42d3b55d2fc2d6d73e29d525f12690348f124d35b6a88fa55cc76f1bcef15ba7913993742db880c4f3f0ff00fc3d17f6b3ff00a0bf823ff08ab3ff00e4cafd46ff0082a27fc9a5eb3ff63bf82bff004baf2bf9a8a00fd77f80bf1e7e21fede9f10edff0067bfda0ee74ad43e1eea3a56a7e29b9b6f0b6971786f573abf86e35b9d2dd354b796e24481649dccf008f1302aacc0026bee0ff875d7ec99ff00408f1bff00e16b7bff00c875f973ff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af401f831f063f681f1f7fc1413c710fece7f1e61d02d3c05a969da878aee26f00e9b75a078886abe1845b9d3163d4752d4fc436cb6ad24eff006a84e9ecf2a9509346416afaeffe1d49fb2dff00d047e297fe15ba2fff003215f9a9ff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af401f8fdf197f67df017fc13efc0d73fb467c069f5fbcf1ee9ba8e9de13b687c7ba8daebfe1d3a5789a596d7536974dd374df0fdcb5dac76e9f65986a2b1c4c58c90cb9c57c87ff000f5afda97fe7c3e167fe123adfff003635fa59ff000544ff00934bd67fec77f057fe975e57f351401fb03f063f681f1f7fc1413c710fece7f1e61d02d3c05a969da878aee26f00e9b75a078886abe1845b9d3163d4752d4fc436cb6ad24eff006a84e9ecf2a9509346416afd4df87df04749f831e0fd27e1a780adf5bbbf0b7870ea1fd9571ac5cc17da939d5f56d435fbefb4dd5bda58c52ecd4353ba48b6dac7b2010c4c1dd1e56fc42ff825cffc9d9e93ff0062478d3ff48edebfa57af82f113c3ecb3c48c8f0b9166b8ec76070f85cd2866b0ad97fd5d57956a184cc3091a52facd0af0f652863a7295a0a7cf0a76924e69fe67e2a785f93f8b5c3b83e1bceb31ccb2dc2e0b39c36754ebe57f555889e230f81cd3030a53fade1f134fd8ca9e655672e5829f3c295a7cbce9fcc7e3cf12e83f0bbc3b2f8b3e20ea96fe15f0f43756b632eafaa9923b44bbbc778ed202d1a48de64ed1b2a0da464724641af0fff0086bafd997fe8b2f847ff00022f3ff90ea2ff0082a27fc9a5eb3ff63bf82bff004baf2bf9a8afc67fe254b833fe8a5e26fbf28f2ffa9675b3fbfc8fc07fe24a7c3fff00a2b78bff00f02c93cbfea51fd5d6f677fea3fc05f1dbe0efc52f1147e13f87bf10342f1578865b4babe8f48d2e5b892f1ececd55aeae1565823531c0a54c8776402383ce7dc3fb035aff00a06dcffdf03ff8aafc11ff00825cff00c9d9e93ff62478d3ff0048edebfa57a3fe254b833fe8a5e26fbf28f2ff00a9675b3fbfc83fe24a7c3fff00a2b78bff00f02c93cbfea51fd5d6f677fcaefda93c1963fb30db7883f6d6f012de1f8cba8ea3e1ef09ded8f89a58f51f05a695a869f6de1895a3d0ad22d36f92ece97a0e9f24531d6dd16e9ee26681a374847c27ff000f5afda97fe7c3e167fe123adfff003635fa59ff000544ff00934bd67fec77f057fe975e57f3515fd1f916534720c8f26c8b0d56a56c3e4d9565d94d0ad5b97db55a39760e960e955abc918c3dad48528cea7245439e52e58c62923fac386f24c3f0cf0e641c3784ad5b1186c8326cab24c362311ecfeb15f0f9560686068d6afeca14e9fb6ab4e846757d9c230e772e58463a1fb03f063f681f1f7fc1413c710fece7f1e61d02d3c05a969da878aee26f00e9b75a078886abe1845b9d3163d4752d4fc436cb6ad24eff006a84e9ecf2a9509346416afaeffe1d49fb2dff00d047e297fe15ba2fff003215f9a9ff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af5ea1ed1f8fdf197f67df017fc13efc0d73fb467c069f5fbcf1ee9ba8e9de13b687c7ba8daebfe1d3a5789a596d7536974dd374df0fdcb5dac76e9f65986a2b1c4c58c90cb9c57c87ff000f5afda97fe7c3e167fe123adfff003635fa59ff000544ff00934bd67fec77f057fe975e57f351401fb03f063f681f1f7fc1413c710fece7f1e61d02d3c05a969da878aee26f00e9b75a078886abe1845b9d3163d4752d4fc436cb6ad24eff006a84e9ecf2a9509346416afaeffe1d49fb2dff00d047e297fe15ba2fff003215f9a9ff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af401f8fdf197f67df017fc13efc0d73fb467c069f5fbcf1ee9ba8e9de13b687c7ba8daebfe1d3a5789a596d7536974dd374df0fdcb5dac76e9f65986a2b1c4c58c90cb9c57c87ff000f5afda97fe7c3e167fe123adfff003635fa59ff000544ff00934bd67fec77f057fe975e57f351401fbbbf143f675f03ff00c13afc253fed2bf04b55f14f8a3c6fa65f58f842df4af8a37da3eb3e127d33c5324b6ba8cf358f84f40f046acd7d0c76c8d652a6b896f1bb3fda2d2e0102be69ff0087b87ed2bff423fc12ff00c26be207ff003d2afd10ff0082a27fc9a5eb3ff63bf82bff004baf2bf9a8a00fd8bf85bfb44f8e3fe0a29e2d8bf66af8dba5785bc31e08d4ec6f7c5d71ab7c2eb1d6346f16a6a7e165175a7410df78b35ff1c692b633c970e2f627d0dee644082deee060cc7e96ff008747fecd5ff43c7c6dff00c297e1ff00ff003adafcefff00825cff00c9d9e93ff62478d3ff0048edebfa57a00fc74f8a1fb3af81ff00e09d7e129ff695f825aaf8a7c51e37d32fac7c216fa57c51bed1f59f093e99e29925b5d4679ac7c27a07823566be863b646b29535c4b78dd9fed169700815f34ff00c3dc3f695ffa11fe097fe135f103ff009e957e887fc1513fe4d2f59ffb1dfc15ff00a5d795fcd45007ec5fc2dfda27c71ff0514f16c5fb357c6dd2bc2de18f046a7637be2eb8d5be1758eb1a378b5353f0b28bad3a086fbc59aff8e3495b19e4b8717b13e86f73220416f77030663f4b7fc3a3ff0066affa1e3e36ff00e14bf0ff00ff009d6d7e77ff00c12e7fe4ecf49ffb123c69ff00a476f5fd2bd007e3a7c50fd9d7c0ff00f04ebf094ffb4afc12d57c53e28f1be997d63e10b7d2be28df68facf849f4cf14c92daea33cd63e13d03c11ab35f431db23594a9ae25bc6ecff68b4b8040af9a7fe1ee1fb4affd08ff0004bff09af881ff00cf4abf443fe0a89ff2697acffd8efe0aff00d2ebcafe6a2803f62fe16fed13e38ff828a78b62fd9abe36e95e16f0c782353b1bdf175c6adf0bac758d1bc5a9a9f85945d69d0437de2cd7fc71a4ad8cf25c38bd89f437b991020b7bb818331fa5bfe1d1ff00b357fd0f1f1b7ff0a5f87fff00ceb6bf3bff00e0973ff2767a4ffd891e34ff00d23b7afe95e803f1d3e287ecebe07ff8275f84a7fda57e096abe29f1478df4cbeb1f085be95f146fb47d67c24fa678a6496d7519e6b1f09e81e08d59afa18ed91aca54d712de3767fb45a5c02057cd3ff0f70fda57fe847f825ff84d7c40ff00e7a55fa21ff0544ff934bd67fec77f057fe975e57f351401fb17f0b7f689f1c7fc1453c5b17ecd5f1b74af0b7863c11a9d8def8bae356f85d63ac68de2d4d4fc2ca2eb4e821bef166bfe38d256c6792e1c5ec4fa1bdcc88105bddc0c198fd2dff0e8ff00d9abfe878f8dbff852fc3fff00e75b5f9dff00f04b9ff93b3d27fec48f1a7fe91dbd7f4af401f8e9f143f675f03ffc13afc253fed2bf04b55f14f8a3c6fa65f58f842df4af8a37da3eb3e127d33c5324b6ba8cf358f84f40f046acd7d0c76c8d652a6b896f1bb3fda2d2e0102be69ff87b87ed2bff00423fc12ffc26be207ff3d2afd10ff82a27fc9a5eb3ff0063bf82bff4baf2bf9a8a00fd8bf85bfb44f8e3fe0a29e2d8bf66af8dba5785bc31e08d4ec6f7c5d71ab7c2eb1d6346f16a6a7e165175a7410df78b35ff001c692b633c970e2f627d0dee644082deee060cc7e96ff8747fecd5ff0043c7c6dffc297e1fff00f3adafceff00f825cffc9d9e93ff0062478d3ff48edebfa57a00fc2cf00fed19e2aff828d78853f667f8a5a1681e07f0b6a76b73e2f9b5ff00012ea4be228efbc2a3ed5656b11f10ea1ae69df64b97b865ba0f62d3ed0be4cd1b0663ee1ff0e87f81ff00f453fe29ff00df7e0eff00e656be0bff00825cff00c9d9e93ff62478d3ff0048edebfa57a00fc69f1dfece5e15ff008272f8766fda63e16ebdaff8e3c53a65d5a783e1d07c7c74c6f0ec963e29924b5bdba917c3da7e87a8fdaad92d95ad76df08773379d14838af0fff0087bbfc70ff00a263f0b7fefdf8c3ff009a9afbd7fe0a89ff002697acff00d8efe0affd2ebcafe6a2803f657c03fb4678abfe0a35e214fd99fe29685a0781fc2da9dadcf8be6d7fc04ba92f88a3bef0a8fb5595ac47c43a86b9a77d92e5ee196e83d8b4fb42f93346c198fb87fc3a1fe07ffd14ff008a7ff7df83bff995af82ff00e0973ff2767a4ffd891e34ff00d23b7afe95e803f1a7c77fb397857fe09cbe1d9bf698f85baf6bfe38f14e997569e0f8741f1f1d31bc3b258f8a6492d6f6ea45f0f69fa1ea3f6ab64b656b5db7c21dccde74520e2bc3ff00e1eeff001c3fe898fc2dff00bf7e30ff00e6a6bef5ff0082a27fc9a5eb3ff63bf82bff004baf2bf9a8a00fd95f00fed19e2aff00828d78853f667f8a5a1681e07f0b6a76b73e2f9b5ff012ea4be228efbc2a3ed5656b11f10ea1ae69df64b97b865ba0f62d3ed0be4cd1b0663ee1ff000e87f81fff00453fe29ffdf7e0effe656be0bff825cffc9d9e93ff0062478d3ff48edebfa57a00fc69f1dfece5e15ff8272f8766fda63e16ebdaff008e3c53a65d5a783e1d07c7c74c6f0ec963e29924b5bdba917c3da7e87a8fdaad92d95ad76df08773379d14838af0ff00f87bbfc70ffa263f0b7fefdf8c3ff9a9afbd7fe0a89ff2697acffd8efe0aff00d2ebcafe6a2803f657c03fb4678abfe0a35e214fd99fe29685a0781fc2da9dadcf8be6d7fc04ba92f88a3bef0a8fb5595ac47c43a86b9a77d92e5ee196e83d8b4fb42f93346c198fb87fc3a1fe07ff00d14ff8a7ff007df83bff00995af82ffe0973ff002767a4ff00d891e34ffd23b7afe95e803f1a7c77fb397857fe09cbe1d9bf698f85baf6bfe38f14e997569e0f8741f1f1d31bc3b258f8a6492d6f6ea45f0f69fa1ea3f6ab64b656b5db7c21dccde74520e2bc3ffe1eeff1c3fe898fc2dffbf7e30ffe6a6bef5ff82a27fc9a5eb3ff0063bf82bff4baf2bf9a8a00fd95f00fed19e2aff828d78853f667f8a5a1681e07f0b6a76b73e2f9b5ff00012ea4be228efbc2a3ed5656b11f10ea1ae69df64b97b865ba0f62d3ed0be4cd1b0663ee1ff0e87f81ff00f453fe29ff00df7e0eff00e656be0bff00825cff00c9d9e93ff62478d3ff0048edebfa57a00fc69f1dfece5e15ff008272f8766fda63e16ebdaff8e3c53a65d5a783e1d07c7c74c6f0ec963e29924b5bdba917c3da7e87a8fdaad92d95ad76df08773379d14838af0fff0087bbfc70ff00a263f0b7fefdf8c3ff009a9afbd7fe0a89ff002697acff00d8efe0affd2ebcafe6a2803f723c51fb38687ff04dfd224fda6fc11e26d57e23eb9a5cf0783a3f0c78a6d2cf4bd225b5f153c969737af79a49376b3da2db2bc118cc6e59849c735e69ff000f7ff897ff00446fc11ff83ef107f857db5ff0544ff934bd67fec77f057fe975e57f351401fb3fe15fda3f5cff00828feacbfb3278dfc35a57c38d0f54826f1849e27f0b5dde6a9abc575e1406eadacd2cf5602d1a0bc6b8659e463e6228531e4824fa67fc3a03e1a7fd164f1bff00e087c3ff00e35f12ff00c12e7fe4ecf49ffb123c69ff00a476f5fd2bd007e2ff008a3f670d0ffe09bfa449fb4df823c4daafc47d734b9e0f0747e18f14da59e97a44b6be2a792d2e6f5ef34926ed67b45b657823198dcb30938e6bcd3fe1efff0012ff00e88df823ff0007de20ff000afb6bfe0a89ff002697acff00d8efe0affd2ebcafe6a2803f67fc2bfb47eb9ff051fd597f664f1bf86b4af871a1ea904de3093c4fe16bbbcd53578aebc280dd5b59a59eac05a34178d70cb3c8c7cc450a63c9049f4cff0087407c34ff00a2c9e37ffc10f87ffc6be25ff825cffc9d9e93ff0062478d3ff48edebfa57a00fc5ff147ece1a1ff00c137f4893f69bf04789b55f88fae6973c1e0e8fc31e29b4b3d2f4896d7c54f25a5cdebde6924ddacf68b6caf046331b9661271cd79a7fc3dff00e25ffd11bf047fe0fbc41fe15f6d7fc1513fe4d2f59ffb1dfc15ff00a5d795fcd45007ecff00857f68fd73fe0a3fab2fecc9e37f0d695f0e343d5209bc612789fc2d7779aa6af15d78501bab6b34b3d580b4682f1ae1967918f988a14c792093e99ff0e80f869ff4593c6fff00821f0fff008d7c4bff0004b9ff0093b3d27fec48f1a7fe91dbd7f4af401f8bfe28fd9c343ff826fe9127ed37e08f136abf11f5cd2e783c1d1f863c536967a5e912daf8a9e4b4b9bd7bcd249bb59ed16d95e08c66372cc24e39af34ff0087bffc4bff00a237e08ffc1f7883fc2bedaff82a27fc9a5eb3ff0063bf82bff4baf2bf9a8a00fd9ff0afed1fae7fc147f565fd993c6fe1ad2be1c687aa41378c24f13f85aeef354d5e2baf0a03756d66967ab0168d05e35c32cf231f3114298f24127d33fe1d01f0d3fe8b278dff00f043e1ff00f1af897fe0973ff2767a4ffd891e34ff00d23b7afe95e803f17fc51fb38687ff0004dfd224fda6fc11e26d57e23eb9a5cf0783a3f0c78a6d2cf4bd225b5f153c969737af79a49376b3da2db2bc118cc6e59849c735e69ff0f7ff00897ff446fc11ff0083ef107f857db5ff000544ff00934bd67fec77f057fe975e57f351401fb3fe15fda3f5cff828feacbfb3278dfc35a57c38d0f54826f1849e27f0b5dde6a9abc575e1406eadacd2cf5602d1a0bc6b8659e463e6228531e4824fa67fc3a03e1a7fd164f1bffe087c3ffe35f12ffc12e7fe4ecf49ff00b123c69ffa476f5fd2bd007e20e95fb495f7fc1496effe19875bf08dafc28b1d5237f18b78c34bd626f165dc32f8533751d80d1aef4ed062923be37051ee0dfab401432c32926ba5ff00873c786bfe8bdeb7ff0086ff004fff00e6b28a28033b53fd9b6c7fe09b366ffb4f689e2ebaf8af7da5bc7e0d5f07ea9a3c3e13b49a2f15b3da49a836b369a8ebd3249622d83a5b8b0659cb9569a3c6e3cd7fc3e1fc4bff00441344ff00c381a87ff327451401a3a57ed257dff0525bbff8661d6fc236bf0a2c7548dfc62de30d2f589bc59770cbe14cdd4760346bbd3b418a48ef8dc147b837ead0050cb0ca49ae97fe1cf1e1affa2f7adffe1bfd3fff009aca28a00ced4ff66db1ff00826cd9bfed3da278baebe2bdf696f1f8357c1faa68f0f84ed268bc56cf6926a0dacda6a3af4c92588b60e96e2c19672e55a68f1b8f35ff000f87f12ffd104d13ff000e06a1ff00cc9d1450068e95fb495f7fc1496eff00e19875bf08dafc28b1d5237f18b78c34bd626f165dc32f8533751d80d1aef4ed062923be37051ee0dfab401432c32926ba5ff873c786bfe8bdeb7ff86ff4ff00fe6b28a28033b53fd9b6c7fe09b366ff00b4f689e2ebaf8af7da5bc7e0d5f07ea9a3c3e13b49a2f15b3da49a836b369a8ebd3249622d83a5b8b0659cb9569a3c6e3cd7fc3e1fc4bff441344ffc381a87ff00327451401a3a57ed257dff000525bbff008661d6fc236bf0a2c7548dfc62de30d2f589bc59770cbe14cdd4760346bbd3b418a48ef8dc147b837ead0050cb0ca49ae97fe1cf1e1aff00a2f7adff00e1bfd3ff00f9aca28a00ced4ff0066db1ff826cd9bfed3da278baebe2bdf696f1f8357c1faa68f0f84ed268bc56cf6926a0dacda6a3af4c92588b60e96e2c19672e55a68f1b8f35ff0f87f12ff00d104d13ff0e06a1ffcc9d1450068e95fb495f7fc1496effe19875bf08dafc28b1d5237f18b78c34bd626f165dc32f8533751d80d1aef4ed062923be37051ee0dfab401432c32926ba5ff00873c786bfe8bdeb7ff0086ff004fff00e6b28a28033b53fd9b6c7fe09b366ffb4f689e2ebaf8af7da5bc7e0d5f07ea9a3c3e13b49a2f15b3da49a836b369a8ebd3249622d83a5b8b0659cb9569a3c6e3cd7fc3e1fc4bff00441344ff00c381a87ff327451401ffd9, NULL, NULL),
(5, '904cf11f-9a41-466f-993a', 'test', 'test@hobby.local', '9730dcce5169aca755381767a284e726e9297729f82ada9ea99176f0c1251539bdd8d393a38e8c0e8eced805f08666d495e4534c9bd74c9188d3eaa31f43b4d0', '8f675f19a777f533', '2019-09-24 14:57:18', '2019-09-24 14:57:18', 0, 0, 0, 'bcdb7436fec7747862c9aadad1bc93e2e510e45d', 1, NULL, NULL, NULL),
(7, '1d92bf15-66e2-4e99-86b2', 'john', 'johndoe@hobby.local', 'ee697fafd511f5556e4afde0dea7f7e44d5a99dcbbba056a95519d8740924b11ecfe9580c3c3f6d4f4197cdf397111d56b80a3385ea539823f0294b05b228edb', 'fe0c4cbdb71171ca', '2019-09-24 16:50:17', '2019-09-24 16:50:17', 1, 0, 0, '5419625011ffcce6bd2f0d272cb56e9304606c57', 1, NULL, NULL, NULL);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `catalogue`
--
ALTER TABLE `catalogue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Category` (`category_id`),
  ADD KEY `FK_Site` (`site_id`);

--
-- A tábla indexei `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan`);

--
-- A tábla indexei `loancategory`
--
ALTER TABLE `loancategory`
  ADD PRIMARY KEY (`loancategory`);

--
-- A tábla indexei `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction`),
  ADD KEY `FK_Category` (`transaction`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_id` (`unique_id`),
  ADD KEY `FK_Site_User` (`default_site_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `catalogue`
--
ALTER TABLE `catalogue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=251;
--
-- AUTO_INCREMENT a táblához `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT a táblához `loan`
--
ALTER TABLE `loan`
  MODIFY `loan` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT a táblához `loancategory`
--
ALTER TABLE `loancategory`
  MODIFY `loancategory` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `site`
--
ALTER TABLE `site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT a táblához `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `catalogue`
--
ALTER TABLE `catalogue`
  ADD CONSTRAINT `FK_Category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_Site` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`);

--
-- Megkötések a táblához `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_Site_User` FOREIGN KEY (`default_site_id`) REFERENCES `site` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
