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
          PBDoc(title: "Alignment") {
            alignmentView
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
        size: .title4,
        symbol: "en_US",
        isEmphasized: true
      )
      PBCurrency(
        dollarAmount: "342",
        decimalAmount: ".00",
        label: "medium",
        size: .title3,
        symbol: "en_EU",
        isEmphasized: true
      )
      PBCurrency(
        dollarAmount: "45",
        label: "large",
        size: .title1,
        symbol: "en_US",
        unit: "/mo", 
        isEmphasized: true,
        hasUnit: true
      )
    }
  }
  var alignmentView: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      PBCurrency(
        dollarAmount: "2,000",
        decimalAmount: ".50",
        size: .title4,
        symbol: "en_US",
        alignment: .leading, 
        isEmphasized: true
      )
      PBCurrency(
        dollarAmount: "342",
        decimalAmount: ".00",
        size: .title4,
        symbol: "en_EU",
        alignment: .center,
        isEmphasized: true
      )
      PBCurrency(
        dollarAmount: "45",
        size: .title4,
        symbol: "en_US",
        unit: "/mo",
        alignment: .trailing, 
        isEmphasized: true,
        hasUnit: true
      )
    }
  }
}


