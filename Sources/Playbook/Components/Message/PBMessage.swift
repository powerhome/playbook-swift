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
  let content: Content?
  let timestampVariant: PBTimestamp.Variant
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
            .pbFont(.messageTitle, color: isLoading ? .text(.light) : .text(.default))
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
                  amPmStyle: .full,
                  showDate: false,
                  showUser: false,
                  variant: returnTimestamp(isHovering: isHovering)
                )
              }
            }
          }
          .frame(height: 16.8)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        if let message = message {
          Text(message)
            .pbFont(.messageBody, color: isLoading ? .text(.light) : .text(.default))
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
  return MessageCatalog()
}
