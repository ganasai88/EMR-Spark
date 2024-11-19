pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
    }

    stages {
        stage('Checkout') {
            steps {

                git branch: 'main', url: "${REPO_URL}"

            }
        }

        stage('Setup') {
            steps {
                script {
                    // Install python3-venv package
                    sh '''
                    sudo apt-get update
                    sudo apt-get install -y python3-venv
                    '''
                }
            }
        }
    }
}
