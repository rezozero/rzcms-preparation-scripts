#!bin/bash
# Ambroise Maupate

echo "---------------- REZO ZERO CMS ------------------\n"
echo "--- Création d'un nouveau site sur `hostname` ---\n"
echo "-------------------------------------------------\n"

APACHE_ROOT="/var/www/"
CMS_REL_DIR="../RZCMS-folder"

MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASS="****password****"


cd $APACHE_ROOT

echo "1. Entrez le nom du nouveau site et appuyez sur [ENTRER]\nCe nom sera utilisé pour le dossier et l'utilisateur MySQL :"
read destination

echo "2. Entrez le mot de passe de la base de donnée et appuyez sur [ENTRER]:"
read password

mkdir $destination
cd $APACHE_ROOT$destination

echo "\n* Création du dossier `pwd` - OK"
# Copy unique folders
cp -r $CMS_REL_DIR/rz-temp ./
cp -r $CMS_REL_DIR/rz-conf ./
cp -r $CMS_REL_DIR/templates ./
cp -r $CMS_REL_DIR/cache ./
cp -r $CMS_REL_DIR/fonts ./
cp -r $CMS_REL_DIR/documents ./
cp -r $CMS_REL_DIR/private_documents ./

echo "* Copie des fichiers spécifiques - OK"

# Create symlinks for common files
ln -s $CMS_REL_DIR/index.php ./
ln -s $CMS_REL_DIR/robots.txt ./
ln -s $CMS_REL_DIR/rz-core ./
ln -s $CMS_REL_DIR/plugins ./
ln -s $CMS_REL_DIR/.htaccess ./
ln -s $CMS_REL_DIR/vendor ./

echo "* Création des liens symboliques - OK"

# Create symlink for admin template
rm -rf ./templates/administration
ln -s ../$CMS_REL_DIR/templates/administration ./templates

echo "* Création du lien symbolique pour le template Administration - OK"

# Downlod default template
GIT=`which git`

cd $APACHE_ROOT$destination/templates
$GIT clone https://github.com/rezozero/rzcms-default-template.git
echo "* Téléchargement du template par défaut depuis Github - OK"

cd $APACHE_ROOT$destination

echo "* Création de la base de donnée sur `hostname` - OK\n"

MYSQL=`which mysql`
 
Q1="CREATE DATABASE IF NOT EXISTS $destination;"
Q2="CREATE USER '$destination'@'$MYSQL_HOST' IDENTIFIED BY '$password';"

Q4="GRANT ALL PRIVILEGES ON \`$destination\`.* TO '$destination'@'$MYSQL_HOST' WITH GRANT OPTION;"

SQL="${Q1}${Q2}${Q4}"
 
$MYSQL -u$MYSQL_USER -p$MYSQL_PASS -e "$SQL"
	
	echo "--------------------------------------------------------------------------------\n"
	echo "---- Le nouveau site '$destination' a été créé ainsi que sa base de donnée -----\n"
	echo "---- MySQL Base: '$destination' User: '$destination' Password: '$password' -----\n"
	echo "--------------------------------------------------------------------------------\n"
