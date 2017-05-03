# Final Project EDT | LDAP TLS SASL
_Advanced Use of Dockerized Openldap Server and alternatives to secure and improve your Openldap Server_

## Overview

With different _Dockers Containers_ we gonna construct some examples around _LDAP SERVER container_.

## Description of the Project

Let's assume you all have some idea about [LDAP](https://es.wikipedia.org/wiki/OpenLDAP), theorical or practical.

In this project we are going to study different examples based on the _Openldap_ service through docker container.
In particular, I have chosen 4 examples in which we can see technologies that although very different, can be used to improve our ldap server.

## The Examples

### StartTLS LDAP Server With SASL GSSAPI Auth.

In this model, we will perform a _GSSAPI Authentication_ using the Openldap client utilities. For this we will use a total of 3 _Docker Containers_.
All communication between the client and the _LDAP SERVER_ is encrypted using the _TLS_ protocol, using port 389, the default for unencrypted communications, but thanks to _StartTLS_, we can use it for secure communications

_Docker Images_ used for this example:
- [Ldap StartTLS + GSSAPI Keytab](https://hub.docker.com/r/antagme/ldap_gssapi/) 
- [Kerberos](https://hub.docker.com/r/antagme/kerberos/)
- [Client for try some consults to Database](https://hub.docker.com/r/antagme/client_gssapi/)

[Click Here for more information about this model...](https://github.com/antagme/Documentation_Project/blob/master/example1.md)

### StartTLS LDAP Producer Server Replicating without SASL GSSAPI Auth and with it.

In this model, we will see how an _LDAP Server_ works as _Producer_ so that other _LDAP servers_ can replicate and act as Consumer.

We will have the _Consumer_ communicate with the _Producer_ through _simple authentication_.

On the other hand we will make another _Consumer_ do the same but through _SASL GSSAPI authentication_.

Finally we will verify that the **Client** can perform searches in both servers, and we will make modifications in the database of the _Producer_ and we will verify if it is really producing a correct replication.

_Docker Images_ used for this example:
- Ldap StartTLS Producer + GSSAPI Keytab 
- Kerberos
- Client for try some consults to Database
- Ldap StartTLS Consumer with Simple Authentication
- Ldap StartTLS Consumer with SASL GSSAPI Authentication

### Client with PAM + SSSD for Kerberos Auth , LDAP user information and Kerberos Password.

In this model, starting from example one, we will see how to make a more secure authentication in the system using the best of Kerberos and Ldap technologies.

For this example, in the Client we will see how the System-Auth works with these two technologies, and we will perform a series of checks to make sure it works correctly.

_Docker Images_ used for this example:
- Ldap StartTLS + GSSAPI Keytab 
- Kerberos
- Client PAM + ldapwhoami

### Zabbix Monitoring to Monitor Database from Openldap Server.

Finally, in this model, we will see in a Zabbix server how to have monitored by graphs, all the operations that are done in our LDAP Server and all connections to it.

_Docker Images_ used for this example:
- Ldap StartTLS with Crond Python Script
- Kerberos
- Client for do some searchs and see the graphs
- Zabbix with Openldap Custom Template

## Summary

### Summary of the examples

So we have the next _Dockers Images_ , each with differents configurations:

- Docker LDAP
- Docker Kerberos
- Docker Client (Simulating a School Client)
- Docker LDAP Replica 
- Docker Apache + Mysql + Zabbix

**Note** _: Each Docker Container have their own work. Also , when i was preparating my project , i decided to use a most secure auth than the simple one of LDAP , so i decided  to implement GSSAPI , the best one for this environment , but u have another options. See ([Auth Types](http://www.openldap.org/doc/admin24/security.html#Authentication%20Methods)) for more information_

### Summary of Used Technologies.

* Openldap
  * Object Class used:
      * To Retrieve Users.
      * To Retrieve Grups.
      * To Retrieve Hosts.
  * AuthTypes Working:
     * SASL GSSAPI(Kerberos Ticket Auth)
     * SASL External(Certificate Auth)
  * StartTLS Security Transport Layer
  * Replication Consumer LDAP with StartTLS Communication And SASL GSSAPI.
* Docker 
* Openssl ( To create Own Certificates for each service that need it)
* Supervisord 
    * To Manage the Processes inside the _Dockers Containers_ 
* Nslcd 
    * For retrieve Hosts Info 
* Kerberos 
  * For Obtain ticket
  * Do _Kerberos Auth_ with _SSSD_ 
  * _GSSAPI Auth_ with ldap clients.
* PAM
  * For the propertly _System-Auth_ With _Kerberos_ + _LDAP_
* Zabbix Agentd y Zabbix Server
  * For Monitoring each _Docker Container_
  * For Monitoring  _LDAP Monitor Database_ with a _Python Script_.
* Crond
  * For Automated execution of the _Python Script_ for _LDAP Monitor Database_ each minute.

### To Start Docker Containers
#### Create Docker Network 
_This is for a very important reason, we need to always have the same container IP for the proper Ip distribution through LDAP and NSLCD.
In the default Bridge Network , we can't assign ips for containers_

 ```bash
 # docker network create --subnet 172.18.0.0/16 -d bridge test
 ```
#### Run Docker LDAP! 
 ```bash
 # docker run --net test --ip 172.18.0.2 -h ldap.edt.org --name ldap -it antagme/ldap_supervisor:zabbix_pam_tls
 ```  

#### Run Docker Kerberos (TGT)  
 ```bash
 # docker run --net test --ip 172.18.0.3 -h kserver.edt.org --name kerberos -it antagme/kerberos:supervisord
 ```
 
#### Run Docker Client (PAM for Authconfig with LDAP+Kerberos)  
 ```bash
 # docker run --net test --ip 172.18.0.8 -h client.edt.org --name client -it antagme/client:pam_tls
 ```
 
#### Run Docker LDAP REPLICA
 ```bash
 # docker run --net test --ip 172.18.0.4 -h ldaprepl.edt.org --name replica -it antagme/ldap_replica:latest
 ```
 
#### Run Docker Zabbix (Apache + Zabbix Monitoring each Container + Monitoring through Trapper LDAP MONITOR DB)  
 ```bash
 # docker run --net test --ip 172.18.0.10 -h zabbix.edt.org --name zabbix -it antagme/httpd:zabbix
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


## Appendix

- All the entries used in Ldap Database has been created on the M06 Subject in [Escola del Treball](https://www.escoladeltreball.org) School
