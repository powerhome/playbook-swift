//
//  PBReactionButton.swift
//  
//
//  Created by Rachel Radford on 11/26/23.
//

import SwiftUI

public struct PBReactionButton: View {
  @State var count: Int = 0
  @State var isHighlighted: Bool = false
  var icon: String?
  var pbIcon: PBIcon?
  var variant: Variant?
  let action: (() -> Void)?

  init(
    icon: String? = nil,
    pbIcon: PBIcon? = nil,
    variant: Variant? = .reactionButtonEmoji,
    action: (() -> Void)? = {}
  ) {
    self.icon = icon
    self.pbIcon = pbIcon
    self.variant = variant
    self.action = action
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      iconVariant as? AnyView
    }
    .padding(.horizontal, 8)
    .padding(.vertical, 2)
     
  }
}

extension PBReactionButton {
  enum Variant {
    case reactionButtonEmoji
    // in the future there could be a navEmoji variant for icons without button borders
  }

  var iconVariant: any View {
    switch variant {
    case .reactionButtonEmoji:
      return reactionButtonView
    case .none:
      break
    }
    return self.iconVariant
  }

  var reactionButtonView: some View {
    return Button(action: {
      pbHighlightReaction()
    }, label: {
      reactionButtonLabelView
    })
    
  }

  var reactionButtonLabelView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      if icon != nil {
        emojiPlusCountView
      } else if pbIcon != nil {
        pbEmojiIcon
      } else {
        addReactionEmojiView
      }
    }
    .background(Capsule(style: .circular).stroke(
      isHighlighted ? Color.pbPrimary : Color.border,
      lineWidth: isHighlighted ? 1.5 : 1.0))
  }
  
  var emojiPlusCountView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      emojiView
      countView
    }
    .pbFont(.caption, variant: .light, color: .text(.light))
    .fixedSize()
    .frame(width: count > 0 ? 55 : 40, height: 28)
     

  }

  var emojiView: some View {
    return Text(icon ?? "")
      .padding(.leading, count > 0 ? 0 : 4)
  }
  
  var countView: some View {
    return Text(count != 0 && variant == .reactionButtonEmoji ? "\(count)" : "")
     
  }

  var addReactionEmojiView: some View {
    return Image("smilePlus", bundle: .module)
      .resizable()
      .pbFont(.caption, variant: .light, color: .text(.light))
      .frame(width: Spacing.xLarge, height: 28)
  }

  var pbEmojiIcon: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.user)
        .pbFont(.caption, variant: .light, color: .text(.lighter))
        .frame(width: Spacing.xLarge, height: 28)
    }
  }

  func pbHighlightReaction() {
    isHighlighted.toggle()
    if isHighlighted == false {
      count -= 1
    } else {
      count += 1
    }
  }
}

#Preview {
  registerFonts()
  return ReactionButtonCatalog()
}
