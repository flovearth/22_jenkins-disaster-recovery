# How to backup Jenkins data to AWS S3 with a Jenkins job.
## This pipeline automatically copies Jenkins data to your AWS S3 bucket. You should add your AWS credentials to Jenkins beforehand. You can find the Jenkinsfile in the repo. 

Go to Jenkins Dashboard

New Item

Enter an item name "Daily backup of Jenkins to AWS S3"

select pipeline > OK

Description: This pipeline sends Jenkins backup data to AWS S3 every night regularly.

Build Triggers > click Build periodically > Schedule > enter "H 4 * * *" 
(this job will run at 4am everyday.)

Pipeline > Pipeline scriopt from SCM > Chooose your repo > 

Script Path > "Jenkinsfile"

Apply


