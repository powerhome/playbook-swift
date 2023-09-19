//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

struct PBPopover<T: View>: ViewModifier {
  let popover: T
  let position: PopoverPosition
  let shouldClosePopover: CloseOptions
  let cardPadding: CGFloat
  let backgroundAlpha: CGFloat

  @State var isPresented: Bool = false
  @State var yOffset: CGFloat = .zero
  @State var midY: CGFloat = .zero
  @State var midX: CGFloat = .zero
  @State var xOffset: CGFloat = .zero

  init(
    position: PopoverPosition = .bottom(),
    shouldClosePopover: CloseOptions = .anywhere,
    cardPadding: CGFloat,
    backgroundAlpha: CGFloat = 0,
    @ViewBuilder popover: () -> T
  ) {
    self.position = position
    self.shouldClosePopover = shouldClosePopover
    self.cardPadding = cardPadding
    self.backgroundAlpha = backgroundAlpha
    self.popover = popover()
  }

  @ViewBuilder
  func body(content: Content) -> some View {
    VStack {
      content
        .disabled(true)
        .background {
          GeometryReader { geometry in
            let frame = geometry.frame(in: .global)
#if os(iOS)
            let positionX = frame.midX + xOffset
            let positionY = frame.midY + yOffset
            Color.clear.fullScreenCover(isPresented: $isPresented) {
              popoverView(frame)
                .position(
                  x: positionX,
                  y: positionY
                )
                .backgroundViewModifier(alpha: backgroundAlpha)
                .onTapGesture {
                  switch shouldClosePopover {
                  case .outside, .anywhere:
                    isPresented.toggle()
                  case .inside:
                    break
                  }
                }
            }
#elseif os(macOS)
            BackgroundView(isVisible: $isPresented, frame: frame) {
              popoverView(frame)
            }
#endif
          }
        }
        .onTapGesture {
#if os(iOS)
          UIView.setAnimationsEnabled(false)
#endif
          isPresented.toggle()
        }
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
    }
    .onTapGesture {
      switch shouldClosePopover {
      case .inside, .anywhere:
        isPresented.toggle()
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

extension View {
  func pbPopover<Content: View>(
    position: PopoverPosition = .bottom(),
    shouldClosePopover: CloseOptions = .anywhere,
    cardPadding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    @ViewBuilder popover: () -> Content
  ) -> some View {
    return modifier(
      PBPopover(
        position: position,
        shouldClosePopover: shouldClosePopover,
        cardPadding: cardPadding,
        backgroundAlpha: backgroundAlpha,
        popover: popover)
    )
  }
}

public enum CloseOptions {
  case inside, outside, anywhere
}

public enum PopoverPosition {
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
        x: horizontalOffset(popoverFrame, padding),
        y: -(labelHeight/2 + popHeight/2) - space
      )
    case .bottom(let space, let padding):
      return CGPoint(
        x: horizontalOffset(popoverFrame, padding),
        y: (labelHeight/2 + popHeight/2) + space
      )
    case .right(let space):
      return CGPoint(
        x: (labelWidth/2 + popWidth/2) + space,
        y: 0
      )
    case .left(let space):
      return CGPoint(
        x: -(labelWidth/2 + popWidth/2) - space,
        y: 0
      )
    case .center:
      return CGPoint(
        x: 0,
        y: 0
      )
    }
  }

  func horizontalOffset(_ frame: CGRect, _ padding: CGFloat) -> CGFloat {
    var space: CGFloat = 0
#if os(iOS)
    let view = UIScreen.main.bounds
    let frameMax = frame.maxX + padding
    let frameMin = frame.minX

    if frameMin.isLess(than: view.minX) {
      space = -frame.minX + padding
    }
    if view.maxX.isLess(than: frameMax - 1) {
      space = -(frameMax - view.maxX) - padding
    }
#endif
    return space
  }
}

public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}

#if os(macOS)
struct BackgroundView<T: View>: NSViewRepresentable {
  @Binding var isVisible: Bool
  let frame: CGRect
  let content: T

  init(isVisible: Binding<Bool>, frame: CGRect, @ViewBuilder content: () -> T) {
    self._isVisible = isVisible
    self.frame = frame
    self.content = content()
  }

  func makeNSView(context: Context) -> NSView {
    let view = NSView()
    return view
  }

  func updateNSView(_ nsView: NSView, context: Context) {
    if isVisible {
      let popover = NSPopover()
      let content = NSHostingController(rootView: content)
      popover.contentViewController = content
      popover.setValue(true, forKeyPath: "shouldHideAnchor")
      popover.animates = false
      popover.behavior = .semitransient
      let rect = NSRect(x: nsView.bounds.width/2, y: 0, width: nsView.bounds.width, height: nsView.bounds.height)
      popover.show(relativeTo: rect, of: nsView, preferredEdge: .minY)
    }
  }
}
#endif
