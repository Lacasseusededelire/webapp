pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'webapp:latest' // Nom de l'image Docker
        CONTAINER_NAME = 'webapp-container2' // Nom du conteneur
        DOCKER_REGISTRY = 'registry.hub.docker.com' // Exemple : "registry.hub.docker.com" ou "ghcr.io"
        DOCKER_USERNAME = 'marieemko' // Remplacez par votre nom d'utilisateur Docker
        DOCKER_PASSWORD = 'Ndomemouto2105@' // Remplacez par votre mot de passe Docker (configuré dans Jenkins Credentials)
    }
    stages {
        stage('Checkout Code') {
            steps {
               git branch: 'main', url: 'https://github.com/Lacasseusededelire/webapp.git'            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
        stage('Run Docker Container') {
            steps {
                sh 'docker run -d --name ${CONTAINER_NAME} -p 8085:8080 ${DOCKER_IMAGE}'
            }
        }
        stage('Wait for Application to Start') {
            steps {
                script {
                     sleep(30)  // Attend 30 secondes
                }
            }
        }

        stage('Test Application') {
            steps {
                script {
                    // Exemple de test basique
                    def response = sh(script: "curl -o /dev/null -s -w '%{http_code}' --max-time 60 http://localhost:8085", returnStdout: true)
                    if (response.trim() != '200') {
                        error("Application test failed. HTTP response: ${response}")
                    } else {
                        echo "Application test passed. HTTP response: ${response}"
                    }
                }
            }
        }
        stage('Push to Docker Registry') {
            steps {
                script {
                    // Authentification au registre Docker
                    sh "echo ${DOCKER_PASSWORD} | docker login ${DOCKER_REGISTRY} -u ${DOCKER_USERNAME} --password-stdin"
                    
                    // Renommer l'image pour inclure l'URL du registre
                    sh "docker tag ${DOCKER_IMAGE} ${DOCKER_REGISTRY}/${DOCKER_USERNAME}/${DOCKER_IMAGE}"
                    
                    // Pousser l'image vers le registre
                    sh "docker push ${DOCKER_REGISTRY}/${DOCKER_USERNAME}/${DOCKER_IMAGE}"
                }
            }
        }
        stage('Cleanup') {
            steps {
                sh 'docker stop ${CONTAINER_NAME} || true'
                sh 'docker rm ${CONTAINER_NAME} || true'
                sh 'docker rmi ${DOCKER_IMAGE} || true'
            }
        }
    }
}
