#mysql -u pub --password=pub pubtator --local-infile=1 < /var/lib/mysql/gene_count_query.sql >/var/lib/mysql/gene_count_query.result
mysql -u root --password=password pubtator --local-infile=1 < /var/lib/mysql/gene_count_query.sql >/var/lib/mysql/gene_count_query.result