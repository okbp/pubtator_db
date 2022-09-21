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
load_file_dir_name = "load_files"
output_dir = File.expand_path("../../data/mysql_data/#{load_file_dir_name}/", __FILE__)
FileUtils.mkdir_p(output_dir) unless File.exist?(output_dir)

seq = 1;
Dir.glob("#{input_dir}/*.json").sort_by{|fn| File.birthtime(fn) }.each do |f|
  output_file = "#{output_dir}/#{File.basename(f).sub('.json', '.tsv')}"
  next if File.exist?(output_file)
  data_list = JSON.parse(File.read(f))
  pubmed_hash = data_list.group_by{|row| row["pmid"]} # PubMedID毎にグループ化

  out = File.open(output_file, "w")
  pubmed_hash.each do |pmid, list|
    pminfo = {}
    list.each do |row|
      pminfo[row["type"]] = [] if pminfo[row["type"]].nil?
      pminfo[row["type"]].push({id: row["id"]})
    end
    pminfo.each do |key, value|
      unless key.to_s == "pmid"
        value.uniq! #重複IDを削除(一つのPubMedに何度も9606が付いているようなケース)
      end
    end
    pminfo.each do |type, id_list|
      id_list.each do |id|
        out.puts [seq, pmid, type, id[:id]].join("\t")
        seq += 1
      end
    end
  end
  out.flush
  out.close
end