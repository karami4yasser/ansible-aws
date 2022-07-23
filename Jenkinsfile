pipeline{
    agent any
    tools {
      maven 'maven'
    }
    stages{
        stage('SCM'){
            steps{
                git credentialsId: 'github',
                url: 'https://github.com/javahometech/dockeransiblejenkins'

            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Docker Build'){
            steps{
                sh "docker build . -t $JOB_NAME:v1.$BUILD_ID "
                sh "docker image tag $JOB_NAME:v1.$BUILD_ID karamiyasser/$JOB_NAME:v1.$BUILD_ID "
                sh "docker image tag $JOB_NAME:v1.$BUILD_ID karamiyasser/$JOB_NAME:latest "
            }
        }
        stage('DockerHub Push'){
            steps{
           withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerpwd')]) {
    sh "docker login -u karamiyasser -p ${dockerpwd}"
}
                
                sh "docker push karamiyasser/$JOB_NAME:v1.$BUILD_ID "
                sh "docker push karamiyasser/$JOB_NAME:latest "
            }
        }
        
        stage('Docker Deploy '){
            steps{
                sh " cd  "
                sh " cd stage-1"

                sh "ansible-playbook site.yml  "
            }
        }
        stage("clean workdirectory")
        {
                steps{
                cleanWs()
            }
        }
       

    }
}

