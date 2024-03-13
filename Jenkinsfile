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
                script{
                    sh 'git checkout main'
                }
            }
        }

        stage('Package Helm Chart') {
            steps {
                script{
                    dir("${CHART_DIR}") {
                        sh 'rm -rf index.yaml'
                        sh 'rm -rf *.tgz'
                        sh 'helm package .'
                    }
                }
            }
        }

        stage('Update Helm Repository') {
            steps {
                script{
                    dir("${CHART_DIR}") {
                        sh 'helm repo index . --url ${REPO_URL} --merge index.yaml'
                    }
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
