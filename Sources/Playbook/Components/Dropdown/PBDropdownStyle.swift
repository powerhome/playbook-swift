//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDropdownStyle.swift
//

import Foundation
import SwiftUI

struct PBDropdownStyle: ViewModifier {
  @Binding var optionIndex: Int
  let index: Int
  let option: String
  @Binding var selectedText: String
  @Binding var isOpen: Bool

  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, .iOS(Spacing.none, macOS: Spacing.xSmall))
      .overlay(
        ZStack {
          optionIndex == index ? Color.pbPrimary.opacity(0.05) : .clear
        }
        .frame(minWidth: 800, minHeight: 45)
      )
      .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
        return -viewDimensions.width / 2
      }
      .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
        return viewDimensions.width * 1.1
      }
      .onHover { isHovering in
        optionIndex = index
        #if os(macOS)
        if isHovering {
          NSCursor.pointingHand.set()
        } else {
          NSCursor.arrow.set()
        }
        #endif
      }
      .onTapGesture {
        self.selectedText = option
        self.isOpen = false
      }
  }
}

extension View  {
  func dropdownStyle(
    optionIndex: Binding<Int>,
    index: Int,
    option: String,
    selectedText: Binding<String>,
    isOpen: Binding<Bool>
  ) -> some View {
    self.modifier(PBDropdownStyle(
      optionIndex: optionIndex,
      index: index,
      option: option,
      selectedText: selectedText,
      isOpen: isOpen
    ))
  }
}
