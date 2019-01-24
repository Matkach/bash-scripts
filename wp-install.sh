#!/bin/bash
# Skripta za instaliranje WordPress na Ubuntu
#
# Kreiraj nova baza
function create_new_db {
  echo -n "Enter password for the MySQL root account: "
  read -s rootpass
  echo ""
  Q00="CREATE DATABASE $dbname;"
  Q01="USE $dbname;"
  Q02="CREATE USER $dbuser@localhost IDENTIFIED BY '$dbpass';"
  Q03="GRANT ALL PRIVILEGES ON $dbname.* TO $dbuser@localhost;"
  Q04="FLUSH PRIVILEGES;"
  SQL0="${Q00}${Q01}${Q02}${Q03}${Q04}"
  mysql -v -u "root" -p$rootpass -e"$SQL0"
}
# Download na WordPress, modifikacija na  wp-config.php i menuvanje permisii
function install_wp {
  wget http://wordpress.org/latest.tar.gz
  tar xzvf latest.tar.gz
  cp -rf wordpress/** ./
  rm -R wordpress
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/$dbname/g" wp-config.php
  sed -i "s/username_here/$dbuser/g" wp-config.php
  sed -i "s/password_here/$dbpass/g" wp-config.php
  wget -O wp.keys https://api.wordpress.org/secret-key/1.1/salt/
  sed -i '/#@-/r wp.keys' wp-config.php
  sed -i "/#@+/,/#@-/d" wp-config.php
  mkdir wp-content/uploads
  find . -type d -exec chmod 755 {} \;
  find . -type f -exec chmod 644 {} \;
  chown -R :www-data wp-content/uploads
  chown -R $USER: *
  chmod 640 wp-config.php
  rm -f latest.tar.gz
  rm -f wp-install.sh
  rm -f wp.keys
}
# Kreiranje na .htaccess
function generate_htaccess {
  touch .htaccess
  chown :www-data .htaccess
  chmod 644 .htaccess
  bash -c "cat > .htaccess" << _EOF_

<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^wp-admin/includes/ - [F,L]
RewriteRule !^wp-includes/ - [S=3]
RewriteRule ^wp-includes/[^/]+\.php$ - [F,L]
RewriteRule ^wp-includes/js/tinymce/langs/.+\.php - [F,L]
RewriteRule ^wp-includes/theme-compat/ - [F,L]
</IfModule>

<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

<Files wp-config.php>
order allow,deny 
deny from all
</Files>

Options All -Indexes
_EOF_
}
# Kreiranje na robots.txt
function generate_robots {
  touch robots.txt
  bash -c "cat > robots.txt" << _EOF_
# Sitemap: absolute url
User-agent: *
Disallow: /cgi-bin/
Disallow: /wp-admin/
Disallow: /wp-includes/
Disallow: /wp-content/plugins/
Disallow: /wp-content/cache/
Disallow: /wp-content/themes/
Disallow: /trackback/
Disallow: /comments/
Disallow: */trackback/
Disallow: */comments/
Disallow: wp-login.php
Disallow: wp-signup.php
_EOF_
}

##### Prasanja za user
echo "Please insert the information required for the WordPress installation."
echo -n "WordPress database name: "
read dbname
echo -n "WordPress database user: "
read dbuser
echo -n "WordPress database password: "
read -s dbpass
echo ""
echo -n "Install Wordpress? [Y/n] "
read instwp
echo -n "Create a NEW database with entered info? [Y/n] "
read newdb

##### Proces i proverka
if [ "$newdb" = y ] || [ "$newdb" = Y ]
then
  create_new_db
  install_wp
  generate_htaccess
  generate_robots
  download_plugins
else
  if [ "$instwp" = y ] || [ "$instwp" = Y ]
  then
    install_wp
    generate_htaccess
    generate_robots
  fi
fi

echo -n "Now, go to your new WordPress and finish the installation!"
echo ""
