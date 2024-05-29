//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  HomeAddressStreetCatalog.swift
//

import SwiftUI

public struct HomeAddressStreetCatalog: View {
  public var body: some View {
    PBDocStack(title: "Home Address Street") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Emphasis") {
        defaultView
        Spacer(minLength: Spacing.medium)
        emphasisView
      }
      PBDoc(title: "Modified") {
        modifiedView
      }
      PBDoc(title: "Link") {
        linkView
      }
    }
  }

  var defaultView: some View {
    PBHomeAddressStreet(
      address: "70 Prospect Ave",
      withBullet: true,
      houseStyle: "Colonial",
      addressCont: "Apt M18",
      city: "West Chester",
      homeId: "8250263",
      homeUrl: "https://powerhrg.com/",
      state: "PA",
      territory: "PHL",
      zipcode: "19382"
    )
  }

  var emphasisView: some View {
    PBHomeAddressStreet(
      address: "70 Prospect Ave",
      withBullet: true,
      houseStyle: "Colonial",
      addressCont: "Apt M18",
      city: "West Chester",
      homeId: "8250263",
      homeUrl: "https://powerhrg.com/",
      state: "PA",
      territory: "PHL",
      zipcode: "19382",
      emphasize: .city
    )
  }

  var modifiedView: some View {
    PBHomeAddressStreet(
      address: "70 Prospect Ave",
      city: "West Chester",
      state: "PA",
      territory: "PHL",
      zipcode: "19382"
    )
  }

  var linkView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBHomeAddressStreet(
        address: "70 Prospect Ave",
        withBullet: true,
        houseStyle: "Colonial",
        addressCont: "Apt M18",
        city: "West Chester",
        homeId: "8250263",
        homeUrl: "https://powerhrg.com/",
        state: "PA",
        territory: "PHL",
        zipcode: "19382"
      )
    }
  }
}

// #Preview {
//    HomeAddressStreetCatalog()
// }
