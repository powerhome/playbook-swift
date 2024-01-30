<h1 align="center">Playbook Swift Contribution Guidelines</h1><br />

# Feature Request
Before submitting a feature request be sure to review our [issue history](https://github.com/powerhome/PlaybookSwift/issues?q=is%3Aissue+) to confirm that your request is unique or not already in progress. 
When you're ready to submit, be sure to use the following template: 

| Name | About  | Title  | Labels | Assignees |
| :---:   | :---: | :---: | :---: | :---: |
|  Feature Request | Suggest an idea for this preoject   |    

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex: I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.

<br />
<br/>

# Bug Reporting
Like Feature Requests, before submitting a bug report, be sure to review our [issue history](https://github.com/powerhome/PlaybookSwift/issues?q=is%3Aissue+) to confirm that your bug fix is not already resolved or in progress.
When you're ready to submit, be sure to use the following template: 

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
<br />![swift-format-plugin](https://github.com/powerhome/PlaybookSwift/assets/60269827/fa5fdfcc-b430-46f4-b8cd-0b6f1758bbd0)
    * Click Run
<br />![swift-format-click-run](https://github.com/powerhome/PlaybookSwift/assets/60269827/6f55d10a-39a3-43fc-8b66-6134f4186bea)


These rules will also be enforced before you commit via [pre-commit](https://pre-commit.com/).

* After installing pre-commit via `brew install pre-commit && pre-commit install`, the first time you try to commit, it will take some time to install the hooks:
<br /><br />![swift-rules](https://github.com/powerhome/PlaybookSwift/assets/60269827/43860663-900b-4ffc-9636-cc1770343efc)



* pre-commit will check for several rules and auto-corrects any violations. You will have to commit again if it finds an error. In the example below, one file did not have proper indentation which SwiftFormat detected and corrected:
<br /><br />![swift-format-violations](https://github.com/powerhome/PlaybookSwift/assets/60269827/80d86b5b-bfdc-4be5-a10b-1744772f3d99)


<br />
<br />

# Pull Requests

When submitting a pull request use the following template: 
## Summary
- [First bullet point must be a **_short_** overall summary]

## Additional Details
- [Runway Story]
- [Optional: add more details]

## Screenshots (for UI stories: show before/after changes)

| Before                            | After                             |
| --------------------------------- | --------------------------------- |
| [Before Pic]                      | [After Pic]                       |

## Breaking Changes

[Yes/No (Explain)]

## Testing

[Insert testing details or N/A]

## Checklist

- [ ] **LABELS** - Add a label: `breaking`, `bug`, `improvement`, `documentation`, or `enhancement`. See [Labels](https://github.com/powerhome/playbook-apple/labels) for descriptions.
- [ ] **SCREENSHOTS** - Please add a screenshot or two. For UI changes, you MUST provide before and after screenshots.
- [ ] **RELEASES** - Add the appropriate label: `Ready for Testing` / `Ready for Release`
- [ ] **TESTING** - Have you tested your story?
