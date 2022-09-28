require 'json'
require 'fileutils'

# JSONファイルから mongodbロード用のJSONファイルに変換
# type別の配列データを持つ構造に変換
# 配列は{id: xxxx}とハッシュの列挙
#
# 変換前
# [
#  {
#    "pmid": "3958000",
#    "type": "Species",
#    "id": "9606",
#    "label": "patients",
#    "source": "SR4GN"
#  },
#  {
#    "pmid": "3958000",
#    "type": "Disease",
#    "id": "MESH:D012544",
#    "label": "Scheuermann's kyphosis",
#    "source": "TaggerOne"
#  },
#  {
#    "pmid": "3958000",
#    "type": "Disease",
#    "id": "MESH:D007738",
#    "label": "kyphosis",
#    "source": "TaggerOne"
#  },...
#
# 変換後
#

#
input_dir = File.expand_path("../../data/json/", __FILE__)
load_file_dir_name = "load_table_files"
output_dir = File.expand_path("../../data/mysql_data/#{load_file_dir_name}/", __FILE__)
FileUtils.mkdir_p(output_dir) unless File.exist?(output_dir)

pm_file =  File.open("#{output_dir}/pmid_list.tsv", "w")    
output_files = {
  "Disease" => File.open("#{output_dir}/disease_list.tsv", "w"),
  "Chemical" => File.open("#{output_dir}/chemical_list.tsv", "w"),
  "Gene" => File.open("#{output_dir}/gene_list.tsv", "w"),
  "Species" => File.open("#{output_dir}/species_list.tsv", "w"),
  "Mutation" => File.open("#{output_dir}/mutation_list.tsv", "w"),
  "CellLine" => File.open("#{output_dir}/cellline_list.tsv", "w")
}
Dir.glob("#{input_dir}/*.json").sort_by{|fn| File.birthtime(fn) }.each do |f|
  p f 
  data_list = JSON.parse(File.read(f))
  current_pmid = ""

  pubmed_hash = data_list.group_by{|row| row["pmid"]} # PubMedID毎にグループ化
  pubmed_hash.each do |pmid, list|
    unless current_pmid == pmid
      pm_file.puts pmid
      current_pmid = pmid
    end
    pminfo = {}
    list.map{|row| {type: row["type"], id: row["id"]}}.uniq.each do |row|
      output_files[row[:type]].puts "#{pmid}\t#{row[:id]}" 
    end
  end
end
output_files.each do |k, v|
  v.flush
  v.close
end

# ID, PMID順にsortしたファイル(+連番付き)ファイルを生成する
Dir.glob("#{output_dir}/*.tsv").each do |f|
  sorted_file = f.sub(".tsv", ".tsv.sorted")
  if f.include?("pmid_list.tsv")
    p "sort #{f} > #{sorted_file}"
    p Time.now
    system("sort #{f} > #{sorted_file}")
    
  else
    p "sort -k 2,2 -k1,1 #{f} | nl -n ln > #{sorted_file}"
    p Time.now
    system("sort -k 2,2 -k1,1 #{f} | nl -n ln > #{sorted_file}")
  end
end