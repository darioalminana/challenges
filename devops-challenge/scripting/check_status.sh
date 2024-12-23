#!/bin/bash

ssh chango@dario.alminana.com.ar "systemctl status apache2" > /tmp/apache_status
cat /tmp/apache_status |grep "Active: active" >/dev/null 2>&1

if [[ `echo $?` == '1' ]]
then
  echo "El servicio Apache esta caido"
  cat /tmp/apache_status
else
   echo "El servicio Apache esta arriba"
fi

#colppy/challenge-devops-challenge/script$ ./check_status.sh 
#El servicio Apache esta arriba
#colppy/challenge-devops-challenge/script$ ./check_status.sh 
#El servicio Apache esta caido
#● apache2.service - The Apache HTTP Server
#     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
#     Active: inactive (dead) since Tue 2024-12-17 02:47:26 UTC; 9s ago
#       Docs: https://httpd.apache.org/docs/2.4/
#    Process: 1031800 ExecStart=/usr/sbin/apachectl start (code=exited, status=0/SUCCESS)
#    Process: 1032188 ExecStop=/usr/sbin/apachectl stop (code=exited, status=0/SUCCESS)
#   Main PID: 1031814 (code=exited, status=0/SUCCESS)