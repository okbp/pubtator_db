require 'json'
require 'fileutils'

def quote(str)
  return str.to_s.gsub(/(\\|\t|\n|\r|")/, '\\' => '\\\\', "\t" => '\\t', "\n" => '\\n', "\r" => '\\r', '"' => '\\"').inspect
end

input_dir = File.expand_path("../../data/json/", __FILE__)
load_file_dir_name = "load_files"
output_dir = File.expand_path("../../data/virtuoso_data/#{load_file_dir_name}/", __FILE__)
FileUtils.mkdir_p(output_dir) unless File.exist?(output_dir)

Dir.glob("#{input_dir}/*.json").sort_by{|fn| File.birthtime(fn) }.each do |f|
  output_file = "#{output_dir}/#{File.basename(f).sub(".json", ".ttl")}"
  next if File.exist?(output_file)

  out = File.open(output_file, "w")
  out.puts "@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> ."
  out.puts "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> ."
  out.puts "@prefix pubmed: <http://www.w3.org/2000/01/rdf-schema#> ."
  out.puts "@prefix ex: <http://example.com/> ."
  out.puts ""

  data_list = JSON.parse(File.read(f))
  pubmed_hash = data_list.group_by{|row| row["pmid"]} # PubMedID毎にグループ化
  pubmed_hash.each do |pmid, id_list|
    pm_uri = "https://pubmed.ncbi.nlm.nih.gov/#{pmid}"
    out.puts "pubmed:#{pmid} a ex:PubMedID ."
    hash = {}
    id_list.each_with_index do |row, idx|
      if hash[row["type"]].nil? || !(hash[row["type"]].include?(row["id"])) # 重複IDは登録しない
        out.puts "pubmed:#{pmid} ex:has_#{row["type"].downcase} #{quote(row['id'])} ."
        if hash[row["type"]].nil?
          hash[row["type"]] = [row["id"]]
        else
          hash[row["type"]].push(row["id"])
        end
      end
    end
  end
  out.flush
  out.close
end