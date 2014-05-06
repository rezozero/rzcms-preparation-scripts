#!bin/bash
# Ambroise Maupate REZO ZERO

echo "---------------------------------------------\n"
echo "---------- Préparation d'un site  -----------\n"
echo "---- pour son exportation en production  ----\n"
echo "---------------------------------------------\n"

APACHE_ROOT="/var/www/"
CMS_REL_DIR="../RZCMS-folder"

if [ -z "$1" ]; then
	echo "ERREUR, vous devez fournir le nom du dossier à préparer.";
else
	cd $APACHE_ROOT

	PREPARED_FOLDER="$1_preparation"
	
	mkdir $PREPARED_FOLDER
	cd $APACHE_ROOT$PREPARED_FOLDER
	
	pwd
	
	# Copy unique folders
	cp -r ../$1/rz-temp ./
	cp -r ../$1/rz-conf ./
	cp -r ../$1/templates ./
	cp -r ../$1/plugins ./
	cp -r ../$1/cache ./
	cp -r ../$1/fonts ./
	cp -r ../$1/documents ./
	cp -r ../$1/private_documents ./
	
	# Remove administration symlink
	rm -rf ./templates/administration

	# Copy RZCMS files to replace symlinks
	cp -r $CMS_REL_DIR/index.php ./
	cp -r $CMS_REL_DIR/robots.txt ./
	cp -r $CMS_REL_DIR/rz-core ./
	cp -r $CMS_REL_DIR/.htaccess ./
	cp -r $CMS_REL_DIR/vendor ./
	cp -r $CMS_REL_DIR/templates/administration ./templates/

	# Remove image cache
	rm -rf ./rz-core/SLIR/cache
	rm -rf ./cache/rendered
	rm -rf ./cache/request
	
	echo "`ls -la`"
	echo "---- Prepare site DONE --> now zipping----\n\n"

	cd $APACHE_ROOT
	
	zip -r $PREPARED_FOLDER.zip $PREPARED_FOLDER/.htaccess
	zip -r $PREPARED_FOLDER.zip $PREPARED_FOLDER/*

	rm -rf $PREPARED_FOLDER
fi