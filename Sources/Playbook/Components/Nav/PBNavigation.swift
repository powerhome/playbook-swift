//
//  PBNavigation.swift
//  Playbook
//
//  Created by Lucas C. Feijo on 14/06/22.
//

import SwiftUI

public enum PBNavigationOrientation {
  case horizontal
  case vertical
}

public enum PBNavigationVariant {
  case normal
  case subtle
}

struct PBNavigationItem<Content: View>: View {
  @State var isHovering: Bool = false
  var selected: Bool
  var variant: PBNavigationVariant
  var orientation: PBNavigationOrientation
  var onTap: () -> Void
  var content: () -> Content

  var markerColor: Color {
    if isHovering {
      return Color.pbPrimary
    }
    if selected {
      return Color.pbPrimary
    } else {
      return Color(hex: 0xE4E8F0)
    }
  }

  @ViewBuilder
  var selectionMarker: some View {
    if variant == .subtle { EmptyView() } else {
      let marker = Rectangle()
        .fill(markerColor)

      if orientation == .horizontal {
        VStack(spacing: Spacing.none) {
          Spacer()
          marker
            .frame(height: 3)
            .frame(maxWidth: .infinity)
        }
      } else {
        HStack(spacing: Spacing.none) {
          marker
            .opacity(selected ? 1 : 0)
            .frame(width: 3)
          Spacer()
        }
      }
    }
  }

  var selectionBackground: some View {
    if
      variant == .normal,
      orientation == .horizontal {
      return Color.clear
    }
    return markerColor.opacity(0.1)
  }

  var cornerRadius: CGFloat {
    if variant == .normal {
      return 0
    } else {
      return 8
    }
  }

  var maxWidth: CGFloat? {
    orientation == .vertical ? .infinity : nil
  }

  var hoverColor: some View {
    if
      orientation == .horizontal,
      variant == .normal {
      return Color.clear
    }
    return markerColor.opacity(0.1)
  }

  var padding: CGFloat {
    if variant == .normal {
      return 18
    } else {
      return 10
    }
  }

  struct PBNavigationLabelStyle: LabelStyle {
    var selected: Bool
    var variant: PBNavigationVariant
    var orientation: PBNavigationOrientation
    var isHovering: Bool

    var captionForegroundColor: Color {
      if
        variant == .normal,
        orientation == .horizontal
      {
        if isHovering {
          return .pbPrimary
        }
        return .text(.default)
      }

      if selected || isHovering {
        return .pbPrimary
      }
      return .text(.default)
    }

    var font: PBFont {
      if
        variant == .normal,
        orientation == .horizontal || selected {
        return .title4
      }
      return .body
    }

    func makeBody(configuration: Configuration) -> some View {
      HStack {
        configuration.icon
          .foregroundColor(captionForegroundColor)
        configuration.title
          .pbFont(font)
          .foregroundColor(captionForegroundColor)
      }
    }
  }

  var body: some View {
    Button(action: onTap) {
      content()
        .labelStyle(
          PBNavigationLabelStyle(
            selected: selected,
            variant: variant,
            orientation: orientation,
            isHovering: isHovering
          )
        )
        .frame(maxWidth: maxWidth, alignment: .leading)
        .padding(padding)
        .onHover { isHovering = $0 }
        .background(selected ? selectionBackground : nil)
        .overlay(isHovering ? hoverColor : nil)
        .background(selectionMarker)
        .cornerRadius(cornerRadius)
    }
    .buttonStyle(.plain)
  }
}

public struct PBNavigation<Option: Equatable & Identifiable, Content: View>: View {
  public init(
    _ options: [Option],
    selected: Binding<Option>,
    variant: PBNavigationVariant = .normal,
    orientation: PBNavigationOrientation = .vertical,
    @ViewBuilder renderOption: @escaping (Option) -> Content
  ) {
    self.options = options
    self.selected = selected
    self.variant = variant
    self.orientation = orientation
    self.renderOption = renderOption
  }

  var options: [Option]
  var selected: Binding<Option>
  var variant: PBNavigationVariant
  var orientation: PBNavigationOrientation
  var border: Bool = true
  var renderOption: (Option) -> Content

  func item(_ option: Option) -> some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      HStack(spacing: Spacing.none) {
        PBNavigationItem(
          selected: selected.wrappedValue == option,
          variant: variant,
          orientation: orientation,
          onTap: { selected.wrappedValue = option },
          content: { HStack { renderOption(option) } }
        )
      }

      if orientation == .vertical, variant == .normal, border {
        Divider()
      }
    }
  }

  var items: some View {
    ForEach(options) { option in
      item(option)
    }
  }

  var spacing: CGFloat { return variant == .normal ? Spacing.none : 2 }

  public var body: some View {
    if orientation == .horizontal {
      HStack(spacing: spacing) {
        items
      }
    } else {
      VStack(spacing: spacing) {
        items
      }
    }
  }
}

struct PBNavigation_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return NavigationCatalog()
  }
}
