pipeline {
    agent { 
        label 'master'
    }
    stages {
        def ec2pubip
        def ec2prvip
        stage('IaC: terraform') {
            steps {
                withAWS(credentials:'aws-credentials') {
                    dir('infra') {
                        sh 'terraform init -reconfigure'
                        sh 'terraform apply --var-file dev.tfvars -auto-approve'
                        ec2pubip = sh(returnStdout: true, script: "terraform output -raw ec2pubip").trim()
                        ec2rvip = sh(returnStdout: true, script: "terraform output -raw ec2prvip").trim()
                        sh 'echo this is the public ip: ${ec2pubip}'
                        sh 'echo this is the private ip: ${ec2rvip}'
                    }
                }
            }
        }
    }
}
