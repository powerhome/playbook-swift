//
//  PBCircleIcon.swift
//  
//
//  Created by Everton Cunha on 11/05/22.
//

import SwiftUI

public struct PBCircleIcon: View {
  var icon: PBIcon

  public init(icon: PBIcon) {
    self.icon = icon
  }

  public var body: some View {
    icon
      .frame(minWidth: 38, minHeight: 38)
      .background(Color.pbPrimary.subtle)
      .foregroundColor(.pbPrimary)
      .clipShape(Circle())
  }
}

struct PBCircleIcon_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return PBCircleIcon(icon: PBIcon(FontAwesome.info, size: .small))
  }
}
