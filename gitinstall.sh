#!/bin/bash
declare -a ARRAY_NAME
declare rc_curl_txt
declare rc_curl
declare folder
declare rc
version=$1

if [ -z ${version} ]; then
echo "*****************************************************************"
echo "Falta agregar como parametro la version del git  ejemplo: 2.30.0  "
echo "*****************************************************************"

exit 1
fi


rm -f /tmp/salida_curl.txt
echo "*************************************************************"
echo "Se descargara de nexus la version de git : " $version
echo "*************************************************************"
echo ""
echo ""
rm gitdownload.tar.gz -rf
rm git-$version -rf

echo " ===>>  http://nexus.bancogalicia.com.ar/repository/alm/git/git-${version}.tar.gz"
curl -vs http://nexus.bancogalicia.com.ar/repository/alm/git/git-${version}.tar.gz --output gitdownload.tar.gz  > /tmp/salida_curl.txt 2>&1

rc_curl_txt=$(cat /tmp/salida_curl.txt | grep HTTP)
ARRAY_NAME=($rc_curl_txt)
rc_curl=${ARRAY_NAME[6]}

if [ $rc_curl -eq 200 ]
 then
   echo "CURL 200 OK"
   rc=0
 else
   echo "**********************************************************************"
   echo "**********************************************************************"
   echo " Error en la descarga de nexus"
   echo " "
   echo " A continuación log del curl:"
   echo ""
   cat /tmp/salida_curl.txt
   echo "**********************************************************************"
   echo "**********************************************************************"
   echo ""
   echo ""
   exit 1
fi


echo ""
echo ""
echo "************************************************************************"
echo "tar -zxf gitdownload.tar.gz"
echo "************************************************************************"
tar -zxf gitdownload.tar.gz

cd git-$version


echo ""
echo ""
echo "************************************************************************"
echo " yum remove git -y"
echo "************************************************************************"
yum remove git -y

echo ""
echo ""
echo "************************************************************************"
echo ' yum groupinstall "Development Tools" -y'
echo "************************************************************************"
yum groupinstall "Development Tools" -y

echo ""
echo ""
echo "************************************************************************"
echo "yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel -y"
echo "************************************************************************"
yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel -y

echo ""
echo ""
echo "************************************************************************"
echo "yum install curl-devel -y"
echo "************************************************************************"
yum install curl-devel -y 
echo ""
echo ""
echo "************************************************************************"
echo " make configure.........."
echo "************************************************************************"
make configure
./configure --prefix=/usr/local

echo ""
echo ""
echo "************************************************************************"
echo " make install."
echo "************************************************************************"
make install
echo ""
echo ""
echo "************************************************************************"
echo " instalacion finalizada"
echo " git version: "
git --version

cd ..
rm gitdownload.tar.gz -rf
rm git-$version -rf



