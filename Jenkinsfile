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
        container('dind') {
          sh "echo Docker build"
          sh "docker build -t $registry_prefix$webapp webapp"
          sh "echo *******"
          sh "echo Docker push"
          sh "docker push $registry_prefix$webapp"
          sh "echo *******"
        }
      }
    }

    stage('Deploy apps') {
      steps{
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

