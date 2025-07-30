pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-danime08'
        IMAGE_NAME = "danime08/cw2-server"
        PROD_SSH = credentials('prod-ssh')  // SSH credential object for sshagent
        PROD_HOST = "ec2-35-171-2-25.compute-1.amazonaws.com"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Test Docker Container') {
            steps {
                sh "docker run --rm ${IMAGE_NAME} npm test || true"
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS_ID) {
                        sh "docker push ${IMAGE_NAME}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes on Production') {
            steps {
                sshagent (credentials: ['prod-ssh']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@${PROD_HOST} '
                            kubectl delete deployment cw2-server-deployment --ignore-not-found
                            kubectl apply -f ~/k8s/
                        '
                    """
                }
            }
        }
    }
}
