#!/bin/bash
cd /www/smsxml/
python manage.py makemigrations
python manage.py migrate
chown -R apache ./

