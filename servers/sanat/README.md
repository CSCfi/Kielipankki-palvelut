## Prerequisites

 - A Centos 7 fresh install (tested on fresh CSC install)
 - Ansible (developed on version 2)
 - Ansible-Galaxy (developed on version 2)
  - `ansible-galaxy install -r requirements.yml`)

## Usage

 - `ansible-playbook -i development site.yml`
 - After completed setup, initialize the database and update, eg:
  - gzip -dc mw.sql.gz| mysql -u wikiuser -p  mediawiki
  - php /srv/mediawiki/targets/production/maintenance/update.php


## Notes

 - "Run composer update" is not very stable, 2-3 reruns should get you further
 - Cloning the wiki can take a long time, depending on network speed
 - Set Selinux to at least permissive, this script does not yet support it
 
