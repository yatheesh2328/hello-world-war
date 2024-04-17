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
        stage('Helm Deploy') {
            steps {
                // Authenticate with AWS using IAM credentials stored in Jenkins
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-credentials',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh "aws eks --region ap-south-1 update-kubeconfig --name my-eks-cluster"
                    echo 'Deploying to Kubernetes using Helm'
                    // Deploy Helm chart to Kubernetes cluster
                    sh "helm upgrade first /var/lib/jenkins/workspace/Assignment/hello-world-war --install --namespace hello-world-war --set image.tag=$BUILD_NUMBER"
                }
            }
        }
    }
}
