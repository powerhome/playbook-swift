//
//  PBMessage.swift
//
//
//  Created by Alexandre Hauber on 29/07/21.
//

import SwiftUI

public struct PBMessage<Content: View, Avatar: View>: View {

    // MARK: Props
    let content: Content // mandatory

    var avatar: Avatar
    let label: String?
    let timestamp: PBTimestamp?
    //

  public init(avatar: Avatar, label: String? = nil, timestamp: PBTimestamp? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.avatar = avatar
        self.label = label
        self.timestamp = timestamp
    }

    public var body: some View {
        HStack(alignment: .top, spacing: nil, content: {
            avatar
            VStack(alignment: .leading, spacing: nil, content: {
                HStack(alignment: .firstTextBaseline, spacing: 2, content: {
                    if let label = label, !label.isEmpty {
                        Text(label).pbFont(.title4)
                    }
                    if let timestamp = timestamp {
                        timestamp.padding(.leading, 8)
                            .padding(.bottom, -4)
                    }
                })
                .padding(.bottom, -6)
                content
            })
        })
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
    }
}
#if DEBUG
struct PBMessage_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()

      return PBMessage(avatar: PBAvatar(image: Image("andrew", bundle: .module)), label: "Andrew Koeckler", timestamp: PBTimestamp(Date.init(), showDate: false)) {
            Text("This below is our great friend (and amazing dev), aka me, Andrew:").pbFont(.body)
            Image("andrew", bundle: .module).resizable().frame(width: 240, height: 240)
        }
    }
}
#endif
