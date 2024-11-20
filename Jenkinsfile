pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
        TF_DIR = 'S3-Terraform'
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
        REGION = 'us-east-2'
    }

    stages {
        stage('Checkout') {
            steps {

                git branch: 'main', url: "${REPO_URL}"

            }
        }


        stage('SonarQube Analysis') {
             steps {
                 script {
                         sh '''
                         docker run --rm -e SONAR_HOST_URL=http://18.189.184.41:9000/ \
                         -e SONAR_LOGIN=sqp_b32477c8d2b442414c295034a210a75cc79bcf8f \
                         -v /var/lib/jenkins/workspace/EMR-Spark:/usr/src \
                         sonarsource/sonar-scanner-cli \
                         -Dsonar.projectKey=EMR-Spark \
                         -Dsonar.sources=. \
                         -Dsonar.host.url=http://18.189.184.41:9000 \
                         -Dsonar.login=sqp_b32477c8d2b442414c295034a210a75cc79bcf8f \
                         '''
                 }
             }
        }

       stage('Set up AWS Credentials') {
                   steps {
                       script {
                           // Export AWS credentials for Terraform to use
                           sh '''
                           export AWS_ACCESS_KEY_ID=$ACCESS_KEY
                           export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
                           export AWS_DEFAULT_REGION=$REGION
                           '''
                       }
                   }
       }

       stage('Creating S3 using Terraform') {
                           steps {
                               script {
                                   // Initialize Terraform
                                   dir(TF_DIR) {
                                       sh """
                                             terraform init
                                             terraform plan
                                       """
                                   }
                               }
                           }
       }

    }
}
