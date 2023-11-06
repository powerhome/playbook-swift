//
//  File.swift
//
//
//  Created by Lucas C. Feijo on 30/07/21.
//

import SwiftUI

public enum NavigationIcon {
  case pbIcon(PBIcon)
  case custom(AnyView)
  case image(PBImage)

  var iconView: AnyView {
    switch self {
    case .pbIcon(let icon):
      return AnyView(icon)
    case .custom(let view):
      return AnyView(view)
    case .image(let image):
      return AnyView(
        image.image?
          .resizable()
          .frame(width: 24, height: 24)
        )
    }
  }
}

public struct PBNavItem<Content: View>: View {
  @Environment(\.selected) var isSelected: Bool
  @Environment(\.hovering) var isHovering: Bool
  @Environment(\.variant) var variant: PBNav.Variant
  @Environment(\.orientation) var orientation: Orientation
  @Environment(\.highlight) var highlight: Bool
  var label: String?
  var icon: NavigationIcon?
  var accessory: FontAwesome?
  var content: Content?

  public init(
    _ label: String? = nil,
    icon: NavigationIcon? = nil,
    accessory: FontAwesome? = nil,
    @ViewBuilder content: @escaping () -> Content = { EmptyView() }
  ) {
    self.label = label
    self.icon = icon
    self.accessory = accessory
    self.content = content()
  }

  public var body: some View {
    HStack(spacing: Spacing.xSmall) {
      if let label = label {
        icon?.iconView
          .frame(width: 25)
          .foregroundColor(iconColor)

        Text(label)
          .pbFont(font, color: captionForegroundColor)

        if orientation == .vertical {
          Spacer()
        }

        if let accessory = accessory {
          PBIcon( accessory, size: .small)
            .foregroundColor(captionForegroundColor)
            .frame(width: 25)
        }
      } else {
        content
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .foregroundColor(captionForegroundColor)
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, verticalPadding)
    .background(backgroundColor)
    .cornerRadius(cornerRadius)
    .overlay(
      selectionIndicator,
      alignment: selectionIndicatorAlignment
    )
    .overlay {
      textView
    }
  }
  @ViewBuilder
  var textView: some View {
    if orientation == .horizontal, variant == .bold {
      Text(label ?? "")
        .pbFont(isSelected ? .title4 : .body, color: captionBoldForegroundColor)
    }
  }
}

extension PBNavItem {
  var iconColor: Color {
    ((isSelected && variant == .normal) || isHovering) ? .pbPrimary : .text(.lighter)
  }

  var hoverBackgroundColor: Color {
    if variant == .normal && orientation == .horizontal {
      return .clear
    }
    return .pbPrimary
  }

  var selectionIndicatorAlignment: Alignment {
    if orientation == .vertical {
      return .leading
    }
    return .bottom
  }

  var iconForegroundColor: Color {
    if variant == .normal && orientation == .horizontal {
      if isHovering {
        return .pbPrimary
      }
      return .text(.default)
    }

    if isSelected || isHovering {
      return .pbPrimary
    }
    return .text(.lighter)
  }

  var captionForegroundColor: Color {
    if variant != .bold {
      if variant == .normal && orientation == .horizontal {
        if isHovering {
          return .pbPrimary
        }
        return .text(.default)
      }

      if isSelected || isHovering {
        return .pbPrimary
      }
    } else {
      if orientation == .horizontal {
        return .clear
      } else {
        if isSelected {
          return .white
        }
      }
    }
    return .text(.default)
  }

  var captionBoldForegroundColor: Color {
    if variant == .bold, orientation == .horizontal {
      if isSelected {
        return .white
      } else if isHovering {
        return .pbPrimary
      }
      else {
        return .text(.default)
      }
    } else {
      return Color.clear
    }
  }

  var font: PBFont {
    if isSelected, variant != .subtle {
      if variant == .bold, orientation == .vertical {
        return .title4
      } else if variant == .bold, orientation == .horizontal {
        return .body
      }
      return .title4
    } else if variant == .normal, orientation == .horizontal {
      return .title4
    }
      else {
      return .body
    }
  }

  var backgroundColor: Color {
    if variant != .bold {
      if isSelected, isHovering, highlight {
        return hoverBackgroundColor.opacity(0.08)
      }
      if isSelected || isHovering, highlight {
        return hoverBackgroundColor.opacity(0.03)
      }
    } else {
      if isSelected {
        return .pbPrimary
      }
      if isHovering {
        return .hover
      }
    }
    return .clear
  }

  var cornerRadius: CGFloat {
    switch variant {
    case .normal:
      return 0
    case .subtle, .bold:
      return BorderRadius.medium
    }
  }

  var horizontalPadding: CGFloat {
    switch variant {
    case .normal:
      switch orientation {
      case .horizontal: return Spacing.medium
      case .vertical: return Spacing.small
      }

    case .subtle, .bold:
      switch orientation {
      case .horizontal: return 14
      case .vertical: return 14
      }
    }
  }

  var verticalPadding: CGFloat {
    switch variant {
    case .normal: return Spacing.small
    case .subtle, .bold: return Spacing.xSmall
    }
  }

  var selectionIndicator: some View {
    Group {
      if orientation == .vertical {
        Rectangle()
          .frame(maxWidth: variant == .normal ? 3 : 0)
          .foregroundColor(isSelected ? .pbPrimary : .clear)
      } else {
        Rectangle()
          .frame(height: variant == .normal ? 3 : 0)
          .foregroundColor(isSelected ? .pbPrimary : .shadow)
      }
    }
  }
}

struct PBNavItem_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    let item = PBNavItem(
      "Users Item",
      icon: .pbIcon(.fontAwesome(.addressCard))
    )

    let allItemCombinations = Group {
      item
        .environment(\.selected, false)
        .environment(\.hovering, false)
      item
        .environment(\.selected, false)
        .environment(\.hovering, true)
      item
        .environment(\.selected, true)
        .environment(\.hovering, false)
      item
        .environment(\.selected, true)
        .environment(\.hovering, true)
    }

    return List {
      Section("Normal Variant Horizontal") {
        HStack { allItemCombinations }
          .environment(\.orientation, .horizontal)
      }

      Section("Normal Variant Vertical") {
        VStack { allItemCombinations }
      }
    }
  }
}
