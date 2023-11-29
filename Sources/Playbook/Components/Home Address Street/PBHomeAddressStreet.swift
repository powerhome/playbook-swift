//
//  PBHomeAddressStreet.swift
//
//
//  Created by Rachel Radford on 11/16/23.
//

import SwiftUI

public struct PBHomeAddressStreet: View {
  let address: String
  let withBullet: Bool
  let houseStyle: String?
  let addressCont: String?
  let city: String
  let homeId: String?
  let homeUrl: String?
  let state: String
  let territory: String
  let zipcode: String
  let emphasize: Emphasize

  public init(
    address: String,
    withBullet: Bool = false,
    houseStyle: String? = nil,
    addressCont: String? = nil,
    city: String,
    homeId: String? = nil,
    homeUrl: String? = nil,
    state: String,
    territory: String,
    zipcode: String,
    emphasize: Emphasize = .address
  ) {
    self.address = address
    self.withBullet = withBullet
    self.houseStyle = houseStyle
    self.addressCont = addressCont
    self.city = city
    self.homeId = homeId
    self.homeUrl = homeUrl
    self.state = state
    self.territory = territory
    self.zipcode = zipcode
    self.emphasize = emphasize
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      addressView
      cityView
      linkView
        .padding(.top, 3)
    }
  }
}

public extension PBHomeAddressStreet {
  enum Emphasize {
    case address, city, cityWithZipcode
  }

  var addressView: some View {
    VStack(alignment: .leading) {
      HStack(spacing: Spacing.xxSmall) {
        Text(address)
        if let houseStyle = houseStyle {
          Text(withBullet ? "•"  : "")
          Text(houseStyle)
        }
      }
      if let addressCont = addressCont {
        Text(addressCont)
      }
    }
    .pbFont(emphasize == .address ? .title4 : .body, color: emphasize == .address ? .text(.default) : .text(.light))
  }

  var cityView: some View {
    HStack(spacing: Spacing.xxSmall) {
      if emphasize == .cityWithZipcode {
        cityStateStyle
          .pbFont(.title4)
        zipcodeStyle
          .pbFont(.title4)
      } else {
        cityStateStyle
          .pbFont(emphasize == .city ? .title4 : .body, color: emphasize == .city ? .text(.default) : .text(.light))
        zipcodeStyle
          .pbFont(.body, color: .text(.light))
      }
    }
  }

  var cityStateStyle: AnyView? {
    return AnyView(
      HStack(spacing: Spacing.xxSmall) {
        Text(city + ",")
        Text(state)
      }
    )
  }

  var zipcodeStyle: Text? {
    return Text(zipcode)
  }

  var linkView: AnyView? {
    return AnyView(
      HStack(spacing: Spacing.xSmall) {
        if let homeId = homeId, let homeUrl = URL(string: homeUrl ?? "") {
          Link(destination: homeUrl) {
            PBBadge(text: homeId)
          }
        }
        Text(territory)
          .pbFont(.subcaption, variant: .light, color: .text(.light))
      }
    )
  }
}

#Preview {
  registerFonts()
  return HomeAddressStreetCatalog()
}
