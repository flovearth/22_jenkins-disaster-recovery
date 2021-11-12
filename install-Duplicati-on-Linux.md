# Installing Duplicati on a Linux Server
Follow this procedure to install Mono on your Linux based system.
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
    sudo apt update
    sudo apt install -y mono-devel gtk-sharp2 libappindicator0.1-cil libmono-2.0-1

Maybe optional: Forum instructions advise installation of the following Debian repository packages:
sudo apt install apt-transport-https nano git-core software-properties-common dirmngr -y

Duplicati can be downloaded from https://www.duplicati.com/download
wget https://updates.duplicati.com/beta/duplicati_2.0.6.3-1_all.deb

sudo apt install ./duplicati_2.0.6.3-1_all.deb -y

Create and edit the file /etc/systemd/system/duplicati.service

sudo vim /etc/systemd/system/duplicati.service

Should look like this:
```
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
```

Edit the file /etc/default/duplicati and add DAEMON_OPTS options to your liking: 
sudo vim /etc/default/duplicati
```
# Defaults for duplicati initscript
# sourced by /etc/init.d/duplicati
# installed at /etc/default/duplicati by the maintainer scripts

#
# This is a POSIX shell fragment
#

# Additional options that are passed to the Daemon.
DAEMON_OPTS="--webservice-interface=any --webservice-port=8200 --portable-mode"


Enable, start and check running status of the duplicati service:
sudo systemctl enable duplicati.service
sudo systemctl daemon-reload
sudo systemctl start duplicati.service  
sudo systemctl status duplicati.service
```

Linux and Mac OS X users should type mono Duplicati.CommandLine.exe or duplicati-cli, which is a wrapper for running mono Duplicati.CommandLine.exe.

The Commandline tool supports these commands:
backup, find, restore, delete, compact, test, compare, purge, vacuum, repair, affected, list-broken-files, purge-broken-files

duplicati-cli <command> [storage-URL] [arguments] [advanced-options] --advanced-option=value

duplicati-cli backup <storage-URL> "<source-path>" [<options>]

duplicati-cli restore <storage-URL> ["<filename>"] [<options>]
--overwrite=<boolean>
Overwrites existing files.
--restore-path=<string>
Restores files to instead of their original destination. Top folders are removed if possible.
--time=<time>
Restore files that are older than the specified time.
--version=<int>
Restore files from a specific backup.

test <storage-URL> <samples> [<options>]

duplicati-cli  compare <storage-URL> [<base-version>] [<compare-to>] [<options>]

duplicati-cli  find <storage-URL> ["<filename>"] [<options>]

The DELETE command¶
Marks old data deleted and removes outdated dlist files. A backup is deleted when it is older than <keep-time> or when there are more newer versions than <keep-versions>. Data is considered old, when it is not required from any existing backup anymore. Usage:

duplicati-cli  delete <storage-URL> [<options>]