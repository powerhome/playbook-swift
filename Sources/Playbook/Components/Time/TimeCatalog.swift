//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TimeCatalog.swift
//

import SwiftUI

struct TimeCatalog: View {
    var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
          PBDoc(title: "Variants") {
            
          }
          PBDoc(title: "Alignment") {
           
          }
          PBDoc(title: "Unstyled") {
            
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Time")
    }
}

extension TimeCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTime(variant: .time)
      PBTime(variant: .withTimeZone)
      PBTime(variant: .withIcon)
      PBTime(variant: .iconTimeZone)
    }
  }
}
