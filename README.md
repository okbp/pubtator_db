# pubtator_db

## データ取得
```
$ wget "https://ftp.ncbi.nlm.nih.gov/pub/lu/PubTatorCentral/bioconcepts2pubtatorcentral.gz"
$ zcat bioconcepts2pubtatorcentral.gz | perl -ne 'BEGIN{$key=0} chomp; @vals = split /\t/; $vals[3] ||= "-"; @labels = split m(\|), $vals[3]; @sources = split m(\|), $vals[4]; for my $_l ( @labels ) { for my $_s ( @sources ) { print join("\t", ($key++, @vals[0..2], $_l, $_s)), "\n"}}' > bioconcepts2pubtatorcentral.tsv
$ mv bioconcepts2pubtatorcentral.tsv data/
$ ruby bin/tsv2json.rb
```
data/jsonに`0NNN.json`といったファイルが出来るはず。
```
[
  {
    "pmid": "3958000",
    "type": "Species",
    "id": "9606",
    "label": "patients",
    "source": "SR4GN"
  }, ...
```
## MongoDB
コンテナ起動。`mongo-express`は必須ではない(統計値取得用)
```
$ cd docker/mongodb
$ docker-compose up -d
```
データ生成。`data/mongodb_data/load_files`にロード用JSONファイルが吐かれる。はず。
```
$ ruby bin/json2mongo.rb
```
ロードスクリプトの生成。`data/mongodb_data/load.sh`に吐かれる。はず。
```
$ ruby bin/create_mongodb_load_file.rb
```
ロードスクリプト。1ファイルずつの進み具合確認のためecho
```
echo 'load start 0001.json'
mongoimport -u pub -p pub --jsonArray --db pubtator --collection bc2pubtator --host=localhost:27017 --file '/data/db/load_files/0001.json'
echo 'load start 0002.json'
mongoimport -u pub -p pub --jsonArray --db pubtator --collection bc2pubtator --host=localhost:27017 --file '/data/db/load_files/0002.json'
....
```
ロード開始。Macだと1h40minぐらい
```
$ docker exec -it mongo_db sh /data/db/load.sh
```
クエリ実行。`aggregation_result.json`に結果が吐かれるといいですね。
```
$ cd ruby
$ bundle install
$ bundle exec ruby mongo_query.rb
```

## Virtuoso

## MySQL(初期版)

## MySQL(テーブル再設計版)

## MySQL(NoJOIN版)