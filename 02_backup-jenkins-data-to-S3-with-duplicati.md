  # How to back up your Jenkins data to AWS S3 with Duplicati
  Duplicati is a backup client that securely stores encrypted, incremental, compressed remote backups of local files on cloud storage services and remote file servers. Duplicati supports not only various online backup services like Azure, Amazon S3, and Google Drive, but also any servers that support SSH/SFTP, WebDAV or FTP. 
To be able to backup your Jenkins data with Duplicati to AWS S3, you need to install Duplicati on your system.
A docker-compose file is added to create a Duplicati container.
If you would like to install yourself on a container use these commands:

```
$ sudo docker pull linuxserver/duplicati
$ sudo docker create --name=duplicati -p 8200:8200 -v ~/duplicati_home:/source -v duplicati-data:/data linuxserver/duplicati
$ sudo docker start duplicati
```

If you want to install Duplicati on an Ubuntu server you can run https://github.com/flovearth/22_jenkins-disaster-recovery/install-duplicati-on-ubuntu.sh file.

When you run Duplicati on http://localhost:8200 
## On user interface:
- Add backup
- Configure a new backup
- Fill in General backup settings
    - Name
    - Choose encryption
    - Enter passphrase
- Config Backup destination
    - Storage Type : S3 compatible
    - Server: Amazon S3 (s3.amazonaws.com)
    - Bucket name: write a unique bucket name
    - Choose Bucket create region, Storage class and Folder path
    - Enter AWS Access ID and AWS Access Key
    - Client library to use: Amazon AWS SDK
    - Test connection
    - The folder <your bucket name> does not exist. Create it now? (click yes when prompted)
        - Expected result:  Connection worked!
- Config source data
    - Choose "jenkins_backup" folder (please refer notes if you want to backup some specific sub-folders or files)
- Config Schedule cycle
- Choose Backup retention
- Save
You can run your job at once or wait for the scheduled time.
