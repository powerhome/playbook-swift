//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Button.swift
//

import SwiftUI

public struct PlayButton: View {
  var fullWidth: Bool
  var variant: Variant
  let hasIcon: Bool
 // var size: Size
  var shape: Shape
  var title: String?
  var icon: PBIcon?
  var iconPosition: IconPosition?
  let action: (() -> Void)?
  @Binding var isLoading: Bool
  
  public init(
      variant: Variant = .primary,
      hasIcon: Bool = false,
//      size: Size = .medium,
      shape: Shape = .primary,
      title: String? = nil,
      icon: PBIcon? = nil,
      iconPosition: IconPosition? = .left,
      isLoading: Binding<Bool> = .constant(false),
      fullWidth: Bool = false,
      action: (() -> Void)? = nil
  ) {
    self.fullWidth = fullWidth
    self.variant = variant
    self.hasIcon = hasIcon
    //      self.size = size
    self.shape = shape
    self.title = title
    self.icon = icon
    self.iconPosition = iconPosition
    self._isLoading = isLoading
    self.action = action
  }
  
  public var body: some View {
    Button {
      action?()
    } label: {
      HStack {
        icon
        if isLoading {
          PBLoader(color: variant == .primary ? .white : .pbPrimary)
        } else {
          if let title = title, shape == .primary {
            Text(title)
          }
        }
      }
      .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
    }
    .pbFont(.buttonText(16), variant: .bold, color: buttonFontColor)
    .padding(.horizontal, Spacing.xLarge)
    .padding(.vertical, Spacing.small)
    .frame(maxWidth: fullWidth ? .infinity : nil)
    .background(buttonColor)
    .clipShape(buttonShape)
    .disabled(variant == .disabled ? true : false)
  }
}

public extension PlayButton {
  enum Variant {
    case primary
    case secondary
    case link
    case disabled
  }
  enum IconPosition {
    case left
    case right
    case center
  }
  enum Shape {
    case primary
    case circle
    
  }
  var buttonColor: Color {
    switch variant {
    case .primary: return .pbPrimary
    case .secondary: return .status(.neutral).opacity(0.05)
    case .link: return .clear
    case .disabled: return .status(.neutral).opacity(0.5)
    }
  }
  var buttonFontColor: Color {
    switch variant {
    case .primary: return .white
    case .disabled: return .text(.default).opacity(0.5)
    default: return .pbPrimary
    }
  }

  var buttonShape: AnyShape {
    switch shape {
    case .circle: AnyShape(Circle())
    case .primary:AnyShape(RoundedRectangle(cornerRadius: 5))
    }
  }
  @ViewBuilder
  var circleIconView: some View {
  
      if shape == .circle && hasIcon  {
       
            icon
              foregroundStyle(buttonFontColor)
          
    }
  }
}
#Preview {
  registerFonts()
    return PlayButton()
}
