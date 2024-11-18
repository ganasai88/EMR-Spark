pipeline {
    agent any

    environment {
            SONAR_CREDENTIALS_ID = 'Sonar-API'
            PROJECT_DIR = '.'
            SONAR_PROJECT_KEY = 'EMR-Spark'
            VENV_DIR = 'venv'
            REPO_URL = 'https://github.com/ganasai88/EMR-Spark' // GitHub raw file URL
        }

    stages {
        stage('Checkout') {
            steps {
                git '${REPO_URL}'
            }
        }
        stage('Download requirements.txt') {
            steps {
                script {
                    // Download the requirements.txt file from GitHub
                    sh 'curl -o requirements.txt ${REPO_URL}/requirements.txt'
                }
            }
        }

    }
}
