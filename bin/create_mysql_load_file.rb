# mongoloadファイルを生成

# TODO 引数化
table_name = "bc2pubtator"
load_file_dir_name = "load_files"
output_dir = File.expand_path("../../data/mysql_data/#{load_file_dir_name}/", __FILE__)
load_file = File.expand_path("../../data/mysql_data/load.sql", __FILE__)
container_dir = "/var/lib/mysql/#{load_file_dir_name}"

out = File.open(load_file, "w")
Dir.glob("#{output_dir}/*.tsv").sort_by {|fn| File.birthtime(fn) }.each do |f|
  file_name = File.basename(f)
  command = "LOAD DATA LOCAL INFILE '#{container_dir}/#{file_name}' INTO TABLE #{table_name};"
  out.puts command
  command = "SELECT '#{file_name}', CURRENT_DATE(), CURRENT_TIME();"
  out.puts command
end
# 最終行のincrement数を取得する
seq_id = 0
last_file = Dir.glob("#{output_dir}/*.tsv").sort_by {|fn| File.birthtime(fn) }.last
File.open(last_file) do |f|
  f.each_line do |line|
    seq_id = line.split("\t").first
  end
end

out.puts  "SELECT 'update auto increment', CURRENT_DATE(), CURRENT_TIME();"
out.puts  "ALTER TABLE #{table_name} AUTO_INCREMENT=#{seq_id.to_i + 1};"
out.flush
out.close