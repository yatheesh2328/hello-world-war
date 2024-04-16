Modify this pipeline to use the image from docker hub and create an helm and deploy to exiting eks cluster
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
                    sh "docker build -t tomcat-war:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    echo 'Logging into Docker Hub'
                    sh "docker login -u $USERNAME -p $PASSWORD"
                    echo 'Tagging and pushing Docker image'
                    sh "docker tag tomcat-war:${BUILD_NUMBER} yatheesh2328/custom-images:${BUILD_NUMBER}"
                    sh "docker push yatheesh2328/custom-images:${BUILD_NUMBER}"
                }
            }
        }
        stage ('Helm Deploy') {
            steps {
                script {
                    sh "helm upgrade first --install mychart --namespace helm-deployment --set image.tag=$BUILD_NUMBER"
                }
            }
        }
    }
}
