#!/data/data/com.termux/files/usr/bin/bash

apt update
apt install -y autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev \
    postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config \
    postgresql-contrib wget make ruby-dev libgrpc-dev termux-tools ncurses-utils ncurses unzip zip tar postgresql

cd $HOME
curl -LO https://github.com/rapid7/metasploit-framework/archive/4.16.4.tar.gz
tar -xf $HOME/4.16.4.tar.gz
mv $HOME/metasploit-framework-4.16.4 $HOME/metasploit-framework
cd $HOME/metasploit-framework
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
gem install bundler


gem install nokogiri -- --use-system-libraries
 
sed 's|grpc (.*|grpc (1.4.1)|g' -i $HOME/metasploit-framework/Gemfile.lock
gem unpack grpc -v 1.4.1
cd grpc-1.4.1
curl -LO https://raw.githubusercontent.com/grpc/grpc/v1.4.1/grpc.gemspec
curl -L https://wiki.termux.com/images/b/bf/Grpc_extconf.patch -o extconf.patch
patch -p1 < extconf.patch
gem build grpc.gemspec
gem install grpc-1.4.1.gem
cd ..
rm -r grpc-1.4.1


cd $HOME/metasploit-framework
bundle install -j5

echo -e "\e[1;34m[+] Gems installed"
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
ln -s $HOME/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/

echo -e "\e[1;32m[.] Creating database"

cd $HOME/metasploit-framework/config
curl -LO https://Auxilus.github.io/database.yml

mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql

pg_ctl -D $PREFIX/var/lib/postgresql start
createuser msf
createdb msf_database
