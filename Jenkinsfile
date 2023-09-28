#!/usr/bin/env groovy

success = true
defaultNode = 'xcode-14'

stage('Build number') {
  node(defaultNode) {
    setupEnvironment {
      updateBuildNumber()
    }
  }
}

def steps = [
  'iOS': {
    runNode {
      getReleaseNotes()
      def args = "build_number:${buildNumber} type:${buildType()}"
      buildAndShipiOS(args, target())
    }
  // }, 'macOS': {
  //   runNode {
  //     buildAndShipMacOS(args)
  //   }
  }
]
def map = steps
map.failFast = true
parallel map

waitUntil { success }

runShortNode {
  stage('Runway Comment') {
    writeRunwayComment()
  }
  stage('Tag') {
    try { fastlane("tag_build build:${buildNumber}") } catch (e) { }
  }
}

// Methods

def setupEnvironment(block) {
  withCredentials([
    string(credentialsId: '62620542-b00d-4c1f-81dd-4d014369f07d', variable: 'GITHUB_API_TOKEN'),
    string(credentialsId: 'nitro-runway-api-token-tps-40', variable: 'RUNWAY_API_TOKEN')
  ]) {
    withEnv(['LC_ALL=en_US.UTF-8', 'LANG=en_US.UTF-8']) {
      sshagent(['powerci-github-ssh-key']) {
        block()
      }
    }
  }
}

def runNode(block) {
  runNodeWith(defaultNode, block, false)
}

def runShortNode(block) {
  runNodeWith(defaultNode, block, true)
}

def checkForFailedParallelJob() {
  if (success == false) {
    throw new Exception('A parallel job has failed.')
  }
}

def runNodeWith(label, block, isShort) {
  node(label) {
    setupEnvironment {
      try {
        checkForFailedParallelJob()

        stage('Print Node Name') {
          echo "Running on node: ${env.NODE_NAME}"
        }
        stage('Checkout') {
            checkout scm
        }
        
        if (isShort == false) {
          stage('Dependencies') {
            sh 'make dependencies'
          }
          stage('Provisioning Profiles') {
            clearProvisioningProfiles()
            downloadProvisioningProfiles()
            fastlane('install_prov_profiles')
          }
          stage('Keychain') {
            setupKeychain()
          }
        }
        checkForFailedParallelJob()
        block()
      }
      catch (e) {
        success = false
        currentBuild.result = "FAILED"
        stage('Handle Failure') {
          handleFailure()
        }
        throw e
      }
      finally {
        stage('Cleanup') {
          handleCleanup()
        }
      }
    }
  }
}

def prepareToBuild() {
  def fastlaneOpts = ''
  stage('Prepare') {
    sh "make playbook-ios && sleep 1"
    fastlaneOpts = "build_number:${buildNumber} type:${buildType()}"
    fastlane("setup_before_build ${fastlaneOpts}")
  }
  checkForFailedParallelJob()
  return fastlaneOpts
}

