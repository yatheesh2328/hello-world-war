pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'yatish2823/custom-images' // Docker Hub image repository
        HELM_RELEASE_NAME = 'myapp'
        NAMESPACE = 'helm-deployment'
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'rm -rf hello-world-war'
                sh 'git clone https://github.com/yatheesh2328/hello-world-war.git'
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        echo 'Logging into Docker Hub'
                        sh "docker login -u $USERNAME -p $PASSWORD"
                        echo 'Tagging and pushing Docker image'
                        sh "docker tag tomcat-war:${BUILD_NUMBER} $DOCKER_IMAGE:${BUILD_NUMBER}"
                        sh "docker push $DOCKER_IMAGE:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage ('Helm Deploy') {
            steps {
                script {
                    sh "helm upgrade $HELM_RELEASE_NAME --install mychart --namespace $NAMESPACE --set image.repository=$DOCKER_IMAGE,image.tag=$BUILD_NUMBER"
                }
            }
        }
    }
}
