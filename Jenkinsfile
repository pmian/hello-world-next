pipeline {
    agent any

    environment {
        IMAGE_NAME = "hello-world-next"
        VERCEL_TOKEN = credentials('VERCEL_TOKEN')
        VERCEL_PROJECT = "hello-world-next"
        VERCEL_ORG = "your-vercel-org-name"
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

        stage('Test Docker Build') {
            steps {
                script {
                    echo 'Skipping test build; Docker image already contains built Next.js app'
                    // Optional: run container to test if it starts
                    // bat "docker run --rm -d -p 3001:3000 --name ${IMAGE_NAME}-test ${IMAGE_NAME}"
                }
            }
        }

        stage('Deploy to Vercel') {
            steps {
                script {
                    bat "vercel --prod --token ${VERCEL_TOKEN} --confirm src"
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
