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

        stage('Upload Files to S3') {
            steps {
                 script {
                     sh '''
                     echo "Uploading files to S3 bucket ${S3_BUCKET}..."

                     # Sync the code to S3
                     aws s3 sync . s3://${S3_BUCKET} --exclude ".git/*"

                     echo "Files uploaded successfully!"
                     '''
                 }
            }
        }
    }
}
