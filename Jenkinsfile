pipeline {
	agent any
	tools {
		maven 'Maven3'
		jdk 'Java'
	}
	options {
		skipDefaultCheckout()
	}
	stages {
		stage('Checkout code') {
			steps {
				echo 'Checking out code'
				checkout scm
			}			
		}
		stage('Build') {
			steps {
				echo 'building project'
				bat 'mvn install'
			}
		}
		stage('Unit Testing') {
			steps {
				echo 'unit testing'
				bat 'mvn test'
			}
		}
		stage('Sonar Analysis') {
			steps {
				withSonarQubeEnv('Test_Sonar') {
					echo 'sonar analysis of project'
					bat 'mvn sonar:sonar'
				}				
			}
		}
		stage('Deploy artifacts') {
			steps {
				rtMavenDeployer (
					id: 'deployer',
					serverId: '123456789@artifactory'
					releaseRepo: 'devops-exam'
					snapshotRepo: 'devops-exam'
				)
				rtMavenBuild (
					pom: 'pom.xml'
					goals: 'clean install'
					deployerId: 'deployer'
				)
				rtPublishBuildInfo(
					serverId: '123456789@artifactory'
				)
			}
		}
		stage('Docker Image') {
			steps {
				bat 'docker build -t nitisharora31/devops-nagp-exam:%BUILD_NUMBER% --no-cache -f Dockerfile .'
			}
		}
		stage('Check and Stop running container') {
			steps {
				bat '(docker stop c_devops_nagp_exam || "No such container is running") && (docker rm -fv c_devops_nagp_exam || "No such container is present in stopped state")'
			}
		}
		stage('Run container') {
			steps {
				bat 'docker run --name c_devops_nagp_exam -d -p 9090:9090 nitisharora31/devops-nagp-exam:%BUILD_NUMBER%'
			}
		}
	}
}