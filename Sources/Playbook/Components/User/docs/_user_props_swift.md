
## Props
| Name            | Type                           | Description                                                   | Default      | Values                               |
|-----------------|--------------------------------|---------------------------------------------------------------|--------------|--------------------------------------|
| **name**        | `String`                       | The name of the user.                                          | `""`         ||
| **displayAvatar**| `Bool`                        | Boolean that determines whether the avatar is displayed.       | `true`       | `true`, `false`                      |
| **image**       | `Image?`                       | An optional image to display as the user's avatar.             | `nil`        ||
| **orientation** | `Orientation`                  | The orientation of the user's information.                     | `.horizontal`| `.horizontal`, `.vertical`           |
| **size**        | `UserAvatarSize`               | The size of the user's avatar.                                 | `.medium`    | `.small`, `.medium`, `.large`        |
| **territory**   | `String?`                      | The territory information of the user.                         | `nil`        ||
| **title**       | `String?`                      | The title information of the user.                             | `nil`        ||
| **subtitle**    | `AnyView?`                     | An optional subtitle view for additional user information.     | `nil`        ||
| **status**      | `PBAvatar.PresenceStatus?`     | The presence status of the user.                               | `.none`      | `.none`, other `PBAvatar.PresenceStatus` values |
