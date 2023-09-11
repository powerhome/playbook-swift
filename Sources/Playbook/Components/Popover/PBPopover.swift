//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

@available(iOS 16.4, *)
struct Popup<T: View>: ViewModifier {
  let popup: T
  let position: PopoverPosition
  let dismissOptions: DismissOptions
  let backgroundAlpha: CGFloat 

  @State var isPresented: Bool = false
  @State var heightOffset: CGFloat = .zero
  @State var midY: CGFloat = .zero
  @State var yOffset: CGFloat = .zero
  @State var xOffset: CGFloat = .zero

  init(
    position: PopoverPosition,
    dismissOptions: DismissOptions = .outside,
    backgroundAlpha: CGFloat = 0,
    @ViewBuilder content: () -> T
  ) {
    self.position = position
    self.dismissOptions = dismissOptions
    self.backgroundAlpha = backgroundAlpha
    popup = content()
  }

  func body(content: Content) -> some View {
    content
      .disabled(true)
      .background {
        GeometryReader { geometry in
          let frame = geometry.frame(in: .global)
          Color.clear
            .fullScreenCover(isPresented: $isPresented) {
              popoverView(frame)
                .position(
                  x: frame.midX + xOffset,
                  y: frame.midY + heightOffset + yOffset
                )
                .backgroundViewModifier(alpha: backgroundAlpha)
            }
        }
      }
      .onTapGesture {
        UIView.setAnimationsEnabled(false)
          isPresented.toggle()
      }
  }

  @ViewBuilder
  private func popoverView(_ p: CGRect) -> some View {
    PBCard(padding: 10, width: nil) {
      popup
    }
    .onTapGesture {
      switch dismissOptions {
      case .inside, .anywhere:
        isPresented.toggle()
      case .outside:
        break
      }
    }
    .background(GeometryReader { geo in
      Color.clear.onAppear {
        let offset = position.offset(labelFrame: p.size, popoverFrame: geo.size)
        midY = p.midY - geo.frame(in: .global).midY + offset.y
        xOffset = offset.x
      }
      .onChange(of: midY) { newValue in
        if midY != 0 {
          heightOffset = newValue
        }
      }
    })
    .preferredColorScheme(.light)
  }
}

@available(iOS 16.4, *)
extension View {
  func popup<T: View>(
    position: PopoverPosition = .bottom(),
    dismissOptions: DismissOptions = .anywhere,
    backgroundAlpha: CGFloat = 0,
    @ViewBuilder content: () -> T
  ) -> some View {
    return modifier(
      Popup(
        position: position,
        dismissOptions: dismissOptions,
        backgroundAlpha: backgroundAlpha,
        content: content)
    )
  }
}

public enum DismissOptions {
  case inside, outside, anywhere
}

public enum PopoverPosition {
  case top(_ spacing: CGFloat = Spacing.xSmall)
  case bottom(_ spacing: CGFloat = Spacing.xSmall)
  case left(_ spacing: CGFloat = Spacing.xSmall)
  case right(_ spacing: CGFloat = Spacing.xSmall)
  case center(_ spacing: CGFloat = Spacing.xSmall)

  func offset(labelFrame: CGSize, popoverFrame: CGSize) -> CGPoint {
    let labelHeight = labelFrame.height
    let labelWidth = labelFrame.width
    let popHeight = popoverFrame.height
    let popWidth = popoverFrame.width

    switch self {
    case .top(let offset):
      return CGPoint(
        x: 0,
        y: -(labelHeight/2 + popHeight/2) - offset
      )
    case .bottom(let offset):
      return CGPoint(
        x: 0,
        y: (labelHeight/2 + popHeight/2) + offset
      )
    case .right(let offset):
      return CGPoint(
        x: (labelWidth/2 + popWidth/2) + offset,
        y: 0
      )
    case .left(let offset):
      return CGPoint(
        x: -(labelWidth/2 + popWidth/2) - offset,
        y: 0
      )
    case .center(let offset):
      return CGPoint(
        x: 0,
        y: 0
      )
    }
  }
}

public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    if #available(iOS 16.4, *) {
      return PopoverCatalog()
    } else {
      return EmptyView()
    }
  }
}
