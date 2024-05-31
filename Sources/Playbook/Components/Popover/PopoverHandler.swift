//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverHandler: ViewModifier {
  let popoverManager = PopoverManager.shared
  
  func body(content: Content) -> some View {
    content
      .overlay(GlobalPopoverView())
      .environmentObject(popoverManager)
  }
}

public extension View {
  func popoverHandler() -> some View {
    self.modifier(PopoverHandler())
  }
}

struct GlobalPopoverView: View {
  @EnvironmentObject var popoverManager: PopoverManager
  
  var body: some View {
    ZStack {
      let presentedList = popoverManager.isPresented.sorted(by: { $0.key <= $1.key })
      let popoverList = popoverManager.popovers.sorted(by: { $0.key <= $1.key })
      let commonKeys = Set(presentedList.map { $0.key }).intersection(popoverList.map { $0.key })
      let newArray: [(Int, Bool, PopoverManager.Popover)] = commonKeys.compactMap { key in
        if let presentedValue = popoverManager.isPresented[key], let listValue = popoverManager.popovers[key] {
          return (key, presentedValue, listValue)
        }
        return nil
      }
      
      ForEach(newArray, id: \.0) { id, isPresented, popover in
        if isPresented {
          closeOutside(id)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          popover.view
            .position(popover.position ?? .zero)
            .onTapGesture {
              closeInside(id)
            }
        }
      }
    }
  }
  
  private func closeInside(_ key: Int) -> Void {
    switch popoverManager.popovers[key]?.close.0 {
    case .inside, .anywhere:
      onClose(key)
    default:
      break
    }
  }
  
  private func closeOutside(_ key: Int) -> AnyView {
    switch popoverManager.popovers[key]?.close.0 {
    case .outside, .anywhere:
      return AnyView(ClickDetectorView {
        onClose(key)
      })
    default:
      return AnyView(EmptyView())
    }
  }
  
  private func onClose(_ key: Int) {
    if let closeAction = popoverManager.popovers[key]?.close.action {
      popoverManager.isPresented.updateValue(false, forKey: key)
      closeAction()
    } else {
      popoverManager.isPresented.updateValue(false, forKey: key)
    }
  }
}
