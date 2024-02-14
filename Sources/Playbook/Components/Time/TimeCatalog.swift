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
          PBDoc(title: "Sizes") {
            sizesView
          }
          PBDoc(title: "Time Zones") {
            handlingTimeZones
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
      PBTime(showTimeZone: true,
             variant: .iconTimeZone
      )
      PBTime(showIcon: true,
             variant: .iconTimeZone
      )
      PBTime(variant: .iconTimeZone)
      PBTime(variant: .time,
             isLowercase: true,
             isBold: true
      )
      PBTime(showTimeZone: true,
             variant: .iconTimeZone,
             isLowercase: true,
             isBold: true,
             timeZoneSize: .body
      )
      PBTime(showIcon: true,
             variant: .iconTimeZone,
             isLowercase: true,
             isBold: true
      )
      PBTime(variant: .iconTimeZone,
             isLowercase: true,
             isBold: true,
             timeZoneSize: .body
      )
     
    }
  }
  
  var sizesView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTime(showTimeZone: true, 
             variant: .iconTimeZone)
      PBTime(showTimeZone: true, 
             variant: .iconTimeZone,
             isLowercase: true,
             isBold: true,
             timeZoneSize: .body
      )
    }
  }
  var handlingTimeZones: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTime(showTimeZone: true, 
             variant: .withTimeZoneHeader,
             isLowercase: true,
             header: "East Coast",
             isBold: true,
             timeZoneSize: .body
      )
      PBTime(showTimeZone: true, 
             variant: .withTimeZoneHeader,
             header: "Central",
             zone: .central
      )
      PBTime(showTimeZone: true,
             variant: .withTimeZoneHeader,
             header: "Mountain",
             zone: .mountain
      )
      PBTime(showTimeZone: true,
             variant: .withTimeZoneHeader,
             header: "West Coast",
             zone: .pacific
      )
      PBTime(showTimeZone: true,
             variant: .withTimeZoneHeader,
             header: "Tokyo, Japan",
             zone: .gmt
      )
    }
  }
}
