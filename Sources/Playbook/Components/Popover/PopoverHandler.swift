//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverHandler: ViewModifier {
    let popoverManager = PopoverManager.shared
    @State private var popoverID: Int?
    
    func body(content: Content) -> some View {
        content
            .overlay(GlobalPopoverView { popoverID = $0 })
            .onTapGesture {
                if let id = popoverID {
                    popoverManager.closeOutside(id)
                }
            }
            .environmentObject(popoverManager)
    }
}

struct GlobalPopoverView: View {
    @EnvironmentObject var popoverManager: PopoverManager
    var withID: ((Int) -> Void)? = nil
    
    var body: some View {
        ZStack {
            let presentedList = popoverManager.isPresented.sorted(by: { $0.key <= $1.key })
            let popoverList = popoverManager.popovers.sorted(by: { $0.key <= $1.key })
            let commonKeys = Set(presentedList.map { $0.key }).intersection(popoverList.map { $0.key })
            let compactArray: [(Int, Bool, PopoverManager.Popover)] = commonKeys.compactMap { key in
                if let presentedValue = popoverManager.isPresented[key], let listValue = popoverManager.popovers[key] {
                    return (key, presentedValue, listValue)
                }
                return nil
            }
            
            ForEach(compactArray, id: \.0) { id, isPresented, popover in
                if isPresented {
                    Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear { withID?(id) }
                    popover.view
                        .position(popover.position ?? .zero)
                        .onTapGesture {
                            popoverManager.closeInside(id)
                        }
                }
            }
        }
    }
}

public extension View {
    func popoverHandler() -> some View {
        self.modifier(PopoverHandler())
    }
}
