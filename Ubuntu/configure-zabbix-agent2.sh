#!/usr/bin/env bash

# Unikatni hostname ubuntu (Lepší než hostname školní stanice)
UNIQUE_HOSTNAME="ubuntu-$(uuidgen)"
SHORT_HOSTNAME=$(echo $UNIQUE_HOSTNAME | cut -d'-' -f1,2)

# # Konfigurace zabbix_agent2.conf
sudo cp -v /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf-orig
sudo sed -i "s/Hostname=Zabbix server/Hostname=$SHORT_HOSTNAME/g" /etc/zabbix/zabbix_agent2.conf
sudo sed -i 's/Server=127.0.0.1/Server=192.168.1.2/g' /etc/zabbix/zabbix_agent2.conf
sudo sed -i 's/ServerActive=127.0.0.1/ServerActive=192.168.1.2/g' /etc/zabbix/zabbix_agent2.conf
sudo sed -i 's/# Timeout=3/Timeout=30/g' /etc/zabbix/zabbix_agent2.conf
sudo sed -i 's/# HostMetadata=/HostMetadata=SPOS/g' /etc/zabbix/zabbix_agent2.conf
sudo diff -u /etc/zabbix/zabbix_agent2.conf-orig /etc/zabbix/zabbix_agent2.conf

# Restart sluzby zabbix-agent2
sudo systemctl restart zabbix-agent2

# EOF