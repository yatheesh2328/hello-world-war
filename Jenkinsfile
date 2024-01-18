pipeline {
  agent {label 'slave3'}
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
    stage ('deploy') {
      steps {
        sh 'scp /home/slave3/workspace/demoP1/target/hello-world-war-1.0.0.war root@172.31.17.229:/opt/apache-tomcat-8.5.98/webapps/'
    }
}
  }
}
