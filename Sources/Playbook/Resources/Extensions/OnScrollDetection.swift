//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  OnScrollDetection.swift
//

import SwiftUI

struct OnScrollDetection: ViewModifier {
    let id: String
    @State var scrollOffset: CGFloat = .zero
    let action: (() -> Void)

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo -> Color in
                    let offset = geo.frame(in: .named(id)).minY
                    DispatchQueue.main.async {
                        self.scrollOffset = offset
                    }
                    return Color.clear
                }
            )
            .onChange(of: scrollOffset) { newValue in
                action()
            }
    }
}

extension View {
    func onScroll(id: String = "scroll", action: @escaping (() -> Void)) -> some View {
        self.modifier(OnScrollDetection(id: id, action: action))
    }
}
