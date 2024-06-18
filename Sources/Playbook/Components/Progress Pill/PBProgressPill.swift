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
  @Binding var  isActive: Bool
  
  public init(
    isActive: Binding<Bool> = .constant(false)
  ) {
    self._isActive = isActive
  }
  
  public var body: some View {
    progressPillView
  }
}

extension PBProgressPill {
  var progressPillView: some View {
    HStack {
      RoundedRectangle(cornerRadius: 4)
        .frame(width: 45, height: 4)
        .foregroundStyle(isActive ? Color.pbPrimary : Color.text(.lighter))
    }
  }
}
#Preview {
  registerFonts()
  return PBProgressPill()
}
