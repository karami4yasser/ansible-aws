pipeline{
    agent any
    tools {
      maven 'maven'
    }
    stages{
        stage('SCM'){
            steps{
                
               git branch: 'main', credentialsId: 'git', url: 'git@github.com:karami4yasser/stage-1.git'

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
             
                  ansiblePlaybook credentialsId: 'ec2', inventory: 'inventory', playbook: 'site.yml'
               //sh "ansible-playbook site.yml -i inventory --private-key ec2.pem -u ubuntu -e ansible_become_password="
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

 