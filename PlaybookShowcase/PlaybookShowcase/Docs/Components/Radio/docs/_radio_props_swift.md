## Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **items** | `[PBRadioItem]` | An array of radio items to display. | | |
| **orientation** | `Orientation` | The orientation of the radio items layout. | `.vertical` | `.vertical`, `.horizontal` |
| **textAlignment** | `Orientation` | The orientation of the text next to the  radio items. | `.horizontal` | `.horizontal`, `.vertical` |
| **spacing** | `CGFloat` | The spacing between radio items. | `Spacing.xSmall` | |
| **padding** | `CGFloat` | The padding around the radio items. | `Spacing.xSmall` | |
| **errorState** | `Bool` | Indicates whether the radio group is in an error state. | `false` | `true`, `false` |
| **selectedItem** | `Binding<PBRadioItem?>` | A binding to track the selected radio item. | | |
| **subtitle** | `String?` | The subtitle text displayed below the radio button label. | `""` | |
| **isSelected** | `Bool` | Indicates whether the radio button is selected. | | |
| **title** | `String` | The main title of the radio item. | | |
| **subtitle** | `String` | The subtitle of the radio item. | `""` | |
| **id** | `String` | The idof the radio item. | | |
