@Library('MY-SHARED-LIBRARY') _

pipeline {

    agent any

    environment {
        SONAR_CREDENTIALS_ID = 'Sonar-API'       // Linked SonarQube token in Jenkins
        PROJECT_DIR = '.'                        // Python project directory
        SONAR_PROJECT_KEY = 'EMR-Spark'          // SonarQube project key
    }

    parameters {
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create or delete')
    }

    stages {

        stage('Git Checkout') {
            when { expression { params.action == 'create' } } // Fixed parameter reference
            steps {
                script {
                    gitcheckout(
                        branch: 'main',
                        url: 'https://github.com/ganasai88/EMR-Spark.git'
                    )
                }
            }
        }

        stage('SonarQube Analysis') {
            when { expression { params.action == 'create' } } // Fixed parameter reference
            steps {
                script {
                    staticcodeanalysis(
                        SONAR_CREDENTIALS_ID,
                        PROJECT_DIR,
                        SONAR_PROJECT_KEY
                    )
                }
            }
        }

    }

}
