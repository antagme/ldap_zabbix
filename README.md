# Final Project EDT | LDAP TLS SASL
_StartTLS Ldap Server_ with _GSSAPI AUTH_ and _Zabbix_ Monitoring to _LDAP Monitor DB_

## Overview

With different _Dockers_ construct an infraestructure for work in a real instance. Each _Docker_ have their own work.
Also , when i was preparating my project , i decided to use a most secure auth than the simple one of _LDAP_ , so i decided  to implement _GSSAPI_ , the best one.

## Description of the Project

Partirem de la base que tothom te una base de [LDAP](https://es.wikipedia.org/wiki/OpenLDAP) , teorica o practica.
El que he fet ha sigut crear una infraestructura real amb `dockers` del que podria ser una empresa o una escola.
Tota la comunicacio de dades sensibles entre els dockers es fa mitjançant TLS.

Tenim diversos Dockers , cadascun per una finalitat diferent:

- Docker LDAP
- Docker Kerberos
- Docker Client (Simulating the School)
- Docker LDAP Replica 
- Docker Apache + Mysql + Zabbix

La meva idea es tenir tots els dockers monitoritçats amb un servidor Zabbix central instalat a un docker httpd i agents zabbix a cada docker. En especial en el docker del servidor `LDAP` la meva intencio es fabricar uns scripts per redirigir dades de la `BBDD`
Monitor i aixi veure-ls a la interficie grafica.

### Tecnologies Emprades.

1. Openldap
  1. Object Class used:
      * Per a Gestionar Users.
      * Per a Gestionar Grups.
      * Per a Gestionar Hosts.
  2. AuthTypes Working:
      * SASL GSSAPI(Kerberos Ticket Auth)
      * SASL External(Certificate Auth)
  3. StartTLS Security Transport Layer    
2. Docker 
4. Openssl
5. Supervisord
6. Nslcd
7. Kerberos
8. PAM
9. Zabbix Agentd y Zabbix Server
10. Replica LDAP mitjançant TLS y SASL GSSAPI.

### Per arrencar els dockers
#### Crear Network primer
_Aixo te un motiu, volem que sempre s'arrenquin amb la mateixa Ip per que quan faci DNS LDAP , concideixin les ips._
 ```bash
 # docker network create --subnet 172.18.0.0/16 -d bridge test
 ```
#### Arrencar Docker LDAP! 
 ```bash
 # docker run --net test --ip 172.178.0.2 -h ldap.edt.org --name ldap -it antagme/ldap_supervisor:latest
 ```  
#### Arrencar Docker Kerberos (TGT)  
 ```bash
 # docker run --net test --ip 172.178.0.3 -h kserver.edt.org --name ldap -it antagme/kerberos:latest
 ```
#### Arrencar Docker LDAP REPLICA
 ```bash
 # docker run --net test --ip 172.178.0.4 -h ldaprepl.edt.org --name replica -it antagme/ldap_replica:latest
 ```
#### Nota important.
_Es Molt important seguir l'ordre per rebre correctament les dades del DNS , encara que si falles, nomes hauria que reiniciarse el Daemon NSLCD al docker que falla_

### Under Construction...

- [x] Zabbix Server Working in Ubuntu
- [ ] Put supervisord in all computers
- [ ] Put TLS on nslcd communication.
- [ ] Create a PAM for auth krb5 and/or unix ldap.

 
 ![Alt text](http://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

- |Client Autoritçat per GSSAPI , i per SASL EXTERNAL|
- |Serveis instalats: Slapd , nslcd , nginx|
- |Clients Agafen tickets d'un docker kerberos per auth|
- | LDAP fa de dns als ordinadors de la xarxa |
