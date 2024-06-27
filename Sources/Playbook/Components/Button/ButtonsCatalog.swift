//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ButtonsCatalog.swift
//

import SwiftUI

public struct ButtonsCatalog: View {
  @State private var count: Int = 153
  @State private var count1: Int = 5
    @State private var isLoading: Bool = false

  public var body: some View {
    PBDocStack(title: "Button") {
      PBDoc(title: "Simple") { simpleButtons }
      PBDoc(title: "Reaction Button") { reactionButtonView }
      PBDoc(title: "Full Width") { fullWidthButtonView }
      PBDoc(title: "Button Icon Positions") { buttonIconView }
      PBDoc(title: "Circle Buttons") { circleButtonView }
      PBDoc(title: "Button Sizes") { buttonSizeView }
      PBDoc(title: "Button Loading") { buttonLoadingView }
    }
  }
}

extension ButtonsCatalog {
  var simpleButtons: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBButton(
        title: "Button Primary",
        isLoading: $isLoading, 
        action: { isLoading = true }
      )
      PBButton(
        variant: .secondary,
        title: "Button Secondary",
        action: {})
      PBButton(
        variant: .link,
        title: "Button Link",
        action: {}
      )
      PBButton(
        variant: .disabled,
        title: "Button Disabled"
      )
    }
    .listRowSeparator(.hidden)
    .previewDisplayName("Button Variants")
  }
  var reactionButtonView: some View {
    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12) {
      PBReactionButton(
        count: $count,
        icon: "\u{1F389}", isInteractive: true)
      PBReactionButton(count: $count1, icon: "1️⃣", isInteractive: false)
      PBReactionButton(isInteractive: false)
      PBReactionButton(pbIcon: PBIcon(FontAwesome.user), isInteractive: false)
    }
  }
  var fullWidthButtonView: some View {
    PBButton(
      fullWidth: true,
      title: "Full Width",
      action: {}
    )
  }
  var buttonIconView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBButton(
        title: "Button with Icon on Left",
        icon: PBIcon.fontAwesome(.user, size: .x1),
        action: {}
      )
      PBButton(
        title: "Button with Icon on Right",
        icon: PBIcon.fontAwesome(.user, size: .x1),
        iconPosition: .right,
        action: {}
      )
    }
  }
  var buttonSizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBButton(
        size: .small,
        title: "Button sm",
        action: {}
      )
      PBButton(
        title: "Button md",
        action: {}
      )
      PBButton(
        size: .large,
        title: "Button lg",
        action: {}
      )
    }
  }
  var buttonLoadingView:  some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBButton(
        fullWidth: true,
        variant: .primary,
        title: "Button lg",
        isLoading: .constant(true),
        action: {}
      )
      PBButton(
        fullWidth: true,
        variant: .secondary,
        title: "Button lg",
        isLoading: .constant(true),
        action: {}
      )
      PBButton(
        fullWidth: true,
        variant: .link,
        title: "Button lg",
        isLoading: .constant(true),
        action: {}
      )
    }
  }
  var circleButtonView: some View {
    return HStack(spacing: Spacing.small) {
      PBButton(
        shape: .circle,
        icon: PBIcon.fontAwesome(.plus, size: .x1),
        action: {}
      )
      PBButton(
        variant: .secondary,
        shape: .circle,
        icon: PBIcon.fontAwesome(.pen, size: .x1),
        action: {}
      )
      PBButton(
        variant: .disabled,
        shape: .circle,
        icon: PBIcon.fontAwesome(.times, size: .x1)
      )
      PBButton(
        variant: .link,
        shape: .circle,
        icon: PBIcon.fontAwesome(.user, size: .x1),
        action: {}
      )
    }
  }
}

#Preview {
  registerFonts()
  return ButtonsCatalog()
}
