#!/bin/bash
# Script for creating an SVN Server Repository
# and a Trac Environment at <HOME>/server/
#
# It assumes that the folder ~/server exists.
#
# Author: Nikos Vasilakis
# Email: n.c.vasilakis@gmail.com
# Last Update 24|0|10
# TO DO
# * change the script to write on /usr/local/
# * change writting on /etc/apache2/httpd.conf ~/server/ ==> /home/[username]/server
# * output "Give password for user"
# * Output info on how to insert admin panel on Trac and some must-have plugins

echo "Assuming User Name = edutubeplus"
echo "SVN Directory: [/home/edutubeplus]/server/svn"
echo "TRAC Directory: [/home/edutubeplus]/server/trac"

if [ -n "$1" ]; then
#SVN project
  mkdir ~/server/svn
  mkdir ~/server/trac
  sudo mkdir ~/server/svn/$1
  sudo svnadmin create ~/server/svn/$1
  sudo chown -R www-data ~/server/svn/$1
  sudo htpasswd -c /etc/apache2/conf.d/.$1.passwd nvasilakis
  echo '  '#' $1 System Backup ' >> /etc/apache2/httpd.conf
  echo ' ' >> /etc/apache2/httpd.conf
  echo '   <Location /svn/'$1'>' >> /etc/apache2/httpd.conf
  echo '       DAV svn' >> /etc/apache2/httpd.conf
  echo '       SVNPath ~/server/svn/'$1'' >> /etc/apache2/httpd.conf
  echo '       AuthType Basic' >> /etc/apache2/httpd.conf
  echo '       AuthName "'$1' Subversion Repository"' >> /etc/apache2/httpd.conf
  echo '       AuthUserFile /etc/apache2/conf.d/.'$1'.passwd' >> /etc/apache2/httpd.conf
  echo '       Require valid-user' >> /etc/apache2/httpd.conf
  echo '   </Location>' >> /etc/apache2/httpd.conf
# Trac Project  
  mkdir ~/server/trac/$1
  trac-admin ~/server/trac/$1 initenv $1 sqlite:db/trac.db svn ~/server/svn/$1
  sudo chown -Rf www-data:www-data ~/server/trac/$1
  echo ' ' >> /etc/apache2/httpd.conf
  echo '   <Location /projects/'$1'>' >> /etc/apache2/httpd.conf
  echo '       PythonInterpreter main_interpreter' >> /etc/apache2/httpd.conf
  echo '       SetHandler mod_python' >> /etc/apache2/httpd.conf
  echo '       PythonHandler trac.web.modpython_frontend' >> /etc/apache2/httpd.conf
  echo '       PythonOption TracEnv ~/server/trac/'$1'' >> /etc/apache2/httpd.conf
  echo '       PythonOption TracUriRoot /projects/'$1'' >> /etc/apache2/httpd.conf
  echo '       AuthType Basic' >> /etc/apache2/httpd.conf
  echo '       AuthName "System Backup"' >> /etc/apache2/httpd.conf
  echo '       AuthUserFile /etc/apache2/conf.d/.'$1'.passwd' >> /etc/apache2/httpd.conf
  echo '       Require valid-user' >> /etc/apache2/httpd.conf
  echo '   </Location>' >> /etc/apache2/httpd.conf
  echo ' ' >> /etc/apache2/httpd.conf
  sudo apache2ctl restart
else 
  echo "No argument Provided"
  echo "Use continuity [project name]"
fi

exit 0;
