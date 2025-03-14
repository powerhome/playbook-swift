//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBIconCircle.swift
//

import SwiftUI

public struct PBIconCircle: View {
  var icon: PlaybookGenericIcon
  var size: Size
  var color: PBIconCircle.IconColor

  public init(
    _ icon: PlaybookGenericIcon,
    size: Size = .small,
    color: PBIconCircle.IconColor = .custom(.text(.light))
  ) {
    self.icon = icon
    self.size = size
    self.color = color
  }

  public var body: some View {
    ZStack {
      PBIcon(icon, size: .custom(size.iconSize))
        .iconCircle(diameter: size.circleSize, color: color.color)
    }
  }
}

public extension PBIconCircle {
  enum Size: CaseIterable {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge

    var iconSize: CGFloat {
      switch self {
        case .xxSmall: return 10
        case .xSmall: return 10.64
        case .small: return 14.44
        case .medium: return 22.8
        case .large: return 30.4
        case .xLarge: return 38
      }
    }

    var circleSize: CGFloat {
      switch self {
        case .xxSmall: return 16
        case .xSmall: return 28
        case .small: return 38
        case .medium: return 60
        case .large: return 80
        case .xLarge: return 100
      }
    }
  }

  enum IconColor: Hashable  {
    case royal
    case orange
    case purple
    case teal
    case red
    case yellow
    case green
    case custom(Color)

    public static let allCases: [PBIconCircle.IconColor] = [.royal, .orange, .purple, .teal, .red, .yellow, .green]

    var color: Color {
      switch self {
        case .royal: return .pbPrimary
        case .orange: return .data(.data5)
        case .purple: return .data(.data3)
        case .teal: return .data(.data7)
        case .red: return .status(.error)
        case .yellow: return .data(.data2)
        case .green: return .status(.success)
        case .custom(let color): return color
      }
    }
  }
}

private struct IconCircle: ViewModifier {
  var diameter: CGFloat
  var color: Color

  func body(content: Content) -> some View {
    content
      .foregroundColor(color)
      .frame(
        width: diameter,
        height: diameter,
        alignment: .center
      )
      .background(color.opacity(0.1))
      .cornerRadius(diameter/2)
  }
}

private extension View {
  func iconCircle(diameter: CGFloat, color: Color) -> some View {
    modifier(IconCircle(diameter: diameter, color: color))
  }
}

#Preview {
  registerFonts()
  return VStack(alignment: .leading, spacing: Spacing.small) {

    ForEach(PBIconCircle.Size.allCases, id: \.self) { size in
      PBIconCircle(FontAwesome.rocket, size: size)
    }
  }
}
