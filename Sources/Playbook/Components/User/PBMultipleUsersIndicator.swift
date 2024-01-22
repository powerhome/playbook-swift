//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBMultipleUsersIndicator.swift
//

import SwiftUI

public struct PBMultipleUsersIndicator: View {
  let usersCount: Int?
  var size: PBAvatar.Size

  public var body: some View {
    if let count = usersCount, count != 0 {
      Text("+\(count)")
        .tag("additionalUser")
        .pbFont(.buttonText(size.fontSize), color: .pbPrimary)
        .frame(width: size.diameter-1, height: size.diameter-1)
        .background(Color.shadow)
        .clipShape(Circle())
        .background {
          Circle()
            .foregroundColor(.white)
        }
        .overlay {
          Circle()
            .stroke(.white, lineWidth: 1)
        }
    }
  }
}

@available(macOS 13.0, *)
struct PBMultipleUsersIndicator_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return MultipleUsersIndicatorCatalog()
  }
}
