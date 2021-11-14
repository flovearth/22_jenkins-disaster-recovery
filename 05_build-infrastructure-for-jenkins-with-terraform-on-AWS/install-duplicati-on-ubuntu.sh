#!/bin/bash
#  Follow this procedure to install Mono on your Linux based system.
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install -y mono-devel gtk-sharp2 libappindicator0.1-cil libmono-2.0-1

#  Forum instructions advise installation of the following Debian repository packages:
sudo apt install apt-transport-https nano git-core software-properties-common dirmngr -y

#  Download duplicati
wget https://updates.duplicati.com/beta/duplicati_2.0.6.3-1_all.deb


#  install duplicati
sudo apt install ./duplicati_2.0.6.3-1_all.deb -y

#  Create and edit the file /etc/systemd/system/duplicati.service
sudo cat > /etc/systemd/system/duplicati.service << EOF
[Unit]
Description=Duplicati web-server
After=network.target

[Service]
Nice=19
IOSchedulingClass=idle
EnvironmentFile=-/etc/default/duplicati
ExecStart=/usr/bin/duplicati-server $DAEMON_OPTS
Restart=always

[Install]
WantedBy=multi-user.target
EOF

#  Edit the file /etc/default/duplicati and add DAEMON_OPTS options to your liking: 
sudo cat > /etc/default/duplicati << EOF
# Defaults for duplicati initscript
# sourced by /etc/init.d/duplicati
# installed at /etc/default/duplicati by the maintainer scripts

#
# This is a POSIX shell fragment
#

# Additional options that are passed to the Daemon.
DAEMON_OPTS="--webservice-interface=any --webservice-port=8200 --portable-mode"
EOF

#  Enable, start and check running status of the duplicati service:
sudo systemctl enable duplicati.service
sudo systemctl daemon-reload
sudo systemctl start duplicati.service  
sudo systemctl status duplicati.service