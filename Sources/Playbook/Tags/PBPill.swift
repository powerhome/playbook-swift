//
//  PBPill.swift
//  
//
//  Created by Alexandre Hauber on 04/10/21.
//

import SwiftUI

public struct PBPill: View {
  private let title: String
  private let variant: Color.StatusColor

  public init(_ title: String, variant: Color.StatusColor = .neutral) {
    self.title = title
    self.variant = variant
  }

  public var body: some View {
    Text(title)
      .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
      .foregroundColor(.status(variant))
      .background(Color.status(variant).subtle)
      .pbFont(.title4)
      .cornerRadius(12)
  }
}

struct PBPill_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack(alignment: .leading) {
      PBPill("success", variant: .success)
      PBPill("error", variant: .error)
      PBPill("warning", variant: .warning)
      PBPill("info", variant: .info)
      PBPill("neutral", variant: .neutral)
      PBPill("primary", variant: .primary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading, 20)
    .background(Color.card)
    .previewDisplayName("Pills")
  }
}
