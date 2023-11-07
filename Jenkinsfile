#!/usr/bin/env groovy

success = true
defaultNode = 'xcode-15'
sshKey = 'powerci-github-ssh-key'

// TODO: move all secrets out!
secrets = [
  github: [
    credentialsId: '62620542-b00d-4c1f-81dd-4d014369f07d',
    variable: 'GITHUB_API_TOKEN'
  ],
  runway: [
    credentialsId: 'nitro-runway-api-token-tps-40',
    variable: 'RUNWAY_API_TOKEN'
  ],
  appcenter: [
    credentialsId: 'appcenter-token',
    variable: 'APPCENTER_API_TOKEN'
  ]
]

stg = [
  details: 'Release Details',
]

stage(stg.details) {
  node(defaultNode) {
    setupEnv {
      updateBuildNum()
      checkout scm
      jenkinsSetup()
      getReleaseNotes()
    }
  }
}

// Methods

def jenkinsSetup() {
  echo "Running Jenkins setup script..."
  sh './.jenkins/jenkins-setup.sh'
}

def setupEnv(block) {
  withCredentials([
    string(secrets.github),
    string(secrets.runway),
    string(secrets.appcenter)
  ]) {
    withEnv(['LC_ALL=en_US.UTF-8', 'LANG=en_US.UTF-8']) {
      sshagent([sshKey]) {
        block()
      }
    }
  }
}

def updateBuildNum() {
  lock(resource: stg.details) {
    // clone repo
    dir('.buildnumber') {
      try {
        sh 'git clone --depth 5 git@github.com:powerhome/nitro-buildnumber.git .'
        buildNumber = sh(returnStdout: true, script: './increment PlaybookSwift-version').trim().toInteger()
        print "Build number: ${buildNumber}"
      }
      finally {
        deleteDir()
      }
    }
  }
}

def getReleaseNotes() {
  RUNWAY_BACKLOG_ITEM_ID = sh(script: './Tools/setup-story-details.sh', returnStdout: true).trim().replaceAll (/\"/,/\\\"/).readLines().last()
  if (env.CHANGE_ID) {
    releaseNotes = sh(script: "jq -r .title './Build/pr-${env.CHANGE_ID}-details.json'", returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
  }
  else {
    releaseNotes = sh(script: 'git show-branch --no-name HEAD', returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
  }
  echo "Release Notes: ${releaseNotes}"
}
