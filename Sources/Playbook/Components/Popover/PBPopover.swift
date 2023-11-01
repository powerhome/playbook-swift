//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PBPopover<T: View>: ViewModifier {
  let popover: T
  let position: Position
  let shouldClosePopover: CloseOptions
  let cardPadding: CGFloat
  let backgroundAlpha: CGFloat

  @Binding var isPresented: Bool
  @State private var yOffset: CGFloat = .zero
  @State private var midY: CGFloat = .zero
  @State private var midX: CGFloat = .zero
  @State private var xOffset: CGFloat = .zero
  @Binding var viewFrame: CGRect

  init(
    isPresented: Binding<Bool>,
    position: Position = .bottom(),
    shouldClosePopover: CloseOptions = .anywhere,
    cardPadding: CGFloat,
    backgroundAlpha: CGFloat = 0,
    viewFrame: Binding<CGRect>,
    @ViewBuilder popover: () -> T
  ) {
    self._isPresented = isPresented
    self.position = position
    self.shouldClosePopover = shouldClosePopover
    self.cardPadding = cardPadding
    self.backgroundAlpha = backgroundAlpha
    self._viewFrame = viewFrame
    self.popover = popover()
  }

  public func body(content: Content) -> some View {
    if isPresented {
      content
        .overlay {
          let positionX = viewFrame.midX + xOffset
          let positionY = viewFrame.midY + yOffset
          popoverView(viewFrame)
            .position(
              x: positionX,
              y: positionY
            )
            .backgroundViewModifier(alpha: backgroundAlpha)
            .onTapGesture {
              switch shouldClosePopover {
              case .outside, .anywhere:
                isPresented = false
              case .inside:
                break
              }
            }
        }
    } else {
      content
    }
  }

  @ViewBuilder
  private func popoverView(_ p: CGRect) -> some View {
    PBCard(
      border: false,
      padding: cardPadding,
      shadow: .deeper,
      width: nil
    ) {
      popover
        .fixedSize(horizontal: false, vertical: true)
    }
    .onTapGesture {
      switch shouldClosePopover {
      case .inside, .anywhere:
        isPresented = false
      case .outside:
        break
      }
    }
    .background(GeometryReader { geo in
      Color.clear.onAppear {
        let offset = position.offset(
          labelFrame: p.size,
          popoverFrame: geo.frame(in: .global)
        )
        midY = p.midY - geo.frame(in: .global).midY + offset.y
        midX = offset.x
      }
      .onChange(of: midY) { newValue in
        if midY != 0 {
          yOffset = newValue
        }
      }
      .onChange(of: midX) { newValue in
        if midX != 0 {
          xOffset = newValue
        }
      }
    })
    .preferredColorScheme(.light)
  }
}

public extension PBPopover {
  enum CloseOptions {
    case inside, outside, anywhere
  }

  enum Position {
    case top(_ spacing: CGFloat = Spacing.xSmall, padding: CGFloat = 0)
    case bottom(_ spacing: CGFloat = Spacing.xSmall, padding: CGFloat = 0)
    case left(_ spacing: CGFloat = Spacing.xSmall)
    case right(_ spacing: CGFloat = Spacing.xSmall)
    case center(_ spacing: CGFloat = Spacing.xSmall)

    func offset(labelFrame: CGSize, popoverFrame: CGRect) -> CGPoint {
      let labelHeight = labelFrame.height
      let labelWidth = labelFrame.width
      let popHeight = popoverFrame.height
      let popWidth = popoverFrame.width

      switch self {
      case .top(let space, let padding):
        return CGPoint(
          x: offsetX(popoverFrame, padding: padding),
          y: -(labelHeight/2 + popHeight/2) - space
        )
      case .bottom(let space, let padding):
        return CGPoint(
          x: offsetX(popoverFrame, padding: padding),
          y: (labelHeight/2 + popHeight/2) + space
        )
      case .right(let space):
        let offset = (labelWidth/2 + popWidth/2) + space
        return CGPoint(
          x: offsetX(popoverFrame, offset: offset),
          y: 0
        )
      case .left(let space):
        let offset = -(labelWidth/2 + popWidth/2) - space
        return CGPoint(
          x: offsetX(popoverFrame, offset: offset),
          y: 0
        )
      case .center:
        return CGPoint(
          x: offsetX(popoverFrame, offset: 0),
          y: 0
        )
      }
    }

    func offsetX(_ frame: CGRect, offset: CGFloat = 0, padding: CGFloat = 0) -> CGFloat {
      var space: CGFloat = 0
      #if os(iOS)
      let view = UIScreen.main.bounds.width
      let frameMax = frame.maxX
      let frameMin = frame.minX

      switch self {
      case .bottom, .top, .center:
        if frameMin.isLess(than: 0) && frameMax.isLess(than: view) {
          space = -frameMin + padding
        }
        if view.isLess(than: frameMax + padding) {
          space = -(frameMax - view) - padding
        }
  
      case .left, .right:
        if frameMin.isLess(than: 0) && frameMax.isLess(than: view) {
          space = -frameMin + padding
        }
        if view.isLess(than: frame.maxX + offset) {
          space = -(frameMax - view) - padding
        }
      }

      #elseif os(macOS)
      space = offset
      #endif
      return space
    }
  }
}

public extension View {
  func pbPopover<Content: View>(
    isPresented: Binding<Bool>,
    position: PBPopover<Content>.Position = .bottom(),
    shouldClosePopover: PBPopover<Content>.CloseOptions = .anywhere,
    cardPadding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    viewFrame: Binding<CGRect>,
    @ViewBuilder popover: () -> Content
  ) -> some View {
    return modifier(
      PBPopover(
        isPresented: isPresented,
        position: position,
        shouldClosePopover: shouldClosePopover,
        cardPadding: cardPadding,
        backgroundAlpha: backgroundAlpha,
        viewFrame: viewFrame,
        popover: popover)
    )
  }
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}
