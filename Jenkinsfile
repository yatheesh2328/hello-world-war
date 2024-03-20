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
          withDockerRegistry(credentialsId: 'dockerhub-yatish2823', url: 'https://hub.docker.com') {
            sh "docker push tomcat-war:${BUILD_NUMBER}"
          }
        }
      }
    }
  }
}
