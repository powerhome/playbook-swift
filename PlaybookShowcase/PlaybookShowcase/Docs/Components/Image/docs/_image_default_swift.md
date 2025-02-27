```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
    VStack(alignment: .leading) {
      Text(size.name).pbFont(.detail(true), color: .text(.default))
      PBImage(
        image: nil,
        placeholder: Image("Forest"),
        size: size,
        rounded: .sharp
      )
    }
  }
VStack(alignment: .leading) {
  Text("None").pbFont(.detail(true), color: .text(.default))
  PBImage(image: Image("Forest"))
  }
}
```
