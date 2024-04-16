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
                echo 'Building Docker image'
                dir("hello-world-war") {
                    sh 'docker build -t tomcat-war:${BUILD_NUMBER} .'
                }
            }
        }
    }
}

