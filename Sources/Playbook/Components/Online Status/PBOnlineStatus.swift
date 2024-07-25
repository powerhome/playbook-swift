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
    
    public init(
        color: Color = .status(.neutral),
        size: Size = .small,
        borderColor: Color? = .white
    ) {
        self.borderColor = borderColor
        self.color = color
        self.size = size
    }
    public var body: some View {
        statusView
    }
}

public extension PBOnlineStatus {
    private var hasBorder: Bool {
        return borderColor != nil
    }
    
    private var statusView: some View {
        Circle()
            .stroke(_borederColor, lineWidth: borderWidth)
            .background(Circle().fill(color))
            .frame(width: _size, height: _size)
    }
    
    private var _borederColor: Color {
        return borderColor ?? .clear
    }
    
    private var borderWidth: CGFloat {
        return hasBorder ? 2 : 0
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
    return VStack {
        PBOnlineStatus()
        PBOnlineStatus(borderColor: .black)
    }
}
