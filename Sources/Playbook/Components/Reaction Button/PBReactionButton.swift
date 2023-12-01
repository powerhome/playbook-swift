//
//  PBReactionButton.swift
//  
//
//  Created by Rachel Radford on 11/26/23.
//

import SwiftUI

public struct PBReactionButton: View {
  @Binding var count: Int?
  @State private var isHighlighted: Bool = false
  @State private var isHovering: Bool = false
  let icon: String?
  let pbIcon: PBIcon?
  let variant: Variant?
  let action: (() -> Void)?
  init(
    count: Binding<Int?> = .constant(nil),
    icon: String? = nil,
    pbIcon: PBIcon? = nil,
    variant: Variant? = .emoji,
    action: (() -> Void)? = {}
  ) {
    self._count = count
    self.icon = icon
    self.pbIcon = pbIcon
    self.variant = variant
    self.action = action
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      reactionButtonView
    }
  }
}

extension PBReactionButton {
  enum Variant {
    case emoji, defaultIcon, addReaction
  }

  var reactionButtonView: some View {
    return VStack(alignment: .leading, spacing: 10) {
      Button {
        highlightReaction()
      } label: {
        reactionButtonLabelView
          .background(isHovering ? Color.text(.lighter) : Color.clear)
          .onHover { hovering in
            isHovering = hovering
          }
      }
    }
  }

  var reactionButtonLabelView: some View {
    return HStack(spacing: Spacing.xxSmall) {
      if icon != nil {
        emojiCountView
      } else if pbIcon != nil {
        pbIconView
      } else {
        addReactionView
      }
    }
    .background(Capsule(style: .circular).stroke(
      isHighlighted && variant != .defaultIcon ? Color.pbPrimary : Color.border,
      lineWidth: isHighlighted ? 2.0 : 1.0))
  }

  var emojiCountView: some View {
    return HStack(spacing: Spacing.xxSmall) {
      emojiView
      if count != nil {
        countView
      }
    }
    .padding(.vertical, 2)
    .padding(.horizontal, 8)
    .frame(height: 28)
  }

  var emojiView: some View {
    return Text(icon ?? "")
      .padding(.leading, count ?? 0 > 0 ? 0 : 4)
      .pbFont(.body, variant: .light, color: .text(.light))
  }

  var countView: some View {
    return Text(variant == .emoji ? "\(count ?? 0)" : "")
      .pbFont(.caption, variant: .light, color: .text(.light))
  }

  var addReactionView: some View {
    return Image("smilePlus", bundle: .module)
      .resizable()
      .pbFont(.caption, variant: .light, color: .text(.light))
      .frame(width: Spacing.xLarge, height: 28)
  }

  var pbIconView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.user)
        .pbFont(.caption, variant: .light, color: .text(.lighter))
        .frame(width: Spacing.xLarge, height: 28)
    }
  }

  func highlightReaction() {
    isHighlighted.toggle()
    if isHighlighted == false {
      if count == count {
        count! -= 1
      }
    }
    if isHighlighted == true {
      count! += 1
    }
  }
}

#Preview {
  registerFonts()
  return ReactionButtonCatalog()
}
