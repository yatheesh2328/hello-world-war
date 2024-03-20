pipeline {
    agent { label 'slave1' }
    stages {
        stage('checkout') {
            steps {
                sh 'rm -rf hello-world-war'
                sh 'git clone https://github.com/yatheesh2328/hello-world-war.git'
            }
        }
        stage('build') {
            steps {
                sh 'echo "inside build"'
                dir("hello-world-war") {
                    sh 'echo "inside dir"'
                    sh "docker build -t tomcat-war:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Docker_push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'd78a9014-fc35-4ef4-90a5-4f45c19d5f65', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        sh "docker push tomcat-war:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
