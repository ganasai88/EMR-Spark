pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
        TF_DIR = 'S3-Terraform'
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
                         sh '''
                         docker run --rm -e SONAR_HOST_URL=http://3.12.152.149:9000/ \
                         -e SONAR_LOGIN=sqp_b32477c8d2b442414c295034a210a75cc79bcf8f \
                         -v /var/lib/jenkins/workspace/EMR-Spark:/usr/src \
                         sonarsource/sonar-scanner-cli \
                         -Dsonar.projectKey=EMR-Spark \
                         -Dsonar.sources=. \
                         -Dsonar.host.url=http://3.12.152.149:9000 \
                         -Dsonar.login=sqp_b32477c8d2b442414c295034a210a75cc79bcf8f \
                         -X
                         '''
                 }
             }
        }

        stage('Set Up Terraform') {
                    steps {
                        script {
                            // Install Terraform if necessary
                            sh 'curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -'
                            sh 'sudo apt-get update && sudo apt-get install terraform'
                        }
                    }
                }

    }
}
