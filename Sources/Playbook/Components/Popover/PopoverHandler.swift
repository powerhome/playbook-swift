//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct GlobalPopoverView: View {
    @EnvironmentObject var popoverManager: PopoverManager
//    var withID: ((Int) -> Void)? = nil
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        ZStack {
            let isPresented = popoverManager.isPresented.first { $0.key == id }?.value
            let popover = popoverManager.popovers.first { $0.key == id }?.value
           
            if isPresented ?? false {
                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .onAppear { withID?(id) }
                    popover?.view
                        .position(popover?.position ?? .zero)
                        .onTapGesture {
                            popoverManager.closeInside(id)
                        }
                }
            }
        }
}

public extension View {
    func popoverHandler(id: Int = 0) -> some View {
        let popoverManager = PopoverManager.shared
        return self
            .overlay(GlobalPopoverView(id: id))
            .onTapGesture { popoverManager.closeOutside() }
            .environmentObject(popoverManager)
    }
}



//struct PopoverHandler: ViewModifier {
//    let popoverManager = PopoverManager.shared
//    @State private var popoverID: Int?
//    
//    func body(content: Content) -> some View {
//        content
//            .overlay(GlobalPopoverView { popoverID = $0 })
//            .onTapGesture { popoverManager.closeOutside() }
//            .environmentObject(popoverManager)
//    }
//}
