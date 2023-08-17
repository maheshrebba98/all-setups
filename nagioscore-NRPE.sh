# UPDATE
sudo apt update -y
sudo apt upgrade -y
sudo -i
# INSTALL NRPE PLUGIN
apt install nagios-plugins nagios-nrpe-server -y
systemctl status nagios-nrpe-server
# vim /etc/nagios/nrpe.cfg (Enter Nagios Server Public IP #:61)
  # systemctl restart nagios-nrpe-server
  # /usr/sbin/nrpe -V /etc/nagios/nrpe.cfg -f
