#!/usr/bin/groovy
pipeline {
    environment {
        JAVA_HOME = tool('java')
    }
agent any
options {
disableConcurrentBuilds()
}
stages {
  
stage("buildsrc") {
steps { buildsrc() }
}

stage('renaming the target zip file') {
    steps {
               sh 'mv target/helloworld-1.0.0-SNAPSHOT.zip helloworld.zip'
    }
}  
stage("Buildimg") {
steps { 
	slackSend (message: 'Building the image')
	buildApp() }
}
stage("Deploy") {
  steps { deploy() 
	  slackSend (message: 'container deployed sucessfully')
	}
}
}
}
// steps
def buildsrc() {
dir ('.' ) {
    sh '/app/ciplatform/apache-maven-3.3.9/bin/mvn install'
}
}
def buildApp() {
dir ('' ) {
def appImage = docker.build("eaiesbhub/mulehelloworld:${BUILD_NUMBER}")
}
}
def deploy() {

	def containerName = 'mulehelloworld'

	sh "docker ps -f name=${containerName} -q | xargs --no-run-if-empty docker stop"
	sh "docker ps -a -f name=${containerName} -q | xargs -r docker rm"
	sh "docker run -d --name ${containerName} eaiesbhub/mulehelloworld:${BUILD_NUMBER}"

}
