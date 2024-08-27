//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBButtonStyle.swift
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
    var variant: PBButton.Variant
    var size: PBButton.Size
    var shape: PBButton.Shape
    @State private var isHovering = false
    @Environment(\.colorScheme) var colorScheme
    
    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        let isPrimaryVariant = variant == .primary
        
        configuration.label
            .padding(.vertical, shape.verticalPadding(size: size, variant: variant))
            .padding(.horizontal, shape.horizontalPadding(size: size, variant: variant))
            .frame(minWidth: shape.minWidth, minHeight: shape.minHeight(size: size, variant: variant))
            .background(
                variant
                    .backgroundAnimation(
                        configuration: configuration,
                        isHovering: isHovering,
                        colorScheme: colorScheme
                    )
                    .primaryVariantBrightness(
                        isPrimaryVariant: isPrimaryVariant,
                        isPressed: isPressed,
                        isHovering: isHovering
                    )
            )
            .foregroundColor(
              variant.foregroundAnimation(
                configuration: configuration,
                isHovering: isHovering,
                colorScheme: colorScheme
              )
            )
            .clipShape(ButtonShape(shape: shape))
            .onHover(disabled: variant == .disabled ? true : false) {
                self.isHovering = $0
            }
            .pbFont(.buttonText(size.fontSize))
    }
}

extension PBButtonStyle {
    struct ButtonShape: Shape {
        let shape: PBButton.Shape
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            switch shape {
                case .circle:
                    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
                    path.closeSubpath()
                    return path
                case .primary:
                    let cornerRadius: CGFloat = 5
                    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                    path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
                    path.closeSubpath()
                    return path
            }
        }
    }
}

#Preview {
    registerFonts()
    return VStack {
        HStack(spacing: Spacing.small) {
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
        
        HStack(spacing: Spacing.small) {
            PBButton(
                shape: .primary,
                icon: PBIcon.fontAwesome(.plus, size: .x1),
                action: {}
            )
            PBButton(
                variant: .secondary,
                shape: .primary,
                icon: PBIcon.fontAwesome(.pen, size: .x1),
                action: {}
            )
            PBButton(
                variant: .disabled,
                shape: .primary,
                icon: PBIcon.fontAwesome(.times, size: .x1)
            )
            PBButton(
                variant: .link,
                shape: .primary,
                icon: PBIcon.fontAwesome(.user, size: .x1),
                action: {}
            )
        }
    }
}
