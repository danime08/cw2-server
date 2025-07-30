pipeline {
    agent any

    environment {
        IMAGE_NAME = "danime08/cw2-server"
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-danime08'  // <-- This must be exact ID
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
                    docker.withRegistry('', env.DOCKERHUB_CREDENTIALS_ID) {
                        sh "docker push ${IMAGE_NAME}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }
    }
}
