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
  public var body: some View {
    PBDocStack(title: "Button", spacing:  Spacing.medium) {
      PBDoc(title: "Simple", spacing: Spacing.medium) {
        simpleView
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
    }
   
  }
}
public extension PlayButtonCatalog {
  var simpleView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PlayButton(
        variant: .primary,
        shape: .primary,
        title: "Primary Button"
      ) {}
      PlayButton(
        variant: .secondary,
        shape: .primary,
        title: "Secondary Button"
      ) {}
      PlayButton(
        variant: .link,
        shape: .primary,
        title: "Link Button"
      ) {}
      PlayButton(
        variant: .disabled,
        shape: .primary,
        title: "Disabled Button"
      ) {}
    }
  }
  var fullWidthView: some View {
    PlayButton(
      variant: .primary,
      shape: .primary,
      title: "Full Width", fullWidth: true
    ) {}
  }
  var iconButtonView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PlayButton(
        variant: .primary,
        shape: .primary,
        title: "Button w/ left icon",
        icon: PBIcon.fontAwesome(.user, size: .x1),
        iconPosition: .left,
        fullWidth:true
      ) {}
      PlayButton(
        variant: .primary, 
        shape: .primary,
        title: "Button w/ right icon", 
        icon: PBIcon.fontAwesome(.user, size: .x1), 
        iconPosition: .right, fullWidth:true
      ) {}
    }
  }
  var circleButton: some View {
    HStack {
      PlayButton(
        variant: .primary,
        shape: .circle,
        icon: PBIcon.fontAwesome(.plus, size: .x1)
      ) {}
      PlayButton(
        variant: .secondary,
        shape: .circle,
        icon: PBIcon.fontAwesome(.pen, size: .x1)
      ) {}
      PlayButton(
        variant: .disabled,
        shape: .circle,
        icon: PBIcon.fontAwesome(.times, size: .x1)
      ) {}
      PlayButton(
        variant: .link,
        shape: .circle,
        icon: PBIcon.fontAwesome(.user, size: .x1)
      ) {}
    }
  }
}
#Preview {
  registerFonts()
    return PlayButtonCatalog()
}
