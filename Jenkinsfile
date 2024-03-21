pipeline {
   agent { label 'slave01' }
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
                    withCredentials([usernamePassword(credentialsId: 'd41611e1-03d8-4c24-a4e1-d2b0bc262934', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        sh "docker tag tomcat-war:${BUILD_NUMBER} yatish2823/tomcat-project:${BUILD_NUMBER}"
                        sh "docker push yatish2823/tomcat-project:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Pull & Deploy') {
            parallel {
                stage('Prod') {
                    agent { label 'slave02' }
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: 'd41611e1-03d8-4c24-a4e1-d2b0bc262934', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                                sh "docker login -u $USERNAME -p $PASSWORD"
                                sh "docker pull yatish2823/tomcat-project:${BUILD_NUMBER}"
                                sh 'docker rm -f cont01 || true'
                                sh 'docker run -d -p 8080:8080 --name cont01 yatish2823/tomcat-project:${BUILD_NUMBER}'
                            }
                        }
                    }
                }
                stage('Dev') {
                    agent { label 'slave03' }
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: 'd41611e1-03d8-4c24-a4e1-d2b0bc262934', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                                sh "docker login -u $USERNAME -p $PASSWORD"
                                sh "docker pull yatish2823/tomcat-project:${BUILD_NUMBER}"
                                sh 'docker rm -f cont01 || true'
                                sh 'docker run -d -p 8081:8080 --name cont01 yatish2823/tomcat-project:${BUILD_NUMBER}'
                            }
                        }
                    }
                }
            }
        }
    }
}
