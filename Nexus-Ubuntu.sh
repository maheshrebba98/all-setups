sudo apt update -y
sudo apt install vim nano curl wget zip unzip -y
sudo apt install openjdk-8-jdk -y                                            
 java -version
sudo mkdir /app && cd /app
wget https://download.sonatype.com/nexus/3/nexus-3.41.1-01-unix.tar.gz
tar -xzf nexus-3.41.1-01-unix.tar.gz
sudo mv nexus* nexus
sudo useradd nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
ulimit -n 65536
sudo echo "nexus - nofile 65536" > /etc/security/limits.d/nexus.conf  
ulimit -a
sudo echo "run_as_user="nexus"" > /app/nexus/bin/nexus.rc
sudo tee /opt/nexus/bin/nexus.vmoptions > /dev/null << EOL
-Xms1024m
-Xmx1024m
-XX:MaxDirectMemorySize=1024m
-XX:LogFile=./app/sonatype-work/nexus3/log/jvm.log
-XX:-OmitStackTraceInFastThrow
-Djava.net.preferIPv4Stack=true
-Dkaraf.home=.
-Dkaraf.base=.
-Dkaraf.etc=etc/karaf
-Djava.util.logging.config.file=/etc/karaf/java.util.logging.properties
-Dkaraf.data=./app/sonatype-work/nexus3
-Dkaraf.log=./app/sonatype-work/nexus3/log
-Djava.io.tmpdir=./app/sonatype-work/nexus3/tmp
EOL
sudo tee /etc/systemd/system/nexus.service > /dev/null << EOL
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL
chkconfig nexus on
sudo systemctl daemon-reload
sudo systemctl start nexus.service
sudo systemctl enable nexus.service
sudo systemctl status nexus.service

#  tail -f /opt/sonatype-work/nexus3/log/nexus.log
#sudo cat /opt/nexus/sonatype-work/nexus3/admin.password

