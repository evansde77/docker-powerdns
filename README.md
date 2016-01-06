docker-powerdns
===============

Flexible powerdns container for docker

Forked from (https://github.com/timHerman/docker-powerdns)[timHerman/docker-powerdns] 

Changes made:

 * Bump to debian:stretch to allow v4 of powerdns to be installed 
 * Support enabling the PDNS REST api via environment variables passed to docker run 
 * expose port 8081 
 * add a couple of debugging tools to apt installs
 
