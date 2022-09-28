use pubtator;
SET GLOBAL local_infile=on;
ALTER INSTANCE DISABLE INNODB REDO_LOG;
GRANT INNODB_REDO_LOG_ENABLE ON *.* to 'pub';
commit;
/* single table mode */
/*
CREATE TABLE `bc2pubtator` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `Type` varchar(8) COLLATE utf8mb4_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
*/

/* separate table mode */
CREATE TABLE `pm` (
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `species` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `disease` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `chemical` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `gene` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `mutation` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `cellline` (
  `serial_id` int unsigned NOT NULL AUTO_INCREMENT,
  `PMID` varchar(8) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `ID` varchar(256) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`serial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;