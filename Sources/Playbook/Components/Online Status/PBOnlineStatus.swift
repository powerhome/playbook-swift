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
  let strokeColor: Color
  let backgroundColor: Color
  let size: Size
  let hasBorder: Bool
  public init(
    strokeColor: Color = .white,
    backgroundColor: Color = .status(.neutral),
    size: Size = .small,
    hasBorder: Bool = false
  ) {
    self.strokeColor = strokeColor
    self.backgroundColor = backgroundColor
    self.size = size
    self.hasBorder = hasBorder
  }
    public var body: some View {
      statusView
    }
}

public extension PBOnlineStatus {
  enum Size {
    case small, medium, large
  }
  var statusView: some View {
    Circle()
      .stroke(hasBorder ? strokeColor : .clear, lineWidth: hasBorder ? 2 : 0)
      .background(Circle().fill(backgroundColor))
      .frame(width: statusSize, height: statusSize)
  }
  var statusSize: CGFloat {
    switch size {
    case .small: return 8
    case .medium: return 10
    case .large: return 12
    }
  }
}
#Preview {
  registerFonts()
   return PBOnlineStatus()
}
