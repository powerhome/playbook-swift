//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI
#if os(iOS)
import Popovers
#endif

public struct PBPopover<Content: View, Label: View>: View {
  let position: PopoverPosition
  let padding: CGFloat
  let backgroundAlpha: CGFloat
  let popoverWidth: CGFloat?
  let dismissOptions: DismissOptions
  let content: Content
  let label: Label

  @State private var presentPopover: Bool = false

  public init(
    position: PopoverPosition = .bottom,
    padding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    popoverWidth: CGFloat? = nil,
    dismissOptions: DismissOptions = .anywhere,
    @ViewBuilder content: (() -> Content) = { EmptyView() },
    @ViewBuilder label: (() -> Label) = { EmptyView() }
  ) {
    self.position = position
    self.padding = padding
    self.backgroundAlpha = backgroundAlpha
    self.popoverWidth = popoverWidth
    self.dismissOptions = dismissOptions
    self.content = content()
    self.label = label()
  }

  public var body: some View {
    ZStack {
      label
        .disabled(true)
        .onTapGesture {
          presentPopover.toggle()
        }
      #if os(iOS)
        .popover(
          present: $presentPopover,
          attributes: {
            $0.position = position.position
            $0.sourceFrameInset.horizontal = -16
            $0.sourceFrameInset.vertical = -16
            if position == .center {
              $0.sourceFrameInset.bottom = -32
            }
            $0.rubberBandingMode = .none
            switch dismissOptions {
            case .outside, .anywhere:
              $0.dismissal.mode = .tapOutside
            case .inside:
              $0.dismissal.mode = .none
            }
          }
        ) { popoverView }
      #elseif os(macOS)
        .popover(isPresented: $presentPopover) { popoverView }
      #endif
    }
  }

var popoverView: some View {
  PBCard(
    padding: padding,
    shadow: .deeper,
    width: popoverWidth
  ) {
    content
  }
  .environment(\.colorScheme, .light)
  .onTapGesture {
    switch dismissOptions {
    case .inside, .anywhere:
      presentPopover.toggle()
    case .outside:
      break
    }
  }
  .backgroundViewModifier(alpha: backgroundAlpha)  
}

  public enum DismissOptions {
    case inside, outside, anywhere
  }
}

public enum PopoverPosition {
  case top, bottom, right, left, center
#if os(iOS)
  var position: Popover.Attributes.Position {
    switch self {
    case .top:
      return .absolute(
        originAnchor: .top,
        popoverAnchor: .bottom
      )
    case .bottom:
      return .absolute(
        originAnchor: .bottom,
        popoverAnchor: .top
      )
    case .right:
      return .absolute(
        originAnchor: .right,
        popoverAnchor: .left
      )
    case .left:
      return .absolute(
        originAnchor: .left,
        popoverAnchor: .right
      )
    case .center:
      return .absolute(
        originAnchor: .center,
        popoverAnchor: .top
      )
    }
  }
  #endif
}

public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}
