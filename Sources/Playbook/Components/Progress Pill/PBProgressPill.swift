//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBProgressPill.swift
//

import SwiftUI

public struct PBProgressPill: View {
  @Binding var active: Int
  let steps: Int
  let title: String?
  let value: String?
  let pillWidth: CGFloat
  let pillHeight: CGFloat
  let progressBarColorTrue: Color?
  let progressBarColorFalse: Color?
  let cornerRadius: CGFloat
  public init(
    active: Binding<Int> = .constant(2),
    steps: Int = 3,
    title: String? = nil,
    value: String? = nil,
    pillWidth: CGFloat = 45,
    pillHeight: CGFloat = 4,
    progressBarColorTrue: Color? = .pbPrimary,
    progressBarColorFalse: Color? = Color.text(.lighter),
    cornerRadius: CGFloat = 4
  ) {
    self._active = active
    self.steps = steps
    self.title = title
    self.value = value
    self.pillWidth = pillWidth
    self.pillHeight = pillHeight
    self.progressBarColorTrue = progressBarColorTrue
    self.progressBarColorFalse = progressBarColorFalse
    self.cornerRadius = cornerRadius
  }
  
  public var body: some View {
    titleProgressView
  }
}

extension PBProgressPill {
  var titleProgressView: some View {
    VStack(alignment: .leading) {
      titleValueView
      progressView
    }
  }
  var titleValueView: some View {
    HStack {
      titleView
      valueView
    }
  }
  @ViewBuilder
  var titleView: some View {
    if let title = title {
      Text(title)
        .pbFont(.title4)
    }
  }
  @ViewBuilder
  var valueView: some View {
    if let value = value {
      Text(value)
        .pbFont(.body, color: .text(.light))
    }
  }
  var progressView: some View {
    HStack {
      ForEach(1...steps, id: \.self) { step in
        progressPillView(isActive: step <= active ? true : false)
      }
    }
  }
  func progressPillView(isActive: Bool) -> some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .frame(width: pillWidth, height: pillHeight)
      .foregroundColor(isActive ? progressBarColorTrue : progressBarColorFalse)
  }
}
#Preview {
  registerFonts()
  return PBProgressPill()
}
