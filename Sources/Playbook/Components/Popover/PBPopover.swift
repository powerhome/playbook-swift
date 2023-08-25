//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PBPopover<Content: View, Label: View>: View {
  let content: Content
  let label: Label
  let onClose: (() -> Void)?

  @State private var presentPopover: Bool = false
  @State private var popoverPosition: CGRect = .zero
  @State private var popoverSize: CGSize = .zero

  public init(
    @ViewBuilder content: (() -> Content) = { EmptyView() },
    @ViewBuilder label: (() -> Label) = { EmptyView() },
    onClose: (() -> Void)? = nil
  ) {
    self.content = content()
    self.label = label()
    self.onClose = onClose
  }

  public var body: some View {
    label
      .disabled(true)
      .onTapGesture {
        UIView.setAnimationsEnabled(false)
        presentPopover.toggle()
      }
      .background(GeometryReader { proxy in
        Color.clear
          .onAppear {
            popoverPosition = proxy.frame(in: .global)
          }
      })
      .fullScreenCover(isPresented: $presentPopover) {
        PBCard(padding: Spacing.small) {
          content
        }
        .background(GeometryReader { proxy in
          Color.clear.onAppear {
            popoverSize = proxy.size
          }
        })
        .position(x: popoverPosition.maxX + popoverSize.width/2, y: popoverPosition.minY - popoverPosition.height/2)
        .backgroundViewModifier(alpha: 0)
        .onTapGesture {
          if let onClose {
            onClose()
          }
          presentPopover.toggle()
        }
      }
  }
}

@available(macOS 13.0, *)
public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}
