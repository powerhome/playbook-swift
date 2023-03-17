//
//  PBButtonStyle.swift
//  
//
//  Created by Lucas C. Feijo on 16/07/21.
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
  var variant: PBButtonVariant = .primary
  var size: PBButtonSize = .medium
  var disabled: Bool = false
  @State private var isHovering: Bool = false
  @Environment(\.colorScheme) var colorScheme

  public init(
    variant: PBButtonVariant? = .primary,
    size: PBButtonSize? = .medium,
    disabled: Bool? = false,
    isHovering: Bool? = false
  ) {
    self.variant = variant ?? self.variant
    self.disabled = disabled ?? self.disabled
    self.size = size ?? self.size
  }

  public func makeBody(configuration: Configuration) -> some View {
    let isPressedOrHovered = (configuration.isPressed || isHovering) && !disabled
    let primaryVariantPressedHovered = variant == .primary && isPressedOrHovered
    let linkVariantPressedHovered = variant == .link && isPressedOrHovered

    configuration.label
      .padding(.vertical, size.verticalPadding())
      .padding(.horizontal, size.horizontalPadding())
      .frame(minWidth: 0, minHeight: size.minHeight())
      .background(
        backgroundColor(
          configuration,
          variant: variant,
          disabled: disabled,
          isHovering: isHovering
        )
      )
      .brightness(primaryVariantPressedHovered ? -0.04 : 0)
      .foregroundColor(
        linkVariantPressedHovered
          ? linkForegroundColor(colorScheme)
          : variant.foregroundColor(disabled, colorScheme: colorScheme)
      )
      .cornerRadius(5)
      .pbFont(.buttonText(size.fontSize))
      #if os(macOS)
        .opacity(configuration.isPressed && !disabled ? 0.8 : 1)
        .onHover { hovering in
          isHovering = hovering

          switch (isHovering, disabled) {
          case (true, true): NSCursor.operationNotAllowed.set()
          case (true, false): NSCursor.pointingHand.set()
          default: NSCursor.arrow.set()
          }
        }
      #endif
  }

  private func backgroundColor(
    _ configuration: Configuration,
    variant: PBButtonVariant,
    disabled: Bool,
    isHovering: Bool
  ) -> Color {
    let isPressedOrHovered = (configuration.isPressed || isHovering) && !disabled

    if isPressedOrHovered {
      switch (variant, colorScheme) {
      case (.secondary, .light): return .pbPrimary.opacity(0.3)
      case (.secondary, .dark): return .pbPrimary.opacity(0.2)
      case (.link, _): return .clear
      default: return .pbPrimary
      }
    }

    return variant.backgroundColor(disabled, colorScheme: colorScheme)
  }

  private func linkForegroundColor(_ colorScheme: ColorScheme) -> Color {
    switch colorScheme {
    case .dark: return .white.opacity(0.5)
    default: return .pbTextDefault
    }
  }
}

public enum PBButtonVariant {
  case primary
  case secondary
  case link

  func foregroundColor(_ disabled: Bool, colorScheme: ColorScheme) -> Color {
    if disabled { return Color.pbTextDefault.opacity(0.5) }

    switch self {
    case .primary:
      switch colorScheme {
      default: return .white
      }
    case .secondary, .link:
      switch colorScheme {
      case .light: return .pbPrimary
      default: return .white
      }
    }
  }

  func backgroundColor(_ disabled: Bool, colorScheme: ColorScheme) -> Color {
    switch self {
    case .primary:
      switch (disabled, colorScheme) {
      case (true, _ ): return .pbNeutral.opacity(0.5)
      case (false, _): return .pbPrimary
      }
    case .secondary:
      switch (disabled, colorScheme) {
      default: return .pbNeutral.opacity(0.5)
      }
    case .link:
      switch (disabled, colorScheme) {
      default: return .clear
      }
    }
  }
}

public enum PBButtonSize {
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

  func verticalPadding() -> CGFloat {
    return fontSize / 2
  }

  func horizontalPadding() -> CGFloat {
    return fontSize * 2.42
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
        Button("Button Primary") {}
          .buttonStyle(PBButtonStyle())
        Button("Button Disabled") {}
          .buttonStyle(PBButtonStyle(disabled: true))
        Button("Button Secondary") {}
          .buttonStyle(PBButtonStyle(variant: .secondary))
        Button("Button Link") {}
          .buttonStyle(PBButtonStyle(variant: .link))
        Button("Button Link Disabled") {}
          .buttonStyle(PBButtonStyle(variant: .link, disabled: true))

        HStack {
          Button("Cancel") {}
            .buttonStyle(PBButtonStyle(variant: .secondary, size: .small))

          Button("Save") {}
            .buttonStyle(PBButtonStyle(variant: .primary, size: .small))
        }

        Button("Button Primary Medium") {}
          .buttonStyle(PBButtonStyle(variant: .primary, size: .medium))

        Button("Button Primary Large") {}
          .buttonStyle(PBButtonStyle(variant: .primary, size: .large))
      }
      .padding(.horizontal, 20)
    }
  }
}
