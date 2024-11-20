pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
       // Replace with your SonarQube instance URL
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

        stage('SonarQube Analysis') {
                    steps {
                        script {
                            withSonarQubeEnv(credentialsId: '83d5786d-e8a4-40a2-9f3e-b76227de9f1b') {
                                // Run sonar-scanner using Docker with injected SonarQube environment variables
                                sh '''
                                docker pull sonarsource/sonar-scanner-cli
                                docker run --rm \
                                  -v "${PWD}:/usr/src" \
                                  sonarsource/sonar-scanner-cli -X
                                '''
                            }
                        }
                    }
        }
    }
}
