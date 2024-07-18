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
    let action: (() -> Void)?
    @Binding var isLoading: Bool
    
    public init(
        variant: Variant = .primary,
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
                    PBLoader(color: variant.foregroundColor)
                } else {
                    if let title = title, shape == .primary {
                        Text(title)
                    }
                }
            }
            .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
            .frame(maxWidth: fullWidth ? .infinity : nil)
        }
        .buttonStyle(PBButtonStyle(variant: variant, size: size, shape: shape))
        .disabled(variant == .disabled ? true : false)
    }
}

public extension PBButton {
    enum Shape {
        case primary
        case circle
        
        var minWidth: CGFloat {
            switch self {
                case .primary: return 0
                case .circle: return 40
            }
        }
        
        func minHeight(size: PBButton.Size, variant: PBButton.Variant) -> CGFloat {
            switch self {
                case .primary: return size.minHeight(variant)
                case .circle: return 40
            }
        }
        
        func verticalPadding(size: PBButton.Size, variant: PBButton.Variant) -> CGFloat {
            switch self {
                case .primary: return size.verticalPadding(variant)
                case .circle: return 0
            }
        }
        
        func horizontalPadding(size: PBButton.Size, variant: PBButton.Variant) -> CGFloat {
            switch self {
                case .primary: return size.horizontalPadding(variant)
                case .circle: return 0
            }
        }
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
