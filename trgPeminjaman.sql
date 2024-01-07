DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    TRIGGER `dbperpustakaan`.`trgPeminjaman` AFTER INSERT
    ON `dbperpustakaan`.`tblpeminjaman`
    FOR EACH ROW BEGIN
	UPDATE `dbperpustakaan`.`tblbuku` SET stokBuku = stokBuku - new.jmlPeminjaman WHERE idBuku = new.idBuku;
    END$$

DELIMITER ;