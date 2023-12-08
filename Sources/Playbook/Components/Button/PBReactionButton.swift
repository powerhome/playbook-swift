//
//  PBReactionButton.swift
//  
//
//  Created by Rachel Radford on 11/26/23.
//

import SwiftUI

public struct PBReactionButton: View {
  @Binding var count: Int
  @State private var isHighlighted: Bool = false
  @State private var isHovering: Bool = false
  let icon: String?
  let pbIcon: PBIcon?
  let isInteractive: Bool

  init(
    count: Binding<Int> = .constant(0),
    icon: String? = nil,
    pbIcon: PBIcon? = nil,
    isInteractive: Bool = false
  ) {
    self._count = count
    self.icon = icon
    self.pbIcon = pbIcon
    self.isInteractive = isInteractive
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      reactionButtonView
    }
  }
}

extension PBReactionButton {
  var reactionButtonView: some View {
    return VStack(alignment: .leading, spacing: 10) {
      Button {
        highlightReaction()
      } label: {
        reactionButtonLabelView
          .background(isHovering ? Color.background(.light) : Color.clear)
          .clipShape(.capsule)
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
      isHighlighted && isInteractive == true ? Color.pbPrimary : Color.border,
      lineWidth: isHighlighted ? 2.0 : 1.0))
  }

  var emojiCountView: some View {
    return HStack(spacing: Spacing.xxSmall) {
      emojiView
      countView
    }
    .padding(.vertical, 2)
    .padding(.horizontal, 8)
    .frame(height: 28)
  }

  var emojiView: some View {
    return Text(icon ?? "")
      .padding(.leading, count > 0 ? 0 : 4)
      .pbFont(.detail(false), variant: .light, color: .text(.light))
  }

  var countView: some View {
    return Text(count > 0 ? "\(count)" : "")
      .pbFont(.caption, variant: .light, color: .text(.light))
  }

  var addReactionView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.faceSmilePlus, size: .small)
        .foregroundStyle(Color.text(.lighter))
        .frame(width: Spacing.xLarge, height: 28)
    }
  }

  var pbIconView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.user, size: .small)
        .foregroundStyle(Color.text(.lighter))
        .frame(width: Spacing.xLarge, height: 28)
    }
  }

  func highlightReaction() {
    isHighlighted.toggle()
    if isHighlighted == false {
      count -= 1
    } else {
      count += 1
    }
  }
}
