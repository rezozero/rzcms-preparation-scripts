#!bin/bash
# Ambroise Maupate

echo "------------------ ROADIZ CMS -------------------\n"
echo "--- Création d'un nouveau site sur `hostname` ---\n"
echo "-------------------------------------------------\n"

APACHE_ROOT="/var/www/"

RENZO_URL="https://github.com/roadiz/roadiz.git"
RENZO_BRANCH="master"

MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASS="****password****"

GIT=`which git`
COMPOSER=`which composer`

cd $APACHE_ROOT;

echo "1. Entrez le nom du nouveau site et appuyez sur [ENTRER]\nCe nom sera utilisé pour le dossier et l'utilisateur MySQL :";
read destination;

echo "2. Entrez le mot de passe de la base de donnée et appuyez sur [ENTRER]:";
read password;

mkdir -p $destination;
cd $APACHE_ROOT$destination;

$GIT clone -b $RENZO_BRANCH $RENZO_URL ./;
echo "* Téléchargement des sources - OK";

$COMPOSER install;
$COMPOSER dumpautoload -o;
echo "* Téléchargement des dépendances - OK";

cp conf/config.default.json conf/config.json;
echo "* Copie de la configuration par défaut - OK";

MYSQL=`which mysql`;

Q1="CREATE DATABASE IF NOT EXISTS $destination;";
Q2="CREATE USER '$destination'@'$MYSQL_HOST' IDENTIFIED BY '$password';";

Q4="GRANT ALL PRIVILEGES ON \`$destination\`.* TO '$destination'@'$MYSQL_HOST' WITH GRANT OPTION;";

SQL="${Q1}${Q2}${Q4}";


$MYSQL -u$MYSQL_USER -p$MYSQL_PASS -e "$SQL";
echo "* Création de la base de donnée sur `hostname` - OK\n";

	echo "--------------------------------------------------------------------------------\n"
	echo "---- Le nouveau site '$destination' a été créé ainsi que sa base de donnée -----\n"
	echo "---- MySQL Base: '$destination' User: '$destination' Password: '$password' -----\n"
	echo "--------------------------------------------------------------------------------\n"
