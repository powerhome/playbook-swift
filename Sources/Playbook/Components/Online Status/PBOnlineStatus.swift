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
  let status: Status?
  let color: Color?
  let size: Size
  let borderColor: Color?
  let variant: Variant
  @Environment(\.colorScheme) var colorScheme

  public init(
    status: Status? = nil,
    color: Color? = nil,
    size: Size = .small,
    borderColor: Color? = .white,
    variant: Variant = .border
  ) {
    self.status = status
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
      .background(Circle().fill(_color))
      .frame(width: _size, height: _size)
  }
  
  private var _color: Color {
    if let color = color {
      return color
    } else {
      if let status = status {
        return status.color
      } else {
        return .status(.neutral)
      }
    }
  }
  
  private var _borderColor: Color {
    switch variant {
    case .border: return colorScheme == .dark ? Color.background(.dark) : borderColor ?? .clear
    case .borderless: return .clear
    }
  }
    
  private var borderWidth: CGFloat {
    switch variant {
    case .border: return 2
    case .borderless: return 0
    }
  }
    
  private var _size: CGFloat {
    switch size {
    case .small: return hasBorder ? 12 : 10
    case .medium: return hasBorder ? 14 : 12
    case .large: return hasBorder ? 16 : 14
    }
  }
  
  enum Size {
    case small, medium, large
  }
    
  enum Status {
    case away
    case error
    case info
    case neutral
    case offline
    case online
    case primary
    case success
    case warning
    
    var color: Color {
      switch self {
      case .online: return .status(.success)
      case .away: return .status(.warning)
      case .offline: return .status(.neutral)
      case .error: return .status(.error)
      case .info: return .status(.info)
      case .neutral: return .status(.neutral)
      case .primary: return .pbPrimary
      case .success: return .status(.success)
      case .warning: return .status(.warning)
      }
    }
  }
}

#Preview {
  registerFonts()
  return PBOnlineStatus()
}
