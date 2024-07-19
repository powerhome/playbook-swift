//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PlayButtonCatalog.swift
//

import SwiftUI

public struct PlayButtonCatalog: View {
  @State private var count: Int = 152
  @State private var count1: Int = 5
  public var body: some View {
    PBDocStack(title: "Button", spacing:  Spacing.medium) {
      PBDoc(title: "Simple", spacing: Spacing.medium) {
        simpleView
      }
      PBDoc(title: "Reaction Button", spacing: Spacing.medium) {
        reactionButtonView
      }
      PBDoc(title: "Full Width", spacing: Spacing.medium) {
        fullWidthView
      }
      PBDoc(title: "Button with Icon", spacing: Spacing.medium) {
        iconButtonView
      }
      PBDoc(title: "Button with Icon", spacing: Spacing.medium) {
        circleButton
      }
      PBDoc(title: "Button Sizes", spacing: Spacing.medium) {
        buttonSizeView
      }
      PBDoc(title: "Button Loading", spacing: Spacing.medium) {
        loadingButtonView
      }
    }
   
  }
}
public extension PlayButtonCatalog {
  var simpleView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PlayButton(
        variant: .primary,
        shape: .primary,
        title: "Primary Button",
        action: {}
      )
      PlayButton(
        variant: .secondary,
        shape: .primary,
        title: "Secondary Button",
        action: {}
      )
      PlayButton(
        variant: .link,
        shape: .primary,
        title: "Link Button",
        action: {}
      )
      PlayButton(
        variant: .disabled,
        shape: .primary,
        title: "Disabled Button",
        action: {}
      )
    }
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
  
  var fullWidthView: some View {
    PlayButton(
      variant: .primary,
      shape: .primary,
      title: "Full Width", 
      fullWidth: true,
      action: {}
    )
  }
  var iconButtonView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PlayButton(
        variant: .primary,
        shape: .primary,
        title: "Button w/ left icon",
        icon: PBIcon.fontAwesome(.user, size: .x1),
        iconPosition: .left,
        action: {}
      )
      PlayButton(
        variant: .primary, 
        shape: .primary,
        title: "Button w/ right icon", 
        icon: PBIcon.fontAwesome(.user, size: .x1), 
        iconPosition: .right,
        action: {}
      )
    }
  }
  
  var circleButton: some View {
    HStack(spacing: Spacing.small) {
      PlayButton(
        shape: .circle,
        icon: PBIcon.fontAwesome(.plus, size: .x1),
        action: {}
      )
      PlayButton(
        variant: .secondary,
        hasIcon: true,
        shape: .circle,
        icon: PBIcon.fontAwesome(.pen, size: .x1),
        action: {}
      )
      PlayButton(
        variant: .disabled,
        hasIcon: true,
        shape: .circle,
        icon: PBIcon.fontAwesome(.times, size: .x1),
        action: {}
      )
      PlayButton(
        variant: .link,
        hasIcon: true,
        shape: .circle,
        icon: PBIcon.fontAwesome(.user, size: .x1),
        action: {}
      ) 
    }
  }
  
  var buttonSizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PlayButton(
        variant: .primary,
        size: .small,
        shape: .primary,
        title: "Button sm",
        action: {}
      )
      PlayButton(
        variant: .primary,
        size: .medium,
        shape: .primary,
        title: "Button md",
        action: {}
      )
      PlayButton(
        variant: .primary,
        size: .large,
        shape: .primary,
        title: "Button lg",
        action: {}
      )
    }
  }
  var loadingButtonView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBButton(
        variant: .primary,
        isLoading: .constant(true),
        fullWidth: true,
        action: {}
      )
      PBButton(
        variant: .secondary,
        isLoading: .constant(true),
        fullWidth: true,
        action: {}
      )
      PBButton(
        variant: .link,
        isLoading: .constant(true),
        fullWidth: true,
        action: {}
      )
      
    }
  }
}
#Preview {
  registerFonts()
    return PlayButtonCatalog()
}
