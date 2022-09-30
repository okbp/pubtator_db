require 'sparql/client'

def query(query_text)
  @client.query(query_text, **{content_type: 'application/sparql-results+json'}).map {|binding|
    binding.each_with_object({}) {|(name, term), hash|
      hash[name] = term.to_s
    }
  }
end
sparql_client = SPARQL::Client.new("http://localhost:28890/sparql")
query_text = <<~SPARQL
  DEFINE sql:select-option "order"

  prefix ex: <http://example.com/>

  SELECT ?gene_id (count(DISTINCT ?pmid) AS ?count)
  FROM <https://pubmed.ncbi.nlm.nih.gov/pubtator>
  {
    ?pmid ex:has_species "9606" .
    ?pmid ex:has_gene ?gene_id .
  } GROUP BY ?gene_id ORDER BY DESC(?count)
SPARQL

# クエリ実行と時間計測
start_time = Time.now
ret = sparql_client.query(query_text, **{content_type: 'application/sparql-results+json', read_timeout: 3600, keep_alive: 3600}).map {|binding|
  binding.each_with_object({}) {|(name, term), hash|
    hash[name] = term.to_s
  }
}
p ret.size
p "query time: #{Time.now - start_time}s"

File.open("./aggregation_result_by_virtuoso.json", "w") do |out|
  out.puts JSON.pretty_generate(ret)
end
