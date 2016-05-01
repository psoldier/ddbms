#!/bin/bash
# cargar_dump.sh

# $1 = database
# $2 = hostname
# $3 = host_ip
# $4 = mysql username
# $5 = mysql user password
# $6 = master database name 
# $7 = master host_ip

if echo "create database $1" | ssh $2@$3 mysql -u $4 -p$5; then
  echo "SE CREO LA BASE DE DATOS CORRECTAMENTE"
  if echo "GRANT ALL ON $1.* TO '$4'@'$7' IDENTIFIED BY '$5'" | ssh $2@$3 mysql -u $4 -p$5; then
    echo "SE ASIGNO PERMISOS A LA BASE DE DATOS CORRECTAMENTE"
    if mysqldump -u $4 -p$5 $6 | ssh $2@$3 mysql -u $4 -p$5 $1; then
      echo "SE CARGO LA BASE DE DATOS CORRECTAMENTE"
    else
      echo "OCURRIO UN PROBLEMA CARGANDO LA BASE DE DATOS"
    fi
  else
    echo "OCURRIO UN PROBLEMA ASIGNANDO PERMISOS A LA BASE DE DATOS"
  fi
else
  echo "OCURRIO UN PROBLEMA AL CREAR LA BASE DE DATOS"
fi



