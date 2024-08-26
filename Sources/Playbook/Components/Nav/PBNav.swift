//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBNav.swift
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
      .onHover(disabled: false) { hovering in
        if hovering {
          currentHover = index
        } else if currentHover == index {
          currentHover = nil
        }
      }
      .onTapGesture { selected = index }
      .environment(\.selected, isSelected)
      .environment(\.hovering, isHovering)
      .environment(\.variant, variant)
      .environment(\.orientation, orientation)
      .environment(\.highlight, highlight)
     
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      if let title = title {
        Text(title)
          .pbFont(.caption)
          .padding(.leading, Spacing.small)
          .padding(.bottom, Spacing.small)
      }
      if orientation == .vertical {
        verticalBody
      } else {
        horizontalBody
      }
    }
  }
}

public extension PBNav {
  enum Variant {
    case normal
    case subtle
    case bold
  
    var spacing: CGFloat {
      switch self {
      case .normal:
        return 0
      case .subtle, .bold:
        return 2

      }
    }
  }

  @ViewBuilder
  var horizontalBody: some View {
    HStack(spacing: variant.spacing) {
      ForEach(views.indices, id: \.self) { index in
        item(views[index], index)
          .scaledToFill()
          .contentShape(Rectangle())
      }
    }
  }

  var verticalBody: some View {
    ForEach(views.indices, id: \.self) { index in
      VStack(alignment: .leading, spacing: Spacing.none) {
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

public struct PBNav_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return NavCatalog()
  }
}
