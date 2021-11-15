# How to run one-click Disaster Recovery Jenkins Server with Github Actions?

Github action creates an environment and runs our script to deploy resources on public cloud. In this occasion github action will use a Linux environment, deploy terraform in the environment, upload our connected repository and run our terraform files. To run all this, github actions require us to script a workflow yaml file. We now must write our script in the local repo and push it to github as [run-terraform.yml file](/09_disaster-recovery-automation-with-github-actions/run-terraform.yml)

Go back to github, select your repo "jenkins-disaster-recovery" and
```
Settings
Chose secrets
New repository secret
```
Enter your AWS environment variables as key value pairs as follows

```
AWS_ACCESS_KEY_ID: <AWS_ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY: <AWS_SECRET_ACCESS_KEY>
AWS_DEFAULT_REGION: 'eu-west-2'
```

Copy all [required terraform files](/08_disaster-recovery-automation-with-bitbucket-pipelines/) to your repo. You can see that the files for Terraform are same as we used in Bitbucket-pipelines.


Please remember that we have written top section of run-terraform.yml file as follows:
```
on:
  push:
    branches:
    - main
…
```

Therefore, on every push to the main branch of jenkins-disaster-recovery repo github actions will automatically run and as per terraform script all listed AWS resources will be deployed and public IP address of the EC2 instance will be displayed on the screen.


Copy ec2 IP address from screen. And on internet browser search bar <ec2 public ip address>:8080, to login to Jenkins console and you should be able to login using credential from existing Jenkins master.
  
