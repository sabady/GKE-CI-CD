pipeline {
  agent {
    kubernetes {
      label 'app' 
      idleMinutes 5 
      yamlFile 'build-agent.yaml'
      defaultContainer 'maven' 
    }
  }
  stages {
    stage('Checkout Source') {
      steps {
        git 'https://github.com/sabady/GKE-CI-CD.git'
      }
    }

    stage('Build Maven') {
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Test Maven') {
      steps {
        sh 'mvn test'
      }
    }

    stage('Run Maven') {
      steps {
        sh 'cp /home/jenkins/agent/workspace/Qwilt-pipeline/target/my-app-1.0-SNAPSHOT.jar ./webapp.jar'
        sh 'java -jar ./webapp.jar'
      }
    }

    //stage('Build Docker Image') {
      //steps{
        //container('dind') {
          //script {
            //docker.build "eu.gcr.io/jenkins-004/webapp"
          //}
        //}
      //}
    //}

    //stage('Push Docker Image') {
     // steps {
      //  container('dind') {
     //     script {
      //      docker.withRegistry('https://gcr.io', 'gcr:jenkins-gcr-sa@jenkins-004.iam.gserviceaccount.com') {
     //         dockerImage.push()
              //docker.push("eu.gcr.io/jenkins-004/webapp")
      //      }
       //   }
     //   }
     // }
  //  }

    //stage('Deploy apps') {
      //steps {
          //withKubeConfig([credentialsId: '38579427-0849-4338-aba4-2591a583c4aa', serverUrl: 'https://kubernetes.default']){
            //sh 'kubectl get pods'
            //sh 'kubectl apply -f webapp.yaml'
            //sh 'kubectl apply -f intense.yaml'
            //sh 'kubectl autoscale deployment intense --cpu-percent=50 --min=1 --max=10'
            //sh 'kubectl expose deployment webapp --type=LoadBalancer --name=webapp'
            //sh 'kubectl expose deployment intense --type=LoadBalancer --name=intense'
            //sh 'kubectl apply -f ingress.yaml'
      //}
    //}
  }

}

