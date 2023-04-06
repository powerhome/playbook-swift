//
//  PBButtonStyle.swift
//
//
//  Created by Lucas C. Feijo on 16/07/21.
//

import SwiftUI

public struct PBButton: View {
  var variant: PBButtonVariant
  var size: PBButtonSize
  var shape: PBButtonShape
  var title: String?
  var disabled: Bool
  let action: (() -> Void)
  @State private var isHovering: Bool = false

  public init(
    variant: PBButtonVariant = .primary,
    size: PBButtonSize = .medium,
    shape: PBButtonShape = .primary,
    title: String? = nil,
    disabled: Bool = false,
    action: @escaping (() -> Void)
  ) {
    self.variant = disabled == true ? .disabled : variant
    self.size = size
    self.shape = shape
    self.title = title
    self.disabled = disabled
    self.action = action
  }

  public var body: some View {
    Button {
      action()
    } label: {
      HStack {
        PBIcon.fontAwesome(.user, size: .x1)
        if let title = title {
          Text(title)
        }
      }
    }
    .buttonStyle(
      PBButtonStyle2(
        variant: variant,
        shape: shape,
        size: size
      )
    )
    .disabled(disabled)
  }

  public struct PBButtonStyle2: ButtonStyle {
    var variant: PBButtonVariant
    var shape: PBButtonShape
    var size: PBButtonSize

    public func makeBody(configuration: Configuration) -> some View {
      let isPressed = configuration.isPressed

      configuration.label
        .padding(.vertical, size.verticalPadding())
        .padding(.horizontal, size.horizontalPadding())
        .frame(minWidth: 0, minHeight: size.minHeight())
        .background(
          background(for: configuration)
            .brightness(variant == .primary && isPressed ? -0.04 : 0)
        )
        .foregroundColor(
          variant == .link && isPressed
            ? .pbTextDefault
            : foregroundColor(variant)
        )
        .cornerRadius(5)
        .pbFont(.buttonText(size.fontSize))
    }

    private func background(for configuration: Configuration) -> some View {
      configuration.isPressed ? activeBackgroundColor(variant) : backgroundColor(variant)
    }

    private func backgroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .secondary: return .pbPrimary.opacity(0.05)
      case .link: return .clear
      case .disabled: return .pbNeutral.opacity(0.5)
      default: return .pbPrimary
      }
    }

    private func activeBackgroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      default: return .pbPrimary
      }
    }

    private func foregroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .primary: return .white
      case .disabled: return .pbTextDefault.opacity(0.5)
      default: return .pbPrimary
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
}

// DON'T TOUCH THIS
// DON'T TOUCH THIS
// DON'T TOUCH THIS
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
    let isPressed = configuration.isPressed && !disabled
    let primaryVariant = variant == .primary
    let linkVariant = variant == .link

    let primaryVariantPressed = primaryVariant && isPressed
    let primaryVariantPressedHovered = primaryVariant && (isPressed || isHovering) && !disabled
    let linkVariantPressedHovered = linkVariant && (isPressed || isHovering) && !disabled

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
        #if os(macOS)
        .brightness(primaryVariantPressed ? 0 : -0.04)
        #endif
        .brightness(primaryVariantPressedHovered ? -0.04 : 0)
      )
      .foregroundColor(
        linkVariantPressedHovered
          ? linkForegroundColor(colorScheme, isPressed: isPressed)
          : variant.foregroundColor(disabled, colorScheme: colorScheme)
      )
      .cornerRadius(5)
      .pbFont(.buttonText(size.fontSize))
    #if os(macOS)
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
    let isPressed = configuration.isPressed && !disabled
    let hovering = isHovering && !disabled

    #if os(macOS)
      if isPressed {
        switch (variant, colorScheme) {
        case (.secondary, .light): return .pbPrimary.opacity(0.05)
        case (.secondary, .dark): return .pbPrimary.opacity(0.05)
        case (.link, _): return .clear
        default: return .pbPrimary
        }
      }
    #endif

    if isPressed || hovering {
      switch (variant, colorScheme) {
      case (.secondary, .light): return .pbPrimary.opacity(0.3)
      case (.secondary, .dark): return .pbPrimary.opacity(0.2)
      case (.link, _): return .clear
      default: return .pbPrimary
      }
    }

    return variant.backgroundColor(disabled, colorScheme: colorScheme)
  }

  private func linkForegroundColor(
    _ colorScheme: ColorScheme,
    isPressed: Bool
  ) -> Color {
    #if os(macOS)
      if isPressed {
        switch colorScheme {
        case .dark: return .white
        default: return .pbPrimary
        }
      }
    #endif

    switch colorScheme {
    case .dark: return .white.opacity(0.5)
    default: return .pbTextDefault
    }
  }
}
// DON'T TOUCH THIS
// DON'T TOUCH THIS
// DON'T TOUCH THIS

public enum PBButtonVariant {
  case primary
  case secondary
  case link
  case disabled

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
    default: return .black
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
      default: return .white.opacity(0.2)
      }
    case .link:
      switch (disabled, colorScheme) {
      default: return .clear
      }
    default: return .black
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

public enum PBButtonShape {
  case primary
  case circle
}

@available(macOS 13.0, *)
struct PBButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack {
      PBButton(action: {})
      PBButton(variant: .secondary, title: "Test", action: {})
      PBButton(variant: .link, action: {})
      PBButton(disabled: true, action: {})
    }
  }
}
