## Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **title** | `String?` | The title of the select component. | `nil` | |
| **options** | `[(value: String, text: String?)]` | An array of options for the select component. | | |
| **style** | `Variant` | The style variant of the select component. | `.default` | `.default`, `.disabled`, `.error(String?)` |
| **selectedOption** | `(String) -> Void` | A closure to handle selection changes. | | |
| **selected** | `String` | The currently selected value of the select component. | | |
