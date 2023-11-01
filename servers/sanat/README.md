## Prerequisites

 - A Centos 7 fresh install (tested on fresh CSC install)
 - Ansible (developed on version 2)
 - Ansible-Galaxy (developed on version 2)
  - `ansible-galaxy install -r requirements.yml`)

## Usage

 - `ansible-playbook -i inventories/development site.yml`
 - After completed setup, initialize the database and update, eg:
  - gzip -dc mw.sql.gz| mysql -u wikiuser -p  mediawiki
  - php /srv/mediawiki/SITE/targets/production/maintenance/update.php

## Notes

 - Cloning the MediaWiki code can take a long time, depending on network speed
 - Set Selinux to at least permissive, this script does not yet support it
 
## Example for bootstrapping an empty wiki database

  - `cd /srv/mediawiki/SITE/workdir`
  - `rm LocalSettings.php`
  - `php maintenance/install.php --pass=... --dbname=sanat --dbuser=wikiuser --dbpass=wikipass MediaWiki WikiSysop`
  - Then run ansible-playbook again
