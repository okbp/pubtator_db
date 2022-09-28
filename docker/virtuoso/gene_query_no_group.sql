SPARQL
prefix ex: <http://example.com/>

SELECT DISTINCT ?gene_id ?pmid
FROM <https://pubmed.ncbi.nlm.nih.gov/pubtator>
{
  ?pmid ex:has_species "9606" .
  ?pmid ex:has_gene ?gene_id .
}
;