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
      .background(backgroundColor)
      .pbForegroundColor(.primary)
      .pbFont(.buttonText())
      .clipShape(Circle())
  }

  var backgroundColor: Color {
    PBColor.primary.color.opacity(0.1)
  }
}

struct PBCircleIcon_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return PBCircleIcon(icon: PBIcon(FontAwesome.plus, size: .small))
  }
}
