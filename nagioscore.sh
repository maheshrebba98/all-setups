#  NAGIOS SERVER
# UPDATE
sudo apt update -y
sudo apt upgrade -y
sudo -i
# PRE-REQUESITES
apt install wget vim unzip curl gcc openssl build-essential libgd-dev libssl-dev libapache2-mod-php php-gd php apache2 -y
#INSTALL NAGIOS CORE:
export VER="4.4.6"
curl -SL https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-$VER/nagios-$VER.tar.gz | tar -xzf -
cd /root/nagios-4.4.6/
#TO COMPILE:
./configure
make all
make install-groups-users
usermod -a -G nagios nagios
make install
make install-init
make install-config
make install-commandmode
make install-webconf
a2enmod rewrite cgi
systemctl restart apache2
make install-exfoliation
make install-classicui
# INSTALL NAGIOS PLUGINS
VER="2.3.3"
#TO GET NAGIOS PLUGINS:
curl -SL https://github.com/nagios-plugins/nagios-plugins/releases/download/release-$VER/nagios-plugins-$VER.tar.gz | tar -xzf -
cd nagios-plugins-2.3.3/
./configure
make install
#Create a nagiosadmin account for logging into the Nagios web interface. Note the password you need it while login to Nagios web console.
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo service apache2 restart
sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
systemctl enable --now nagios
systemctl status nagios
