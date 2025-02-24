//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTooltip.swift
//

import SwiftUI

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
        .onHover(disabled: false) { handleOnHover(hovering: $0) }
        .onChange(of: shouldPresentPopover) { handleOnChange() }
        .popover(isPresented: $presentPopover, arrowEdge: self.placement, content: { popoverView })
      } else {
        content
      }
    }
  }
}

public extension PBTooltip {
  enum DelayType {
    case all
    case open
    case close
  }

  private func handleOnHover(hovering: Bool) {
    shouldPresentPopover = hovering
  }

  private func handleOnChange() {
    if delay > 0.0 {
      handleDelay
    } else {
      presentPopover = shouldPresentPopover
    }
  }

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

  private var popoverView: some View {
    let view = HStack {
      if let icon = icon {
        PBIcon(icon)
          .padding(.leading, Spacing.xSmall)
        Text(text)
          .padding(.vertical, Spacing.xSmall)
          .padding(.trailing, Spacing.xSmall)
          .pbFont(.body)
      } else {
        Text(text)
          .pbFont(.body)
          .padding(.all, 10)
      }
    }.background(Color.black.padding(-80))
    
    if #available(macOS 13.3, *), #available(iOS 16.4, *) {
      return view.presentationCompactAdaptation(.popover)
    } else {
      return view
    }
  }
}

public extension View {
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

//#Preview {
//  registerFonts()
//  return TooltipCatalog()
//}
