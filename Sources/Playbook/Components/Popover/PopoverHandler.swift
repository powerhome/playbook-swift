//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverView: View {
    let id: Int
    let blockBackgroundInteractions: Bool
    @State private var opacity: CGFloat = 0.01
    @EnvironmentObject var popoverManager: PopoverManager
    
    init(
        id: Int,
        blockBackgroundInteractions: Bool
    ) {
        self.id = id
        self.blockBackgroundInteractions = blockBackgroundInteractions
    }
    
    var body: some View {
        ZStack {
            let isPresented = popoverManager.isPresented.first { $0.key == id }?.value
            let popover = popoverManager.popovers.first { $0.key == id }?.value
           
            if isPresented ?? false {
                background
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    popover?.view
                        .position(popover?.position ?? .zero)
                        .onTapGesture {
                            popoverManager.closeInside(id)
                        }
                        .onAppear {
                            if popover?.position != nil {
                                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                                    opacity = 1
                                }
                            } else {
                                opacity = 0.01
                            }
                        }
                        .opacity(opacity)
                }
            }
        }
    
    var background: some View {
        if blockBackgroundInteractions {
            return  Color.white.opacity(0.01)
        } else {
            return Color.clear
        }
    }
}

public extension View {
    func popoverHandler(id: Int = 0, blockBackgroundInteractions: Bool = false) -> some View {
        let popoverManager = PopoverManager.shared
        return self
            .overlay(PopoverView(id: id, blockBackgroundInteractions: blockBackgroundInteractions))
            .onTapGesture { popoverManager.closeOutside() }
            .environmentObject(popoverManager)
            .coordinateSpace(name: "scroll")
    }
}
