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
  var count: Int
  var isHighlighted: Bool
  let icon: Icon?
  let countColor: Color
  let action: (() -> Void)?
  @State private var isHovering: Bool = false
  @Environment(\.colorScheme) var colorScheme

  public enum Icon {
    case emoji(String)
    case pbIcon(PBIcon)
  }

  public init(
    count: Int = 0,
    isHighlighted: Bool = false,
    icon: Icon? = nil,
    countColor: Color = .text(.light),
    action: (() -> Void)? = nil
  ) {
    self.count = count
    self.isHighlighted = isHighlighted
    self.icon = icon
    self.countColor = countColor
    self.action = action
  }

  public var body: some View {
    reactionButtonView
      .onHover { isHovering = $0 }
      .setCursorPointer()
  }
}

public extension PBReactionButton {
  var reactionButtonView: some View {
    return Button {
      action?()
    } label: {
      iconCountView
        .reactionButtonStyle(
          isHighlighted: isHighlighted,
          isHovering: isHovering
        )
    }
    .buttonStyle(.plain)
  }

  @ViewBuilder
  var iconCountView: some View {
    HStack(spacing: Spacing.xxSmall) {
      switch icon {
        case .emoji(let emoji):
          Text(emoji)
            .font(.system(size: 12))
        case .pbIcon(let pbIcon):
          pbIcon
            .foregroundStyle(textColor)
        case .none:
          addReactionView
      }
      if count > 0 && icon != nil {
        countView(count)
      }
    }
    .padding(.horizontal, horizontalPadding)
  }

  var horizontalPadding: CGFloat {
    return (count > 0 && icon != nil) ? Spacing.xSmall : Spacing.small-4
  }

  func countView(_ count: Int) -> some View {
      Text("\(count)")
        .pbFont(.subcaption, variant: .light, color: textColor)
  }

  var addReactionView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.faceSmilePlus, size: .small)
        .foregroundStyle(textColor)
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
}

#Preview {
  registerFonts()
  return HStack {
    PBReactionButton()
    PBReactionButton(count: 10, isHighlighted: false, icon: .pbIcon(PBIcon.fontAwesome(.perbyte)), countColor: .pink, action: {})
    PBReactionButton(count: 10, isHighlighted: true, icon: .emoji("😇"), action: {})
  }
}
