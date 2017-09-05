#!/data/data/com.termux/files/usr/bin/sh

echo "installing Prequisities \n"
apt update && apt upgrade
apt install autoconf bison clang coreutils curl findutils libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config wget ruby-dev libgrpc-dev termux-tools ncurses-utils ncurses tar

echo "\n"
echo "cloning Metasploit framework\n"
cd $HOME
#wget https://github.com/Auxilus/Auxilus.github.io/blob/master/4.14.21.tar.gz
#tar -xf 4.14.21.tar.gz 
curl -LO https://github.com/rapid7/metasploit-framework/archive/4.16.2.tar.gz
tar -xf 4.16.4.tar.gz
mv metasploit-framework-4.16.4 metasploit-framework
#git clone https://github.com/rapid7/metasploit-framework --depth 1
cd metasploit-framework
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
echo "\n"
echo "Installing bundler"
gem install bundler

echo "\n"
echo "Installing nokogiri\n"
gem install nokogiri -- --use-system-libraries


echo "\n"
echo "Installing grpc"
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

echo "\n"
echo "Installig gems\n"
cd $HOME/metasploit-framework
bundle install -j5


echo "\n"
echo "Performing shebang fix"
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;

echo "\n"
echo "Type ./msfconsole to start metasploit"
cd $HOME/metasploit-framework
