#mysql -u root --password=password pubtator < alter_setting.sql
mysql -u pub --password=pub pubtator --local-infile=1 < /var/lib/mysql/load.sql >  /var/lib/mysql/load.log