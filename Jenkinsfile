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
                    // Set up a Python virtual environment and install pylint
                    sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip pylint
                    '''
                }
            }
        }

        stage('Code Analysis') {
            steps {
                script {
                   // Run SonarQube analysis using the sonar-scanner
                    sh '''
                    sonar-scanner \
                      -Dsonar.projectKey=EMR-Spark \
                      -Dsonar.sources=. \
                      -Dsonar.host.url=http://3.128.79.130:9000 \
                      -Dsonar.token=sqp_667dd69b43ba9b086ef638db1ed81823ae887acf
                    '''
            }
        }
    }
}
