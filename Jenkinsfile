pipeline {
  agent {label 'slavenode'}
  stages {
    stage ('checkout') {
      steps {
        sh 'rm -rf hello-world-war'
       sh 'git clone https://github.com/yatheesh2328/hello-world-war.git'
      }
    }
    stage ('build') {
      steps {
        sh 'mvn clean install'
  }
}
    stage('deploy') {
      steps {
        sh 'sudo cp /home/slave1/workspace/Pipeline_01/target/hello-world-war-1.0.0.war /opt/apache-tomcat-8.5.98/webapps/'
  }
}
  }
}
