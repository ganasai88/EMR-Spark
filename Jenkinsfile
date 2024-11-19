pipeline {
    agent any

    environment {
                REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub raw file URL
            }

    stages {
        stage('Checkout') {
            steps {
            script {
                git 'url: '${REPO_URL}' // Use environment variable REPO_URL
                }
            }
        }
    }
}
