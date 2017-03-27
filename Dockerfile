FROM fedora
MAINTAINER "Pedro Romero Aguado" <pedroromeroaguado@gmail.com> 

#installs
RUN dnf install -y openldap openldap-servers openldap-clients
# directoris
RUN mkdir /opt/docker
RUN mkdir /var/tmp/home
RUN mkdir /var/tmp/home/1asix
RUN mkdir /var/tmp/home/2asix
#Copy github to dockerhub build
COPY scripts /scripts/
COPY files /opt/docker

#COPY configs /etc/
#make executable and execute
RUN /usr/bin/chmod +x /scripts/startup-slapd.sh & /scripts/startup-slapd.sh ; exit 0
#RUN /usr/bin/echo "Creating DB edt.org..."
#RUN cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
#RUN rm -rf /etc/openldap/slapd.d/*
#RUN slaptest -u -f /opt/docker/slapd-edt.org.acl.conf -F /etc/openldap/slapd.d
#RUN slapadd -F /etc/openldap/slapd.d -l /opt/docker/organitzacio_edt.org.ldif
#RUN slapadd -F /etc/openldap/slapd.d -l /opt/docker/usuaris-edt.org.ldiff
#RUN chown -R ldap.ldap /etc/openldap/slapd.d/
#RUN chown -R ldap.ldap /var/lib/ldap/
#RUN /usr/sbin/slapd -u ldap -h "ldap:/// ldaps:/// ldapi:///" && echo "ok"
#VOLUME ["/data"] 
ENTRYPOINT ["/bin/bash"] 
EXPOSE 25 143 587 993 4190 8001 8002 9001 389
