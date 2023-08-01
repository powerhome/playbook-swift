//
//  PBRadioButtonStyle.swift
//
//
//  Created by Israel Molestina on 6/20/23.
//

import SwiftUI

public struct PBRadioButtonStyle: ButtonStyle {
  private let subtitle: String
  private let isSelected: Bool
  private let textAlignment: Orientation
  private let padding: CGFloat
  private let errorState: Bool

  private var borderColor: Color {
    if errorState {
      return isSelected ? .pbPrimary : .red
    } else {
      return isSelected ? .pbPrimary : .border
    }
  }

  private var lineWidth: CGFloat {
    isSelected ? 6 : 2
  }

  public init(
    subtitle: String?,
    isSelected: Bool,
    textAlignment: Orientation,
    padding: CGFloat,
    errorState: Bool
  ) {
    self.isSelected = isSelected
    self.subtitle = subtitle ?? ""
    self.textAlignment = textAlignment
    self.padding = padding
    self.errorState = errorState
  }

  public func makeBody(configuration: Configuration) -> some View {
    switch textAlignment {
    case .horizontal:
      HStack(alignment: .top, spacing: padding) {
        Circle()
          .strokeBorder(borderColor, lineWidth: lineWidth)
          .frame(width: 22, height: 22)
        VStack(alignment: .leading, spacing: Spacing.xxSmall) {
          configuration.label
            .foregroundColor(errorState == true ? .status(.error) : .text(.default))
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
    case .vertical:
      VStack {
        Circle()
          .strokeBorder(borderColor, lineWidth: lineWidth)
          .frame(width: 22, height: 22)
        VStack(alignment: .leading, spacing: Spacing.xxSmall) {
          configuration.label
            .foregroundColor(errorState == true ? .status(.error) :  .text(.default))
            .pbFont(.body())
            .frame(minHeight: 22)
        }
      }
      .contentShape(Rectangle())
    }

  }
}
