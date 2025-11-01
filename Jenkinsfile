
pipeline {
    agent any
    parameters {
        choice(
            name: 'Action',
            choices: 'apply\ndestroy',
            description: 'Apply or Destroy Instance'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    if (params.Action == 'apply') {
                        git branch: 'main', credentialsId: 'my-keys', url: 'git@github.com:kychiu001/automation.git'

                        dir('StaycationX') {
                            git branch: 'main', credentialsId: 'my-keys', url: 'git@github.com:kychiu001/StaycationX.git'
                        }

                        dir('myReactApp') {
                            git branch: 'main', credentialsId: 'my-keys', url: 'git@github.com:kychiu001/myReactApp.git'
                        }
                    }
                }
            }
        }

        stage('Docker') {
            steps {
                withCredentials([
                    usernamePassword(credentialsId: 'docker-hub-credentials',
                                    usernameVariable: 'DOCKER_USER',
                                    passwordVariable: 'DOCKER_PASSWORD')
                ])

                 {
                    script {
                        if (params.Action == 'apply') {
                            sh 'ansible-playbook ansible/build-docker.yaml'
                        }
                    }
                }
            }
        }

        stage('Terraform') {
            steps {
                script {
                    if (params.Action == 'apply') {
                        sh 'terraform -chdir=terraform init'
                        sh 'terraform -chdir=terraform apply -var="name=prod-ict381" -var="group=web" --auto-approve'
                    }
                    else {
                        sh 'terraform -chdir=terraform destroy -var="name=prod-ict381" -var="group=web" --auto-approve'
                    }
                }
            }
        }

        stage('Ansible') {
            steps {
                script {
                    if (params.Action == 'apply') {
                        sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/prod-application.yaml'
                    }
                }
            }
        }
    }
}
