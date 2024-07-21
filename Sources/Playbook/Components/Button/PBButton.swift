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
  var variant: PBButtonStyle.Variant
  var size: PBButtonStyle.Size
  var shape: Shape
  var title: String?
  var icon: PBIcon?
  var iconPosition: IconPosition?
  let action: (() -> Void)?
  @Binding var isLoading: Bool
  @Binding var isHovering: Bool
  @Binding var isPressed: Bool
  
  public init(
    variant: PBButtonStyle.Variant = .primary,
    size: PBButtonStyle.Size = .medium,
    shape: Shape = .primary,
    title: String? = nil,
    icon: PBIcon? = nil,
    iconPosition: IconPosition? = .left,
    isLoading: Binding<Bool> = .constant(false),
    isHovering: Binding<Bool> = .constant(false),
    isPressed: Binding<Bool> = .constant(false),
    fullWidth: Bool = false,
    action: (() -> Void)? = nil
  ) {
    self.fullWidth = fullWidth
    self.variant = variant
    self.size = size
    self.shape = shape
    self.title = title
    self.icon = icon
    self.iconPosition = iconPosition
    self._isLoading = isLoading
    self._isHovering = isHovering
    self._isPressed = isPressed
    self.action = action
  }
  
  public var body: some View {
    buttonView
  }
}

public extension PBButton {
  
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
    
    public var buttonSize: CGFloat {
      switch self {
      case .small: return 12
      case .medium: return 10
      case .large: return 20
      default: return 0
      }
    }
  }
  
  var buttonView: some View {
    Button {
      action?()
      
    } label: {
      buttonLabelView
      
    }
    .buttonStyle(PBButtonStyle(variant: variant, size: self.size))
    .clipShape(buttonShape)
    .disabled(variant == .disabled ? true : false)
  }
  var buttonLabelView: some View {
    HStack {
      icon
      if isLoading {
        PBLoader(color: loaderColor)
      } else {
        if let title = title, shape == .primary {
          Text(title)
        }
      }
    }
    .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, verticalPadding)
    .frame(maxWidth: frameWidth)
    .frame(width: circleButtonFrame, height: circleButtonFrame)
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
  var horizontalPadding: CGFloat {
    shape == .primary && variant != .link ? Spacing.xLarge : buttonSize
  }
  var verticalPadding: CGFloat {
    variant != .link ? Spacing.small : Spacing.none
  }
  var frameWidth: CGFloat? {
    fullWidth ? .infinity : nil
  }
  var buttonSize: CGFloat {
    switch size {
    case .small: return 12
    case .medium: return 10
    case .large: return 20
    default: return 0
    }
  }
  var loaderColor: Color {
    variant == .primary ? .white : .pbPrimary
  }
}
#Preview {
  registerFonts()
  return PBButton()
}

//public struct PBButton: View {
//    var fullWidth: Bool
//    var variant: Variant
//    var size: Size
//    var shape: Shape
//    var title: String?
//    var icon: PBIcon?
//    var iconPosition: IconPosition?
//    let action: (() -> Void)?
//    @Binding var isLoading: Bool
//    
//    public init(
//        variant: Variant = .primary,
//        size: Size = .medium,
//        shape: Shape = .primary,
//        title: String? = nil,
//        icon: PBIcon? = nil,
//        iconPosition: IconPosition? = .left,
//        isLoading: Binding<Bool> = .constant(false),
//        fullWidth: Bool = false,
//        action: (() -> Void)? = nil
//    ) {
//        self.fullWidth = fullWidth
//        self.variant = variant
//        self.size = size
//        self.shape = shape
//        self.title = title
//        self.icon = icon
//        self.iconPosition = iconPosition
//        self._isLoading = isLoading
//        self.action = action
//    }
//    
//    public var body: some View {
//     
//        Button {
//            action?()
//        } label: {
//            HStack {
//                icon
//                if isLoading {
//                    PBLoader(color: variant.foregroundColor)
//                } else {
//                    if let title = title, shape == .primary {
//                        Text(title)
//                    }
//                }
//            }
//            .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
//            .frame(maxWidth: fullWidth ? .infinity : nil)
//        }
//        //.buttonStyle(PBButtonStyle(variant: variant, size: size, shape: shape))
//        .disabled(variant == .disabled ? true : false)
//    }
//}

//public extension PBButton {
//    enum Shape {
//        case primary
//        case circle
//        
//        var minWidth: CGFloat {
//            switch self {
//                case .primary: return 0
//                case .circle: return 40
//            }
//        }
//        
//        func minHeight(size: PBButton.Size, variant: PBButton.Variant) -> CGFloat {
//            switch self {
//                case .primary: return size.minHeight(variant)
//                case .circle: return 40
//            }
//        }
//        
//        func verticalPadding(size: PBButton.Size, variant: PBButton.Variant) -> CGFloat {
//            switch self {
//                case .primary: return size.verticalPadding(variant)
//                case .circle: return 0
//            }
//        }
//        
//        func horizontalPadding(size: PBButton.Size, variant: PBButton.Variant) -> CGFloat {
//            switch self {
//                case .primary: return size.horizontalPadding(variant)
//                case .circle: return 0
//            }
//        }
//    }
//    
//    enum Size {
//        case small
//        case medium
//        case large
//        
//        public var fontSize: CGFloat {
//            switch self {
//                case .small:
//                    return 12
//                case .medium:
//                    return 14
//                case .large:
//                    return 18
//            }
//        }
//        
//        func verticalPadding(_ variant: PBButton.Variant) -> CGFloat {
//            return variant == .link ? 0 : fontSize / 2
//        }
//        
//        func horizontalPadding(_ variant: PBButton.Variant) -> CGFloat {
//            return variant == .link ? 0 : fontSize * 2.42
//        }
//        
//        func minHeight(_ variant: PBButton.Variant) -> CGFloat {
//            if variant != .link {
//                switch self {
//                    case .small:
//                        return 30
//                    case .medium:
//                        return 40
//                    case .large:
//                        return 45
//                }
//            } else {
//                return 0
//            }
//        }
//    }
//    
//    enum IconPosition {
//        case left
//        case right
//    }
//}

//#Preview {
//    registerFonts()
//    return ButtonsCatalog()
//}
