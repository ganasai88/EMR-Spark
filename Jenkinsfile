pipeline{

    agent any

    stages{

        stage('Git Checkout'){

            steps{

                script{
                    gitCheckout(
                        branch: 'main',
                        url: 'https://github.com/ganasai88/EMR-Spark.git'
                    )

                }

            }

        }

    }
}