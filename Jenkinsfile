def ec2pubip
def ec2prvip
def rdshost
def rdsport
def rdsusername
def rdspassword
def redishost
def redisport
def master_node_ip
pipeline {
    agent { 
        label 'master'
    }
    stages {
        stage('Adding execution permission for .sh files') {
            steps {
                sh "chmod +x *.sh"
            }
        }
        stage('terraform: IaC') {
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
                            master_node_ip = sh(returnStdout: true, script: "curl ipinfo.io/ip").trim()
                        }
                        sh "echo this is the public ip: ${ec2pubip}"
                        sh "echo this is the private ip: ${ec2prvip}"
                        sh "echo this is the rds host: ${rdshost}"
                        sh "echo this is the rds port: ${rdsport}"
                        sh "echo this is the rds username: ${rdsusername}"
                        sh "echo this is the rds rds password: ${rdspassword}"
                        sh "echo this is the redis host: ${redishost}"
                        sh "echo this is the redis port: ${redisport}"
                        sh "echo current master node ip is: ${master_node_ip}"
                    }
                }
            }
        }
        stage('SSH: ssh jump configuration') {
            steps {
                sh "chmod 400 ~/.ssh/private.pem"
                sh "./ssh-jump-config.sh ${ec2pubip} ${ec2prvip}"
                //sh "ansible-playbook ./scripter.yml -e \"data=./ssh-jump-config.sh ${ec2pubip} ${ec2prvip}\""
            }
        }
        stage('Ansible: Configuration Management') {
            steps {
                sh "./ansible-config.sh http://${master_node_ip}:8080/jnlpJars/agent.jar"
                sh 'ansible-playbook -i /var/jenkins_home/ansible/inventory /var/jenkins_home/ansible/bootstrap.yml'
            }
        }
        stage('Jenkins-cli: Automating node creation') {
            steps {
                //automating node creation code step 1: using master_node_ip to download jenkins-cli.jar
                sh "./automatic-node-creation1.sh http://${master_node_ip}:8080/jnlpJars/jenkins-cli.jar"
                sh 'ansible-playbook /var/jenkins_home/ansible/add-node.yml'
                //automating node creation code step 2: running xml script and creating new node
                sh "echo ${cli_name}:${cli_pass}"
                sh "./automatic-node-creation2.sh ${cli_name} ${cli_pass}"
            }
        }
    }
    
    agent {
        label 'private'
    }
    stages {
        stage('Git') {
            steps {
                git branch: 'rds_redis',
                    url: 'https://github.com/Mostafa-Yehia/jenkins_nodejs_example.git'

                sh 'docker build -t mostafaye7ia/nodejs-cicd .'

                withCredentials([usernamePassword(credentialsId: 'docker_credentials', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh "docker login -u ${env.username} -p ${env.password}"
                    sh 'docker push mostafaye7ia/nodejs-cicd'

                    sh "docker run -p 3000:3000 -e RDS_HOSTNAME=${rdshost} -e RDS_USERNAME=${rdsusername} -e RDS_PASSWORD=${rdspassword} -e RDS_PORT=${rdsport} -e REDIS_HOSTNAME=${redishost} -e REDIS_PORT=${redisport} mostafaye7ia/nodejs-cicd"
                }
            }
        }
    }
}
