pipeline {
  agent {
    kubernetes {
      label 'app' 
      idleMinutes 5 
      yamlFile 'build-agent.yaml'
      defaultContainer 'maven' 
    }
  }
  environment {
    registry_prefix = "eu.gcr.io/jenkins-004/"
    image_name = "webapp"
  }

    stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/sabady/GKE-CI-CD.git'
      }
    }

    stage('Build Maven') {
      steps {
        //sh 'mvn -B -DskipTests clean package'
        sh 'mvn clean install'
      }
    }

    stage('Test Maven') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Build Docker Image') {
      steps{
        script {
          app = docker.build("jenkins-004/webapp")
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://eu.gcr.io', 'gcr:jenkins-gcr-sa@jenkins-004.iam.gserviceaccount.com') {
            app.push("latest")
          }
        }
      }
    }

    stage('Deploy apps') {
      steps {
        withKubeConfig([credentialsId: '38579427-0849-4338-aba4-2591a583c4aa', serverUrl: 'https://kubernetes.default']){
          sh 'kubectl apply -f webapp.yaml'
          sh 'kubectl apply -f intense.yaml'
          sh 'kubectl autoscale deployment intense --cpu-percent=50 --min=1 --max=10'
          sh 'kubectl expose deployment webapp --type=LoadBalancer --name=webapp'
          sh 'kubectl expose deployment intense --type=LoadBalancer --name=intense'
          sh 'kubectl apply -f ingress.yaml'
        }
      }
    }
  }

}

