//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBShadow.swift
//

import SwiftUI

public extension View {
    func pbShadow(_ shadow: Shadow, x: CGFloat = 0, y: CGFloat = 6) -> some View {
    if shadow == .deepest {
      return AnyView(
        self.shadow(color: shadow.color.opacity(0.20), radius: shadow.radius, x: x, y: y * 1.6)
            .shadow(color: shadow.color.opacity(0.10), radius: shadow.radius, x: x, y: y * 1.6)
      )
    } else {
      return AnyView(
        self.shadow(color: shadow.color, radius: shadow.radius, x: x, y: y))
    }
  }
}

public enum Shadow: String, CaseIterable {
  case deep, deeper, deepest, shadowDark, none
  
  var color: Color {
    switch self {
    case .deep: return .shadow.opacity(0.16)
    case .deeper: return .shadow.opacity(0.18)
    case .shadowDark: return Color.background(.dark)
    case .none: return Color.clear
    default: return .shadow
    }
  }
  
  var radius: CGFloat {
    switch self {
    case .deep: return 4
    case .deeper: return 10
    case .none: return 0
    default: return 14
    }
  }
}

#Preview {
    let shape = RoundedRectangle(cornerRadius: 7)
    List(Shadow.allCases, id: \.hashValue) { shadow in
      Section(shadow.rawValue.uppercased()) {
        shape
          .frame(height: 80)
          .foregroundColor(.white)
          .pbShadow(shadow)
          .overlay {
            shape
              .stroke(.gray, lineWidth: 0.1)
          }
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
      }
      .listRowBackground(Color.clear)
      .navigationTitle("Shadows")
    }
}
