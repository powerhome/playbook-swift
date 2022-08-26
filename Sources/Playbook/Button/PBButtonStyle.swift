//
//  PBButtonStyle.swift
//  
//
//  Created by Lucas C. Feijo on 16/07/21.
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {

    // MARK: Props
    var variant: PBButtonVariant = .primary
    var size: PBButtonSize = .medium
    var disabled: Bool = false
    var fullWidth: Bool = false
    //

    public init(variant: PBButtonVariant? = .primary,
                size: PBButtonSize? = .medium,
                disabled: Bool? = false,
                fullWidth: Bool? = false) {
        self.variant = variant ?? self.variant
        self.disabled = disabled ?? self.disabled
        self.fullWidth = fullWidth ?? self.fullWidth
        self.size = size ?? self.size
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onHover { isHovering in
                #if os(macOS)
                if disabled { return }
                if isHovering {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
                #endif
            }
            .padding(.vertical, size.verticalPadding())
            .padding(.horizontal, size.horizontalPadding())
            .frame(minWidth: 0, maxWidth: fullWidth ? .infinity : nil, minHeight: size.minHeight())
            .background(variant.backgroundColor(disabled))
            .foregroundColor(variant.foregroundColor(disabled))
            .cornerRadius(5)
            .font(.pb(.buttonText(size)))
            .modifier(OnHover(disabled: disabled))
            .brightness(configuration.isPressed && !disabled ? 0.04 : 0.0)
    }
}

struct OnHover: ViewModifier {
    var disabled: Bool
//    @State private var isHovering = false

    func body(content: Content) -> some View {
        content
#if os(macOS)
            .onHover { isHovering in
              if isHovering {
                NSCursor.pointingHand.push()
              } else {
                NSCursor.pop()
              }
              // the code below conflicts with pointingHand
//                withAnimation(.easeInOut(duration: 0.2)) {
//                    self.isHovering = isHovering
//                }
            }
//            .brightness(isHovering && !disabled ? -0.04 : 0.0)
#endif
    }
}

public enum PBButtonVariant {
    case primary
    case secondary
    case link

    func foregroundColor(_ disabled: Bool) -> Color {
        if disabled { return Color.pbTextDefault.opacity(0.5) }
        switch self {
        case .primary: return .white
        case .secondary: return .pbPrimary
        case .link: return .pbPrimary
        }
    }

    func backgroundColor(_ disabled: Bool) -> Color {
        switch (self, disabled) {
        case (.primary, true): return Color.pbNeutral.opacity(0.4)
        case (.primary, false): return .pbPrimary
        case (.secondary, _): return Color.pbPrimary.opacity(0.05)
        case (.link, _): return .clear
        }
    }
}

public enum PBButtonSize {
    case small
    case medium
    case large
    
    func fontSize() -> CGFloat {
        switch (self) {
        case .small:
            return 12
        case .medium:
            return 14
        case .large:
            return 18
        }
    }
    
    func verticalPadding() -> CGFloat {
        return fontSize() / 2
    }
    
    func horizontalPadding() -> CGFloat {
        return fontSize() * 2.42
    }
    
    func minHeight() -> CGFloat {
        return self == .small ? 36 : 40
    }
}

struct PBButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()

        return Group {
            VStack {
                Button("Button Primary") {
                }.buttonStyle(PBButtonStyle())
                
                Button("Button Primary Disabled") {
                }.buttonStyle(PBButtonStyle(disabled: true))
                Button("Button Secondary") {
                }.buttonStyle(PBButtonStyle(variant: .secondary))
                Button("Button Secondary Disabled") {
                }.buttonStyle(PBButtonStyle(variant: .secondary,
                                            disabled: true))
                Button("Button Link") {
                }.buttonStyle(PBButtonStyle(variant: .link))
                Button("Button Link Disabled") {
                }.buttonStyle(PBButtonStyle(variant: .link,
                                            disabled: true))
                Button("Button Full Width") {
                }.buttonStyle(PBButtonStyle(fullWidth: true))
                
                HStack {
                    Button("Cancel") {
                    }.buttonStyle(PBButtonStyle(variant: .secondary, size: .small))
                    
                    Button("Save") {
                    }.buttonStyle(PBButtonStyle(variant: .primary, size: .small))
                }
                Button("Button Primary Medium") {
                }.buttonStyle(PBButtonStyle(variant: .primary, size: .medium))

                Button("Button Primary Large") {
                }.buttonStyle(PBButtonStyle(variant: .primary, size: .large))
            }.padding(.horizontal, 20)
        }
    }
}
