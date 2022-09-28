#SET GLOBAL max_heap_table_size = 64 * 1024 * 1024;
#SET GLOBAL tmp_table_size = 64 * 1024 * 1024;
#SET GLOBAL join_buffer_size = 64 * 1024 * 1024;
#SET GLOBAL sort_buffer_size = 64 * 1024 * 1024;

SELECT '=====1=====';
EXPLAIN FORMAT=JSON SELECT count(DISTINCT ot.PMID),ot.ID FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID;
SELECT '=====2=====';

# filtered table join
EXPLAIN SELECT count(DISTINCT ot.PMID),ot.ID 
FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE ID="9606" AND TYPE="Species") as ct 
  INNER JOIN (SELECT PMID, ID FROM pubtator.bc2pubtator WHERE TYPE="Chemical") as ot
  ON ot.PMID=ct.PMID 
GROUP BY ID;
SELECT '=====3=====';
EXPLAIN SELECT count(DISTINCT ot.PMID),ot.ID 
FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE ID="9606" AND TYPE="Species") as ct 
  INNER JOIN (SELECT PMID, ID FROM pubtator.bc2pubtator WHERE TYPE="Gene") as ot
  ON ot.PMID=ct.PMID 
GROUP BY ID;
SELECT '=====4====='; # typeとIDを位置を入れ替えても実行計画は変わらない
EXPLAIN SELECT count(DISTINCT ot.PMID),ot.ID 
FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct 
  INNER JOIN (SELECT PMID, ID FROM pubtator.bc2pubtator WHERE TYPE="Gene") as ot
  ON ot.PMID=ct.PMID 
GROUP BY ID;
SELECT '=====5=====';
EXPLAIN SELECT count(DISTINCT ot.PMID),ot.ID 
FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE ID="7160" AND TYPE="Species") as ct 
  INNER JOIN (SELECT PMID, ID FROM pubtator.bc2pubtator WHERE TYPE="Gene") as ot
  ON ot.PMID=ct.PMID 
GROUP BY ID;
SELECT '=====6=====';
EXPLAIN SELECT PMID
FROM pubtator.bc2pubtator
WHERE ID="9606" AND TYPE="Species";
SELECT '=====7=====';
EXPLAIN SELECT DISTINCT pm2.PMID, pm2.ID
FROM pubtator.bc2pubtator pm1
 JOIN pubtator.bc2pubtator pm2
 ON pm1.PMID = pm2.PMID
WHERE pm1.ID="9606" AND pm1.TYPE="Species" AND pm2.TYPE="Gene";
SELECT '=====8=====';
EXPLAIN FORMAT=JSON SELECT count(DISTINCT pm2.PMID),pm2.ID
FROM pubtator.bc2pubtator pm1
 JOIN pubtator.bc2pubtator pm2
 ON pm1.PMID = pm2.PMID
WHERE pm1.ID="9606" AND pm1.TYPE="Species" AND pm2.TYPE="Gene"
GROUP BY pm2.ID;
SELECT '=====9=====';
EXPLAIN SELECT count(pm2.PMID),pm2.ID
FROM pubtator.bc2pubtator pm2
 JOIN pubtator.bc2pubtator pm1
 ON pm2.PMID = pm1.PMID
WHERE pm2.TYPE="Gene" AND pm1.ID="9606" AND pm1.TYPE="Species"
GROUP BY pm2.ID;
SELECT '=====10=====';
EXPLAIN FORMAT=JSON SELECT pm2.ID, count(pm2.PMID) AS pm_count
FROM pubtator.bc2pubtator pm2
 JOIN pubtator.bc2pubtator pm1
 ON pm2.PMID = pm1.PMID
WHERE pm2.TYPE="Gene" AND pm1.ID="9606" AND pm1.TYPE="Species"
GROUP BY pm2.ID
ORDER BY pm_count DESC;

