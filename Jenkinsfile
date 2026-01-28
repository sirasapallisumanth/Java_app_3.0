@Library('my-shared-library') _

pipeline {
    agent any

    parameters {
        choice(
            name: 'action', 
            choices: 'create\ndelete', 
            description: 'Choose create or delete'
        )
        string(
            name: 'ImageName', 
            description: "Name of the Docker image", 
            defaultValue: 'javapp'
        )
        string(
            name: 'ImageTag', 
            description: "Tag of the Docker image", 
            defaultValue: 'v1'
        )
        string(
            name: 'DockerHubUser', 
            description: "DockerHub username", 
            defaultValue: 'sumanthsirasapalli'
        )
    }

    stages {

        stage('Git Checkout') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    gitCheckout(
                        branch: "main",
                        url: "https://github.com/sirasapallisumanth/Java_app_3.0.git"
                    )
                }
            }
        }

        stage('Unit Test Maven') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    mvnTest()
                }
            }
        }

        stage('Integration Test Maven') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    mvnIntegrationTest()
                }
            }
        }

        
        stage('Static Code Analysis: SonarQube') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    def SonarQubecredentialsId = 'sonarqube-api'
                    statiCodeAnalysis(SonarQubecredentialsId)
                }
            }
        }

        stage('Quality Gate Status Check: SonarQube') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    def SonarQubecredentialsId = 'sonarqube-api'
                    QualityGateStatus(SonarQubecredentialsId)
                }
            }
        }
        

        stage('Maven Build') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    mvnBuild()
                }
            }
        }

        stage('Docker Image Build') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    dockerBuild(params.ImageName, params.ImageTag, params.DockerHubUser)
                }
            }
        }

        stage('Docker Image Scan: Trivy') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    dockerImageScan(params.ImageName, params.ImageTag, params.DockerHubUser)
                }
            }
        }

        stage('Docker Image Push: DockerHub') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    dockerImagePush(params.ImageName, params.ImageTag, params.DockerHubUser)
                }
            }
        }

        stage('Docker Image Cleanup: DockerHub') {
            when { expression { params.action == 'create' } }
            steps {
                script {
                    dockerImageCleanup(params.ImageName, params.ImageTag, params.DockerHubUser)
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
