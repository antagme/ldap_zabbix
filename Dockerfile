FROM fedora
MAINTAINER "Pedro Romero Aguado" <pedroromeroaguado@gmail.com> 

#installs
RUN dnf install -y openldap openldap-servers openldap-clients krb5-server-ldap cyrus-sasl-gssapi cyrus-sasl-ldap 
# directoris
RUN mkdir /opt/docker
RUN mkdir /var/tmp/home
RUN mkdir /var/tmp/home/1asix
RUN mkdir /var/tmp/home/2asix
#Copy github to dockerhub build
COPY scripts /scripts/
COPY files /opt/docker
RUN cp /opt/docker/krb5.keytab /etc/
RUN chmod 600 /etc/krb5.keytab
RUN setfacl -m u:ldap:r /etc/krb5.keytab
RUN setfacl -m u:ldap:r /etc/pki/tls/private/slapd.pem
RUN cp /usr/share/doc/krb5-server-ldap/kerberos.schema /etc/openldap/schema/
#COPY configs /etc/
#make executable and execute
RUN /usr/bin/chmod +x /scripts/startup-slapd.sh & bash /scripts/startup-slapd.sh ; exit 0
#VOLUME ["/data"] 
ENTRYPOINT /usr/sbin/slapd & /bin/bash
EXPOSE 25 143 587 993 4190 8001 8002 9001 389
