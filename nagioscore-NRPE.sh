# UPDATE
sudo apt update -y
sudo apt upgrade -y
sudo -i
# INSTALL NRPE PLUGIN
apt install nagios-plugins nagios-nrpe-server -y
systemctl status nagios-nrpe-server
