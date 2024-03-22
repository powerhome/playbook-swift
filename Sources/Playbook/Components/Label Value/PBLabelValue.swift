//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBLabelValue.swift
//

import SwiftUI

public struct PBLabelValue: View {
  private let label: String
  private let value: String?
  private let variant: Variant?
  private let icon: PlaybookGenericIcon?
  private let description: String?
  private let title: String?
  private let date: Date?
  private let active: Bool?

  public init(
    _ label: String,
    _ value: String? = nil,
    variant: Variant? = .default,
    icon: PlaybookGenericIcon? = nil,
    description: String? = nil,
    title: String? = nil,
    date: Date? = nil,
    active: Bool? = false
  ) {
    self.label = label
    self.value = value
    self.variant = variant
    self.icon = icon
    self.description = description
    self.title = title
    self.date = date
    self.active = active
  }

  public var body: some View {
    let textVariant: Typography.Variant = active == true ? .link : .none
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      Text(label)
        .padding(.bottom, 5.3)
        .pbFont(.caption)

      if variant == .details {
        HStack(spacing: Spacing.xSmall) {
          if let icon = icon {
            PBIcon(icon, size: .small)
              .foregroundColor(.text(.light))
          }
          if let description = description {
            Text(description)
              .foregroundColor(.text(.light))
              .pbFont(.body)
          }
          if let title = title {
            Text(title)
              .pbFont(.title4, variant: textVariant)
          }
          if let date = date {
            Text(formatDate(date))
              .pbFont(.title4, variant: textVariant)
          }
        }
      } else {
        if let value = value {
          Text(value)
            .foregroundColor(.text(.default))
            .pbFont(.body)
        }
      }
    }
  }
}

public extension PBLabelValue {
  enum Variant {
    case `default`
    case details
  }

  func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd"
    return "· " + formatter.string(from: date)
  }
}

public struct PBLabelValue_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return LabelValueCatalog()
  }
}
