## Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **avatar** | `AnyView` | Value for the avatar displayed next to the message. | `nil` ||
| **label** | `String ` | Value for the message label. | `””` ||
| **message** | `AttributedString` | Value that holds the message string.| `nil` ||
| **timestamp** | `Date` | Value that shows the time that the message was sent.| `nil` ||
| **timestampAlignment** | `TimestampAlignment` | Value to set the alignment of the timestamp. | `.trailing`| `leading` `trailing`|
| **timestampVariant** | `PBTimestamp.Variant` | Enum value that allows the user to choose the style of timestamp to be displayed.| `.standard` | `elapsed` `standard` `updated` `hideUserElapsed`|
| **changeTimeStampOnHover** | `Bool ` | Hover state value that changes the style of the timestamp when cursor is hovering over it. | `false` | `true` `false`|
| **verticalPadding** | `CGFloat` | Value to store the size of vertical padding around the message container.| `Spacing.none` | `none` `xxSmall` `xSmall``small` `medium` `large` `xLarge`|
| **horizontalPadding** | `CGFloat` | Value to store the size of horizontal padding around the message container.| `Spacing.none` | `none` `xxSmall` `xSmall``small` `medium` `large` `xLarge|
| **isLoading** | `Bool` | Boolean value to change loading state.| `false` ||
| **isHovering** | `Bool` | Boolean value to change hover state. | `false`||