SELECT '=====11=====';
EXPLAIN SELECT tbl2.ID, count(DISTINCT tbl2.PMID) AS pmid_count
FROM
  (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as tbl1,
  pubtator.bc2pubtator as tbl2
WHERE tbl2.PMID=tbl1.PMID AND tbl2.TYPE="Gene"
GROUP BY ID
ORDER BY pmid_count DESC;
SELECT '=====11=====';
EXPLAIN FORMAT=JSON SELECT tbl2.ID, count(DISTINCT tbl2.PMID) AS pmid_count
FROM
  (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as tbl1,
  pubtator.bc2pubtator as tbl2
WHERE tbl2.PMID=tbl1.PMID AND tbl2.TYPE="Gene"
GROUP BY ID
ORDER BY pmid_count DESC;
SELECT '=====11=====';
EXPLAIN SELECT tbl2.ID, count(tbl2.PMID) AS pmid_count
FROM pubtator.bc2pubtator tbl2
  JOIN pubtator.bc2pubtator tbl1 ON tbl2.PMID = tbl1.PMID
WHERE tbl2.TYPE="Gene" AND tbl1.ID="9606" AND tbl1.TYPE="Species"
GROUP BY tbl2.ID
ORDER BY pmid_count DESC;
SELECT '=====12=====';
EXPLAIN FORMAT=JSON SELECT tbl2.ID, count(tbl2.PMID) AS pmid_count
FROM pubtator.bc2pubtator tbl2
  JOIN pubtator.bc2pubtator tbl1 ON tbl2.PMID = tbl1.PMID
WHERE tbl2.TYPE="Gene" AND tbl1.ID="9606" AND tbl1.TYPE="Species"
GROUP BY tbl2.ID
ORDER BY pmid_count DESC;
SELECT '=====13=====';
EXPLAIN FORMAT=JSON SELECT tbl2.ID, count(tbl2.PMID) AS pmid_count
FROM pubtator.bc2pubtator tbl2
  JOIN pubtator.bc2pubtator tbl1 ON tbl2.PMID = tbl1.PMID
WHERE tbl2.TYPE="Gene" AND tbl1.ID="9606" AND tbl1.TYPE="Species"
GROUP BY tbl2.ID
ORDER BY pmid_count DESC;
SELECT '=====14=====';
EXPLAIN FORMAT=TREE SELECT pm2.ID, count(pm2.PMID) AS pm_count
FROM pubtator.bc2pubtator pm2
  JOIN pubtator.bc2pubtator pm1 ON pm2.PMID = pm1.PMID
WHERE pm2.TYPE="Gene" AND pm1.ID="9606" AND pm1.TYPE="Species"
GROUP BY pm2.ID
ORDER BY pm_count DESC;
SELECT '=====15=====';
EXPLAIN FORMAT=TREE SELECT count(DISTINCT ot.PMID),ot.ID FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID;
SELECT '=====16=====';
SET GLOBAL innodb_buffer_pool_size = 8 * 1024 * 1024 * 1024;
SET GLOBAL max_heap_table_size = 8 * 1024 * 1024 * 1024;
SET GLOBAL tmp_table_size = 8 * 1024 * 1024 * 1024;
SET GLOBAL join_buffer_size =  1 * 1024 * 1024 * 1024;
SET GLOBAL sort_buffer_size = 1 * 1024 * 1024 * 1024;
EXPLAIN ANALYZE SELECT count(DISTINCT ot.PMID),ot.ID FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID;

EXPLAIN ANALYZE SELECT tbl2.ID, count(tbl2.PMID) AS pmid_count
FROM pubtator.bc2pubtator tbl2
  JOIN pubtator.bc2pubtator tbl1 ON tbl2.PMID = tbl1.PMID
WHERE tbl2.TYPE="Gene" AND tbl1.ID="9606" AND tbl1.TYPE="Species"
GROUP BY tbl2.ID
ORDER BY pmid_count DESC;

# with ORDER BY NULL
# EXPLAIN SELECT count(DISTINCT ot.PMID),ot.ID FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID ORDER BY NULL;

# with DISTINCT
# EXPLAIN SELECT count(DISTINCT ot.PMID),ot.ID FROM (SELECT DISTINCT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID;