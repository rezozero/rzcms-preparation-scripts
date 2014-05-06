<?php 
/**
 * Copyright REZO ZERO 2012
 * 
 * This work is licensed under the Creative Commons Attribution-NoDerivs 2.0 France License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/2.0/fr/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
 * 
 * Unzip a prepared site with RZ CMS on remote FTP server
 *
 * @file unzip_preparation.php
 * @copyright REZO ZERO 2012
 * @author Ambroise Maupate
 */

if (!empty($_GET["f"]) && 
	pathinfo($_GET["f"], PATHINFO_EXTENSION) == "zip") {
	
	// Securize get var	
	$_GET["f"] = str_replace("/", "", htmlentities(strip_tags(urldecode($_GET["f"]))));

	$zip = new ZipArchive;
	if ($zip->open($_GET["f"]) === TRUE) {
	    $zip->extractTo('./');
	    $zip->close();
	    echo 'DONE !';
	} else {
	    echo("ERROR: You must specify a valid ZIP file in the current working directory! Zip file failed to open.");
	}
}
else {
	echo("ERROR: You must specify a valid ZIP file in the current working directory!");
}
