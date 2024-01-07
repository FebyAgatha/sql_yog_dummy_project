
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW `dbperpustakaan`.`vwPeminjaman` 
    AS
(
SELECT
    `tblpeminjaman`.`idPeminjaman`
    , `tblpeminjaman`.`idBuku`
    , `tblbuku`.`judulBuku`
    , `tblbuku`.`pengarang`
    , `tblbuku`.`penerbit`
    , `tblbuku`.`tahunTerbit`
    , `tblbuku`.`jmlHalaman`
    , `tblbuku`.`statusAktif` AS `SA_Buku`
    , `tblpeminjam`.`idPeminjam`
    , `tblpeminjam`.`namaPeminjam`
    , `tblpeminjam`.`levelPeminjam`
    , `tblpeminjam`.`statusAktif` AS `SA_Peminjam`
    , `tblkaryawan`.`idKaryawan`
    , `tblkaryawan`.`namaKaryawan`
    , `tblkaryawan`.`statusAktif` AS `SA_Karyawan`
    , `tblpeminjaman`.`statusAktif` AS `SA_Peminjaman`
FROM
    `dbperpustakaan`.`tblpeminjaman`
    INNER JOIN `dbperpustakaan`.`tblbuku` 
        ON (`tblpeminjaman`.`idBuku` = `tblbuku`.`idBuku`)
    INNER JOIN `dbperpustakaan`.`tblpeminjam` 
        ON (`tblpeminjaman`.`idPeminjam` = `tblpeminjam`.`idPeminjam`)
    INNER JOIN `dbperpustakaan`.`tblkaryawan` 
        ON (`tblpeminjaman`.`idKaryawan` = `tblkaryawan`.`idKaryawan`)
WHERE `tblbuku`.`statusAktif` = 1 AND `tblpeminjam`.`statusAktif` = 1 AND `tblkaryawan`.`statusAktif` = 1 AND `tblpeminjaman`.`statusAktif` = 1

);
