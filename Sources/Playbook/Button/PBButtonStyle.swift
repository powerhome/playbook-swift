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
  @State private var isPressed: Bool = false
  @Environment(\.colorScheme) var colorScheme

  public init(
    variant: PBButtonVariant? = .primary,
    size: PBButtonSize? = .medium,
    disabled: Bool? = false,
    isPressed: Bool? = false
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
        variant == .link && isPressed && !disabled
          ? linkForegroundColor(colorScheme)
          : variant.foregroundColor(disabled, colorScheme: colorScheme)
      )
      .cornerRadius(5)
      .pbFont(.buttonText(size.fontSize))
      .onTapGesture {
        if variant == .link && !disabled {
          toggleIsPressed()
        }
      }
  }

  @ViewBuilder private func background(for configuration: Configuration) -> some View {
    if configuration.isPressed && !disabled {
      switch (variant, colorScheme) {
      case (.secondary, .light): Color.pbPrimary.opacity(0.3)
      case (.secondary, .dark): Color.pbPrimary.opacity(0.2)
      case (.link, _): Color.clear
      default: Color.pbPrimary.brightness(-0.04)
      }
    } else {
      variant.backgroundColor(disabled, colorScheme: colorScheme)
    }
  }

  private func linkForegroundColor(_ colorScheme: ColorScheme) -> Color {
    switch colorScheme {
    case .dark: return Color.white.opacity(0.5)
    default: return Color.pbTextDefault
    }
  }

  private func toggleIsPressed() {
    self.isPressed.toggle()

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
      isPressed.toggle()
    }
  }
}

public enum PBButtonVariant {
  case primary
  case secondary
  case link

  func foregroundColor(_ disabled: Bool, colorScheme: ColorScheme) -> Color {
    if disabled { return Color.pbTextDefault.opacity(0.5) }

    if colorScheme == .light {
      switch self {
      case .primary: return .white
      case .secondary: return .pbPrimary
      case .link: return .pbPrimary
      }
    } else {
      switch self {
      default: return .white
      }
    }
  }

  func backgroundColor(_ disabled: Bool, colorScheme: ColorScheme) -> Color {
    if colorScheme == .light {
      switch (self, disabled) {
      case (.primary, true): return Color.pbNeutral.opacity(0.4)
      case (.primary, false): return Color.pbPrimary
      case (.secondary, _): return Color.pbPrimary.opacity(0.05)
      case (.link, _): return Color.clear
      }
    } else {
      switch (self, disabled) {
      case (.primary, true): return Color.pbNeutral.opacity(0.4)
      case (.primary, false): return Color.pbPrimary
      case (.secondary, _): return Color.white.opacity(0.2)
      case (.link, _): return Color.clear
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
