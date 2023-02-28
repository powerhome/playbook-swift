//
//  PBIconCircle.swift
//  
//
//  Created by Alexandre da Silva on 08/12/21.
//

import SwiftUI

public struct PBIconCircle: View {
    var icon: PlaybookGenericIcon
    var size: PBIcon.Size
    var color: Color

    public init(_ icon: PlaybookGenericIcon,
                size: PBIcon.Size = .medium,
                color: Color = .status(.neutral)) {
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
            .frame(width: diameter,
                   height: diameter,
                   alignment: .center)
            .background(color.opacity(0.12))
            .cornerRadius(diameter/2)
    }
}

fileprivate extension View {
    func iconCircle(diameter: CGFloat, color: Color) -> some View {
        self.modifier(IconCircle(diameter: diameter, color: color))
    }
}

@available(macOS 13.0, *)
struct PBIconCircle_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()

        return List {
            Section("Default") {
                PBIconCircle(FontAwesome.rocket)
            }

            Section("Size") {
                let pBIconSizes = [PBIcon.Size.small, PBIcon.Size.medium, PBIcon.Size.large]

                ForEach(pBIconSizes, id: \.self) { size in
                   PBIconCircle(FontAwesome.rocket, size: size)
                }
            }
            .listRowSeparator(.hidden)

            Section("Color") {
              let pBIconColors = [
                Color.data(.data1),
                Color.data(.data5),
                Color.data(.data3),
                Color.data(.data7),
                Color.data(.data8),
                Color.data(.data2),
                Color.data(.data4)
                ]

                ForEach(pBIconColors, id: \.self) { color in
                  PBIconCircle(FontAwesome.rocket, size: .small, color: color)
                }
            }
            .listRowSeparator(.hidden)
        }
    }
}
