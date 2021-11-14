# How to restore your Jenkins data from a server using Duplicati?


You can use [this docker-compose file](/02_backup-jenkins-data-to-S3-with-duplicati/docker-compose-Duplicati.yml) to create a Duplicati container.
When the container created, go to https://<your-host-IP>:8200
On user interface of the Duplicati:
- Restore
- Where do you want to restore from? 
  * Direct restore from backup files ...
- Backup location
  * Storage Type: Local folder or drive
  * Folder path:  <your-jenkins-data-volume>
  * Test connection: you should see : Success - Connection worked!
- Encryption: enter passphrase
- Select files
