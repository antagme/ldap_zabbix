#! /bin/bash

/usr/bin/echo "Creating DB edt.org..."
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
rm -rf /etc/openldap/slapd.d/*
slaptest -f /opt/docker/slapd-edt.org.acl.conf -F /etc/openldap/slapd.d
slapadd -F /etc/openldap/slapd.d -l /opt/docker/organitzacio_edt.org.ldif
slapadd -F /etc/openldap/slapd.d -l /opt/docker/usuaris-edt.org.ldiff
chown -R ldap.ldap /etc/openldap/slapd.d/
chown -R ldap.ldap /var/lib/ldap/
/usr/sbin/slapd

