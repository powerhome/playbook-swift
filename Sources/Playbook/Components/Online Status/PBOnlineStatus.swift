//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBOnlineStatus.swift
//

import SwiftUI

public struct PBOnlineStatus: View {
  let color: Color
  let size: Size
  let borderColor: Color?
  let variant: Variant
  @Environment(\.colorScheme) var colorScheme
  public init(
    color: Color = .status(.neutral),
    size: Size = .small,
    borderColor: Color? = .white,
    variant: Variant = .border
  ) {
    self.borderColor = borderColor
    self.color = color
    self.size = size
    self.variant = variant
  }
  public var body: some View {
    statusView
  }
}

public extension PBOnlineStatus {
  enum Variant {
    case border, borderless
  }
  private var hasBorder: Bool {
    return borderColor != nil
  }
  
  private var statusView: some View {
    Circle()
      .stroke(_borderColor, lineWidth: borderWidth)
      .background(Circle().fill(color))
      .frame(width: _size, height: _size)
  }
  
  var _borderColor: Color {
    switch variant {
    case .border: return colorScheme == .dark ? Color(hex: "#0a0527") : borderColor ?? .clear
    case .borderless: return .clear
    }
  }
  var borderWidth: CGFloat {
    switch variant {
    case .border: return 2
    case .borderless: return 0
    }
  }
  private var _size: CGFloat {
    switch size {
    case .small: return hasBorder ? 8 : 6
    case .medium: return hasBorder ? 10 : 8
    case .large: return hasBorder ? 12 : 10
    }
  }
  
  enum Size {
    case small, medium, large
  }
}

#Preview {
  registerFonts()
  return PBOnlineStatus()
}
