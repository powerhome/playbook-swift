//
//  PBShadow.swift
//
//
//  Created by Isis Silva on 09/02/23.
//

import SwiftUI

extension View {
  func pbShadow(_ shadow: Shadow) -> some View {
    if shadow == .deepest {
      return AnyView(
        self.shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 10)
          .shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 10)
      )
    } else if shadow == .top {
      
      return AnyView(
        self.shadow(color: shadow.color, radius: shadow.radius, x: 2, y: -5)
      )
    }else {
      return AnyView(
        self.shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 6))
    }
  }
}

public enum Shadow: String, CaseIterable {
  case deep, deeper, deepest, top, none
  
  var color: Color {
    switch self {
    case .deep: return .shadow.opacity(0.74)
    case .top: return .shadow.opacity(0.74)
    case .none: return Color.clear
    default: return .shadow
    }
  }
  
  var radius: CGFloat {
    switch self {
    case .deep: return 4
    case .deeper: return 10
    case .top: return 4
    case .none: return 0
    default: return 14
    }
  }
}

public struct PBShadow_Previews: PreviewProvider {
  public static var previews: some View {
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
}
