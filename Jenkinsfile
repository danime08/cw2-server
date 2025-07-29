pipeline {
    agent any

    environment {
        IMAGE_NAME = "danime08/cw2-server"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/danime08/cw2-server.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Test Docker Container') {
            steps {
                script {
                    sh "docker run -d -p 3000:3000 --name test-container $IMAGE_NAME:$IMAGE_TAG"
                    sh "sleep 5"
                    sh "docker ps | grep test-container"
                    sh "docker stop test-container"
                    sh "docker rm test-container"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push $IMAGE_NAME:$IMAGE_TAG"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh "scp k8s-deploy.yaml ubuntu@<YOUR_PROD_SERVER_IP>:/home/ubuntu/"
                sh "ssh ubuntu@<YOUR_PROD_SERVER_IP> 'kubectl apply -f /home/ubuntu/k8s-deploy.yaml'"
            }
        }
    }
}

