//
//  SwiftUIView.swift
//
//
//  Created by Rachel Radford on 11/8/23.
//

import SwiftUI

public struct DateCatalog: View {
  public init() {}
  let minWidth: CGFloat = 0
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          defaultView
        }
        PBDoc(title: "Variants") {
          variantView
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
    .navigationTitle("Date")
  }
}

public extension DateCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      ForEach(PBDate.Variant.showCases, id: \.self) {  variant in
        PBDate(Date(), variant: variant)
      }
      Spacer()
      ForEach(PBDate.Variant.showCases, id: \.self) {  variant in
        PBDate(Date(), variant: variant, typography: .title4)
      }
    }
  }

  var variantView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDate(Date(), variant: .withIcon(isStandard: true), typography: .caption, iconSize: .xSmall)
      PBDate(Date(), variant: .standard, typography: .title4)
      PBDate(Date(), variant: .withIcon(isStandard: true), typography: .title4, iconSize: .x1)
      PBDate(Date(), variant: .dayDate, typography: .title4)
      PBDate(Date(), variant: .withIcon(isStandard: false), typography: .title4, iconSize: .x1)
    }
  }

  var alignmentView: some View {
    VStack(spacing: Spacing.small) {
      PBDate(Date(), variant: .standard, typography: .title4, alignment: .leading)
      PBDate(Date(), variant: .withIcon(isStandard: true), typography: .title4, iconSize: .x1, alignment: .center)
      PBDate(Date(), variant: .short, typography: .title4, alignment: .trailing)
    }
  }

  var unstyledView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDate(Date(), variant: .short, typography: .body)
      PBDate(Date(), variant: .standard, typography: .title1)
      PBDate(Date(), variant: .withIcon(isStandard: false), typography: .subcaption, iconSize: .xSmall)
    }
  }
}
