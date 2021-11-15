# How to build an infrastructure on AWS EC2 to run new Jenkins server with Terraform?


## We will use infrastructure as code to deploy the instance. We decided to utilize Terraform this time. 

Please make sure to add AWS variables to your local machine before running Terraforms scripts.

```
AWS_ACCESS_KEY_ID: <AWS_ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY: <AWS_SECRET_ACCESS_KEY>
AWS_DEFAULT_REGION: ‘eu-west-2’
```
Terraform launches main resources such as VPC, security groups, subnets, EC2, etc.

You will need to configure or create your own files like:

[main.tf](/main.tf)

[network.tf](/network.tf)

[outputs.tf](/output.tf)

[variables.tf](/variables.tf)

[s3-full-policy.json](/s3-full-policy.json)

[ec2-assume-policy.json](/ec2-assume-policy.json)

All files you will need is [here](/05_build-infrastructure-for-jenkins-with-terraform-on-AWS)


when you run terraform with terraform apply command:

- Terraform creates your infrastructure on AWS.
- Then runs [user-data-jenkins.sh](/05_build-infrastructure-for-jenkins-with-terraform-on-AWS/user-data-jenkins.sh) script,
- [This bash scripts](/05_build-infrastructure-for-jenkins-with-terraform-on-AWS/install_docker_and_docker_compose.sh) installs docker and docker-compose,
- Install Letsencrypt, Nginx and Jenkins with [this script](22_jenkins-disaster-recovery/05_build-infrastructure-for-jenkins-with-terraform-on-AWS/jenkins/),
- Installs AWS CLI and restores backup data from S3 to EC2,
- Then starts Jenkins.


On [main.tf](/main.tf) please make sure that your AMI is accurate so that EC2 operating system is desired Ubuntu 20.04. You can decide instance type depending on your workload, for illustration purposes instance type is shown here as t2.micro however probably you will want an instance with a much bigger capacity.

Once Terraform spins the EC2, we will clone the git repo, install Docker, Docker Compose, Jenkins and restore backup data from the s3 bucket using user-data. And finally, Terraform prints the EC2 instance / Jenkins server’s public IP address.

Please copy the IP address and when you paste <ec2 public IP address>:8080 on your internet browser you should see your own Jenkins login page as the Jenkins on EC2 now using restored data from the S3 bucket.

We decided that although this scenario works well, we still need to automate the process further so that the Jenkins recovery time can be minimized.

In fact we restored the Jenkins with just adding a line of script at the end of the script.
