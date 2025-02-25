##Props
| Name            | Type                        | Description                                    | Default  | Values                               |
|-----------------|-----------------------------|------------------------------------------------|---------------|--------------------------------------|
| **selected**    | `Binding<Int>`  | The index of the selected navigation item.    | `.constant(0)` | |
| **currentHover**  | `Int?` | Determines whether the navigation item is being hovered over. | |  |
| **variant**     | `Variant?`  The variant style of the navigation view.     | `.normal`     | `.normal`, `.subtle`, `.bold`       |
| **orientation** | `Orientation` | The orientation of the navigation items.      | `.vertical`   | `.vertical`, `.horizontal`  |
| **title**  | `String?` | The title of the navigation view.  | `nil`    |
| **borders**     | `Bool`  | Determines whether to show borders between navigation items. | `true` | `true`, `false`  |
| **highlight**   | `Bool`  | Determines whether to highlight the selected navigation item. | `true` | `true`, `false`  |
| **content** | `() -> TupleView<Views>`   | The content builder for navigation items.     |  |  |
| **label** | `String?`           | The label text of the navigation item.        | `nil`  |  |
| **icon**   | `NavigationIcon?`   | The icon of the navigation item.              | `nil`  |  |
| **accessory**   | `FontAwesome?`     | An optional icon for the navigation item.    | `nil`    |  |
