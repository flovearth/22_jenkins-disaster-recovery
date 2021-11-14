# How to backup Jenkins data to Another Server with a Jenkins job.
## This pipeline automatically copies Jenkins data to another server. You should install rsync in your server beforehand. You can find the Jenkinsfile in the repo. Do not forget to change credentials-id, your-repo-name, and your folder name in the Jenkinsfile.

Go to Jenkins Dashboard

Select New Item

Enter an item name "Daily backup of Jenkins to another server"

select pipeline > OK

Description: This pipeline sends Jenkins backup data to another server every night regularly.

Build Triggers > click Build periodically > Schedule > enter "H 5 * * *" (this job will run at 5am everyday.)

Pipeline > Pipeline script from SCM > Choose your repo >

Script Path > "Jenkinsfile"

Find Jenkinsfile here

Click Apply
