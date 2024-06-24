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
  @Binding var isActive: Bool
  @Binding var active: Int
  let steps: Int
  public init(
    isActive: Binding<Bool> = .constant(true),
    active: Binding<Int> = .constant(2),
    steps: Int = 3
  ) {
    self._isActive = isActive
    self._active = active
    self.steps = steps
  }
  
  public var body: some View {
    progressView
  }
}

extension PBProgressPill {
  
  var progressView: some View {
    HStack {
      ForEach(1...steps, id: \.self) { step in
          progressPillView(isActive: step <= active ? isActive : false)
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
