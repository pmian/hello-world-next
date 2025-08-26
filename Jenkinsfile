pipeline {
    agent any

    environment {
        IMAGE_NAME = "hello-world-next"
        VERCEL_TOKEN = credentials('VERCEL_TOKEN')
        VERCEL_PROJECT = "hello-world-next"
        VERCEL_ORG = "your-vercel-org-name"
        DOCKER_PATH = "\"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe\""
        VERCEL_PATH = "\"C:\\Users\\ADMIN\\AppData\\Roaming\\npm\\vercel.cmd\""
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
                    bat "${DOCKER_PATH} build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Test Docker Build') {
            steps {
                script {
                    echo 'Skipping test build; Docker image already contains built Next.js app'
                    // Optional: run container to test if it starts
                    // bat "${DOCKER_PATH} run --rm -d -p 3001:3000 --name ${IMAGE_NAME}-test ${IMAGE_NAME}"
                }
            }
        }

        stage('Deploy to Vercel') {
            steps {
                script {
                    bat "${VERCEL_PATH} --prod --token ${VERCEL_TOKEN} --name ${VERCEL_PROJECT} --yes"
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
