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
  let dismissOptions: DismissOptions
  let alignment: Alignment
  @State var isPresented: Bool = false
  @State var position: CGRect = .zero
  @State var size: CGFloat = .zero
  
  init(
    dismissOptions: DismissOptions,
    alignment: Alignment, 
    @ViewBuilder content: () -> T
  ) {
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
                .position(x: geometry.frame(in: .global).midX, y: geometry.frame(in: .global).midY + size)
                .onTapGesture {
                  switch dismissOptions {
                  case .outside, .anywhere:
                    isPresented.toggle()
                  case .inside:
                    break
                  }
                }
                .backgroundViewModifier(alpha: 0)
            }
        }
      }
      .onTapGesture {
        isPresented.toggle()
        UIView.setAnimationsEnabled(false)
      }
  }
  
  @ViewBuilder
  private func popupContent(_ p: CGRect) -> some View {   
    PBCard(padding: 10, width: nil) { 
      popup    
    }
    .background(GeometryReader { geo in
      Color.orange.onAppear { //size = geo.size.height 
        print("size \( geo.size.height )")
        print("size p \( p.height )")
        print("MID p \( (p.midY - geo.frame(in: .global).midY))")
        size = p.midY - geo.frame(in: .global).midY
      }
    })   
    .preferredColorScheme(.light)
    .offset(x: 0, y: 0)
  }
}

@available(iOS 16.4, *)
extension View {
  func popup<T: View>(
    dismissOptions: DismissOptions = .anywhere,
    alignment: Alignment = .trailing,
    @ViewBuilder content: () -> T
  ) -> some View {
    return modifier(
      Popup(
        dismissOptions: dismissOptions,
        alignment: alignment,
        content: content)
    )
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
    let popoverHeight = popoverFrame.height
    
    switch self {
    case .top((let offsetX, let offsetY)):
      return CGPoint(
        x: labelFrame.midX + offsetX,
        y: labelFrame.midY + offsetY
      )
    case .bottom((let offsetX, let offsetY)):
      return CGPoint(
        x: labelFrame.midX + offsetX,
        y: labelFrame.midY + offsetY
      )
    case .right((let offsetX, let offsetY)): return
      CGPoint(
        x: labelFrame.maxX + popoverFrame.width/2 + space + offsetX,
        y: labelFrame.midY + offsetY
      )
    case .left((let offsetX, let offsetY)): return
      CGPoint(
        x: labelFrame.minX - popoverFrame.width/2 - space - offsetX,
        y: labelFrame.midY + offsetY
      )
    case .center((let offsetX, let offsetY)): return
      CGPoint(
        x: labelFrame.midX + offsetX,
        y: labelFrame.midY + offsetY
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
