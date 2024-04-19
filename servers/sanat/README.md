## Prerequisites

### Creating the VM
 - Python 3 (tested on 3.10) and required packages:
```
virtualenv -p python3 .venv
source .venv/bin/activate
pip install -r requirements_dev.txt
```
 - Sourced Pouta openrc file for the CSC project
 - `ansible-galaxy install -r requirements-pouta_creation.yml`


### Setting up the service

 - Ansible (developed on version 2)
 - Ansible-Galaxy (developed on version 2)
  - `ansible-galaxy install -r requirements.yml`)

## Usage

### Creating the VM

```
ansible-playbook -i inventories/pouta create-vm.yml
```

### Setting up the service

 - `ansible-playbook -i inventories/development site.yml`
 - After completed setup, initialize the database and update, eg:
  - gzip -dc mw.sql.gz| mysql -u wikiuser -p  mediawiki
  - /srv/mediawiki/SITE/targets/production/maintenance/run update

## Notes

 - Cloning the MediaWiki code can take a long time, depending on network speed
 - Set Selinux to at least permissive, this script does not yet support it

## Example for bootstrapping an empty wiki database

  - `cd /srv/mediawiki/SITE/workdir`
  - `rm LocalSettings.php`
  - `php maintenance/install.php --pass=... --dbname=sanat --dbuser=wikiuser --dbpass=wikipass MediaWiki WikiSysop`
  - Then run ansible-playbook again
