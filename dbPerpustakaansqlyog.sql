/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.28-MariaDB : Database - dbperpustakaan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dbperpustakaan_1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `dbperpustakaan_1`;

/*Table structure for table `tblbuku` */

DROP TABLE IF EXISTS `tblbuku`;

CREATE TABLE `tblbuku` (
  `idBuku` int(11) NOT NULL AUTO_INCREMENT,
  `judulBuku` varchar(255) NOT NULL,
  `pengarang` varchar(255) NOT NULL,
  `penerbit` varchar(255) NOT NULL,
  `tahunTerbit` char(4) NOT NULL,
  `jmlHalaman` int(5) NOT NULL,
  `stokBuku` int(4) NOT NULL,
  `statusAktif` enum('1','0') NOT NULL,
  PRIMARY KEY (`idBuku`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tblbuku` */

insert  into `tblbuku`(`idBuku`,`judulBuku`,`pengarang`,`penerbit`,`tahunTerbit`,`jmlHalaman`,`stokBuku`,`statusAktif`) values 
(1,'Sistem Operasi','Saiful Ahlan','Teknokrat','2018',105,40,'1'),
(2,'Teknologi Jaringan','Ferico','Teknokrat','2015',99,150,'1'),
(3,'Logika Informatika','Permata','Teknokrat','2004',187,70,'1'),
(4,'Kalkulus','Very','Teknokrat','2019',88,50,'1'),
(5,'Pengantar Tekonologi Informasi','Susiani','Teknokrat','2019',109,80,'1'),
(6,'Organisasi Komuter','Ajeng','Teknokrat','2016',176,60,'1'),
(7,'Mahir Belajar CorelDraw X7','Ade','Teknokrat','2016',132,15,'1');

/*Table structure for table `tblkaryawan` */

DROP TABLE IF EXISTS `tblkaryawan`;

CREATE TABLE `tblkaryawan` (
  `idKaryawan` int(11) NOT NULL AUTO_INCREMENT,
  `namaKaryawan` varchar(255) NOT NULL,
  `statusAktif` enum('1','0') NOT NULL,
  PRIMARY KEY (`idKaryawan`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tblkaryawan` */

insert  into `tblkaryawan`(`idKaryawan`,`namaKaryawan`,`statusAktif`) values 
(1,'Mamat','1'),
(2,'Budi','1'),
(3,'Wawan','1'),
(4,'Sandi','1'),
(5,'Sinta','1');

/*Table structure for table `tblpeminjam` */

DROP TABLE IF EXISTS `tblpeminjam`;

CREATE TABLE `tblpeminjam` (
  `idPeminjam` int(11) NOT NULL AUTO_INCREMENT,
  `namaPeminjam` varchar(255) NOT NULL,
  `levelPeminjam` enum('dosen','mahasiswa') NOT NULL,
  `statusAktif` enum('1','0') NOT NULL,
  PRIMARY KEY (`idPeminjam`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tblpeminjam` */

insert  into `tblpeminjam`(`idPeminjam`,`namaPeminjam`,`levelPeminjam`,`statusAktif`) values 
(1,'Yunus Febriansyah','mahasiswa','1'),
(2,'Riski','mahasiswa','1'),
(3,'Muhammad Gilang','mahasiswa','1'),
(4,'Saniati','dosen','1'),
(5,'Febty Ariany','dosen','1');

/*Table structure for table `tblpeminjaman` */

DROP TABLE IF EXISTS `tblpeminjaman`;

CREATE TABLE `tblpeminjaman` (
  `idPeminjaman` int(11) NOT NULL AUTO_INCREMENT,
  `idBuku` int(11) NOT NULL,
  `idPeminjam` int(11) NOT NULL,
  `idKaryawan` int(11) NOT NULL,
  `jmlPeminjaman` int(2) NOT NULL,
  `statusAktif` enum('1','0') NOT NULL,
  PRIMARY KEY (`idPeminjaman`),
  KEY `ambilIDBukuPeminjaman` (`idBuku`),
  KEY `ambilIDPeminjaman` (`idPeminjam`),
  KEY `ambilIDKaryawan` (`idKaryawan`),
  CONSTRAINT `ambilIDBukuPeminjaman` FOREIGN KEY (`idBuku`) REFERENCES `tblbuku` (`idBuku`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ambilIDKaryawan` FOREIGN KEY (`idKaryawan`) REFERENCES `tblkaryawan` (`idKaryawan`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ambilIDPeminjaman` FOREIGN KEY (`idPeminjam`) REFERENCES `tblpeminjam` (`idPeminjam`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tblpeminjaman` */

insert  into `tblpeminjaman`(`idPeminjaman`,`idBuku`,`idPeminjam`,`idKaryawan`,`jmlPeminjaman`,`statusAktif`) values 
(1,3,1,2,2,'1'),
(2,7,4,1,5,'1'),
(3,7,1,4,5,'1');

/*Table structure for table `tblpengembalian` */

DROP TABLE IF EXISTS `tblpengembalian`;

CREATE TABLE `tblpengembalian` (
  `idPengembalian` int(11) NOT NULL AUTO_INCREMENT,
  `idPeminjaman` int(11) NOT NULL,
  `idKaryawan` int(11) NOT NULL,
  `jmlPengembalian` int(2) NOT NULL,
  `statusAktif` enum('1','0') NOT NULL,
  PRIMARY KEY (`idPengembalian`),
  KEY `ambilIDPeminjamanuntukPengembalian` (`idPeminjaman`),
  KEY `ambilIDKaryawanPengembalian` (`idKaryawan`),
  CONSTRAINT `ambilIDKaryawanPengembalian` FOREIGN KEY (`idKaryawan`) REFERENCES `tblkaryawan` (`idKaryawan`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ambilIDPeminjamanuntukPengembalian` FOREIGN KEY (`idPeminjaman`) REFERENCES `tblpeminjaman` (`idPeminjaman`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tblpengembalian` */

insert  into `tblpengembalian`(`idPengembalian`,`idPeminjaman`,`idKaryawan`,`jmlPengembalian`,`statusAktif`) values 
(1,1,5,1,'1');

/* Trigger structure for table `tblpeminjaman` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trgPeminjaman` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trgPeminjaman` AFTER INSERT ON `tblpeminjaman` FOR EACH ROW BEGIN
	update `dbperpustakaan`.`tblbuku` set stokBuku = stokBuku - new.jmlPeminjaman where idBuku = new.idBuku;
    END */$$


DELIMITER ;

/*Table structure for table `vwpeminjaman` */

DROP TABLE IF EXISTS `vwpeminjaman`;

/*!50001 DROP VIEW IF EXISTS `vwpeminjaman` */;
/*!50001 DROP TABLE IF EXISTS `vwpeminjaman` */;

/*!50001 CREATE TABLE  `vwpeminjaman`(
 `idPeminjaman` int(11) ,
 `idBuku` int(11) ,
 `judulBuku` varchar(255) ,
 `pengarang` varchar(255) ,
 `penerbit` varchar(255) ,
 `tahunTerbit` char(4) ,
 `jmlHalaman` int(5) ,
 `SA_Buku` enum('1','0') ,
 `idPeminjam` int(11) ,
 `namaPeminjam` varchar(255) ,
 `levelPeminjam` enum('dosen','mahasiswa') ,
 `SA_Peminjam` enum('1','0') ,
 `idKaryawan` int(11) ,
 `namaKaryawan` varchar(255) ,
 `SA_Karyawan` enum('1','0') ,
 `jmlPeminjaman` int(2) ,
 `SA_Peminjaman` enum('1','0') 
)*/;

/*Table structure for table `vwpengembalian` */

DROP TABLE IF EXISTS `vwpengembalian`;

/*!50001 DROP VIEW IF EXISTS `vwpengembalian` */;
/*!50001 DROP TABLE IF EXISTS `vwpengembalian` */;

/*!50001 CREATE TABLE  `vwpengembalian`(
 `idPengembalian` int(11) ,
 `idPeminjaman` int(11) ,
 `idBuku` int(11) ,
 `judulBuku` varchar(255) ,
 `idPeminjam` int(11) ,
 `namaPeminjam` varchar(255) ,
 `levelPeminjam` enum('dosen','mahasiswa') ,
 `idKaryawanPeminjaman` int(11) ,
 `namaKaryawanPeminjaman` varchar(255) ,
 `idKaryawanPengembalian` int(11) ,
 `namaKaryawanPengembalian` varchar(255) ,
 `jmlPengembalian` int(2) 
)*/;

/*View structure for view vwpeminjaman */

/*!50001 DROP TABLE IF EXISTS `vwpeminjaman` */;
/*!50001 DROP VIEW IF EXISTS `vwpeminjaman` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwpeminjaman` AS (select `tblpeminjaman`.`idPeminjaman` AS `idPeminjaman`,`tblpeminjaman`.`idBuku` AS `idBuku`,`tblbuku`.`judulBuku` AS `judulBuku`,`tblbuku`.`pengarang` AS `pengarang`,`tblbuku`.`penerbit` AS `penerbit`,`tblbuku`.`tahunTerbit` AS `tahunTerbit`,`tblbuku`.`jmlHalaman` AS `jmlHalaman`,`tblbuku`.`statusAktif` AS `SA_Buku`,`tblpeminjam`.`idPeminjam` AS `idPeminjam`,`tblpeminjam`.`namaPeminjam` AS `namaPeminjam`,`tblpeminjam`.`levelPeminjam` AS `levelPeminjam`,`tblpeminjam`.`statusAktif` AS `SA_Peminjam`,`tblkaryawan`.`idKaryawan` AS `idKaryawan`,`tblkaryawan`.`namaKaryawan` AS `namaKaryawan`,`tblkaryawan`.`statusAktif` AS `SA_Karyawan`,`tblpeminjaman`.`jmlPeminjaman` AS `jmlPeminjaman`,`tblpeminjaman`.`statusAktif` AS `SA_Peminjaman` from (((`tblpeminjaman` join `tblbuku` on(`tblpeminjaman`.`idBuku` = `tblbuku`.`idBuku`)) join `tblpeminjam` on(`tblpeminjaman`.`idPeminjam` = `tblpeminjam`.`idPeminjam`)) join `tblkaryawan` on(`tblpeminjaman`.`idKaryawan` = `tblkaryawan`.`idKaryawan`)) where `tblbuku`.`statusAktif` = 1 and `tblpeminjam`.`statusAktif` = 1 and `tblkaryawan`.`statusAktif` = 1 and `tblpeminjaman`.`statusAktif` = 1) */;

/*View structure for view vwpengembalian */

/*!50001 DROP TABLE IF EXISTS `vwpengembalian` */;
/*!50001 DROP VIEW IF EXISTS `vwpengembalian` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vwpengembalian` AS (select `tblpengembalian`.`idPengembalian` AS `idPengembalian`,`tblpeminjaman`.`idPeminjaman` AS `idPeminjaman`,`tblpeminjaman`.`idBuku` AS `idBuku`,`tblbuku`.`judulBuku` AS `judulBuku`,`tblpeminjaman`.`idPeminjam` AS `idPeminjam`,`tblpeminjam`.`namaPeminjam` AS `namaPeminjam`,`tblpeminjam`.`levelPeminjam` AS `levelPeminjam`,`tblpeminjaman`.`idKaryawan` AS `idKaryawanPeminjaman`,`tblkaryawanpeminjaman`.`namaKaryawan` AS `namaKaryawanPeminjaman`,`tblpengembalian`.`idKaryawan` AS `idKaryawanPengembalian`,`tblkaryawan`.`namaKaryawan` AS `namaKaryawanPengembalian`,`tblpengembalian`.`jmlPengembalian` AS `jmlPengembalian` from (((((`tblpengembalian` join `tblpeminjaman` on(`tblpengembalian`.`idPeminjaman` = `tblpeminjaman`.`idPeminjaman`)) join `tblbuku` on(`tblpeminjaman`.`idBuku` = `tblbuku`.`idBuku`)) join `tblpeminjam` on(`tblpeminjaman`.`idPeminjam` = `tblpeminjam`.`idPeminjam`)) join `tblkaryawan` `tblkaryawanpeminjaman` on(`tblpeminjaman`.`idKaryawan` = `tblkaryawanpeminjaman`.`idKaryawan`)) join `tblkaryawan` on(`tblpengembalian`.`idKaryawan` = `tblkaryawan`.`idKaryawan`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
