#!/usr/bin/bash
echo hola
yum remove git -y
yum groupinstall "Development Tools" -y
yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel -y
yum install curl-devel -y
tar -zxf git-2.30.0.tar.gz
cd git-2.30.0/
make configure
./configure --prefix=/usr/local
make install
git --version
cd ..
rm git-2.30.0 -rf

