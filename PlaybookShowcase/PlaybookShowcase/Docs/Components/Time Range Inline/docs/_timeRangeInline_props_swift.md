### Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **alignment** | `Alignment` | Sets alignment of content | `.leading` | `leading` `center` `trailing` |
| **size** | `PBFont` | Allows user to change the size of the text | `.caption` | `.subcaption` `.caption` `.body` |
| **startTime** | `String` | Allows the user to add the starting time for the time range | | |
| **endTime** | `String` | Allows the user to add the ending time for the time range | | |
| **showStartTimeZone** | `Bool` | Determines whether or not the time zone is displayed for the starting time| `false` | `true` `false` |
| **showEndTimeZone** | `Bool` | Determines whether or not the time zone is displayed for the ending time | `false` | `true` `false` |
| **showIcon** | `Bool` | Determines whether or not the clock icon is displayed | `false` | `true` `false` |
| **isTimeBold** | `Bool` | Determines whether or not the time is bold | `false` | `true` `false` |
| **isIconBold** | `Bool` | Determines whether or not the clock icon is bold | `false` | `true` `false` |
| **isArrowIconBold** | `Bool` | Determines whether or not the arrow icon is bold | `false` | `true` `false` |
| **isTimeZoneBold** | `Bool` | Determines whether or not the time zone is bold | `false` | `true` `false` |
| **isLowercase** | `Bool` | Determines whether or not am/pm is capitalized | `false` | `true` `false` |
| **startVariant** | `Variant` | Allows user to choose how they would like the starting time to be displayed | `.time` | `.time` `clockIcon` `timeZone` `.iconTimeZone` `.withTimeZoneHeader` |
| **endVariant** | `Variant` | Allows user to choose how they would like the ending time to be displayed | `.time` | `.time` `clockIcon` `timeZone` `.iconTimeZone` `.withTimeZoneHeader` |
| **zone** | `PBTime.Zones` | Allows the user to set the time zone | `.east` | `.east` `.central` `.mountain` `.pacific` `.gmt` |
