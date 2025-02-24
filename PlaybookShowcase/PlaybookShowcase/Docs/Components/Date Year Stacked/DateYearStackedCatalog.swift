//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateYearStackedCatalog.swift
//

import SwiftUI
import Playbook

public struct DateYearStackedCatalog: View {
  public var body: some View {
    PBDocStack(title: "Date Year Stacked") {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension DateYearStackedCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateYearStacked(
        date: Date(),
        alignment: .leading
      )
      .frame(maxWidth: .infinity, alignment: .leading)
      PBDateYearStacked(
        date: Date(),
        alignment: .center
      )
      .frame(maxWidth: .infinity, alignment: .center)
      PBDateYearStacked(
        date: Date(),
        alignment: .trailing
      )
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}
