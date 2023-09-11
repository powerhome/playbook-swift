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
  let alignment: Alignment

  @State var isPresented: Bool = false
  @State var heightOffset: CGFloat = .zero
  @State var midY: CGFloat = .zero
  @State var yOffset: CGFloat = .zero
  @State var xOffset: CGFloat = .zero

  init(
    position: PopoverPosition,
    dismissOptions: DismissOptions = .outside,
    alignment: Alignment,
    @ViewBuilder content: () -> T
  ) {
    self.position = position
    self.dismissOptions = dismissOptions
    self.alignment = alignment
    popup = content()
  }

  func body(content: Content) -> some View {
    content
      .disabled(true)
      .background {
        GeometryReader { geometry in
          Color.clear
            .fullScreenCover(isPresented: $isPresented) {
              popupContent(geometry.frame(in: .global))
                .position(
                  x: geometry.frame(in: .global).midX + xOffset,
                  y: (geometry.frame(in: .global).midY) + heightOffset + yOffset
                )
                .backgroundViewModifier(alpha: 0)
            }
        }
      }
      .onTapGesture {
        UIView.setAnimationsEnabled(false)
          isPresented.toggle()
      }
  }

  @ViewBuilder
  private func popupContent(_ p: CGRect) -> some View {
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
      Color.orange.onAppear {
        print("pop height \( geo.size.height )")
        print("height label p \( p.height )")
        
        midY = p.midY - geo.frame(in: .global).midY + position.coordinates(popover: geo.size).y
        print("MID p \(midY)")
        print(position.coordinates(popover: geo.size).y)
//        yOffset = position.coordinates(popover: geo.size).y
        xOffset = position.coordinates(popover: geo.size).x
      }
      .onChange(of: midY) { newValue in
        print("size change \(midY)")
        print("newValue \(newValue)")
        if midY != 0 {
          heightOffset = newValue
          print("heightOffset \(heightOffset)")
        }
      }
    })
    .preferredColorScheme(.light)
  }
}

@available(iOS 16.4, *)
extension View {
  func popup<T: View>(
    position: PopoverPosition,
    dismissOptions: DismissOptions = .anywhere,
    alignment: Alignment = .trailing,
    @ViewBuilder content: () -> T
  ) -> some View {
    return modifier(
      Popup(
        position: position,
        dismissOptions: dismissOptions,
        alignment: alignment,
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

  func coordinates(popover frame: CGSize) -> CGPoint {
    switch self {
    case .top(let offset):
      return CGPoint(
        x: 0,
        y: -frame.height - offset
      )
    case .bottom(let offset):
      return CGPoint(
        x: 0,
        y: frame.height + offset
      )
    case .right(let offset):
      return CGPoint(
        x: frame.width + offset,
        y: 0
      )
    case .left(let offset):
      return CGPoint(
        x: -frame.width - offset,
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

// public struct PBPopover<Content: View, Label: View>: View {
//  let position: PopoverPosition
//  let padding: CGFloat
//  let backgroundAlpha: CGFloat
//  let popoverWidth: CGFloat?
//  let dismissOptions: DismissOptions
//  let content: Content
//  let label: Label
//
//  @State private var presentPopover: Bool = false
//  @State private var labelFrame: CGRect = .zero
//  @State private var popoverSize: CGRect = .zero
//  @Binding var scrollOffset: CGPoint
//
//  public init(
//    position: PopoverPosition = .bottom((0, 0)),
//    padding: CGFloat = Spacing.small,
//    backgroundAlpha: CGFloat = 0,
//    popoverWidth: CGFloat? = nil,
//    dismissOptions: DismissOptions = .anywhere,
//    scrollOffset: Binding<CGPoint>,
//    @ViewBuilder content: (() -> Content) = { EmptyView() },
//    @ViewBuilder label: (() -> Label) = { EmptyView() }
//  ) {
//    self.position = position
//    self.padding = padding
//    self.backgroundAlpha = backgroundAlpha
//    self.popoverWidth = popoverWidth
//    self.dismissOptions = dismissOptions
//    self._scrollOffset = scrollOffset
//    self.content = content()
//    self.label = label()
//  }
//
//  public var body: some View {
//    ZStack {}
//  }
//
//  var popoverView: some View {
//    PBCard(padding: padding, width: popoverWidth) {
//      content
//    }
//    .preferredColorScheme(.light)
//    .onTapGesture {
//      switch dismissOptions {
//      case .inside, .anywhere:
//        presentPopover.toggle()
//      case .outside:
//        break
//      }
//    }
// #if os(iOS)
//    .position(
//      position.coordinates(
//        labelFrame,
//        popoverFrame: popoverSize,
//        scrollOffset: scrollOffset
//      )
//    )
// #endif
//    .backgroundViewModifier(alpha: 0)
//    .onTapGesture {
//      switch dismissOptions {
//      case .outside, .anywhere:
//        presentPopover.toggle()
//      case .inside:
//        break
//      }
//    }
//  }
// }
