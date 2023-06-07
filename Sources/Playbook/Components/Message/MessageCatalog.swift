//
//  MessageCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct MessageCatalog: View {
  public var body: some View {
    List {

      PBMessage(avatar: avatarXSmallStatus, label: userName, message: message, timestamp: Date())
        .padding(.vertical)

        PBMessage(avatar: avatarXSmall, label: userName, message: message, timestamp: Date())
        .padding(.vertical)

        PBMessage(avatar: avatarXSmall, label: userName, message: message, timestamp: Date())
        .padding(.vertical)

        PBMessage(label: userName, message: message, timestamp: Date())
        .padding(.vertical)

        PBMessage(label: userName, timestamp: Date()) {
          Image("Forest", bundle: .module).resizable().frame(width: 240, height: 240)

        }
        .padding(.vertical)

        PBMessage(label: userName, message: message, timestamp: Date()) {
          Image("Forest", bundle: .module).resizable().frame(width: 240, height: 240)
        }
        .padding(.vertical)

    }
    

    .navigationTitle("Message")
  }
}
