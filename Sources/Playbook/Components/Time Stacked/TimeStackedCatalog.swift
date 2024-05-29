//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TimeStackedCatalog.swift
//

import SwiftUI

public struct TimeStackedCatalog: View {
  public var body: some View {
    PBDocStack(title: "Time Stacked") {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension TimeStackedCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      HStack {
        PBTimeStacked(
          alignment: .leading,
          timeZoneIdentifier: "EST",
          isLowercase: true,
          timeStyle: .body,
          timeZoneStyle: .caption
        )
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      PBTimeStacked(
        alignment: .center,
        timeZoneIdentifier: "EST",
        isLowercase: true,
        timeStyle: .body,
        timeZoneStyle: .caption
      )
      .frame(maxWidth: .infinity, alignment: .center)
      PBTimeStacked(
        alignment: .trailing, 
        timeZoneIdentifier: "EST", 
        isLowercase: true, 
        timeStyle: .body, 
        timeZoneStyle: .caption
      )
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

