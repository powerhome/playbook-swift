//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBButton.swift
//

import SwiftUI

public struct PBButton: View {
  var fullWidth: Bool
  var variant: Variant
  var size: Size
  var shape: Shape
  var title: String?
  var icon: PBIcon?
  var iconPosition: IconPosition?
  var iconColor: Color
  @Binding var isLoading: Bool
  var customView: AnyView?
  let action: (() -> Void)?
  @Environment(\.colorScheme) var colorScheme
  
  public init(
    fullWidth: Bool = false,
    variant: Variant = .primary,
    size: Size = .medium,
    shape: Shape = .primary,
    title: String? = nil,
    icon: PBIcon? = nil,
    iconPosition: IconPosition? = .left,
    iconColor: Color = .text(.light),
    isLoading: Binding<Bool> = .constant(false),
    customView: AnyView? = nil,
    action: (() -> Void)? = nil
  ) {
    self.fullWidth = fullWidth
    self.variant = variant
    self.size = size
    self.shape = shape
    self.title = title
    self.icon = icon
    self.iconPosition = iconPosition
    self.iconColor = iconColor
    self._isLoading = isLoading
    self.customView = customView
    self.action = action
  }
  
  public var body: some View {
    Button {
      action?()
    } label: {
      HStack {
        if isLoading {
          PBLoader(color: variant.foregroundColor(colorScheme: colorScheme))
        } else {
          if let customView = customView {
            customView
          } else {
            icon.foregroundStyle(iconColor)
            if let title = title, shape == .primary {
              Text(title)
            }
          }
        }
      }
      .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
      .frame(maxWidth: fullWidth ? .infinity : nil)
    }
    .customButtonStyle(
      variant: customView != nil ? .link : variant,
      shape: shape,
      size: size
    )
    .disabled(variant == .disabled ? true : false)
  }
}

public extension PBButton {
  enum Shape {
    case primary
    case circle
  }
  
  enum Size {
    case small
    case medium
    case large
    
    public var fontSize: CGFloat {
      switch self {
      case .small:
        return 12
      case .medium:
        return 14
      case .large:
        return 18
      }
    }
    
    func verticalPadding(_ variant: PBButton.Variant) -> CGFloat {
      return variant == .link ? 0 : fontSize / 2
    }
    
    func horizontalPadding(_ variant: PBButton.Variant) -> CGFloat {
      return variant == .link ? 0 : fontSize * 2.42
    }
    
    func minHeight(_ variant: PBButton.Variant) -> CGFloat {
      if variant != .link {
        switch self {
        case .small:
          return 30
        case .medium:
          return 40
        case .large:
          return 45
        }
      } else {
        return 0
      }
    }
  }
  
  enum IconPosition {
    case left
    case right
  }
}

#Preview {
  registerFonts()
  return ButtonsCatalog()
}
