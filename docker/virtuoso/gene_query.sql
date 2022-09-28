SPARQL

DEFINE sql:select-option "order"

prefix ex: <http://example.com/>

SELECT ?gene_id (count(DISTINCT ?pmid) AS ?count)
FROM <https://pubmed.ncbi.nlm.nih.gov/pubtator>
{
  ?pmid ex:has_species "9606" .
  ?pmid ex:has_gene ?gene_id .
} GROUP BY ?gene_id ORDER BY DESC(?count)
;