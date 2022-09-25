#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
echo $SCRIPT_DIR

mv ${SCRIPT_DIR}/data/mysql_data/*.dmp  ${SCRIPT_DIR}/data/
mv ${SCRIPT_DIR}/data/mysql_data/*.sh  ${SCRIPT_DIR}/data/
mv ${SCRIPT_DIR}/data/mysql_data/*.result  ${SCRIPT_DIR}/data/
mv ${SCRIPT_DIR}/data/mysql_data/*.sql  ${SCRIPT_DIR}/data/
mv ${SCRIPT_DIR}/data/mysql_data/load_files/  ${SCRIPT_DIR}/data/

cd ${SCRIPT_DIR}/docker/mysql && docker-compose down
sleep 10

# clear db data
rm -rf  ${SCRIPT_DIR}/data/mysql_data/

cd ${SCRIPT_DIR}/docker/mysql && docker-compose up -d
sleep 20

mv ${SCRIPT_DIR}/data/*.sh  ${SCRIPT_DIR}/data/mysql_data/
mv ${SCRIPT_DIR}/data/*.sql  ${SCRIPT_DIR}/data/mysql_data/
mv ${SCRIPT_DIR}/data/load_files/  ${SCRIPT_DIR}/data/mysql_data/
mv ${SCRIPT_DIR}/data/*.result  ${SCRIPT_DIR}/data/mysql_data/