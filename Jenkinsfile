pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
        TF_DIR = 'S3-Terraform'
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

        stage('Setup AWS CLI') {
            steps {
                script {
                    sh '''
                    # Check if AWS CLI is installed
                    if aws --version > /dev/null 2>&1; then
                        echo "AWS CLI is installed."
                    else
                        echo "AWS CLI is not installed. Installing now..."
                        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                        unzip awscliv2.zip
                        sudo ./aws/install
                    fi

                    # Configure AWS CLI
                    aws configure set aws_access_key_id ${ACCESS_KEY}
                    aws configure set aws_secret_access_key ${SECRET_KEY}
                    aws configure set region ${REGION}
                    '''
                }
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
}
