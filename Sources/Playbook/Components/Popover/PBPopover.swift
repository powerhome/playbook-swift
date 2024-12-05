//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverView.swift
//

import SwiftUI

public struct Popover<T: View>: ViewModifier {
    private let position: Position
    private let variant: Variant
    private let clickToClose: (PopoverManager.Close, action: (() -> Void)?)
    private var popoverView: () -> T
    private let id: Int
    
    @Binding var isPresented: Bool
    @Binding var refreshView: Bool
    @State private var isHovering: Bool = false
    @State private var contentFrame: CGRect?
    @State private var popoverSize: CGSize?
    @State private var popoverPosition: CGPoint?
    @EnvironmentObject var popoverManager: PopoverManager
    
    public init(
        isPresented: Binding<Bool>,
        id: Int?,
        position: Position,
        variant: Variant,
        clickToClose: (PopoverManager.Close, action: (() -> Void)?),
        refreshView: Binding<Bool> = .constant(false),
        popoverView: @escaping (() -> T)
    ) {
        self._isPresented = isPresented
        self.position = position
        self.variant = variant
        self.clickToClose = clickToClose
        self._refreshView = refreshView
        self.popoverView = popoverView
        self.id = id ?? UUID().hashValue
    }
    
    public func body(content: Content) -> some View {
        content
            .frameReader {
                contentFrame = $0
            }
            .onAppear {
                popoverManager.createPopover(
                    with: id,
                    view: AnyView(popoverFrameView),
                    position: popoverPosition,
                    close: clickToClose
                )
            }
            .onChange(of: isPresented) { newValue in
                popoverManager.presentPopover(with: id, value: newValue)
                updateViewFrame()
            }
            .onChange(of: popoverPosition) { position in
                updateViewFrame()
            }
            .onChange(of: contentFrame) { frame in
                updateViewFrame()
            }
            .onChange(of: refreshView) { _ in
                updateViewFrame()
            }
            .onChange(of: isHovering) { _ in
                updateViewFrame()
            }
            .onReceive(popoverManager.$isPresented) { newValue in
                if let value = newValue[id] {
                    isPresented = value
                }
            }
            .onDisappear {
                isPresented = false
                popoverManager.teardownPopover(with: id)
            }
    }
    
    var popoverFrameView: any View {
        variant.view(popoverView())
            .frame(width: variant.width(contentFrame?.width ?? .zero))
            .sizeReader { size in
                popoverSize = size
                let popoverFrame = position.calculateFrame(from: variant.offset(contentFrame ?? CGRectZero, position: position), size: size)
                popoverPosition = popoverFrame.point(at: .center())
            }
    }
}

extension Popover {
    func updateViewFrame() {
        if let frame = contentFrame {
            let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: popoverSize)
            let point = popoverFrame.point(at: .center())
            popoverManager.updatePopover(
                with: id,
                view: AnyView(popoverFrameView),
                position: point
            )
        }
    }
}

public extension View {
    func pbPopover<T: View>(
        isPresented: Binding<Bool>,
        id: Int? = nil,
        position: Position = .bottom(),
        variant: Popover<T>.Variant = .default,
        clickToClose: (PopoverManager.Close, action: (() -> Void)?) = (.anywhere, action: nil),
        refreshView: Binding<Bool> = .constant(false),
        popoverView: @escaping () -> T
    ) -> some View {
        modifier(
            Popover(
                isPresented: isPresented,
                id: id,
                position: position,
                variant: variant,
                clickToClose: clickToClose,
                refreshView: refreshView,
                popoverView: popoverView
            )
        )
    }
}

#Preview {
    registerFonts()
    return PopoverCatalog()
}
