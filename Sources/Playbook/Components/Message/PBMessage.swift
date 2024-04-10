//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBMessage.swift
//

import SwiftUI

public struct PBMessage<Content: View>: View {
  let avatar: AnyView?
  let label: String
  let message: String?
  let timestamp: Date?
  let timestampAlignment: TimestampAlignment?
  let changeTimeStampOnHover: Bool
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let content: Content?
  let timestampVariant: PBTimestamp.Variant

  @State private var isHovering: Bool = false

  public init(
    avatar: AnyView? = nil,
    label: String = "",
    message: String? = nil,
    timestamp: Date? = nil,
    timestampAlignment: TimestampAlignment? = .trailing,
    timestampVariant: PBTimestamp.Variant = .standard,
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
    self.timestampVariant = timestampVariant
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
      VStack(alignment: .leading, spacing: Spacing.none) {
        HStack(spacing: Spacing.xSmall) {
          Text(label)
            .pbFont(.messageTitle)
          if timestampAlignment == .trailing {
            Spacer()
          }
          if let timestamp = timestamp {
            PBTimestamp(
              timestamp,
              amPmStyle: .full,
              showDate: false,
              showUser: false,
              variant: returnTimestamp(isHovering: isHovering)
            )
          }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)

        if let message = message {
          Text(message)
            .pbFont(.messageBody)
            .fontWeight(FontWeight.regular)
            .lineSpacing(Spacing.xxSmall + 2)
        }
        content
      }
      .onHover { hover in
        isHovering = hover
      }
    }
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }

  func returnTimestamp(isHovering: Bool) -> PBTimestamp.Variant {
    if changeTimeStampOnHover {
      return isHovering ? .standard : .hideUserElapsed
    } else {
      return timestampVariant
    }
  }
}

public extension PBMessage {
  enum TimestampAlignment {
    case leading, trailing
  }
}

struct PBMessage_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return MessageCatalog()
  }
}
