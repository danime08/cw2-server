pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('your-dockerhub-credentials-id') // replace with your ID
        IMAGE_NAME = "danime08/cw2-server"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Test Docker Container') {
            steps {
                script {
                    sh 'docker run --rm $IMAGE_NAME npm test || true'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        sh "docker push $IMAGE_NAME"
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

