#UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%statement/%';
#UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%stage/%';
#UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%events_statements_%';
#UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%events_stages_%';

#UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%memory%';

SELECT 'start time', CURRENT_DATE(), CURRENT_TIME();
SET GLOBAL innodb_buffer_pool_size = 8 * 1024 * 1024 * 1024;
SET GLOBAL max_heap_table_size = 8 * 1024 * 1024 * 1024;
SET GLOBAL tmp_table_size = 8 * 1024 * 1024 * 1024;
SET GLOBAL join_buffer_size =  1 * 1024 * 1024 * 1024;
SET GLOBAL sort_buffer_size = 1 * 1024 * 1024 * 1024;
EXPLAIN ANALYZE SELECT count(DISTINCT ot.PMID),ot.ID FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID;
SELECT 'end time', CURRENT_DATE(), CURRENT_TIME();


#SELECT count(DISTINCT ot.PMID)  AS pm_count, ot.ID FROM (SELECT PMID FROM pubtator.bc2pubtator WHERE TYPE="Species" AND ID="9606") as ct, pubtator.bc2pubtator as ot WHERE ot.PMID=ct.PMID AND ot.TYPE="Gene" GROUP BY ID ORDER BY pm_count DESC;
#SELECT tbl2.ID, count(tbl2.PMID) AS pmid_count FROM pubtator.bc2pubtator tbl2 JOIN pubtator.bc2pubtator tbl1 ON tbl2.PMID = tbl1.PMID WHERE tbl2.TYPE="Gene" AND tbl1.ID="9606" AND tbl1.TYPE="Species" GROUP BY tbl2.ID ORDER BY pmid_count DESC;


#SELECT pm2.ID, count(pm2.PMID) AS pm_count FROM pubtator.bc2pubtator pm2 JOIN pubtator.bc2pubtator pm1 ON pm2.PMID = pm1.PMID WHERE pm2.TYPE="Gene" AND pm1.ID="9606" AND pm1.TYPE="Species" GROUP BY pm2.ID ORDER BY pm_count DESC;