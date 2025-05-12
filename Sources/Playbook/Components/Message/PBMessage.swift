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
  let message: AttributedString?
  let timestamp: Date?
  let timestampAlignment: Alignment?
  let changeTimeStampOnHover: Bool
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let messageAmPmStyle: PBTimestamp.AmPmStyle
  let showMessageDate: Bool
  let showMessageUser: Bool
  let content: Content?
  let timestampVariant: PBTimestamp.Variant
  var isOnClick: Bool
  var isActive: Bool
  let onHeaderClick: (() -> Void)?
  @Binding var isLoading: Bool
  @State private var isHovering: Bool = false

  public init(
    avatar: AnyView? = nil,
    label: String = "",
    message: AttributedString? = nil,
    timestamp: Date? = nil,
    timestampAlignment: Alignment? = .trailing,
    timestampVariant: PBTimestamp.Variant = .standard,
    changeTimeStampOnHover: Bool = false,
    verticalPadding: CGFloat = Spacing.none,
    horizontalPadding: CGFloat = Spacing.none,
    messageAmPmStyle: PBTimestamp.AmPmStyle = .full,
    showMessageDate: Bool = false,
    showMessageUser: Bool = false,
    isOnClick: Bool = false,
    isActive: Bool = true,
    isLoading: Binding<Bool> = .constant(false),
    onHeaderClick: (() -> Void)? = nil,
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
    self.messageAmPmStyle = messageAmPmStyle
    self.showMessageDate = showMessageDate
    self.showMessageUser = showMessageUser
    self.isOnClick = isOnClick
    self.isActive = isActive
    self._isLoading = isLoading
    self.onHeaderClick = onHeaderClick
    self.content = content()
  }
  
  public var body: some View {
    HStack(alignment: .top, spacing: nil) {
      if let avatar = avatar {
        avatar
          .setCursorPointer(disabled: !isCursorEnabled)
          .opacity(isLoading ? 0.8 : 1)
          .onTapGesture { onHeaderClick?() }
      }
      VStack(alignment: .leading, spacing: Spacing.none) {
        HStack(spacing: Spacing.xSmall) {
          Text(label)
            .pbFont(.messageTitle, color: isLoading || !isActive ? .text(.light) : .text(.default))
            .setCursorPointer(disabled: !isCursorEnabled)
            .onTapGesture { onHeaderClick?() }
          if timestampAlignment == .trailing {
            Spacer()
          }
          Group {
            if isLoading {
              PBLoader()
            } else {
              if let timestamp = timestamp {
                PBTimestamp(
                  timestamp,
                  amPmStyle: messageAmPmStyle,
                  showDate: showMessageDate,
                  showUser: showMessageUser,
                  variant: returnTimestamp(isHovering: isHovering)
                )
              }
            }
          }
          .frame(height: 16.8)
        }
        .setCursorPointer(disabled: !isCursorEnabled)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        if let message = message {
          Text(message)
            .pbFont(.messageBody, color: isLoading ? .text(.light) : .text(.default))
        }
        content
      }
      #if os(macOS)
      .onHover { hover in
        isHovering = hover
      }
      #endif
    }
    .setCursorPointer(disabled: !isOnClick)
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }
}

private extension PBMessage {
  func returnTimestamp(isHovering: Bool) -> PBTimestamp.Variant {
    if changeTimeStampOnHover {
      return isHovering ? .standard : .hideUserElapsed
    } else {
      return timestampVariant
    }
  }
  
  var isCursorEnabled: Bool {
    if onHeaderClick != nil {
      return true
    } else {
      return false
    }
  }
}

public extension PBMessage {
  enum Alignment {
    case leading, trailing
  }
}

#Preview {
  registerFonts()
  return  PBMessage(
    avatar: AnyView(Mocks.picPatric),
    label: "Patrick Welch",
    message: "We will escalate this issue to a Senior Support agent.",
    timestamp: Date().addingTimeInterval(-540),
    timestampAlignment: .leading,
    isLoading: .constant(false)
  )
}
