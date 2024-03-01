//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCurrency.swift
//

import SwiftUI

public struct PBCurrency: View {
  let dollarAmount: String?
  let decimalAmount: String?
  let label: String?
  let size: PBFont?
  let symbol: String?
  let unit: String?
  let alignment: Alignment
  let isEmphasized: Bool
  public init(
    dollarAmount: String? = nil,
    decimalAmount: String? = nil,
    label: String? = nil,
    size: PBFont? = .body,
    symbol: String? = nil,
    unit: String? = nil,
    alignment: Alignment = .leading,
    isEmphasized: Bool = false
  ) {
    self.dollarAmount = dollarAmount
    self.decimalAmount = decimalAmount
    self.label = label
    self.size = size
    self.symbol = symbol
    self.unit = unit
    self.alignment = alignment
    self.isEmphasized = isEmphasized
  }
  public var body: some View {
    currencyView
  }
}
public extension PBCurrency {
  var currencyView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text(label ?? "")
        .pbFont(.caption, color: .text(.light))
      HStack(spacing: 0) {
        Text(getCurrency(symbol: symbol ?? ""))
          .pbFont(.body, color: .text(.light))
        Text(formattedDollar + formattedDecimal)
          .pbFont(.body, variant: .bold)
      }
    }
  }
  var formattedDollar: AttributedString {
    var amount = AttributedString(dollarAmount ?? "")
    amount.foregroundColor = .text(.default)
    return amount
  }
  var formattedDecimal: AttributedString {
    var amount = AttributedString(decimalAmount ?? "")
    amount.foregroundColor = .text(.light)
    return amount
  }
  var fontColor: Color {
    isEmphasized ? .text(.default) : .text(.light)
  }
  func getCurrency(symbol: String) -> String {
    let locale = Locale(identifier: symbol)
    let currencySymbol = locale.currencySymbol!
    return currencySymbol
  }
}
#Preview {
  registerFonts()
  return  CurrencyCatalog()
}
