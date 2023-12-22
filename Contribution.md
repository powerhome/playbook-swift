<h1 align="center">Playbook Design System iOS</h1><br />

# Feature Request

| Name | About  | Title  | Labels | Assignees |
| :---:   | :---: | :---: | :---: | :---: |
|  Feature Request | Suggest an idea for this preoject   |    

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.

<br />
<br/>

# Bug Reporting

| Name | About  | Title  | Labels | Assignees |
| :---:   | :---: | :---: | :---: | :---: |
|  Bug report | Create a report to help us improve  | 

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Desktop (please complete the following information):**
 - OS: [e.g. iOS]
 - Browser [e.g. chrome, safari]
 - Version [e.g. 22]

**Smartphone (please complete the following information):**
 - Device: [e.g. iPhone6]
 - OS: [e.g. iOS8.1]
 - Browser [e.g. stock browser, safari]
 - Version [e.g. 22]

**Additional context**
Add any other context about the problem here.

<br />
<br />

# Editing Linting, Formatting, and Auto Correction

In addition to the default linting rules, Playbook Swift enforces a indentation width of 2 spaces.

* [SwiftLint](https://github.com/realm/SwiftLint), within the `.swiftlint.yml` file, enforces the `indentation_width: 2` rule
  * View all enforced rules via `swiftlint rules` in your Terminal
* [SwiftFormat](https://github.com/nicklockwood/SwiftFormat), within the `.swiftformat` file, only allows the `indent` rule and sets it to `--indent 2`
  * To run SwiftFormat manually, use the plugin:
    * Right click `PlaybookSwift` in the Project Navigator
    * Click SwiftFormatPlugin
<br />![Alt text](swift-format-plugin.png)
    * Click Run
<br />![Alt text](swift-format-click-run.png)

These rules will also be enforced before you commit via [pre-commit](https://pre-commit.com/).

* After installing pre-commit via `brew install pre-commit && pre-commit install`, the first time you try to commit, it will take some time to install the hooks:
<br /><br />![Alt text](swift-rules.png)


* pre-commit will check for several rules and auto-corrects any violations. You will have to commit again if it finds an error. In the example below, one file did not have proper indentation which SwiftFormat detected and corrected:
<br /><br />![Alt text](swift-format-violations.png)
