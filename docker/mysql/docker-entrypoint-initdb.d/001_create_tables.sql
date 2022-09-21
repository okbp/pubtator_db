use pubtator;
SET GLOBAL local_infile=on;
ALTER INSTANCE DISABLE INNODB REDO_LOG;
commit;

CREATE TABLE `bc2pubtator` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `Type` varchar(8) COLLATE utf8mb4_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
