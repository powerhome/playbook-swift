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
  buildNum: 'Build Number'
]

stage(stg.buildNum) {
  node(defaultNode) {
    setupEnv {
      updateBuildNum()
    }
  }
}

// Methods

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
