pipeline {
    agent { 
        label 'master'
    }
    stages {
        stage('IaC: terraform') {
            steps {
                withAWS(credentials:'aws-credentials') {
                    dir('infra') {
                        sh 'terraform init -reconfigure'
                        sh 'terraform apply --var-file dev.tfvars -auto-approve'
                        sh 'terraform output ec2pubip'
                        sh 'terraform output ec2prvip'
                    }
                }
            }
        }
    }
}
