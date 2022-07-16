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
                sh "docker build . -t karamiyasser/hariapp "
            }
        }
        stage('DockerHub Push'){
            steps{
           withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerpwd')]) {
    sh "docker login -u karamiyasser -p ${dockerpwd}"
}
                
                sh "docker push karamiyasser/hariapp "
            }
        }
        
        stage('Docker Deploy then Clean'){
            steps{
                sh " cd  "
                sh " cd stage-1"

                sh "ansible-playbook site.yml -i inventory --private-key ansible.key -u yasser -e ansible_become_password=root "
            }
        }
    }
}

