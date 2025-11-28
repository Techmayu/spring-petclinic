pipeline {
    agent any
    
    tools {
        maven 'Maven'   // Must match the name you gave in Global Tool Configuration
    }

    environment {
        IMAGE_NAME = "techmayu/spring-example"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Techmayu/spring-petclinic.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh "docker push $IMAGE_NAME"
            }
        }

        stage('Deploy Container') {
            steps {
                sh "docker stop spring-app || true"
                sh "docker rm spring-app || true"
                sh "docker run -d -p 8080:8080 --name spring-app $IMAGE_NAME"
            }
        }

    }
}
