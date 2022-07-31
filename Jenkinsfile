pipeline {
    agent any
      environment 
    {
        PROJECT     = 'php-todo'
        ECRURL      = '620444491882.dkr.ecr.us-east-2.amazonaws.com/php-todo:latest'
        DEPLOY_TO = 'development'
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 620444491882.dkr.ecr.us-east-2.amazonaws.com"
                }
                 
            }
        }
        
        stage('Checkout SCM') {
          steps {
            git branch: 'feature-0.0.1', url: 'https://github.com/obafema/dockerization_php-todo_app.git', credentialsId: 'github-login'
          }
       }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build php-todo:0.0.1
        }
      }
    }
   
        stage('Tag the image')
          steps {
              sh 'docker image tag php-todo:0.0.1 obafema/php-todo:feature-0.0.1'
          }

    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "docker tag php-todo:latest 620444491882.dkr.ecr.us-east-2.amazonaws.com/php-todo:latest
                sh "docker push 620444491882.dkr.ecr.us-east-2.amazonaws.com/php-todo:latest
         }
        }
      }
    }
}