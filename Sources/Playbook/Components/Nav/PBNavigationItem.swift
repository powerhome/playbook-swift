//
//  PBNavigationItem.swift
//  
//
//  Created by Isis Silva on 13/07/23.
//

import SwiftUI

struct PBNavigationItem<Content: View>: View {
  @State private var isHovering = false

  var icon: NavigationIcon?
  var label: String
  var selected: Bool
  var variant: PBNavigationVariant
  var orientation: Orientation
  var onTap: () -> Void
  var content: Content?

  init(
    icon: NavigationIcon? = nil,
    label: String,
    selected: Bool,
    variant: PBNavigationVariant,
    orientation: Orientation,
    onTap: @escaping () -> Void,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.icon = icon
    self.label = label
    self.selected = selected
    self.variant = variant
    self.orientation = orientation
    self.onTap = onTap
    self.content = content()
  }

  var body: some View {
    Button(action: onTap) {
      HStack {
        icon?.iconView
        Text(label)
          .pbFont(font, color: captionForegroundColor)
      }
      .foregroundColor(captionForegroundColor)
      .frame(maxWidth: maxWidth, alignment: .leading)
      .padding(padding)
      .onHover { isHovering = $0 }
      .background(selected ? selectionBackground : nil)
      .overlay(isHovering ? hoverColor : nil)
      .background(selectionMarker)
      .cornerRadius(cornerRadius)
    }
    .buttonStyle(PlainButtonStyle())
  }

  var captionForegroundColor: Color {
    if variant == .normal, orientation == .horizontal {
      return isHovering ? .pbPrimary : .text(.default)
    }
    return (selected || isHovering) ? .pbPrimary : .text(.default)
  }

  var font: PBFont {
    if variant == .normal, orientation == .horizontal || selected {
      return .title4
    }
    return .body(.base)
  }

  var markerColor: Color {
    if isHovering || selected {
      return .pbPrimary
    } else {
      return Color(hex: 0xE4E8F0)
    }
  }

  @ViewBuilder
  var selectionMarker: some View {
    if variant == .subtle {
      EmptyView()
    } else {
      let marker = Rectangle()
        .fill(markerColor)

      if orientation == .horizontal {
        VStack(spacing: 0) {
          Spacer()
          marker
            .frame(height: 3)
            .frame(maxWidth: .infinity)
        }
      } else {
        HStack(spacing: 0) {
          marker
            .opacity(selected ? 1 : 0)
            .frame(width: 3)
          Spacer()
        }
      }
    }
  }

  var selectionBackground: some View {
    if variant == .normal, orientation == .horizontal {
      return Color.clear
    }
    return markerColor.opacity(0.1)
  }

  var cornerRadius: CGFloat {
    return variant == .normal ? 0 : 8
  }

  var maxWidth: CGFloat? {
    return orientation == .vertical ? .infinity : nil
  }

  var hoverColor: some View {
    if orientation == .horizontal, variant == .normal {
      return Color.clear
    }
    return markerColor.opacity(0.1)
  }

  var padding: CGFloat {
    return variant == .normal ? 18 : 10
  }
}

struct PBNavigationItem_Previews: PreviewProvider {
  static var previews: some View {
    List {
      PBNavigationItem(
        label: "Ola",
        selected: true,
        variant: .normal,
        orientation: .vertical,
        onTap: {}
      )

      PBNavigationItem(
        icon: .pbIcon(.fontAwesome(.addressCard)),
        label: "Ola",
        selected: true,
        variant: .normal,
        orientation: .vertical,
        onTap: {}
      )

      PBNavigationItem(
        icon: .custom(AnyView(Image(systemName: "person"))),
        label: "Ola",
        selected: true,
        variant: .normal,
        orientation: .vertical,
        onTap: {}
      )

      PBNavigationItem(
        label: "Ola",
        selected: true,
        variant: .normal,
        orientation: .horizontal,
        onTap: {}
      )

      PBNavigationItem(
        label: "Ola",
        selected: true,
        variant: .subtle,
        orientation: .horizontal,
        onTap: {}
      )

      PBNavigationItem(
        label: "Ola",
        selected: true,
        variant: .subtle,
        orientation: .vertical,
        onTap: {}
      )

      PBNavigationItem(
        icon: .pbIcon(.fontAwesome(.addressCard)),
        label: "Ola",
        selected: true,
        variant: .subtle,
        orientation: .vertical,
        onTap: {}
      )

      PBNavigationItem(
        icon: .custom(AnyView(Image(systemName: "person"))),
        label: "Ola",
        selected: true,
        variant: .subtle,
        orientation: .vertical,
        onTap: {}
      )
    }
  }
}

enum PBNavigationVariant {
  case normal
  case subtle
}
