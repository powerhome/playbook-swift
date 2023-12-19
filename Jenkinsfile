#!/usr/bin/env groovy

success = true
defaultNode = 'xcode-15 && !worker13'
sshKey = 'powerci-github-ssh-key'

prTitle = null
runwayBacklogItemId = null
githubPrDetails = null
releaseNotes = null
buildNum = null

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
  build: 'Build iOS',
  buildNum: 'Update Build Number',
  checkout: 'Checkout Repo',
  cleanup: 'Cleanup',
  deps: 'Install Dependencies',
  keychain: 'Setup Keychain',
  provision: 'Provisioning Profiles',
  runway: 'Create Runway Comment',
  setup: 'Setup',
  upload: 'Upload to AppCenter'
]

node(defaultNode) {
  setupEnv {
    stage(stg.buildNum) {
      getBuildNum()
    }
    stage(stg.checkout) {
      checkout scm
    }
    stage(stg.setup) {
      updateBuildNum()
      jenkinsSetup()
      getRunwayBacklogItemId()
      getReleaseNotes()
    }
    stage(stg.deps) {
      sh 'make dependencies'
    }

    stage(stg.provision) {
      clearProvisioningProfiles()
      downloadProvisioningProfiles()
      fastlane('install_prov_profiles')
    }

    stage(stg.keychain) {
      setupKeychain()
    }

    stage(stg.build) {
      fastlane("build_ios suffix:${buildSuffix()}")
    }

    stage(stg.upload) {
      uploadToAppCenter()
    }

    stage(stg.runway) {
      writeRunwayComment()
    }

    stage(stg.cleanup) {
      handleCleanup()
    }
  }
}

// Methods
def buildSuffix() {
  isDevBuild() ? 'beta' : nil
}

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

def getBuildNum() {
  lock(resource: stg.buildNum) {
    dir('.buildnumber') {
      try {
        sh 'git clone --depth 5 git@github.com:powerhome/nitro-buildnumber.git .'
        buildNum = sh(returnStdout: true, script: './increment PlaybookSwift-version').trim().toInteger()
        print "Build number: ${buildNum}"
      }
      finally {
        deleteDir()
      }
    }
  }
}

def updateBuildNum() {
  sh "echo \"CURRENT_PROJECT_VERSION = ${buildNum}\" > ./PlaybookShowcase/Versioning.xcconfig"
}

def getRunwayBacklogItemId() {
  runwayBacklogItemId = sh(script: './Tools/setup-story-details.sh', returnStdout: true).trim().replaceAll (/\"/,/\\\"/).readLines().last()
  if (isDevBuild()) {
    githubPrDetails = readJSON file: "./Build/pr-${env.CHANGE_ID}-details.json"
  }
  return runwayBacklogItemId
}

def getReleaseNotes() {
  if (env.CHANGE_ID) {
    releaseNotes = githubPrDetails['title']
  } else {
    releaseNotes = sh(script: 'git show-branch --no-name HEAD', returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
  }
  echo "Release Notes: ${releaseNotes}"
}

def clearProvisioningProfiles() {
  sh "rm -rf '~/Library/MobileDevice/Provisioning Profiles'"
  sh 'rm -rf ./git_prov_profiles'
}

def downloadProvisioningProfiles() {
  sh 'git clone --depth 1 git@github.com:powerhome/ios-provisioning-profiles.git ./git_prov_profiles'
}

def checkProvisioningProfiles() {
  sh "cd ./git_prov_profiles && ./check-expire-and-install-provisioning-profiles.sh"
  sh "cd ./git_prov_profiles/profiles_macos && ./check-expire-and-install-provisioning-profiles.sh"
}

def fastlane(String command) {
  sh "asdf exec bundle exec fastlane ${command}"
}

def setupKeychain() {
  withEnv([
    "BUILD_NUMBER=${buildNum}",
    "ROOT_DIR=./"
  ]) {
    withCredentials([
      string(credentialsId: 'ios-distribution-password', variable: 'KEY_PASSWORD'),
    ]) {
      lock(resource: 'Nitro-iOS Keychain Search List') {
        sh './.jenkins/jenkins-keychain.sh setup'
      }
    }
  }
}

def deleteKeychain() {
  withEnv([
    "BUILD_NUMBER=${buildNum}",
    "ROOT_DIR=./"
  ]) {
    lock(resource: 'Nitro-iOS Keychain Search List') {
      sh './.jenkins/jenkins-keychain.sh destroy'
    }
  }
}

def buildType() {
  if (isMainBuild() == true) {
    return 'production'
  }
  return 'beta'
}

def isMainBuild() {
  return env.BRANCH_NAME == 'main'
}

def isDevBuild() {
  return env.BRANCH_NAME != 'main'
}

def readyForTesting() {
  def labels = githubPrDetails['labels']
  return labels.find{it.name == "Ready for Testing"}
}

def uploadToAppCenter() {
  if (isDevBuild() && !readyForTesting()) return

  def trimmedReleaseNotes = releaseNotes.trim().replaceAll (/\"/,/\\\"/)
  fastlane("upload_ios suffix:${buildSuffix()} type:${buildType()} release_notes:\"${trimmedReleaseNotes}\" appcenter_token:${APPCENTER_API_TOKEN}")
}

def prTitleValid() {
  def match = githubPrDetails['title'] =~ /\[PBIOS\-[0-9]+\]+/
  return match.find()
}

def writeRunwayComment() {
  if (isDevBuild() && !readyForTesting()) {
    echo "PR is not ready for testing yet. Skipping Runway comment."
    return
  }

  if (env.PR_USER_HANDLE in ['renovate[bot]', 'dependabot']) {
    echo "Bot PR detected. Skipping Runway comment."
    return
  }

  if (isDevBuild() && !prTitleValid()) {
    echo "Invalid PR title detected. Skipping Runway comment."
    return
  }

  fastlane("create_runway_comment build_number:${buildNum} type:${buildType()} runway_api_token:${RUNWAY_API_TOKEN} runway_backlog_item_id:${runwayBacklogItemId} github_pull_request_id:${env.CHANGE_ID}")
}

def deleteDerivedData(){
  fastlane("run clear_derived_data")
}

def handleCleanup() {
  try { deleteKeychain() } catch (e) { }
  try { deleteDerivedData() } catch (e) { }
  try { deleteDir() } catch (e) { }
}