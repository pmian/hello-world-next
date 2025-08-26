pipeline {
    agent any

    environment {
        IMAGE_NAME = "hello-world-next"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/pmian/hello-world-next.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    bat "docker rm -f ${IMAGE_NAME} || exit 0"
                    bat "docker run -d -p 3000:3000 --name ${IMAGE_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
