#!/bin/bash
cd /srv/mediawiki/workdir/maintenance/
php createAndPromote.php --sysop --bot "{{ sms_xml.wiki_username }}" "{{ sms_xml.wiki_password }}"
touch /srv/mediawiki/workdir/maintenance/smsxml_user_added