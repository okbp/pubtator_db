SELECT 'start ID index on disease', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX ID_IDX on disease(PMID);
SELECT 'fin ID index on disease', CURRENT_DATE(), CURRENT_TIME();
SELECT 'start PMID index on disease', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX PMID_IDX on disease(PMID);
SELECT 'fin PMID index on disease', CURRENT_DATE(), CURRENT_TIME();

SELECT 'start ID index on chemical', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX ID_IDX on chemical(PMID);
SELECT 'fin ID index on chemical', CURRENT_DATE(), CURRENT_TIME();
SELECT 'start PMID index on chemical', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX PMID_IDX on chemical(PMID);
SELECT 'fin PMID index on chemical', CURRENT_DATE(), CURRENT_TIME();

SELECT 'start ID index on gene', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX ID_IDX on gene(PMID);
SELECT 'fin ID index on gene', CURRENT_DATE(), CURRENT_TIME();
SELECT 'start PMID index on gene', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX PMID_IDX on gene(PMID);
SELECT 'fin PMID index on gene', CURRENT_DATE(), CURRENT_TIME();

SELECT 'start ID index on species', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX ID_IDX on species(PMID);
SELECT 'fin ID index on species', CURRENT_DATE(), CURRENT_TIME();
SELECT 'start PMID index on species', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX PMID_IDX on species(PMID);
SELECT 'fin PMID index on species', CURRENT_DATE(), CURRENT_TIME();

SELECT 'start ID index on mutation', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX ID_IDX on mutation(PMID);
SELECT 'fin ID index on mutation', CURRENT_DATE(), CURRENT_TIME();
SELECT 'start PMID index on mutation', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX PMID_IDX on mutation(PMID);
SELECT 'fin PMID index on mutation', CURRENT_DATE(), CURRENT_TIME();

SELECT 'start ID index on cellline', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX ID_IDX on cellline(PMID);
SELECT 'fin ID index on cellline', CURRENT_DATE(), CURRENT_TIME();
SELECT 'start PMID index on cellline', CURRENT_DATE(), CURRENT_TIME();
CREATE INDEX PMID_IDX on cellline(PMID);
SELECT 'fin PMID index on cellline', CURRENT_DATE(), CURRENT_TIME();