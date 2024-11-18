@Library('MY-SHARED-LIBRARY') _

pipeline {
    agent any

    environment {
        SONAR_CREDENTIALS_ID = 'Sonar-API'
        PROJECT_DIR = '.'
        SONAR_PROJECT_KEY = 'EMR-Spark'
        VENV_DIR = 'venv'
    }

    parameters {
        choice(name: 'action', choices: ['create', 'delete'], description: 'Choose create or delete')
    }

    stages {

        stage('Git Checkout') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    // Using the gitcheckout from shared library
                    gitcheckout(
                        branch: 'main',
                        url: 'https://github.com/ganasai88/EMR-Spark.git'
                    )
                }
            }
        }

        stage('Setup Virtual Environment') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    // Check if virtual environment exists and install pylint
                    sh """
                        if [ ! -d "${PROJECT_DIR}/${VENV_DIR}" ]; then
                            python3 -m venv ${PROJECT_DIR}/${VENV_DIR}
                        fi
                        source ${PROJECT_DIR}/${VENV_DIR}/bin/activate
                        pip install --upgrade pip
                        pip install pylint
                    """
                }
            }
        }

        stage('Run Pylint') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    // Run pylint using the virtual environment
                    sh """
                        source ${PROJECT_DIR}/${VENV_DIR}/bin/activate
                        pylint ${PROJECT_DIR}
                    """
                }
            }
        }

        stage('SonarQube Analysis') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    // Run SonarQube analysis
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
