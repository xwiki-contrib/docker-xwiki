#!/bin/bash
if [ "$(ls -A /var/lib/mysql)" == "" ]; then
  /usr/bin/mysql_install_db || exit 1;
fi

/etc/init.d/mysql start || exit 1;

if ! mysql -u root -e "show databases" | grep xwiki; then
  mysql -u root -e "create database xwiki default character set utf8 collate utf8_bin"
  mysql -u root -e "grant all privileges on *.* to xwiki@localhost identified by 'xwiki'"
fi

/etc/init.d/xwiki.sh start
bash
