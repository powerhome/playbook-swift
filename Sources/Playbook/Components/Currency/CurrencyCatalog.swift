//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CurrencyCatalog.swift
//

import SwiftUI

public struct CurrencyCatalog: View {
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Size") {
            sizeView
          }
        }
        .padding(Spacing.medium)
      }
      .navigationTitle("Currency")
    }
}
public extension CurrencyCatalog {
  var sizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBCurrency(
        amount: "2,000",
        decimalAmount: ".50",
        label: "small",
        size: .title4,
        symbol: "en_US",
        isEmphasized: true
      )
      PBCurrency(
        amount: "342",
        decimalAmount: ".00",
        label: "medium",
        size: .title3,
        symbol: "en_EU",
        isEmphasized: true
      )
      PBCurrency(
        amount: "45",
        label: "large",
        size: .title1,
        symbol: "en_US",
        unit: "/mo",
        isEmphasized: true,
        hasUnit: true
      )
    }
  }
}


