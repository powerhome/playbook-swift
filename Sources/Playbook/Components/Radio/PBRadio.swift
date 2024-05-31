//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBRadio.swift
//

import SwiftUI

public struct PBRadioItem: Identifiable, Equatable {
  public var title: String
  public var subtitle: String
  public var id: String { title }

  public init(_ title: String, subtitle: String = "") {
    self.title = title
    self.subtitle = subtitle
  }
}

public struct PBRadio: View {
  let items: [PBRadioItem]
  let orientation: Orientation
  let textAlignment: Orientation
  let spacing: CGFloat
  let padding: CGFloat
  let errorState: Bool
  @Binding var selectedItem: PBRadioItem?

  public init(
    items: [PBRadioItem],
    orientation: Orientation = .vertical,
    textAlignment: Orientation = .horizontal,
    spacing: CGFloat = Spacing.xSmall,
    padding: CGFloat = Spacing.xSmall,
    selected: Binding<PBRadioItem?>,
    errorState: Bool = false
  ) {
    self.items = items
    self.orientation = orientation
    self.textAlignment = textAlignment
    self.spacing = spacing
    self.padding = padding
    self.errorState = errorState
    self._selectedItem = selected
  }

  public var body: some View {
    switch orientation {
    case .vertical:
      VStack(alignment: .leading, spacing: spacing) {
        itemView
      }

    case .horizontal:
      HStack(spacing: spacing) {
        itemView
      }
    }
  }

  var itemView: some View {
    ForEach(items) { item in
      Button(item.title) {
        selectedItem = item
      }
      .buttonStyle(
        PBRadioButtonStyle(
          subtitle: item.subtitle,
          isSelected: selectedItem?.id == item.id,
          textAlignment: textAlignment,
          padding: padding,
          errorState: errorState
        )
      )
    }
  }
}

// MARK: - Previews

public struct PBRadio_Previews: PreviewProvider {
  public static var previews: some View {
    RadioCatalog()
  }
}
