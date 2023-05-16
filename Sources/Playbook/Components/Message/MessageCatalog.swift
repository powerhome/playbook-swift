//
//  MessageCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct MessageCatalog: View {

  public init() {}

  public var body: some View {
    List {
      PBMessage(
        avatar: PBAvatar(image: Image("andrew", bundle: .module)),
        label: "Andrew Black", timestamp: PBTimestamp(Date(), showDate: false)
      ) {
        Text("This below ir our great friend (and amazing dev), aka me, Andrew:").pbFont(.body())
        Image("andrew", bundle: .module).resizable().frame(width: 240, height: 240)
      }

      PBMessage(
        avatar: PBAvatar(image: Image("andrew", bundle: .module)),
        label: "Andrew Black", timestamp: PBTimestamp(Date(), showDate: false)
      ) {
        Text("This below ir our great friend (and amazing dev), aka me, Andrew:").pbFont(.body())
      }
    }
  }
}
