# How to run a Jenkins Disaster Recovery with Bitbucket Pipeline?

We want to be able to restore Jenkins data which is resting on an S3 bucket with a Docker container running on an EC2 instance, and we want to have our Jenkins up and running quickly and with one-click automation.

We have mentioned in our previous article that Jenkins backup data is already resting on an S3 bucket and a Jenkins job synchronizes the data every day.

With one click, the Bitbucket pipeline will activate Terraform script, and Terraform script will automate the disaster recovery process as follows.

Write Terraform script that deploys main resources such as VPC, subnet, EC2, a role for S3, security groups, Amazon Machine Image, internet gateway, CIDR, route table, etc. And we must also have user-data for the EC2 so that once EC2 is started it can automatically clone the Bitbucket repo, change the mode of the docker-compose file, install & enable Docker, install docker-compose, remove the secret file, install Jenkins, install AWS CLI, copy the backup file from S3 bucket and paste it to Jenkins container’s volume, run Jenkins, etc. 

Finally, we will also have EC2 public IP address printed on the screen for convenience and speed to start using Jenkins immediately.

Add Terraform files and [related .sh files](/08_disaster-recovery-automation-with-bitbucket-pipelines/) to your local folder. Remember that each variable or data needs to be changed/maintained depending on your desired configuration and region such as Amazon AMI, eu-west-2, CIDR block, required ports, internet privileges, etc.

Create a bitbucket pipelines YAML file namely [“bitbucket-pipelines.yaml”](/08_disaster-recovery-automation-with-bitbucket-pipelines/bitbucket-pipelines.yaml)

Now we have the material for the pipeline to run our disaster recovery automation therefore we will go to the Bitbucket user interface and select

“Pipelines”

- You should see “Looks like you already have a bitbucket-pipelines.yml file in this repository” displayed

- Select ‘enable pipeline”

- Add variables:
```
AWS_ACCESS_KEY_ID: <AWS_ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY: <AWS_SECRET_ACCESS_KEY>
AWS_DEFAULT_REGION: ‘eu-west-2’
S3_BUCKET: <bucket-name>
```

- Click Run pipeline

These files should be in the Bitbucket repo:

- in Bitbucket private repo (AWS credentials are input as variables)

- [main.tf](/08_disaster-recovery-automation-with-bitbucket-pipelines/main.tf) (bitbucket credentials included as secret)

- [.sh file](/user-data-jenkins.sh) is ec2 starting script called user-data (repo clone-docker install-docker-compose up — restore-script.sh)

Copy EC2 IP address from the screen. 

And on the internet browser search bar <EC2 public IP address>:8080, to login to the Jenkins console and you should be able to login using credentials from the existing Jenkins master.


