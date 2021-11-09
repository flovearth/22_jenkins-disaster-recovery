pipeline {
    agent any

    stages {
        stage('Get Jenkinsfile') {
            steps {
                git branch: 'dev', credentialsId: 'devops', url: 'https://bitbucket.finspire.tech/scm/devops/jenkins_backup/'
            }
        }
        stage('Run Script') {
            steps {
                echo 'Synchronizing...'
                // INSTALL AWS CLI if neccessery
                // sh 'curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"'
                // sh 'unzip awscliv2.zip'
                // sh './aws/install'
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding', 
                        accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
                        credentialsId: 'devops-backup'
                    ]]) {
                        sh '''
                            aws s3 sync /var/jenkins_home s3://<Your-S3-bucker-name> --exclude "workspace/*" --delete
                        '''
                    }
                }                
            }
        }
        stage('Notification') {
            steps {
                echo 'Finished....'
            }
        }
    }
}
