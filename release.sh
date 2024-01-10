#!/bin/bash

# Description
# Only for use by admins.
# This script automates 90% of the release process for you.
# It will create the necessary tag, release, and PRs based on your input.

# Prerequisites

# `gh` GitHub CLI brings GitHub to your terminal. Free and open source. https://cli.github.com
# `brew install gh`

# `yq` a lightweight and portable command-line YAML, JSON and XML processor. https://github.com/mikefarah/yq
# `brew install yq`

# Useage
# ./release.sh

MAIN_BRANCH="main"

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

function createPRWithVersionUpdate {
  # It should confirm that the release has been created in Github and print the URL
  pbSwiftBranch="$newVersion-release"
  git checkout -b $pbSwiftBranch
  git commit -am "Release $newVersion"
  git push -u origin $pbSwiftBranch
  gh pr create --title "[PBIOS-$rwStoryId] $newVersion-release"
}

function verifyIfReleaseVersionIsUpdated {
  currentPR=$(gh pr list|grep "PBIOS-$rwStoryId")
  if [ -z "$currentPR" ]
  then
    echo "Please make sure the PR is merged so you can continue with the release."
    echo "When you are ready, choose Yes!"
    select c in Continue Cancel
    do
      case $c in "Continue")
      echo "Great! Let's create $newVersion release!" 
      return
    ;;
    "Cancel")
    echo "Merge $pbSwiftBranch PR to continue with the relese."
    verifyIfReleaseVersionIsUpdated
    ;;
    *)
    echo "Invalid entry."
    exit 1
    ;;
    esac
  done
  fi
}

function createRelease {
  # It should confirm that the release has been created in Github and print the URL
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
  description=$releaseLink

  cd ../connect-apple
  git commit -am "Update PlaybookSwift version"
  git push -u origin $connectAppleBranch
  gh repo sync -b $connectAppleBranch

  title="PBIOS-$rwStoryId"
  connectApplePR=$(gh pr create -a @me -B main -b $description -t \"$title\")
  echo $connectApplePR
}

function setupConnect {
  confirmUpdateConnect
  updateConnect
  confirmCreateConnectPR
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
createPRWithVersionUpdate
verifyIfReleaseVersionIsUpdated
createRelease
setupConnect
createRunwayComment
allDone

exit 1