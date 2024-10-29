pipeline {
 agent any  // { node { label "maven-sonarqube-node" } }
 parameters   {
   choice(name: 'aws_account',choices: ['160885259898', '4568366404742', '922266408974'], description: 'aws account hosting image registry')
   choice(name: 'ecr_tag',choices: ['1.0.0','1.1.0','1.2.0'], description: 'Choose the ecr tag version for the build')
       }
tools {
    maven "maven3.9"
    }
    stages {
      stage('1. Git Checkout') {
        steps {
          git branch: 'main', credentialsId: 'Github-pat', url: 'https://github.com/hardcoredevopsgroup/address-book-application.git'
        }
      }
      stage('2. Build with maven') { 
        steps{
          sh "mvn clean package"
         }
       }
      stage('3. SonarCloud analysis') {
        environment {SONAR_TOKEN = credentials('sonarcloud-token')}
        steps {
          script{
            def scannerHome = tool 'SonarCloud';
            withSonarQubeEnv("SonarCloud") {
            sh "${scannerHome}/bin/sonar-scanner  \
              -Dsonar.projectKey=address-book-application \
              -Dsonar.projectName='address-book-application' \
              -Dsonar.host.url=https://sonarcloud.io/ \
              -Dsonar.login=$SONAR_TOKEN \
              -Dsonar.sources=src/main/java/ \
              -Dsonar.organization=hardcoredevopsgroup \
              -Dsonar.java.binaries=target/classes"
            }
          }
        }
      }
      stage('4. Docker image build') {
         steps{
          sh "aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${params.aws_account}.dkr.ecr.us-east-2.amazonaws.com"
          sh "sudo docker build -t addressbook ."
          sh "sudo docker tag addressbook:latest ${params.aws_account}.dkr.ecr.us-east-2.amazonaws.com/addressbook:${params.ecr_tag}"
          sh "sudo docker push ${params.aws_account}.dkr.ecr.us-east-2.amazonaws.com/addressbook:${params.ecr_tag}"
         }
       } 
     /* stage('5. Application deployment in eks') {
        steps{
          kubeconfig(caCertificate: '',credentialsId: 'k8s-kubeconfig', serverUrl: '') {
          sh "kubectl apply -f manifest"
          }
         }
       }
      stage('6. Monitoring solution deployment in eks') {
        steps{
          kubeconfig(caCertificate: '',credentialsId: 'k8s-kubeconfig', serverUrl: '') {
          sh "kubectl apply -f monitoring"
          sh "chmod +x -R script"
          sh(""" script/createIRSA-AMPIngest.sh""")
          sh(""" script/createIRSA-AMPQuery.sh""")
          }
         }
       }
      stage ('7. Email Notification') {
         steps{
         mail bcc: 'fusisoft@gmail.com', body: '''Build is Over. Check the application using the URL below. 
         https//abook.shiawslab.com/addressbook-1.0
         Let me know if the changes look okay.
         Thanks,
         Dominion System Technologies,
         +1 (313) 413-1477''', cc: 'fusisoft@gmail.com', from: '', replyTo: '', subject: 'Application was Successfully Deployed!!', to: 'fusisoft@gmail.com'
      }
    } */
 }
}



