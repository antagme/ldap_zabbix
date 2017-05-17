#! /bin/bash

/usr/bin/echo "Creating DB edt.org..."
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
rm -rf /etc/openldap/slapd.d/*
slaptest -f /opt/docker/slapd.external.conf -F /etc/openldap/slapd.d &> /dev/null
slapadd -F /etc/openldap/slapd.d -l /opt/docker/full_edt.org.ldif &> /dev/null
chown -R ldap.ldap /etc/openldap/slapd.d/
chown -R ldap.ldap /var/lib/ldap/

