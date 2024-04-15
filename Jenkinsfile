pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                sh 'rm -rf hello-world-war'
                sh 'git clone https://github.com/yatheesh2328/hello-world-war.git'
            }
        }
        stage('Build') {
            steps {
                sh 'echo "inside build"'
                dir("hello-world-war") {
                    sh 'echo "inside dir"'
                    sh "docker build -t tomcat-war:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    // Use withCredentials block for Docker Hub login
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        // Login to Docker Hub
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        // Tag the built Docker image
                        sh "docker tag tomcat-war:${BUILD_NUMBER} yatish2823/tomcat-project:${BUILD_NUMBER}"
                        // Push the Docker image to Docker Hub
                        sh "docker push yatish2823/tomcat-project:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
