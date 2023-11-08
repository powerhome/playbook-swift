#!/usr/bin/env groovy

success = true
defaultNode = 'xcode-15'
sshKey = 'powerci-github-ssh-key'

prDetails = null
runwayBacklogItemId = null

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
  buildNum: 'Build Number',
  checkout: 'Checkout',
  setup: 'Setup',
]

stage(stg.buildNum) {
  node(defaultNode) {
    setupEnv {
      updateBuildNum()
    }
  }
}
stage(stg.checkout) {
  node(defaultNode) {
    setupEnv {
      checkout scm
    }
  }
}
stage(stg.setup) {
  node(defaultNode) {
    setupEnv {
      jenkinsSetup()
      getRunwayBacklogItemId()
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
  lock(resource: stg.buildNum) {
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

def getDetailsJson() {
  if (!prDetails) {
    prDetails = sh(script: "jq -r .title './Build/pr-${env.CHANGE_ID}-details.json'", returnStdout:true)
  }
  echo "PR Details: ${prDetails}"
  return prDetails
}

def getRunwayBacklogItemId() {
  if (!runwayBacklogItemId) {
    runwayBacklogItemId = sh(script: './Tools/setup-story-details.sh', returnStdout: true).trim().replaceAll (/\"/,/\\\"/).readLines().last()
  }
  return runwayBacklogItemId
}

def getReleaseNotes() {
  if (env.CHANGE_ID) {
    releaseNotes = getDetailsJson().trim().replaceAll (/\"/,/\\\"/)
  } else {
    releaseNotes = sh(script: 'git show-branch --no-name HEAD', returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
  }
  echo "Release Notes: ${releaseNotes}"
}
