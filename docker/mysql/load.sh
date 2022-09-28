mysql -u root --password=password pubtator < /var/lib/mysql/alter_setting.sql
mysql -u pub --password=pub pubtator --local-infile=1 < /var/lib/mysql/load.sql
mysql -u pub --password=pub pubtator --local-infile=1 < /var/lib/mysql/create_index.sql