//
//  PBNav.swift
//
//
//  Created by Lucas C. Feijo on 26/07/21.
//

import SwiftUI

public struct PBNav: View {
  @Binding private var selected: Int
  @State private var currentHover: Int?
  private let variant: Variant
  private let orientation: Orientation
  private let title: String?
  private let borders: Bool
  private let highlight: Bool
  private let views: [AnyView]

  public init<Views>(
    selected: Binding<Int> = .constant(0),
    variant: Variant? = .normal,
    orientation: Orientation = .vertical,
    title: String? = nil,
    borders: Bool = true,
    highlight: Bool = true,
    @ViewBuilder content: @escaping () -> TupleView<Views>
  ) {
    views = content().getViews
    self.variant = variant ?? .normal
    self.orientation = orientation
    self.title = title
    self.borders = borders
    self.highlight = highlight
    self._selected = selected
  }

  func item(_ view: AnyView, _ index: Int) -> some View {
    let isSelected = index == selected
    let isHovering = index == currentHover

    return view
      .contentShape(Rectangle())
      .onHover { hovering in
        if hovering {
          currentHover = index
        } else if currentHover == index {
          currentHover = nil
        }
      }
      .onTapGesture {
        selected = index
      }
      .environment(\.selected, isSelected)
      .environment(\.hovering, isHovering)
      .environment(\.variant, variant)
      .environment(\.orientation, orientation)
      .environment(\.highlight, highlight)
  }

  @ViewBuilder
  var horizontalBody: some View {
    if variant == .subtle {
      HStack(spacing: variant.spacing) {
        ForEach(views.indices, id: \.self) { index in
          item(views[index], index)
        }
      }
    } else {
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: variant.spacing) {
          ForEach(views.indices, id: \.self) { index in
            item(views[index], index)
              .contentShape(Rectangle())
          }
        }
      }
    }
  }

  var verticalBody: some View {
    HStack(spacing: variant.spacing) {
      ForEach(views.indices, id: \.self) { index in
        VStack(alignment: .leading, spacing: 0) {
          item(views[index], index)

          if
            index < views.count - 1,
            borders,
            variant == .normal {
            Divider()
          }
        }
      }
    }
  }

  public var body: some View {
    VStack(alignment: .leading) {
      if let title = title {
        Text(title)
          .foregroundColor(.text(.light))
          .pbFont(.caption)
          .padding(.leading, .pbSmall)
      }

      if orientation == .vertical {
        verticalBody.tag("vertical")
      } else {
        horizontalBody.tag("horizontal")
      }
    }
  }
}

public extension PBNav {
  enum Variant {
    case normal
    case subtle

    var spacing: CGFloat {
      switch self {
      case .normal:
        return 0
      case .subtle:
        return 2
      }
    }
  }
}

public struct PBNav_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    return Group {
      PBNav(
        variant: .subtle,
        orientation: .horizontal
      ) {
        PBNavItem("File")
        PBNavItem("Edit")
        PBNavItem("View")
        PBNavItem("Find")
      }
      .previewDisplayName("Horizontal + Subtle")
      .padding()

      PBNav(
        orientation: .horizontal
      ) {
        PBNavItem("Short")
        PBNavItem("MediumText")
        PBNavItem("Titans")
      }
      .previewDisplayName("Horizontal + Normal")
      .padding()

      PBNav(
        variant: .subtle
      ) {
        PBNavItem("Rebels")
        PBNavItem("Rogue One")
        PBNavItem("Titans")
        PBNavItem("Code Blue")
      }
      .previewDisplayName("Vertical + Subtle")
      .padding()

      PBNav(
        title: "Why is this a prop?"
      ) {
        PBNavItem(
          "Humans",
          icon: PBIcon.fontAwesome(.users),
          accessory: PBIcon.fontAwesome(.angleDown)
        )
        PBNavItem("Yumm", icon: PBIcon.fontAwesome(.user))
        PBNavItem("Existence", icon: PBIcon.fontAwesome(.clock))
        PBNavItem("Escape", icon: PBIcon.fontAwesome(.rocket))
      }
      .previewDisplayName("Vertical + Normal")
      .padding()
    }
    .frame(width: 400)
    .background(Color.white)
    .preferredColorScheme(.light)
  }
}
