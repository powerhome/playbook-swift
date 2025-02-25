### Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **alignment** | `Alignment` | Sets alignment of content | `.leading` | `leading` `center` `trailing` |
| **date** | `Date` | Calculates current date | |  |
| **timeVariant** | `Variant` | Allows user to choose the style in which the time is displayed | `.time` | `.time` `.iconTimeZone` `.withTimeZoneHeader` |
| **timeZoneVariant** | `Variant` | Allows user to choose the style in which the time zone is displayed | `.time` | `.time` `.iconTimeZone` `.withTimeZoneHeader` |
| **timeZoneIdentifier** | `String` | A string value that is used in a function to get the correct time in the corrresponding time zone. This value is also used to display the time zone next to the time |  |  |
| **isLowercase** | `Bool` | Determines whether or not am/pm is capitalized | `false` | `true` `false` |
| **timeStyle** | `PBFont` | Allows user to choose the size of the time that is being displayed | `.caption` | `body` `caption` `large` `subcaption`|
| **timeZoneStyle** | `PBFont` | Allows user to choose the size of the time zone that is being displayed | `.caption` | `body` `caption` `large` `subcaption`|

