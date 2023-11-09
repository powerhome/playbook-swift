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
  let shouldClosePopover: CloseOptions
  let cardPadding: CGFloat
  let backgroundAlpha: CGFloat
  let dismissAction: (() -> Void)

  @State private var yOffset: CGFloat = .zero
  @State private var xOffset: CGFloat = .zero

  @Binding var parentFrame: CGRect

  init(
    position: Position = .bottom,
    shouldClosePopover: CloseOptions = .anywhere,
    cardPadding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    parentFrame: Binding<CGRect>,
    dismissAction: @escaping (() -> Void),
    @ViewBuilder popover: () -> Content
  ) {
    self.position = position
    self.shouldClosePopover = shouldClosePopover
    self.cardPadding = cardPadding
    self.backgroundAlpha = backgroundAlpha
    self._parentFrame = parentFrame
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
    .background(Color.white.opacity(0.01))
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
        let offset = position.offset(
          labelFrame: parentFrame.size,
          popoverFrame: geo.frame(in: .global)
        )
        yOffset = parentFrame.midY - geo.frame(in: .global).midY + offset.y
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
    case top
    case bottom
    case left
    case right
    case center

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

    func offsetX(_ frame: CGRect, offset: CGFloat = 0) -> CGFloat {
      let space: CGFloat = Spacing.xSmall
      let viewWidth = Screen.deviceWidth
      let frameMaxX = frame.maxX
      let frameMinX = frame.minX

      switch self {
      case .bottom, .top, .center:
        if viewWidth.isLess(than: frameMaxX) && !frameMinX.isLess(than: 0) {
          return -(frameMaxX - viewWidth) - space
        } else if frameMinX.isLess(than: 0) && frameMaxX.isLess(than: frameMaxX) {
          return -frameMinX + space
        } else {
          return 0
        }
      case .left, .right:
        if viewWidth.isLess(than: frameMaxX + offset) {
          return -(frameMaxX - viewWidth) - space
        } else if (frameMinX + offset).isLess(than: 0) && (frameMaxX + offset).isLess(than: frameMaxX) {
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

struct PopoverHandler: ViewModifier {
  @Environment(\.popoverValue) var popover

  func body(content: Content) -> some View {
    content.overlay(VStack { popover })
  }
}

public extension View {
  func withPopoverHandling(_ popover: AnyView?, position: PBToast.Position = .top) -> some View {
    self
      .modifier(PopoverHandler())
      .environment(\.popoverValue, popover)
  }
}

private struct PopoverEnvironmentKey: EnvironmentKey {
  static let defaultValue: AnyView? = nil
}

extension EnvironmentValues {
  var popoverValue: AnyView? {
    get { self[PopoverEnvironmentKey.self] }
    set { self[PopoverEnvironmentKey.self] = newValue }
  }
}

class Screen {
  #if os(iOS)
  static var deviceWidth: CGFloat = UIScreen.main.bounds.width
  #elseif os(macOS)
  static var deviceWidth: CGFloat = NSScreen.main?.frame.width ?? 500
  #endif
}
