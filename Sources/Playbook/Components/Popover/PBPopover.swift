//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverView.swift
//

import SwiftUI

public struct PopoverView<Content: View>: View {
  let popover: Content
  let position: Position
  let parentFrame: CGRect
  let clickToClose: Close
  let cardPadding: CGFloat
  let backgroundOpacity: Double
  let dismissAction: (() -> Void)

  @State private var yOffset: CGFloat = .zero
  @State private var xOffset: CGFloat = .zero

  public init(
    position: Position,
    clickToClose: Close,
    cardPadding: CGFloat,
    backgroundOpacity: Double,
    parentFrame: CGRect,
    dismissAction: @escaping (() -> Void),
    @ViewBuilder popover: () -> Content
  ) {
    self.position = position
    self.clickToClose = clickToClose
    self.cardPadding = cardPadding
    self.backgroundOpacity = backgroundOpacity
    self.parentFrame = parentFrame
    self.dismissAction = dismissAction
    self.popover = popover()
  }

  public var body: some View {
    let positionX = parentFrame.midX + xOffset
    let positionY = parentFrame.midY + yOffset

    ZStack {
      popoverView
        .position(
          x: positionX,
          y: positionY
        )
    }
    .background(Color.black.opacity(backgroundOpacity))
    .onTapGesture {
      switch clickToClose {
      case .outside, .anywhere:
        dismissAction()
      case .inside:
        break
      }
    }
  }

  private var popoverView: some View {
    PBCard(
      border: false,
      padding: cardPadding,
      shadow: .deeper,
      width: nil
    ) {
      popover
    }
    .onTapGesture {
      switch clickToClose {
      case .inside, .anywhere:
        dismissAction()
      case .outside:
        break
      }
    }
    .background(GeometryReader { geo in
      Color.clear.onAppear {
        let popoverFrame = geo.frame(in: .global)
        let offset = position.offset(
          labelFrame: parentFrame.size,
          popoverFrame: popoverFrame
        )
        yOffset = parentFrame.midY - popoverFrame.midY + offset.y
        xOffset = offset.x
      }
    })
    .preferredColorScheme(.light)
  }
}

public struct PBPopover<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  @Binding var view: AnyView?
  let position: PopoverView<T>.Position
  let clickToClose: PopoverView<T>.Close
  let cardPadding: CGFloat
  let backgroundOpacity: Double
  @ViewBuilder var contentView: () -> T

  init(
    isPresented: Binding<Bool>,
    view: Binding<AnyView?>,
    position: PopoverView<T>.Position,
    clickToClose: PopoverView<T>.Close,
    cardPadding: CGFloat,
    backgroundOpacity: Double,
    contentView: @escaping () -> T
  ) {
    self._isPresented = isPresented
    self._view = view
    self.position = position
    self.clickToClose = clickToClose
    self.cardPadding = cardPadding
    self.backgroundOpacity = backgroundOpacity
    self.contentView = contentView
  }

  public func body(content: Content) -> some View {
    if isPresented {
      content
        .background(GeometryReader { proxy  in
          let frame = proxy.frame(in: .global)
          Color.clear.onAppear {
            view = AnyView(
              PopoverView(
                position: position,
                clickToClose: clickToClose,
                cardPadding: cardPadding,
                backgroundOpacity: backgroundOpacity,
                parentFrame: frame,
                dismissAction: dismiss
              ) {
                contentView()
              }
            )
          }
        })
    } else {
      content
    }
  }

  private var dismiss: () -> Void {
    return {
      isPresented = false
      view = nil
    }
  }
}

public extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    _ view: Binding<AnyView?>,
    position: PopoverView<T>.Position = .bottom,
    clickToClose: PopoverView<T>.Close = .anywhere,
    cardPadding: CGFloat = Spacing.small,
    backgroundOpacity: Double = 0.001,
    contentView: @escaping () -> T
  ) -> some View {
    modifier(
      PBPopover(
        isPresented: isPresented,
        view: view,
        position: position,
        clickToClose: clickToClose,
        cardPadding: cardPadding,
        backgroundOpacity: backgroundOpacity,
        contentView: contentView
      )
    )
  }
}

public extension PopoverView {
  enum Close {
    case inside, outside, anywhere
  }

  enum Position {
    case top, bottom, left, right, center

    func offset(labelFrame: CGSize, popoverFrame: CGRect) -> CGPoint {
      let labelHeight = labelFrame.height
      let labelWidth = labelFrame.width
      let popHeight = popoverFrame.height
      let popWidth = popoverFrame.width

      switch self {
      case .top:
        return CGPoint(
          x: offsetX(popoverFrame),
          y: -(labelHeight/2 + popHeight/2) - Spacing.xSmall
        )
      case .bottom:
        return CGPoint(
          x: offsetX(popoverFrame),
          y: (labelHeight + popHeight)/2 + Spacing.xSmall
        )
      case .right:
        let offset = (labelWidth + popWidth)/2 + Spacing.xSmall
        return CGPoint(
          x: offsetX(popoverFrame, offset: offset),
          y: 0
        )
      case .left:
        let offset = -(labelWidth + popWidth)/2 - Spacing.xSmall
        return CGPoint(
          x: offsetX(popoverFrame, offset: offset),
          y: 0
        )
      case .center:
        return CGPoint(
          x: offsetX(popoverFrame),
          y: 0
        )
      }
    }

    private func offsetX(_ frame: CGRect, offset: CGFloat = 0) -> CGFloat {
      let space: CGFloat = Spacing.xSmall
      let viewWidth = Screen.deviceWidth
      let frameMaxX = frame.maxX
      let frameMinX = frame.minX

      switch self {
      case .bottom, .top, .center:
        if viewWidth.isLess(than: frameMaxX) && !frameMinX.isLess(than: 0) {
          return -(frameMaxX - viewWidth) - space
        } else if frameMinX.isLessThanOrEqualTo(0) {
          return -frameMinX + space
        } else {
          return 0
        }
      case .left, .right:
        if viewWidth.isLess(than: frameMaxX + offset) {
          return -(frameMaxX - viewWidth) - space
        } else if (frameMinX + offset).isLess(than: 0) {
          return -frameMinX + space
        } else {
          return offset
        }
      }
    }
  }
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}
