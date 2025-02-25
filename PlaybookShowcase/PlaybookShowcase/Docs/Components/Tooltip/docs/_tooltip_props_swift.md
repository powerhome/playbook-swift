### Props
| Name | Type | Description | Default | Values |
| --- | ----------- | --------- | --------- | --------- |
| **canPresent** | `Bool` | Boolean that determines whether or not the tooltip will be displayed | `false` | `true` `false` |
| **delay** | `TimeInterval` | Determines how long the tootip will be displayed | `0.0` | |
| **delayType** | `DelayType` |An enum for the different types of delays | `.all` | `all` `open` `close` |
| **icon** | `FontAwesome` | Allows the user to add an icon to the the tooltip | | `paperplane` |
| **placement** | `Edge` | Determines the placement of the tooltip| `.top` | `top` `bottom`  `left` `right`|
| **text** | `String` | Allows user to add a message to the tooltip | | |
| **delayCompleted** | `Bool` | A State var that is used to determine if the tooltip delay is complete  | `false` | `true` `false` |
| **presentPopover** | `Bool` | A State var that is used to determine if the tooltip should be displayed or not | `false` | `true` `false` |
| **shouldPresentPopover** | `Bool` |A State var that is used to determine if the tooltip should be diplayed | `false` | `true` `false` |
| **workItems** | `[DispatchWorkItem?]` | A State var that is used to handle the different states of the tooltip | `[]` |  |
| 
