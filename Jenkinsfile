pipeline {
    agent any
    stages {
        stage('infra init') {
            steps {
                sh 'cd infra'
                sh 'terraform init'
                sh 'terraform workspace new dev'
                sh 'terraform workspace select dev'
                sh 'terraform apply --var-file dev.tfvars -auto-approve'
            }
        }
    }
}
