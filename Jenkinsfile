pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                cleanWs() // Clean workspace before checking out
                git 'https://github.com/yatheesh2328/hello-world-war.git'
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
    ]
//         stage('Docker Push') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
//                     echo 'Logging into Docker Hub'
//                     sh "docker login -u $USERNAME -p $PASSWORD"
//                     echo 'Tagging and pushing Docker image'
//                     sh "docker tag tomcat-war:${BUILD_NUMBER} yatish2823/tomcat-project:${BUILD_NUMBER}"
//                     sh "docker push yatish2823/tomcat-project:${BUILD_NUMBER}"
//                 }
//             }
//         }
//     }
// }
