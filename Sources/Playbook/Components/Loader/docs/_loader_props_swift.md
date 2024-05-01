## Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **dotIndex** | `Int` | Value that changes the color of the dot at the first index to clear. | `0` ||
| **isAnimating** | `Bool ` | Boolean value for determining if the spinner is rotating or not. | `false` ||
| **dotsCount** | `Bool` | Value that sets the number of dots in the spinner. This will make the spinner’s size change.| `8` | `.default` `.details`|
| **dotSize** | `CGFloat` | Value that sets the size of the dots for the default spinner.| `2` ||
| **spinnerSpeed** | `TimeInterval` | Value to set the spinner’s rotation speed. | `0.1`||
| **variant** | `Variant ` | Enum value to set the different loader styles. | `.default` | `.default` `.solid`|
| **solidLoaderSize** | `CGFloat` | Value to store the size of the solid loader.| `15` ||
| **color** | `Color` | Value to set the color of the loader.| `.text(.light)` | `.text(.light)` `.text(.lighter)` `.text(.default)`|
