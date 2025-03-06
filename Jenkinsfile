#!/usr/bin/env groovy

success = true
defaultNode = 'xcode-16 || xcode-16.2'
sshKey = 'powerci-github-ssh-key'

prTitle = null
runwayBacklogItemId = null
githubPrDetails = null
releaseNotes = null
buildNum = null
pullRequestId = null

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
  ],
  nitromdm: [
    credentialsId: 'a5876938-2cc6-4921-9aaa-12f224fe60fe', 
    variable: 'NITRO_MDM_API_KEY'
  ],
  faslaneapp: [
    credentialsId: 'fastlane-apple-password',
    variable: 'FASTLANE_APPLE_PASSWORD'
  ]
]

stg = [
  buildiOS: 'Build iOS',
  buildmacOS: 'Build macOS',
  buildNum: 'Update Build Number',
  checkout: 'Checkout Repo',
  cleanup: 'Cleanup',
  deps: 'Install Dependencies',
  keychain: 'Setup Keychain',
  notarize: 'Notarize macOS',
  provision: 'Provisioning Profiles',
  runway: 'Create Runway Comment',
  setup: 'Setup',
  uploadiOS: 'Upload iOS to Nitro MDM',
  uploadmacOS: 'Upload macOS to Nitro MDM'
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
      fastlane('install_prov_profiles_ios')
      fastlane('install_prov_profiles_macos')
    }

    stage(stg.keychain) {
      setupKeychain()
    }

    stage(stg.buildiOS) {
      fastlane("build_ios suffix:${buildSuffix()}")
    }

     stage(stg.buildmacOS) {
      fastlane("export_app_pass app_specific_pass:${FASTLANE_APPLE_PASSWORD}")
      fastlane("build_macos suffix:${buildSuffix()}")
    }

    stage(stg.uploadiOS) {
      uploadiOS()
    }

    stage(stg.notarize) {
      notarize()
    }

    stage(stg.uploadmacOS) {
      uploadmacOS()
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
  isDevBuild() ? 'beta' : null
}

def jenkinsSetup() {
  echo "Running Jenkins setup script..."
  sh './.jenkins/jenkins-setup.sh'
}

def setupEnv(block) {
  withCredentials([
    string(secrets.github),
    string(secrets.runway),
    string(secrets.appcenter),
    string(secrets.nitromdm)
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
        buildNum = sh(returnStdout: true, script: './increment playbook-swift-version').trim().toInteger()
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
    // CHANGE_ID is PR ID
    pullRequestID = env.CHANGE_ID
    releaseNotes = githubPrDetails['title']
  } else {
    releaseNotes = sh(script: 'git show-branch --no-name HEAD', returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
    pullRequestIDRegex = "s/.*#\\([0-9]\\{1,\\}\\).*/\\1/p"
    extractedPullRequestID = "echo '${releaseNotes}' | sed -n '${pullRequestIDRegex}'"
    pullRequestID = sh(script: extractedPullRequestID, returnStdout: true).trim()
  }
  echo "Release Notes: ${releaseNotes}"
  echo "Pull Request ID: ${pullRequestID}"
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

def uploadiOS() {
  if (isDevBuild() && !readyForTesting()) return

  def trimmedReleaseNotes = releaseNotes.trim().replaceAll (/\"/,/\\\"/)
  def version = sh(script: "xcodebuild -project 'PlaybookShowcase/PlaybookShowcase.xcodeproj' -target 'PlaybookShowcase-iOS' " +
    "-showBuildSettings | grep MARKETING_VERSION | sed 's/.*= //'", returnStdout: true).trim()

  fastlane("upload_ios suffix:${buildSuffix()} type:${buildType()} release_notes:\"${trimmedReleaseNotes}\" appcenter_token:${APPCENTER_API_TOKEN} " +
    "nitro_mdm_api_token:${NITRO_MDM_API_KEY} build_number:${buildNum} version:${version} pr_number:\"${pullRequestID}\"")
}

def uploadmacOS() {
  if (isDevBuild() && !readyForTesting()) return

  def trimmedReleaseNotes = releaseNotes.trim().replaceAll (/\"/,/\\\"/)
  def version = sh(script: "xcodebuild -project 'PlaybookShowcase/PlaybookShowcase.xcodeproj' -target 'PlaybookShowcase-macOS' " +
    "-showBuildSettings | grep MARKETING_VERSION | sed 's/.*= //'", returnStdout: true).trim()
  
  fastlane("upload_macos suffix:${buildSuffix()} type:${buildType()} release_notes:\"${trimmedReleaseNotes}\" appcenter_token:${APPCENTER_API_TOKEN} " +
    "nitro_mdm_api_token:${NITRO_MDM_API_KEY} build_number:${buildNum} version:${version} pr_number:\"${pullRequestID}\"")
}

def notarize() {
  if (isDevBuild() && !readyForTesting()) return

  fastlane("notarize_macos suffix:${buildSuffix()}")
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
