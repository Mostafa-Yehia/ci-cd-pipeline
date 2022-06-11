def ec2pubip
def ec2prvip
def rdshost
def rdsport
def rdsusername
def rdspassword
def redishost
def redisport
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
                            ec2pubip = sh(returnStdout: true, script: "terraform output -raw ec2pubip").trim()
                            ec2prvip = sh(returnStdout: true, script: "terraform output -raw ec2prvip").trim()
                            rdshost = sh(returnStdout: true, script: "terraform output -raw rdshost").trim()
                            rdsport = sh(returnStdout: true, script: "terraform output -raw rdsport").trim()
                            rdsusername = sh(returnStdout: true, script: "terraform output -raw rdsusername").trim()
                            rdspassword = sh(returnStdout: true, script: "terraform output -raw rdspassword").trim()
                            redishost = sh(returnStdout: true, script: "terraform output -raw redishost").trim()
                            redisport = sh(returnStdout: true, script: "terraform output -raw redisport").trim()
                        }
                        sh "echo this is the public ip: ${ec2pubip}"
                        sh "echo this is the private ip: ${ec2prvip}"
                        sh "echo this is the rds host: ${rdshost}"
                        sh "echo this is the rds port: ${rdsport}"
                        sh "echo this is the rds username: ${rdsusername}"
                        sh "echo this is the rds rds password: ${rdspassword}"
                        sh "echo this is the redis host: ${redishost}"
                        sh "echo this is the redis port: ${redisport}"
                    }
                }
            }
        }
    }
}
