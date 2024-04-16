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
  let timestampAlignment: TimestampAlignment?
  let changeTimeStampOnHover: Bool
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let content: Content?
  let timestampVariant: PBTimestamp.Variant
  let variant: Variant
  let backgroundColor: Color
  @Binding var isLoading: Bool
  @State private var isHovering: Bool = false

  public init(
    avatar: AnyView? = nil,
    label: String = "",
    message: AttributedString? = nil,
    timestamp: Date? = nil,
    timestampAlignment: TimestampAlignment? = .trailing,
    timestampVariant: PBTimestamp.Variant = .standard,
    changeTimeStampOnHover: Bool = false,
    verticalPadding: CGFloat = Spacing.none,
    horizontalPadding: CGFloat = Spacing.none,
    isLoading: Binding<Bool> = .constant(false),
    variant: Variant = .bot,
    backgroundColor: Color = .clear,
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
    _isLoading = isLoading
    self.variant = variant
    self.backgroundColor  = backgroundColor
    self.content = content()
  }

  public var body: some View {
    HStack(alignment: .top, spacing: nil) {
      if let avatar = avatar, variant == .bot {
        avatar.opacity(isLoading ? 0.8 : 1)
      }
      VStack(alignment: variant == .bot ? .leading : .trailing, spacing: Spacing.none) {
        
        HStack(spacing: Spacing.xSmall) {
          if variant == .user {
            timestampView.foregroundStyle(Color.white)
            Spacer()
          }
          
          Text(label)
            .pbFont(.messageTitle, color: textColor)
          
          if timestampAlignment == .trailing, variant == .bot {
            Spacer()
            
          }
          timestampView
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        if let message = message {
          Text(message)
            .pbFont(.messageBody, color: textColor)
        }
        content
      }
      
      if let avatar = avatar, variant == .user {
        avatar.opacity(isLoading ? 0.8 : 1)
      }
    }
    .onHover { hover in
      isHovering = hover
    }
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .frame(maxWidth: .infinity, alignment: .topLeading)
    .background(backgroundColor)
    .cornerRadius(BorderRadius.large)
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
  
  enum Variant {
    case user, bot
  }
  
  var textColor: Color {
    if variant == .user {
      Color.white
    } else {
      isLoading ? .text(.light) : .text(.default)
    }
  }
  
  var timestampView: some View {
    Group {
      if let timestamp = timestamp {
        if isLoading {
          PBLoader()
        } else {
          PBTimestamp(
            timestamp,
            amPmStyle: .full,
            showDate: false,
            showUser: false,
            variant: returnTimestamp(isHovering: isHovering),
            color: variant == .user ? .white : .text(.light)
          )
        }
      }
    }
    .frame(height: 16.8)
  }
}

#Preview {
  registerFonts()
  return MessageCatalog()
}
