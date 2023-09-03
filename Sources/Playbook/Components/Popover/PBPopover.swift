//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PBPopover<Content: View, Label: View>: View {
  let position: PopoverPosition
  let padding: CGFloat
  let backgroundAlpha: CGFloat
  let popoverWidth: CGFloat?
  let dismissOptions: DismissOptions
  let content: Content
  let label: Label

  @State private var presentPopover: Bool = false
  @State private var popoverPosition: CGRect = .zero
  @State private var popoverSize: CGSize = .zero
  @Binding var scrollOffset: CGPoint

  public init(
    position: PopoverPosition = .bottom,
    padding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    popoverWidth: CGFloat? = nil,
    dismissOptions: DismissOptions = .anywhere,
    scrollOffset: Binding<CGPoint>,
    @ViewBuilder content: (() -> Content) = { EmptyView() },
    @ViewBuilder label: (() -> Label) = { EmptyView() }
  ) {
    self.position = position
    self.padding = padding
    self.backgroundAlpha = backgroundAlpha
    self.popoverWidth = popoverWidth
    self.dismissOptions = dismissOptions
    self._scrollOffset = scrollOffset
    self.content = content()
    self.label = label()
  }

  public var body: some View {
    ZStack {
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
          .position(
            x: popoverPosition.maxX + popoverSize.width/2 + 6, 
            y: popoverPosition.minY - popoverPosition.height/2 + scrollOffset.y
          )
          .backgroundViewModifier(alpha: 0)
          .onTapGesture {
            presentPopover.toggle()
          }
        }
    }
  }
}

public enum DismissOptions {
  case inside, outside, anywhere
}

public enum PopoverPosition {
  case top, bottom, left, right, center
}

public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}
