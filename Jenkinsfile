pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
        S3_DIR = 'S3-Terraform'
        EMR_DIR = 'EMR'
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
        REGION = 'us-east-2'
        S3_BUCKET = 'cloud-hosting01'
    }

    stages {
        stage('Checkout') {
            steps {

                git branch: 'main', url: "${REPO_URL}"

            }
        }

       stage('Creating S3 using Terraform') {
           steps {
                  script {
                      // Initialize Terraform
                      dir(EMR_DIR) {
                      try {
                          sh """
                                terraform init
                                terraform plan
                                terraform apply -auto-approve
                          """
                       } catch (Exception e){
                          // If apply fails, destroy the infrastructure
                          echo 'Terraform apply failed. Running terraform destroy...'
                          sh """
                                terraform destroy -auto-approve
                          """
                          // Re-throw the exception to ensure the pipeline fails
                          throw e
                       }
                      }
                  }
           }
       }
    }
}
