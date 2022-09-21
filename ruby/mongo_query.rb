require 'mongo'
require 'json'

client = Mongo::Client.new([ '127.0.0.1:27017' ], database: 'pubtator', user: 'pub', password: 'pub')

collection = client['bc2pubtator']

=begin
ret = coll.find( { pmid: '3958000' } )
ret.each do |doc|
  p doc.keys
  p doc["species"]
end
=end

start_time = Time.now
aggregation = collection.aggregate(
  [
    { '$match'=> { 'Species.id'=> '9606' } },
    { '$unwind'=> '$Gene' },
    { '$group'=> { '_id'=> '$Gene.id', 'count'=> { '$sum'=> 1 } } },
    { '$sort'=> { 'count': -1 } }
  ],
    {allow_disk_use: true}
)
# 'allowDiskUse'ではないことに注意!

p "クエリ時間 #{Time.now - start_time}s"
start_time = Time.now

result_list = []
aggregation.each do |doc|
  result_list.push(doc)
end
p "格納時間 #{Time.now - start_time}s"
File.open("./aggregation_result.json", "w") do |out|
  out.puts JSON.pretty_generate(result_list)
end