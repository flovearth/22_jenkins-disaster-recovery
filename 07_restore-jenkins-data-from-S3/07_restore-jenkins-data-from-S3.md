# How to restore Jenkins data from S3 to our new Ec2 server?
These script lines are added at the end of the script which creates the infrastructure on AWS.

```
#install aws cli
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
unzip awscliv2.zip 
sudo ./aws/install
sudo rm awscliv2.zip 

# Do not forget to change s3 bucket name as it is unique
sudo aws s3 sync s3://<your-bucket-name> /var/lib/docker/volumes/jenkins_jenkins-data/_data/
```

Therefore aws cli is installed and with the "aws s3 sync" command all the data are syncronised with our new Jenkins environment.

Remember that we created a [jenkins pipeline](/01_backup-jenkins-data-to-S3-with-jenkins-job/) which daily copies data to S3.
