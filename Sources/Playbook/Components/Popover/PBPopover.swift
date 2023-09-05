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
  @State private var labelFrame: CGRect = .zero
  @State private var popoverSize: CGRect = .zero
  @Binding var scrollOffset: CGPoint

  public init(
    position: PopoverPosition = .bottom((0, 0)),
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
          #if os(iOS)
          UIView.setAnimationsEnabled(false)
          #endif
          presentPopover.toggle()
        }
        .background(GeometryReader { proxy in
          Color.clear
            .onAppear {
              labelFrame = proxy.frame(in: .global)
              print("labelFrame \(labelFrame)")
            }
        })
      #if os(iOS)
        .fullScreenCover(isPresented: $presentPopover) {
          popoverView
        }
      #elseif os(macOS)
        .popover(isPresented: $presentPopover) {
          popoverView
        }
      #endif
    }
  }

  var popoverView: some View {
    PBCard(padding: Spacing.small, width: popoverWidth) {
      content
    }
    .onTapGesture {
      switch dismissOptions {
      case .inside, .anywhere:
        presentPopover.toggle()
      case .outside:
        break
      }
    }
    .background(GeometryReader { proxy in
      Color.clear.onAppear {
        popoverSize = proxy.frame(in: .global)
        print("popoverSize \(popoverSize)")
      }
    })
    .position(
      position.coordinates(
        labelFrame,
        popoverFrame: popoverSize,
        scrollOffset: scrollOffset
      )
    )
    .backgroundViewModifier(alpha: 0)
    .onTapGesture {
      switch dismissOptions {
      case .outside, .anywhere:
        presentPopover.toggle()
      case .inside:
        break
      }
    }
  }
}

public enum DismissOptions {
  case inside, outside, anywhere
}

public enum PopoverPosition {
  case top((CGFloat, CGFloat))
  case bottom((CGFloat, CGFloat)) 
  case left((CGFloat, CGFloat))
  case right((CGFloat, CGFloat))
  case center((CGFloat, CGFloat))

  func coordinates(_ labelFrame: CGRect, popoverFrame: CGRect, scrollOffset: CGPoint) -> CGPoint {
    let space: CGFloat = 8
    let device =  UIDevice.current.userInterfaceIdiom

    switch device {
    case .pad:
      switch self {
      case .top((let offsetX, let offsetY)):
        return CGPoint(
          x: labelFrame.midX + offsetX,
          y: labelFrame.minY - popoverFrame.height - space + scrollOffset.y + offsetY
        )
      case .bottom((let offsetX, let offsetY)):
        return CGPoint(
          x: labelFrame.midX + offsetX,
          y: labelFrame.maxY + space + scrollOffset.y + offsetY
        )
      case .right((let offsetX, let offsetY)): return
        CGPoint(
          x: labelFrame.maxX + popoverFrame.width/2 + space + offsetX,
          y: labelFrame.midY - popoverFrame.height/2 + scrollOffset.y + offsetY
        )
      case .left((let offsetX, let offsetY)): return
        CGPoint(
          x: labelFrame.minX - popoverFrame.width/2 + offsetX,
          y: labelFrame.midY + scrollOffset.y + offsetY
        )
      case .center((let offsetX, let offsetY)): return
        CGPoint(
          x: labelFrame.midX + offsetX,
          y: labelFrame.midY + popoverFrame.height/2 - labelFrame.height/2 + scrollOffset.y + offsetY
        )
      }
    case .phone:
      switch self {
      case .top((let offsetX, let offsetY)):
        return CGPoint(
          x: labelFrame.midX + offsetX,
          y: labelFrame.minY - popoverFrame.height*1.5 - space + scrollOffset.y + offsetY
        )
      case .bottom((let offsetX, let offsetY)):
        return CGPoint(
          x: labelFrame.midX + offsetX,
          y: labelFrame.midY + space + scrollOffset.y + offsetY
        )
      case .right((let offsetX, let offsetY)): return
        CGPoint(
          x: labelFrame.maxX + popoverFrame.width/2 + space + offsetX,
          y: labelFrame.midY - popoverFrame.height + scrollOffset.y + offsetY
        )
      case .left((let offsetX, let offsetY)): return
        CGPoint(
          x: labelFrame.minX - popoverFrame.width/2 + offsetX,
          y: labelFrame.midY + scrollOffset.y + offsetY
        )
      case .center((let offsetX, let offsetY)): return
        CGPoint(
          x: labelFrame.midX + offsetX,
          y: labelFrame.midY + popoverFrame.height/3 + scrollOffset.y + offsetY
        )
      }
    case .mac: return CGPoint(x: 0, y: 0)
    default: return CGPoint(x: 0, y: 0)
    }
  }
}

public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}
