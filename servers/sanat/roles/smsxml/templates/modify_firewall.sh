#!/bin/bash
iptables -A INPUT -p tcp -m tcp --dport 8000 -j ACCEPT
iptables -A IN_public_allow -p tcp -m tcp --dport 8000 -m conntrack --ctstate NEW -j ACCEPT
iptables-save
touch /www/smsxml/firewall_configured