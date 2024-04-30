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
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(.light))
      .navigationTitle("Time Stacked")
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

