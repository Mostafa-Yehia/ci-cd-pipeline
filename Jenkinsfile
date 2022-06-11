def ec2pubip
def ec2prvip
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
                        script {
                            ec2pubip = sh(returnStdout: true, script: "terraform output -raw ec2pubip")
                            ec2prvip = sh(returnStdout: true, script: "terraform output -raw ec2prvip").trim()
                        }
                        sh 'echo this is the public ip: ${ec2pubip}'
                        sh 'echo this is the private ip: ${ec2prvip}'
                    }
                }
            }
        }
    }
}
