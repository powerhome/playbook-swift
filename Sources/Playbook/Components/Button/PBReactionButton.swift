//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBReactionButton.swift
//

import SwiftUI

public struct PBReactionButton: View {
  @Binding var count: Int
  @Binding var isHighlighted: Bool
  @State private var isHovering: Bool = false
  let icon: String?
  let pbIcon: PBIcon?
  let isInteractive: Bool
  let countColor: Color
  let action: (() -> Void)?
  @Environment(\.colorScheme) var colorScheme

  public init(
    count: Binding<Int> = .constant(0),
    isHighlighted: Binding<Bool> = .constant(false),
    icon: String? = nil,
    pbIcon: PBIcon? = nil,
    isInteractive: Bool = false,
    countColor: Color = .text(.light),
    action: (() -> Void)? = nil
  ) {
    self._count = count
    self._isHighlighted = isHighlighted
    self.icon = icon
    self.pbIcon = pbIcon
    self.countColor = countColor
    self.isInteractive = isInteractive
    self.action = action
  }
  
  public var body: some View {
    reactionButtonView
      .clipShape(Capsule())
      .onHover { isHovering = $0 }
  }
}

public extension PBReactionButton {
  var reactionButtonView: some View {
    return Button {
      action?()
      highlightReaction()
    } label: {
        reactionButtonLabelView
        .reactionButtonStyle(
          isHighlighted: isHighlighted,
          isInteractive: isInteractive,
          isHovering: isHovering
        )
    }
    .buttonStyle(.plain)
  }
  
  @ViewBuilder
  var reactionButtonLabelView: some View {
      if icon != nil {
        emojiCountView
      } else if pbIcon != nil {
        pbIconView
      } else {
        addReactionView
      }
  }
  
  var emojiCountView: some View {
    return HStack(spacing: Spacing.xxSmall) {
      emojiView
      countView
    }  
    .padding(.horizontal, 8)
    .padding(.top, 3)
  }
  
  var emojiView: some View {
    return Text(icon ?? "")
      .pbFont(.caption, variant: .light, color: textColor)
      .padding(.leading, count > 0 ? 0 : 4)
  }
  
  var countView: some View {
    return Text(count > 0 || isInteractive == true ? "\(count)" : "")
      .pbFont(.subcaption, variant: .light, color: textColor)
  }
  
  var addReactionView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.faceSmilePlus, size: .small)
        .foregroundStyle(textColor)
        .padding(.horizontal, 12)
    }
  }
  
  var pbIconView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.user, size: .small)
        .foregroundStyle(textColor)
        .padding(.horizontal, 14.5)
    }
  }
  
  var textColor: Color {
    switch colorScheme {
    case .light: return countColor
    case .dark: return icon != nil ? Color(.white) : Color(.white).opacity(0.6)
    default:
      return Color.text(.light)
    }
  }

  func highlightReaction() {
    isHighlighted.toggle()
    if !isHighlighted && isInteractive {
      count -= 1
    } else if isHighlighted  && isInteractive {
      count += 1
    }
  }
}

#Preview {
  registerFonts()
  return PBReactionButton()
}
