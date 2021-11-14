# How to backup your Jenkins data to another server with Duplicati?

http://<your_Public_IP>:8200
## On user interface:
- Add backup
- Configure a new backup
- Fill in General backup settings
    - Name
    - Choose encryption
    - Enter passphrase
- Config Backup destination
    - Storage Type : SFTP (SSH)
    - Server and port : <NEW_ENVIRONMENT_IP> : <22>
    - Path on server : /jenkins_backup/
    - Enter username and password for user
    - Test connection
    - The folder /jenkins_backup/ does not exist. Create it now? (click yes when prompted)
        - Expected result:  Connection worked!
- Config source data
    - Choose "jenkins_backup" folder (please refer notes if you want to backup some specific sub-folders or files)
- Config Schedule cycle
- Choose Backup retention
- Save
