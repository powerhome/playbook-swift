### Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **text** | `String?` | The text to display in the separator. | `nil` | |
| **orientation** | `Orientation` | The orientation of the separator. | `.horizontal` | `.horizontal`, `.vertical` |
| **variant** | `Variant` | The style variant of the separator. | `.card` | `.dashed`, `.card` |
| **dividerOpacity** | `CGFloat?` | The opacity of the divider line. | `1` | |
| **margin** | `CGFloat` | The margin around the separator. | `Spacing.xSmall` | |
| **content** | `() -> Content?` | A closure returning the content view of the separator. | `{ nil }` | |
