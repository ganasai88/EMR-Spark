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
                 withSonarQubeEnv(credentialsId: 'sonar-api') {
                   // Run SonarQube analysis using the sonar-scanner
                        sh '''
                        sonarsource/sonar-scanner-cli \
                          -Dsonar.projectKey=EMR-Spark \
                          -Dsonar.sources=. \
                          -Dsonar.host.url=$SONAR_HOST_URL \
                          -Dsonar.token=$SONAR_TOKEN
                        '''
                    }
                }
            }
        }
    }
}
