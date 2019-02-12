  pipeline {
    agent any
     tools{
        maven 'maven'
          }
    stages {
        
        stage('Build') {
              steps {
                  sh "mvn -B -DskipTests clean package"
                  archiveArtifacts artifacts: 'target/app.war'
            }
        }        
        
        
        
    
  
    stage('Build Docker image'){
                       
            steps {
                script {
                    app = docker.build("suhita/phoenix2.0")
                    app.inside {
                        sh 'echo $(curl localhost:80)'
                    }
                }
            }
            
        }
        
        stage('Push docker image'){
           
            steps{
                script {
                    docker.withRegistry('https://registry.hub.docker.com','docker_hub_login'){
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        
      stage('Perform Sonarqube analysis')
        {
                     steps   {

                                sh "mvn sonar:sonar -Dsonar.host.url=http://54.188.213.9:30002"
                        }
        }

      
        stage('Deploy kubernetes'){
          
          steps {
           kubernetesDeploy(
                kubeconfigId: 'kubeconfig',
                configs: 'application.yaml',
                enableConfigSubstitution: true)
                echo 'App url: http://54.186.233.130:30005/app'
          }
                     
        }
        
    }
}
