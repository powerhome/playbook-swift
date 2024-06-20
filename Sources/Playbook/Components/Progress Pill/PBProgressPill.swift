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
  let active: [Int]
  let steps: [Int]
  public init(
    active: [Int] = [1, 2],
    steps: [Int] = [1, 2, 3]
  ) {
    self.active = active
    self.steps = steps
  }
  
  public var body: some View {
    progressView()
  }
}

extension PBProgressPill {
  func progressView() -> some View {
    HStack {
      ForEach(steps.indices, id: \.self) { index in
        progressPillView(isActive: active.contains(steps[index]))
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
