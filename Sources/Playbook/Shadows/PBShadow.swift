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
        } else {
            return AnyView(
                self.shadow(color: shadow.color, radius: shadow.radius, x: 0, y: 6))
        }
    }
}

public enum Shadow: String, CaseIterable {
    case deep
    case deeper
    case deepest

    var color: Color {
        switch self {
        case .deep: return Color.pbShadow.opacity(0.74)
        default: return Color.pbShadow
        }
    }

    var radius: CGFloat {
        switch self {
        case .deep: return 4
        case .deeper: return 10
        default: return 14
        }
    }
}

struct PBShadow_Previews: PreviewProvider {
    static var previews: some View {
        let shape = RoundedRectangle(cornerRadius: 7)
        List(Shadow.allCases, id: \.hashValue) { shadow in
            Section(shadow.rawValue) {
                shape
                    .foregroundColor(.white)
                    .frame(height: 100)
                    .pbShadow(shadow)
                    .overlay {
                        shape
                            .stroke(.gray, lineWidth: 0.1)
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}