def getReleaseNotes() {
  stage('Release notes') {
    RUNWAY_BACKLOG_ITEM_ID = sh(script: './Tools/setup-story-details.sh', returnStdout: true).trim().replaceAll (/\"/,/\\\"/).readLines().last()
    if (env.CHANGE_ID) {
      // CHANGE_ID is PR ID
      releaseNotes = sh(script: "jq -r .title './Build/pr-${env.CHANGE_ID}-details.json'", returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
    }
    else {
      releaseNotes = sh(script: 'git show-branch --no-name HEAD', returnStdout:true).trim().replaceAll (/\"/,/\\\"/)
    }
    echo "Release Notes: ${releaseNotes}"
  }
}

def writeRunwayComment() {
  fastlane("create_runway_comment build_number:${buildNumber} type:${buildType()} runway_api_token:${RUNWAY_API_TOKEN} runway_backlog_item_id:${RUNWAY_BACKLOG_ITEM_ID} github_pull_request_id:${env.CHANGE_ID}")
}

def target() {
  if (isMainBuild() == true) {
    return 'playbook-ios'
  }
  return 'playbook-ios-beta'
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

def clearProvisioningProfiles() {
  sh "rm -rf '~/Library/MobileDevice/Provisioning Profiles'"
}

def downloadProvisioningProfiles() {
  sh 'rm -rf ./git_prov_profiles'
  sh 'git clone --depth 1 git@github.com:powerhome/ios-provisioning-profiles.git ./git_prov_profiles'
}

def checkProvisioningProfiles() {
  sh "cd ./git_prov_profiles && ./check-expire-and-install-provisioning-profiles.sh"
  sh "cd ./git_prov_profiles/profiles_macos && ./check-expire-and-install-provisioning-profiles.sh"
}

def fastlane(String command) {
  sh "asdf exec bundle exec fastlane ${command}"
}

def runTestsiPad() {
  stage('Test iPad') {
    try {
      fastlane('disable_create_gif')
      fastlane("action clear_derived_data")
      checkForFailedParallelJob()
      runDocker()
      checkForFailedParallelJob()
      fastlane("run_tests_ipad")
    }
    catch (e) { throw e }
    finally { 
      try { publishTestOutput('iPad') } catch (e) {}
      try { 'make docker-stop' } catch (e) {}
    }
  }
}

def runTestsiPhone() {
  stage('Test iPhone') {
    try {
      fastlane('disable_create_gif')
      fastlane("action clear_derived_data")
      checkForFailedParallelJob()
      runDocker()
      checkForFailedParallelJob()
      fastlane("run_tests_iphone")
    }
    catch (e) { throw e }
    finally { 
      try { publishTestOutput('iPhone') } catch (e) {}
      try { 'make docker-stop' } catch (e) {}
    }
  }
}

def runDocker(count = 1) {
  try {
    sh 'make docker'
  }
  catch (e) { 
    if (count > 3) {
      throw e
    }
    else {
      sleep(30)
      runDocker(count+1)
    }
  }
}

def runTestsMacOS() {
  stage('Test macOS') {
    try {
      fastlane('disable_create_gif')
      fastlane("action clear_derived_data")
      checkForFailedParallelJob()
      runDocker()
      checkForFailedParallelJob()
      fastlane("run_ui_tests_macos")
    }
    catch (e) { throw e }
    finally { 
      try { publishTestOutput('macOS') } catch (e) {}
      try { 'make docker-stop' } catch (e) {}
    }
  }
}

def publishTestOutput(String device) {

  def reportDir = 'DerivedData/Logs/Test'
  fastlane("create_test_report_html")
  publishHTML (target: [
    reportName: "Test Results ${device}",
    reportDir: reportDir,
    reportFiles: readFile(reportDir).findAll { it =~ /.*/ },
    keepAll: true,
    allowMissing: false,
    alwaysLinkToLastBuild: false,
  ])
}

def buildAndShipiOS(String fastlaneOpts, String target, String... distributionList) {
  stage('Build iOS') {
    // fastlane("build_ios ${fastlaneOpts}")
    withEnv([
      "BUILD_NUMBER=${buildNumber}",
      "BUILD_TARGET=${target}"]) {
        withCredentials([
          string(credentialsId: '62620542-b00d-4c1f-81dd-4d014369f07d', variable: 'GITHUB_API_TOKEN'),
          string(credentialsId: 'nitro-runway-api-token-tps-40', variable: 'RUNWAY_API_TOKEN')]) {
            sh './.jenkins/jenkins-build.sh'
        }
    }
  }
  // checkForFailedParallelJob()
  // stage('Upload iOS') {
  //   fastlane("upload_ios ${fastlaneOpts} release_notes:\"${releaseNotes}\"")
  // }
  if (distributionList.length > 0) {
    withEnv([
      "BUILD_NUMBER=${buildNumber}",
      "BUILD_TARGET=${target}",
    ]) {
      withCredentials([
        string(credentialsId: 'appcenter-token', variable: 'APP_CENTER_API_TOKEN'),
        string(credentialsId: '62620542-b00d-4c1f-81dd-4d014369f07d', variable: 'GITHUB_API_TOKEN'),
        string(credentialsId: 'nitro-runway-api-token-tps-40', variable: 'RUNWAY_API_TOKEN')]) {
          sh "./.jenkins/jenkins-distribute.sh ${distributionList.join(' ')}"
      }
    }
  }
}

def buildAndShipMacOS(String fastlaneOpts) {
  stage('Build macOS') {
    fastlane("build_macos ${fastlaneOpts}")
  }
  checkForFailedParallelJob()
  stage('Notarize macOS') {
    fastlane("notarize_macos ${fastlaneOpts}")
  }
  checkForFailedParallelJob()
  stage('Upload macOS') {
    fastlane("upload_macos ${fastlaneOpts} release_notes:\"${releaseNotes}\"")
  }
}

//

def setupKeychain() {
  withEnv([
    "BUILD_NUMBER=${buildNumber}",
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

def handleCleanup() {
  try { deleteKeychain() } catch (e) { }
  try { deleteDerivedData() } catch (e) { }
  try { deleteDir() } catch (e) { }
}

def handleFailure() {
  try { sh './.jenkins/jenkins-failed.sh' } catch (e) { }
}

def deleteKeychain() {
  withEnv([
    "BUILD_NUMBER=${buildNumber}",
  ]) {
    lock(resource: 'Nitro-iOS Keychain Search List') {
      sh './.jenkins/jenkins-keychain.sh destroy'
    }
  }
}

def deleteDerivedData(){
  fastlane("run clear_derived_data")
}

def updateBuildNumber() {
  lock(resource: 'Build Number') {
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
