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
  func pbShadow(_ shadow: Shadow) -> some View {
    if shadow == .deepest {
      return AnyView(
        self.shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 10)
          .shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 10)
      )
    } else {
      return AnyView(
        self.shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 6))
    }
  }
}

public enum Shadow: String, CaseIterable {
  case deep, deeper, deepest, shadowDark, none
  
  var color: Color {
    switch self {
    case .deep: return .shadow.opacity(0.74)
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
