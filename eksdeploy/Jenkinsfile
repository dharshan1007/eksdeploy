pipeline {
    agent any
    stages {
        stage('clean_workspace') {
            steps {
                // You can choose to clean workspace before build as follows
                cleanWs deleteDirs: true, notFailBuild: true
                checkout scm
               
            }
        }
//         stage ('Build') {
//             steps { 
//                     sh 'mvn clean install -DskipTests=true '                                    
//                }
//          }
        
         stage ('docker image build') {
             steps {
                 sh 'sudo docker build ./ -t ev_pilot-dev-mqtt:latest '           
             }    
                    
        }
       
       stage ('docker image push to ECR') {
             steps {
                 withCredentials([string(credentialsId: 'aws_account_id', variable: 'Account_id')]){
                     sh 'aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin $Account_id.dkr.ecr.us-east-1.amazonaws.com'
                     sh 'sudo docker tag ev_pilot-dev-mqtt:latest $Account_id.dkr.ecr.us-east-1.amazonaws.com/ev_pilot-dev-mqtt:latest'
                     sh 'sudo docker push $Account_id.dkr.ecr.us-east-1.amazonaws.com/ev_pilot-dev-mqtt:latest'
                 }
             }
         }
       stage ('deploy to EKS') {
                steps { 
               withCredentials([string(credentialsId: 'aws_account_id', variable: 'AWS_ACCOUNT')]) {
                     sh 'export KUBECONFIG=~/.kube/config'
                     sh 'kubectl apply -f rbac.yaml'
                     sh 'kubectl apply -f deployment.yaml -n development'
                     }
              
                }
         }
                   
    }
}
