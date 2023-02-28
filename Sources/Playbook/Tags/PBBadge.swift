//
//  PBBadge.swift
//  
//
//  Created by Alexandre Hauber on 22/07/21.
//

import SwiftUI

public struct PBBadge: View {
  var text: String
  var rounded: Bool
  var variant: Color.StatusColor

  public init(text: String, rounded: Bool = false, variant: Color.StatusColor = .success) {
    self.text = text
    self.rounded = rounded
    self.variant = variant
  }

  public var body: some View {
    Text(text)
      .padding(EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4))
      .frame(minWidth: 8)
      .foregroundColor(.status(variant))
      .background(Color.status(variant, subtle: true))
      .pbFont(.badgeText)
      .cornerRadius(rounded ? 10 : 4)
  }
}

@available(macOS 13.0, *)
struct PBBadge_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return List {
      Section("Rectangle") {
        ForEach(Color.StatusColor.allCases, id: \.self) { varient in
          HStack {
            PBBadge(text: "+1", variant: varient)
            PBBadge(text: "+4", variant: varient)
            PBBadge(text: "+1000", variant: varient)
          }
          .padding(2)
          .listRowSeparator(.hidden)
        }
      }

      Section("Rounded") {
        ForEach(Color.StatusColor.allCases, id: \.self) { varient in
          HStack {
            PBBadge(text: "+1", rounded: true, variant: varient)
            PBBadge(text: "+4", rounded: true, variant: varient)
            PBBadge(text: "+1000", rounded: true, variant: varient)
          }
          .padding(2)
          .listRowSeparator(.hidden)
        }
      }
    }
  }
}
