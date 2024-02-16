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
          alignmentView
        }
        PBDoc(title: "Unstyled") {
          unstyledView
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
      Spacer()
      PBTime(variant: .time,
             isLowercase: true,
             isBold: true,
             unstyled: .body
             
      )
      PBTime(showTimeZone: true,
             variant: .iconTimeZone,
             isLowercase: true,
             isBold: true,
             unstyled: .body
      )
      PBTime(showIcon: true,
             variant: .iconTimeZone,
             isLowercase: true,
             isBold: true
      )
      PBTime(variant: .iconTimeZone,
             isLowercase: true,
             isBold: true,
             unstyled: .body
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
             unstyled: .body
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
             unstyled: .body
      )
      PBTime(showTimeZone: true, 
             variant: .withTimeZoneHeader,
             header: "Central",
             zone: .central,
             timeIdentifier: "CST"
      )
      PBTime(showTimeZone: true,
             variant: .withTimeZoneHeader,
             header: "Mountain",
             zone: .mountain,
             timeIdentifier: "MST"
      )
      PBTime(showTimeZone: true,
             variant: .withTimeZoneHeader,
             header: "West Coast",
             zone: .pacific,
             timeIdentifier: "PST"
      )
      PBTime(showTimeZone: true,
             variant: .withTimeZoneHeader,
             header: "Tokyo, Japan",
             zone: .gmt,
             timeIdentifier: "GMT"
      )
    }
  }
  var alignmentView: some View {
    VStack(spacing: Spacing.small) {
      PBTime(
        showTimeZone: true,
        variant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        alignment: .leading,
        unstyled: .body
      )
      PBTime(showTimeZone: true,
        variant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        alignment: .center,
        unstyled: .body
      )
      PBTime(
        showTimeZone: true,
        variant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        alignment: .trailing,
        unstyled: .body
      )
    }
  }
  var unstyledView: some View {
    VStack(spacing: Spacing.small) {
      PBTime(
        variant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        isIconBold: true,
        isTimeZoneBold: true,
        unstyled: .body
      )
      PBTime(
        iconSize: .x3,
        variant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        isIconBold: true,
        isTimeZoneBold: true,
        unstyled: .title1
      )
      PBTime(
        iconSize: .xSmall,
        variant: .iconTimeZone,
        isLowercase: true,
        unstyled: .subcaption
      )
    }
  }
}
