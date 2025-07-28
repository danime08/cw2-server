pipeline {
  agent any

  environment {
    IMAGE_NAME = 'yourdockerhubusername/cw2-server'   // change this to your DockerHub repo/image name
    REGISTRY_CREDENTIALS = 'dockerhub'                 // Jenkins credential ID for DockerHub
  }

  stages {

    stage('Clone') {
      steps {
        git credentialsId: 'github', url: 'https://github.com/danime08/cw2-server.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t $IMAGE_NAME .'
        }
      }
    }

    stage('Test Container Launch') {
      steps {
        script {
          sh 'docker run --rm $IMAGE_NAME echo "Container started successfully"'
        }
      }
    }

    stage('Push to DockerHub') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
            sh 'docker push $IMAGE_NAME'
          }
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        script {
          // Change your-deployment-name and your-container-name to your actual deployment/container names in Kubernetes
          sh 'kubectl set image deployment/your-deployment-name your-container-name=$IMAGE_NAME'
          // Optional: wait for rollout to finish
          sh 'kubectl rollout status deployment/your-deployment-name'
        }
      }
    }
  }
}
