//
//  PBMessage.swift
//
//
//  Created by Alexandre Hauber on 29/07/21.
//

import SwiftUI

public struct PBMessage<Content: View>: View {
  let avatar: PBAvatar?
  let label: String
  let message: String?
  let timestamp: Date
  let timestampAlignment: TimestampAlignment?
  let changeTimeStampOnHover: Bool
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let content: Content?
  @State var timestampVariant: PBTimestamp.Variant = .elapsed
  @State var hoverColor: Color = .clear

  public init(
    avatar: PBAvatar? = nil,
    label: String,
    message: String? = nil,
    timestamp: Date,
    timestampAlignment: TimestampAlignment? = .trailing,
    changeTimeStampOnHover: Bool = false,
    verticalPadding: CGFloat = Spacing.xSmall,
    horizontalPadding: CGFloat = Spacing.xSmall,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.avatar = avatar
    self.label = label
    self.message = message
    self.timestamp = timestamp
    self.timestampAlignment = timestampAlignment
    self.changeTimeStampOnHover = changeTimeStampOnHover
    self.verticalPadding = verticalPadding
    self.horizontalPadding = horizontalPadding
    self.content = content()
  }

  public var body: some View {
    HStack(alignment: .top, spacing: nil) {
      if let avatar = avatar {
        avatar
      }
      
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
       
        HStack(alignment: .firstTextBaseline, spacing: Spacing.xSmall) {
          Text(label).pbFont(.title4)
          
          if timestampAlignment == .trailing {
            Spacer()
          }

            PBTimestamp(
              timestamp,
              showUser: false,
              variant: timestampVariant
            )
          
        }

        if let message = message {
          Text(message).pbFont(.body())
        }

        content
      }
   
      .onHover { hover in
        if changeTimeStampOnHover {
          timestampVariant =  hover ? .standard : .elapsed
        }
        hoverColor = hover ? .hover : .clear
      }
    }
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .background(hoverColor)
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
  }
}

public extension PBMessage {
  enum TimestampAlignment {
    case leading, trailing 
  }
}

public struct PBMessage_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return MessageCatalog()
  }
}
