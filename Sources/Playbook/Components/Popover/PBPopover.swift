//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PBPopover<Content: View>: View {
  let popover: Content
  let position: Position
  let parentFrame: CGRect
  let shouldClosePopover: CloseOptions
  let cardPadding: CGFloat
  let backgroundAlpha: CGFloat
  let dismissAction: (() -> Void)

  @State private var yOffset: CGFloat = .zero
  @State private var xOffset: CGFloat = .zero

  init(
    position: Position = .bottom,
    shouldClosePopover: CloseOptions = .anywhere,
    cardPadding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    parentFrame: CGRect,
    dismissAction: @escaping (() -> Void),
    @ViewBuilder popover: () -> Content
  ) {
    self.position = position
    self.shouldClosePopover = shouldClosePopover
    self.cardPadding = cardPadding
    self.backgroundAlpha = backgroundAlpha
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
    .backgroundViewModifier(alpha: backgroundAlpha)
    .onTapGesture {
      switch shouldClosePopover {
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
      switch shouldClosePopover {
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

public extension PBPopover {
  enum CloseOptions {
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

struct Popover<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  @Binding var view: AnyView?
  @ViewBuilder var contentView: () -> T

  func body(content: Content) -> some View {
    if isPresented {
      content
        .background(GeometryReader { proxy  in
          let frame = proxy.frame(in: .global)
          Color.clear.onAppear {
            view = AnyView(
              PBPopover(parentFrame: frame, dismissAction: dismiss) {
                contentView()
              }
            )
          }
        })
    } else {
      content
    }
  }

  var dismiss: () -> Void {
    return {
      isPresented = false
      view = nil
    }
  }
}

extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    _ view: Binding<AnyView?>,
    contentView: @escaping () -> T
  ) -> some View {
    modifier(
      Popover(
        isPresented: isPresented,
        view: view,
        contentView: contentView
      )
    )
  }
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}
