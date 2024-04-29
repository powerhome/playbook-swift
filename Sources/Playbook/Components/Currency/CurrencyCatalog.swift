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
      .background(Color.background(.light))
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
  var alignmentView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      HStack {
        PBCurrency(
          amount: "2,000",
          decimalAmount: ".50",
          label: "left",
          size: .title4,
          symbol: "en_US",
          isEmphasized: true,
          alignment: .leading
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      HStack {
        PBCurrency(
          amount: "342",
          decimalAmount: ".00",
          label: "center",
          size: .title4,
          symbol: "en_EU",
          isEmphasized: true,
          alignment: .center
        )
      }
      .frame(maxWidth: .infinity, alignment: .center)
      HStack {
        PBCurrency(
          amount: "45",
          label: "right",
          size: .title4,
          symbol: "en_US",
          unit: "/mo",
          isEmphasized: true,
          hasUnit: true,
          alignment: .trailing
        )
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}


