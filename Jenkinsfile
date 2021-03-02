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
					releaseRepo: 'nagp-devops-exam'
					snapshotRepo: 'nagp-devops-exam'
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

	}
}