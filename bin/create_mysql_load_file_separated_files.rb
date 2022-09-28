# mongoloadファイルを生成

# TODO 引数化
load_file_dir_name = "load_table_files"
output_dir = File.expand_path("../../data/mysql_data/#{load_file_dir_name}/", __FILE__)
load_file = File.expand_path("../../data/mysql_data/load_separated_tables.sql", __FILE__)
container_dir = "/var/lib/mysql/#{load_file_dir_name}"

out = File.open(load_file, "w")
Dir.glob("#{output_dir}/*.tsv.sorted").sort_by {|fn| File.birthtime(fn) }.each do |f|
  file_name = File.basename(f)
  table_name = file_name.split(".").fisrt.split("_").first.downcase
  command = "SELECT 'start' '#{file_name}', CURRENT_DATE(), CURRENT_TIME();"
  out.puts command
  command = "LOAD DATA LOCAL INFILE '#{container_dir}/#{file_name}' INTO TABLE #{table_name};"
  out.puts command
  # 最終行のincrement数を取得する
  seq_id = 0
  File.open(f) do |file|
    file.each_line do |line|
      seq_id = line.split("\t").first
    end
  end
  out.puts  "ALTER TABLE #{table_name} AUTO_INCREMENT=#{seq_id.to_i + 1};"
  command = "SELECT 'end' '#{file_name}', CURRENT_DATE(), CURRENT_TIME();"
  out.puts command
end
out.flush
out.close