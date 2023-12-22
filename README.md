# Playbook Swift Design System 📱

Playbook Swift is the SwiftUI version of [Playbook](https://playbook.powerapp.cloud/), optimizing Playbook's designs for iOS & macOS apps. With Playbook Swift, all of Playbook's design components are now replicated for Apple's devices.

Built and maintained by the User Experience Team at [Power Home Remodeling](https://www.techatpower.com/).

>This project uses [FontAwesome Pro](https://fontawesome.com/icons) icons and the [Proxima Nova](https://www.marksimonson.com/fonts/view/proxima-nova) font, both of which are licensed by Power Home Remodeling and used for demonstrative purposes. Consumers of this project are required to secure >their own license for use.

## Installation

Follow our [installation guide](link here) to setup Playbook Swift in your project.

### Prerequisites

- [Xcode 15](https://developer.apple.com/xcode/)
- [Homebrew](https://brew.sh/)

### Playbook Swift can be added via the Swift Package Manager

<!--![Package Manager Popup](pkgmgr-pop.png)-->
<img src="pkgmgr-pop.png" height=200px />

1. Search for: `git@github.com:powerhome/PlaybookSwift.git`
1. Choose `Add Package`
2. In Xcode, Choose `Packages > Resolve Package Versions`
   <!-- ![Alt text](xcode-resolve-deps.png)-->
3. In your Swift view file:
    ```swift
    import Playbook
    ```
5. Build the project

### Install [`pre-commit`](https://pre-commit.com/#install) via `brew install pre-commit`
  1. In the Playbook Swift root directory, run `pre-commit install` to set up the git hook scripts

### Note: YAML Configuration Files

- You may need to add the package like so:

```yaml
packages:
  Playbook:
    url: git@github.com:powerhome/PlaybookSwift.git
    version x.x.x // Where x.x.x is the desired version
```

## Component Examples via demo app (PlaybookShowcase)

Playbook Swift contains the app named `PlaybookShowcase`; providing examples of each component. PlaybookShowcase can be launched within the XCode simulator, side-loaded, or downloaded to your device.

<img src="./playbook-showcase.png" height="500px" />



# Contributions

Want to contribute to Playbook Swift? Check out our [contribution guidelines](Contributions.md) to better understand how you can help grow our library.


