pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
        SONAR_HOST_URL = 'http://3.128.79.130:9000/' // Replace with your SonarQube instance URL
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
                            withSonarQubeEnv(credentialsId: 'sonar-api') {
                                // Run sonar-scanner using Docker with injected SonarQube environment variables
                                sh '''
                                docker pull sonarsource/sonar-scanner-cli
                                docker run --rm \
                                  -e SONAR_HOST_URL="${SONAR_HOST_URL}" \
                                  -e SONAR_LOGIN="${SONAR_TOKEN}" \
                                  -v "${PWD}:/usr/src" \
                                  sonarsource/sonar-scanner-cli -X
                                '''
                            }
                        }
                    }
                }
    }
}
