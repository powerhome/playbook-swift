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
  @Environment(\.colorScheme) var colorScheme

  public init(
    variant: PBButtonVariant? = .primary,
    size: PBButtonSize? = .medium,
    disabled: Bool? = false
  ) {
    self.variant = variant ?? self.variant
    self.disabled = disabled ?? self.disabled
    self.size = size ?? self.size
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, size.verticalPadding())
      .padding(.horizontal, size.horizontalPadding())
      .frame(minWidth: 0, minHeight: size.minHeight())
      .background(background(for: configuration))
      .foregroundColor(
        colorScheme == .light
          ? variant.foregroundColor(disabled)
          : variant.darkForegroundColor(disabled)
      )
      .cornerRadius(5)
      .pbFont(.buttonText(size.fontSize))
  }

  @ViewBuilder func background(for configuration: Configuration) -> some View {
    if configuration.isPressed && !disabled {
      if variant == .primary {
        Color.pbPrimary.brightness(-0.04)
      }

      if variant == .secondary {
        if colorScheme == .light {
          Color.pbPrimary.opacity(0.3)
        } else {
          Color.pbPrimary.opacity(0.2)
        }
      }
    } else {
      if colorScheme == .light {
        variant.backgroundColor(disabled)
      } else {
        variant.darkBackgroundColor(disabled)
      }
    }
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

  func darkForegroundColor(_ disabled: Bool) -> Color {
    if disabled { return Color.pbTextDefault.opacity(0.5) }

    switch self {
    case .primary: return .white
    case .secondary: return .white
    case .link: return .white
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

  func darkBackgroundColor(_ disabled: Bool) -> Color {
    switch (self, disabled) {
    case (.primary, true): return Color.pbNeutral.opacity(0.4)
    case (.primary, false): return .pbPrimary
    case (.secondary, _): return Color.white.opacity(0.2)
    case (.link, _): return .clear
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
        Button("Button Primary Disabled") {}
          .buttonStyle(PBButtonStyle(disabled: true))
        Button("Button Secondary") {}
          .buttonStyle(PBButtonStyle(variant: .secondary))
        Button("Button Secondary Disabled") {}
          .buttonStyle(PBButtonStyle(variant: .secondary, disabled: true))
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
