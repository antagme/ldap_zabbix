FROM fedora
MAINTAINER "Pedro Romero Aguado" <pedroromeroaguado@gmail.com> 
COPY scripts /scripts/

#RUN /update.sh && \ 
#	pacman -S --noconfirm postfix mariadb dovecot opendkim opendmarc spamassassin roundcubemail pigeonhole nginx-mainline php-imap php-intl postfixadmin php-fpm #binutils python fakeroot python-setuptools cmake help2man gcc make && \ /scripts/aur_install.sh python-pydns python-pyspf python-postfix-policyd-spf postsrsd && \ #pacman -Rs --noconfirm fakeroot python-setuptools cmake help2man && \ /cleanup.sh 

RUN dnf install -y openldap openldap-servers openldap-clients
# directoris
RUN mkdir /opt/docker
RUN mkdir /var/tmp/home
RUN mkdir /var/tmp/home/1asix
RUN mkdir /var/tmp/home/2asix

COPY files /opt/docker

#COPY configs /etc/

RUN chmod +x /scripts/startup-slapd.sh & /scripts/startup-slapd.sh

#VOLUME ["/data"] 
ENTRYPOINT ["/bin/bash"] 
EXPOSE 25 143 587 993 4190 8001 8002 9001 389
