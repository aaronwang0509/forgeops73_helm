pipeline {
    agent any

    environment {
        CHART_DIR = './helm/helm_cm'
        REPO_NAME = 'forgeops73_helm'
        USERNAME = 'aaronwang0509'
        EMAIL = 'qiushi.wang@bostonidentity.com'
        REPO_URL = 'https://aaronwang0509.github.io/forgeops73_helm/'
    }

    stages {
        stage('Prepare Environment') {
            steps {
                checkout scm
                sh 'git config user.name "${USERNAME}"'
                sh 'git config user.email "${EMAIL}"'
                sh 'git checkout main'
            }
        }

        stage('Package Helm Chart') {
            steps {
                dir("${CHART_DIR}") {
                    sh 'helm package .'
                }
            }
        }

        stage('Update Helm Repository') {
            steps {
                dir("${CHART_DIR}") {
                    sh 'helm repo index . --url ${REPO_URL} --merge index.yaml'
                }
            }
        }

        stage('Push Changes') {
            steps {
                sshagent(['GITHUB_SSHKEY_ID']) {
                    script {
                        sh 'git add .'
                        sh 'git commit -m "Update Helm chart"'
                        sh 'git push'
                    }
                }
            }
        }
    }
}
