# Proyecto Final EDT | LDAP TLS SASL

## En que consisteix el proyecte ?

Partirem de la base que tothom te una base de [LDAP](https://es.wikipedia.org/wiki/OpenLDAP) , teorica o practica.
El que he fet ha sigut crear una infraestructura real amb `dockers` del que podria ser una empresa o una escola.
Tota la comunicacio de dades sensibles entre els dockers es fa mitjançant TLS.

La meva idea es tenir tots els dockers monitoritçats amb un servidor Zabbix central instalat a un docker httpd i agents zabbix a cada docker. En especial en el docker del servidor `LDAP` la meva intencio es fabricar uns scripts per redirigir dades de la `BBDD`
Monitor i aixi veure-ls a la interficie grafica.

### Tecnologies Emprades.

1. Openldap
  1. Amb Object Class:
      * Per a Gestionar Users.
      * Per a Gestionar Grups.
      * Per a fer de DNS.
2. Docker
3. Cyrus-sasl(Per a la auth de GSSAPI)
    - Implementades Autentificacions SASL GSSAPI(Ticket) y SASL External(Certificat).
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
