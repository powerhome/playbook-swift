#!/bin/bash

MAIN_BRANCH="PBIOS-234"

currVersion=""
newVersion=""
rwStoryId=""
connectApplePR=""
releaseLink=""
pbSwiftBranch=""
connectAppleBranch=""
currBranch=$(git rev-parse --abbrev-ref HEAD)

if [[ $currBranch != $MAIN_BRANCH ]]
then
  echo "You must be on the $MAIN_BRANCH branch to continue. Tchau!"
  exit 1
fi

function confirmBegin {
  # It should prompt the dev with a message that they are about to create a new release and confirm to continue
  echo "You are about to create a new PlaybookSwift release. Ready to begin?"
  select yn in Yes No
  do
    case $yn in "Yes")
    echo "Great! Let's get started."
    return
    ;;
    "No")
    echo "Tchau!"
    exit 1
    ;;
    *)
    echo "Invalid entry."
    exit 1
    ;;
    esac
  done
}

function getCurrentVersion {
  currVersion=$(yq '.targets.Playbook-iOS.settings.base.MARKETING_VERSION' project.yml)
}

function promptVersion {
  # It should prompt dev to input the version number in this format X.X.X per SemVer rules
  echo "Current version is ${currVersion}. Please enter the new version number:"
  read v
  newVersion=$v
  echo "Okay. We will create PlaybookSwift version $newVersion."
}

function updateMarketingVersion {
  # It should update the MARKETING_VERSION in the project and create a new commit then push to main
  yq -i ".targets.Playbook-iOS.settings.base.MARKETING_VERSION = \"$newVersion\"" project.yml
  yq -i ".targets.Playbook-macOS.settings.base.MARKETING_VERSION = \"$newVersion\"" project.yml
  sed -i '' -e "s/MARKETING_VERSION = .*;/MARKETING_VERSION = $newVersion;/" ./PlaybookShowcase/PlaybookShowcase.xcodeproj/project.pbxproj
}

function createRelease {
  # It should confirm that the release has been created in Github and print the URL
  pbSwiftBranch="$newVersion-release"
  git checkout -b $pbSwiftBranch
  git commit -am "Release $newVersion"
  git push -u origin $pbSwiftBranch
  gh repo sync -b $pbSwiftBranch
  releaseLink=$(gh release create $newVersion --generate-notes)
  echo $releaseLink
}

function confirmUpdateConnect {
  # It should prompt the dev with a message that they are about to make changes to connect-apple repo and confirm to continue
  echo "Ready to create the version update in connect-apple?"
  select yn in Yes No
  do
    case $yn in "Yes")
    echo "Great! Let's get started."
    return
    ;;
    "No")
    echo "Tchau!"
    exit 1
    ;;
    *)
    echo "Invalid entry."
    exit 1
    ;;
    esac
  done
}

function updateConnect {
  cd ../connect-apple

  # It should prompt the dev to input the Runway story ID
  echo "Please enter the Runway story ID (e.g. 123):"
  read id # we need to validate this to only be numerical!
  rwStoryId=$id

  # It create a new branch and confirm to continue
  connectAppleBranch="PBIOS-$rwStoryId-PlaybookSwift-update-$newVersion"
  git checkout -b $connectAppleBranch

  yq -i ".packages.Playbook.version = \"$newVersion\"" project_setup.yml

  echo "Please review and build connect-apple to ensure it is working locally."
  echo "Once completed, press ENTER"
  read c
}

function confirmCreateConnectPR {
  # TODO: this is very difficult to escape propery...
  # description=$(cd ../PlaybookSwift && gh release view --json body|jq '.body')
  description=$releaseLink

  cd ../connect-apple
  git commit -am "Update PlaybookSwift version"
  git push -u origin $connectAppleBranch
  gh repo sync -b $connectAppleBranch

  # TODO: title is a PITA even when I try to escape spaces, it complains 🤷‍♂️
  # title="[PBIOS-$rwStoryId] Update PlaybookSwift Version"
  title="PBIOS-$rwStoryId"
  connectApplePR=$(gh pr create -a @me -B main -b $description -t \"$title\")
  echo $connectApplePR
}

function createRunwayComment {
  echo "TODO: create runway comment?"
}

function allDone {
  echo "Please remember to create a comment with your PR link here: https://nitro.powerhrg.com/runway/backlog_items/PBIOS-$rwStoryId"
  echo "PlaybookSwift release url: $releaseLink"
  echo "connect-apple PR url: $connectApplePR"
}

confirmBegin
getCurrentVersion
promptVersion
updateMarketingVersion
createRelease
confirmUpdateConnect
updateConnect
confirmCreateConnectPR
createRunwayComment
allDone

exit 1