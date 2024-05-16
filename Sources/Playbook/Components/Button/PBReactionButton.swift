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
  @State private var isHighlighted: Bool = false
  @State private var isHovering: Bool = false
  let icon: String?
  let pbIcon: PBIcon?
  let isInteractive: Bool
  init(
    count: Binding<Int> = .constant(0),
    isHighlighted: Bool = false,
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
    reactionButtonView
      .clipShape(Capsule())
      .onHover(perform: { hovering in
        isHovering = hovering
      })
  }
}

public extension PBReactionButton {
  var reactionButtonView: some View {
    return Button {
      highlightReaction()
    } label: {
        reactionButtonLabelView
        .reactionButtonStyle(isHighlighted: isHighlighted, isInteractive: isInteractive, isHovering: isHovering)
        
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
    .padding(.vertical, 2)
  }
  
  var emojiView: some View {
    return Text(icon ?? "")
      .pbFont(.monogram(12), variant: .light, color: .text(.light))
      .padding(.leading, count > 0 ? 0 : 4)
     
  }
  
  var countView: some View {
    return Text(count > 0 || isInteractive == true ? "\(count)" : "")
      .pbFont(.subcaption, variant: .light, color: .text(.light))
  }
  
  var addReactionView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.faceSmilePlus, size: .small)
        .foregroundStyle(Color.text(.lighter))
        .padding(.horizontal, 12)
    }
  }
  
  var pbIconView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.user, size: .small)
        .foregroundStyle(Color.text(.lighter))
        .padding(.horizontal, 14.5)
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

  
