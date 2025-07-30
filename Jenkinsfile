pipeline {
    agent any

    environment {
        // Make sure this ID matches your Jenkins DockerHub credentials ID exactly
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-danime08')
        IMAGE_NAME = "danime08/cw2-server"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Test Docker Container') {
            steps {
                script {
                    // Optional: remove '|| true' to fail pipeline on test errors
                    sh "docker run --rm ${IMAGE_NAME} npm test || true"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Use explicit DockerHub registry URL
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
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
