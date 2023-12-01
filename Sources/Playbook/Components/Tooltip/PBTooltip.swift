//
//  PBTooltip.swift
//
//
//  Created by Stephen Marshall on 11/29/23.
//

import SwiftUI

@available(macOS 13.3, *)
@available(iOS 16.4, *)
public struct PBTooltip: ViewModifier {
  let canPresent: Bool
  let delay: TimeInterval
  let delayType: DelayType
  let icon: FontAwesome?
  let placement: Edge
  let text: String

  @State private var shouldPresentPopover: Bool = false
  @State private var presentPopover: Bool = false

  public init(
    canPresent: Bool = true,
    delay: TimeInterval = 0.0,
    delayType: DelayType = .all,
    icon: FontAwesome? = nil,
    placement: Edge = .top,
    text: String = ""
  ) {
    self.canPresent = canPresent
    self.delay = delay
    self.delayType = delayType
    self.icon = icon
    self.placement = placement
    self.text = text
  }

  public func body(content: Content) -> some View {
    HStack {
      if self.canPresent {
        content.onHover(perform: { hovering in
          shouldPresentPopover = hovering
        })
        .onChange(of: shouldPresentPopover, perform: { _ in
          handleDelay
        })
        .popover(isPresented: $presentPopover, arrowEdge: self.placement, content: {
          if self.icon != nil {
            iconPopover
          } else {
            basePopover
          }
        })
      } else {
        content
      }
    }
  }
}

@available(macOS 13.3, *)
@available(iOS 16.4, *)
public extension PBTooltip {
  enum DelayType {
    case all
    case open
    case close
  }
  var basePopover: some View {
    Text(self.text)
      .padding()
      .presentationCompactAdaptation(.popover)
      .onHover(perform: tooltipContentHover)
  }
  var iconPopover: some View {
    HStack(alignment: .center, spacing: Spacing.xSmall) {
      PBIcon(self.icon!)
        .padding(.leading, Spacing.small)
      Text(self.text)
        .padding(.vertical, Spacing.small)
        .padding(.trailing, Spacing.small)
        .presentationCompactAdaptation(.popover)
    }
  }
  private func handleDispatch(present: Bool) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      presentPopover = present
    }
  }
  private func tooltipContentHover(hovering: Bool) {
    print("Hovering over tooltip contents")
  }
  var handleDelay: Void {
    switch self.delayType {
    case .all:
      handleDispatch(present: shouldPresentPopover)
    case .close:
      if shouldPresentPopover {
        presentPopover = true
      } else {
        handleDispatch(present: false)
      }
    case .open:
      if shouldPresentPopover {
        handleDispatch(present: true)
      } else {
        presentPopover = false
      }
    }
  }
}

@available(macOS 13.3, *)
@available(iOS 16.4, *)
public struct PBTooltip_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return TooltipCatalog()
  }
}
