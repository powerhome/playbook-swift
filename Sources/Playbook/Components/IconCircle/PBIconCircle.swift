//
//  PBIconCircle.swift
//
//
//  Created by Alexandre da Silva on 08/12/21.
//

import SwiftUI

public struct PBIconCircle: View {
  var icon: PlaybookGenericIcon
  var size: PBIcon.IconSize
  var color: Color

  public init(
    _ icon: PlaybookGenericIcon,
    size: PBIcon.IconSize = .medium,
    color: Color = .status(.neutral)
  ) {
    self.icon = icon
    self.size = size
    self.color = color
  }

  public var body: some View {
    ZStack {
      PBIcon(icon, size: size)
        .iconCircle(diameter: size.fontSize * 2.4, color: color)
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
      .background(color.opacity(0.12))
      .cornerRadius(diameter / 2)
  }
}

private extension View {
  func iconCircle(diameter: CGFloat, color: Color) -> some View {
    modifier(IconCircle(diameter: diameter, color: color))
  }
}

@available(macOS 13.0, *)
public struct PBIconCircle_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    return IconCircleCatalog()
  }
}
