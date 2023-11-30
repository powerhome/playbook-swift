//
//  PBTooltip.swift
//
//
//  Created by Stephen Marshall on 11/29/23.
//

import SwiftUI

@available(macOS 13.3, *)
public struct PBTooltip: ViewModifier {
  let canPresent: Bool
  let delay: TimeInterval
  let delayType: DelayType
  let icon: FontAwesome?
  let placement: Edge
  let text: String

  @State private var delayCompleted: Bool = false
  @State private var presentPopover: Bool = false
  @State private var shouldPresentPopover: Bool = false
  @State private var workItems: [DispatchWorkItem?] = []

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
        content
        .onHover(perform: handleOnHover)
        .onChange(of: shouldPresentPopover, perform: handleOnChange)
        .popover(isPresented: $presentPopover, arrowEdge: self.placement, content: popoverView)
      } else {
        content
      }
    }
  }
}

@available(macOS 13.3, *)
public extension PBTooltip {
  enum DelayType {
    case all
    case open
    case close
  }
  private func handleOnHover(hovering: Bool) {
    shouldPresentPopover = hovering
  }
  private func handleOnChange(_: Bool) {
    if delay > 0.0 {
      handleDelay
    } else {
      presentPopover = shouldPresentPopover
    }
  }
//  TODO: timebox learning Task API - 30 mins
  private func handleDispatch(present: Bool) -> DispatchWorkItem {
    let workItem = DispatchWorkItem {
      presentPopover = present
      delayCompleted = present
    }
    let queue = DispatchQueue.global(qos: .utility)
    queue.asyncAfter(deadline: .now() + delay, execute: workItem)
    return workItem
  }
  private var cancelWorkItems: Void {
    for item in workItems {
      item?.cancel()
    }
    workItems.removeAll()
  }
  private var addWorkQueueItem: Void {
    workItems.append(handleDispatch(present: shouldPresentPopover))
  }
  private var handleDelay: Void {
    switch self.delayType {
    case .all:
      addWorkQueueItem
      if !shouldPresentPopover && !delayCompleted {
        cancelWorkItems
      }
    case .close:
      if shouldPresentPopover {
        presentPopover = true
      } else {
        addWorkQueueItem
      }
    case .open:
      if shouldPresentPopover {
        addWorkQueueItem
      } else {
        presentPopover = false
        cancelWorkItems
      }
    }
  }
  private func popoverView() -> some View {
    HStack(alignment: .center) {
      if self.icon == nil {
        Text(self.text)
          .padding()
          .presentationCompactAdaptation(.popover)
      } else {
        PBIcon(self.icon!)
          .padding(.leading, Spacing.small)
        Text(self.text)
          .padding(.vertical, Spacing.small)
          .padding(.trailing, Spacing.small)
          .presentationCompactAdaptation(.popover)
      }
    }
  }
}

public extension View {
  @available(macOS 13.3, *)
  func pbTooltip(
    canPresent: Bool = true,
    delay: TimeInterval = 0.0,
    delayType: PBTooltip.DelayType = .all,
    icon: FontAwesome? = nil,
    placement: Edge = .top,
    text: String = ""
  ) -> some View {
    return AnyView(
      self.modifier(PBTooltip(
        canPresent: canPresent,
        delay: delay,
        delayType: delayType,
        icon: icon,
        placement: placement,
        text: text
      ))
    )
  }
}

@available(macOS 13.3, *)
public struct PBTooltip_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PBButton(title: "Button Text")
      .pbFont(.body)
      .pbTooltip(text: "Tooltip Text")
  }
}
