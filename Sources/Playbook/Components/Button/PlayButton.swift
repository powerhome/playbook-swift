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
  var size: Size
  var shape: Shape
  var title: String?
  var icon: PBIcon?
  var iconPosition: IconPosition?
  let action: (() -> Void)?
  @Binding var isLoading: Bool
  
  public init(
      variant: Variant = .primary,
      hasIcon: Bool = false,      
      size: Size = .medium,
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
    self.size = size
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
      .pbFont(fontSize, variant: .bold, color: buttonFontColor)
      .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
    }
    .padding(.horizontal, shape == .primary ? Spacing.xLarge : Spacing.none)
    .padding(.vertical, Spacing.small)
    .frame(maxWidth: fullWidth ? .infinity : nil)
    .frame(width: circleButtonFrame, height: circleButtonFrame)
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
  }
  enum Shape {
    case primary
    case circle
    
  }
  enum Size {
    case small
    case medium
    case large
    case `default`
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
    case .primary: AnyShape(RoundedRectangle(cornerRadius: 5))
    }
  }
  var circleButtonFrame: CGFloat? {
    shape == .circle ? 40 : nil
  }
  var fontSize: PBFont {
    switch size {
        case .small:
      return .buttonText(12)
        case .medium:
      return .buttonText(14)
        case .large:
      return .buttonText(18)
    case .default: return .buttonText(16)
    }
  }
}
#Preview {
  registerFonts()
    return PlayButton()
}
