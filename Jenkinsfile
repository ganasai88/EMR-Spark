@Library('MY-SHARED-LIBRARY') _

pipeline {
    agent any

    environment {
        SONAR_CREDENTIALS_ID = 'Sonar-API'  // SonarQube credentials ID
        PROJECT_DIR = '.'                    // Project directory (can be changed if needed)
        SONAR_PROJECT_KEY = 'EMR-Spark'      // SonarQube project key
        VENV_DIR = 'venv'                    // Virtual environment directory (if applicable)
    }

    parameters {
        choice(name: 'action', choices: ['create', 'delete'], description: 'Choose create or delete')
    }

    stages {

        stage('Git Checkout') {
            when { expression { params.action == 'create' } }  // Execute only if 'create' is selected
            steps {
                script {
                    // Ensure the gitcheckout function is defined in your shared library
                    gitcheckout(
                        branch: 'main',
                        url: 'https://github.com/ganasai88/EMR-Spark.git'
                    )
                }
            }
        }

        stage('SonarQube Analysis') {
            when { expression { params.action == 'create' } }  // Execute only if 'create' is selected
            steps {
                script {
                    // Ensure the sonarScanner function is defined in your shared library
                    sonarScanner(
                        sonarCredentialsId: SONAR_CREDENTIALS_ID,
                        projectDir: PROJECT_DIR,
                        sonarProjectKey: SONAR_PROJECT_KEY
                    )
                }
            }
        }

    }

}
