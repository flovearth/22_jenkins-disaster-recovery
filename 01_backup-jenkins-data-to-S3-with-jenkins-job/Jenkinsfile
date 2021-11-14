pipeline {
    agent any

    stages {
        stage('Get Jenkinsfile') {
            steps {
                git branch: 'dev', credentialsId: 'your-credentials-id-on-jenkins', url: 'https://github.com/flovearth/22_jenkins-disaster-recovery.git'
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
                        credentialsId: 'your-credentials-name'
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
