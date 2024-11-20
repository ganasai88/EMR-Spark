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


        stage('SonarQube Analysis') {
                    steps {
                        script {
                            withSonarQubeEnv(credentialsId:  'sonar-emr-1') {
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
