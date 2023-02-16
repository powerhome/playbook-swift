//
//  PBPill.swift
//  
//
//  Created by Alexandre Hauber on 04/10/21.
//

import SwiftUI

public struct PBPill: View {
  private let title: String
  private let variant: StatusVariant

  public init(_ title: String, variant: StatusVariant = .neutral) {
    self.title = title
    self.variant = variant
  }

  public var body: some View {
    Text(title)
      .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
      .pbForegroundColor(variant.foregroundColor)
      .pbFont(.title4)
      .background(variant.backgroundColor)
      .cornerRadius(12)
  }
}

struct PBPill_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack(alignment: .leading) {
      PBPill("default")
      PBPill("success", variant: .success)
      PBPill("error", variant: .error)
      PBPill("warning", variant: .warning)
      PBPill("info", variant: .info)
      PBPill("neutral", variant: .neutral)
      PBPill("primary", variant: .primary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading, 20)
    .background(Color.pbCard)
    .previewDisplayName("Pills")
  }
}
