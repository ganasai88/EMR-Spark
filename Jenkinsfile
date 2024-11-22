pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/ganasai88/EMR-Spark.git' // GitHub repository URL4
        VENV_DIR = 'venv'
        S3_DIR = 'S3-Terraform'
        EMR_DIR = 'EMR'
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
        REGION = 'us-east-2'
        S3_BUCKET = 'cloud-hosting01'
    }

    stages {
        stage('Checkout') {
            steps {

                git branch: 'main', url: "${REPO_URL}"

            }
        }

        stage('Find Running EMR Cluster') {
                    steps {
                        script {
                            // Get the cluster ID of the first running EMR cluster
                            def clusterId = sh(
                                script: '''
                                aws emr list-clusters \
                                    --active \
                                    --query "Clusters[?Status.State=='WAITING']|[0].Id" \
                                    --region $REGION \
                                    --output text
                                ''',
                                returnStdout: true
                            ).trim()

                            if (!clusterId) {
                                error "No running EMR cluster found!"
                            }

                            echo "Found EMR Cluster ID: ${clusterId}"
                            env.CLUSTER_ID = clusterId
                        }
                    }
        }
    }
}
