pipeline {
  agent any
  stages {
    stage ('checkout') {
      steps {
      sh 'git clone https://github.com/yatheesh2328/hello-world-war.git'
      }
    }
    stage ('build') {
      steps {
        dir(hello-world-war)
        {
          sh 'docker build -t tomcat-war:1.0 .'
        }
}
      stage ('deploy') {
        steps {
          sh 'docker rm -f tomcat-war'
          sh 'docker  run -d -p 8080:8080 --name tomcat-war tomcat-war:1.0'  
  }
}
    }
  }
}
