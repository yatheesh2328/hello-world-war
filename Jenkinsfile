pipeline {
  agent {label 'slave1' }
  stages {
    stage ('checkout') {
      steps {
      sh 'git clone https://github.com/yatheesh2328/hello-world-war.git'
      }
    }
    stage ('build') {
      steps {
        sh 'mvn clean install'
  }
}
  }
}
