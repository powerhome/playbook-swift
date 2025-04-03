//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDocStack.swift
//

import SwiftUI
import Playbook

struct PBDocStack<Content: View>: View {
  let title: String
  let spacing: CGFloat
  let padding: CGFloat
  let content: Content
  
  public init(
    title: String,
    spacing: CGFloat = Spacing.medium,
    padding: CGFloat = Spacing.medium,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.spacing = spacing
    self.padding = padding
    self.content = content()
  }
  var body: some View {
    ScrollView {
      VStack(spacing: spacing) {
        content
      }
      .padding(padding)
    }
    .background(Color.background(.default))
    .navigationTitle(title)
  }
}


struct Stack<Content: View>: View {
  let spacing: CGFloat
  let content: Content
  
  public init(
    spacing: CGFloat = Spacing.medium,
    padding: CGFloat = Spacing.medium,
    @ViewBuilder content: () -> Content
  ) {
    self.spacing = spacing
    self.content = content()
  }
  
  var body: some View {
#if os(macOS)
    HStack(spacing: spacing) { content }
#elseif os(iOS)
    VStack(alignment: .leading, spacing: spacing) { content }
#endif
  }
}
