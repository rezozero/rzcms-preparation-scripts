# RZCMS scripts

## create_site.sh

This script is made for creating automatically a RZCMS website folder structure and MySQL database. It will create a folder and a database named after the same string. 
`create_site.sh` create regular folders for your website contents (configuration, documents and templates), but it will create symlinks for *core* and *vendor* libraries. Then you will be able to update RZCMS with Git, and files will be automatically available for every websites on your server.

* Rename `create_site.default.sh` file to `create_site.sh`
* Edit your own folder configuration and mysql user credentials
* Set `create_site.sh` executable using `chmod +x create_site.sh` 
* Call `./create_site.sh` to launch RZCMS creation wizard. 

## prepare_site.sh

This script will be useful if you only have a FTP access to your production server. It will pack your website files and resolve every RZCMS symlinks into a single *.zip* archive.

* Rename `prepare_site.default.sh` file to `prepare_site.sh`
* Edit your own folder configuration
* Upload the `***_preparation.zip` file onto your production server
* Unzip it with the `unzip_preparation.php` PHP script.
