//
//  PBRadio.swift
//
//
//  Created by mpc on 8/9/21.
//

import SwiftUI

// MARK: - PBRadioItem

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
  @Binding var selectedItem: PBRadioItem?

  public init(items: [PBRadioItem], orientation: Orientation = .vertical, selected: Binding<PBRadioItem?>) {
    self.items = items
    self.orientation = orientation
    _selectedItem = selected
  }

  public var body: some View {
    switch orientation {
    case .vertical:
      VStack(alignment: .leading, spacing: Spacing.medium) {
        ForEach(items) { item in
          Button(item.title) {
            selectedItem = item
          }
          .buttonStyle(PBRadioButtonStyle(subtitle: item.subtitle, isSelected: selectedItem?.id == item.id))
        }
      }

    case .horizontal:
      HStack {
        ForEach(items) { item in
          Button(item.title) {
            selectedItem = item
          }
          .buttonStyle(PBRadioButtonStyle(subtitle: item.subtitle, isSelected: selectedItem?.id == item.id))
        }
      }
      .padding()
    }
  }
}

// MARK: - PBRadioButtonStyle

public struct PBRadioButtonStyle: ButtonStyle {
  private let subtitle: String
  private let isSelected: Bool

  private var borderColor: Color {
    isSelected ? .pbPrimary : .border
  }

  private var lineWidth: CGFloat {
    isSelected ? 6 : 2
  }

  public init(subtitle: String?, isSelected: Bool) {
    self.isSelected = isSelected
    self.subtitle = subtitle ?? ""
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .top) {
      Circle()
        .strokeBorder(borderColor, lineWidth: lineWidth)
        .frame(width: 22, height: 22)
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
        configuration.label
          .foregroundColor(.text(.default))
          .pbFont(.body())
          .frame(minHeight: 22)
        if !subtitle.isEmpty {
          Text(subtitle)
            .foregroundColor(.text(.light))
            .pbFont(.subcaption)
        }
      }
    }
    .contentShape(Rectangle())
  }
}

// MARK: - Previews

public struct PBRadio_Previews: PreviewProvider {
  public static var previews: some View {
    RadioCatalog()
  }
}
