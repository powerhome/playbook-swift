//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateRangeStacked.swift
//

import SwiftUI

public struct PBDateRangeStacked: View {
  let date: Date
  public init(
    date: Date = Date()
  ) {
    self.date = date
  }
    public var body: some View {
      Text("")
    }
}

#Preview {
  registerFonts()
   return PBDateRangeStacked()
}
