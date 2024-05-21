## Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **title** | `String?` | The title for the text input. | | |
| **placeholder** | `String` | The placeholder text for the text input. | | |
| **error** | `(Bool, String)?` | Tuple indicating if there's an error and the error message. | | |
| **style** | `Style` | The style of the text input. | `.default` | `.default`, `.rightIcon`, `.leftIcon`, `.inline`, `.disabled`, `.typeahead` |
| **onChange** | `Bool?` | Indicates if there's an `onChange` event. | | |
| **text** | `Binding<String>` | The binding to the text input value. | | |
| **keyboardType** | `UIKeyboardType` | The keyboard type for iOS devices. | | `.default`, `.asciiCapable`, `.numbersAndPunctuation`, `.URL`, `.numberPad`, `.phonePad`, `.namePhonePad`, `.emailAddress`, `.decimalPad`, `.twitter`, `.webSearch`, `.asciiCapableNumberPad` |
| **selected** | `Bool` | Indicates if the text input is selected. | | |
| **isHovering** | `Bool` | Indicates if the mouse cursor is hovering over the text input. | `false` | |
| **isIconHovering** | `Bool` | Indicates if the mouse cursor is hovering over the icon of the text input. | `false` | |
