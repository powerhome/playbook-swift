//
//  PBLabelValue.swift
//
//
//  Created by Everton Cunha on 10/03/22.
//

import SwiftUI

public struct PBLabelValue: View {
  private let label: String
  private let value: String

  public init(_ label: String, _ value: String) {
    self.label = label
    self.value = value
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      Text(label)
        .padding(.bottom, 5.3)
        .pbFont(.caption)
      Text(value)
        .foregroundColor(.text(.default))
        .pbFont(.body)
    }
  }
}

public struct PBLabelValue_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return LabelValueCatalog()
  }
}
