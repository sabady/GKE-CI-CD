pipeline {

  environment {
    registry = "us.gcr.io/jenkins-03-273806/"
    dockerImage = ""
  }

  agent { label 'kubepod' }

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/sabady/simple-java-maven-app.git'
      }
    }

    stage('Build Maven') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }

    stage('Test Maven') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        }
      }
    }

    //stage('Deploy App') {
      //steps {
        //script {
          //kubernetesDeploy(configs: "simple-java-app.yaml", kubeconfigId: "mykubeconfig")
        //}
      //}
    //}

  }

}

