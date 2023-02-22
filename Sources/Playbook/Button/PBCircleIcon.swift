//
//  PBCircleIcon.swift
//  
//
//  Created by Everton Cunha on 11/05/22.
//

import SwiftUI

public struct PBCircleIcon: View {
  public var icon: PBIcon

  public var body: some View {
    icon
      .frame(minWidth: 38, minHeight: 38)
      .background(PBColor.primary.color.opacity(0.1))
      .pbForegroundColor(.primary)
      .pbFont(.buttonText())
      .clipShape(Circle())
  }
}

struct PBCircleIcon_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return PBCircleIcon(icon: PBIcon(FontAwesome.plus, size: .small))
  }
}
