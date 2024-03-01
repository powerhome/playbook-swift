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
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Currency")
    }
}
public extension CurrencyCatalog {
  var sizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBCurrency(
        dollarAmount: "2,000",
        decimalAmount: ".50",
        label: "small",
        size: .body,
        symbol: "en_US",
        isEmphasized: true
      )
    }
  }
}


