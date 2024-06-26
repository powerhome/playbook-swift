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
  public init(
    active: Binding<Int> = .constant(2),
    steps: Int = 3,
    title: String? = nil,
    value: String? = nil
  ) {
    self._active = active
    self.steps = steps
    self.title = title
    self.value = value
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
    RoundedRectangle(cornerRadius: 4)
      .frame(width: 45, height: 4)
      .foregroundColor(isActive ? Color.pbPrimary : Color.text(.lighter))
  }
}
#Preview {
  registerFonts()
  return PBProgressPill()
}
