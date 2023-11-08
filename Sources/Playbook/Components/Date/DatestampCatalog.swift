//
//  SwiftUIView.swift
//
//
//  Created by Rachel Radford on 11/8/23.
//

import SwiftUI

public struct DatestampCatalog: View {
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

public extension DatestampCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      ForEach(PBDatestamp.Variant.showCases, id: \.self) {  variant in
        PBDatestamp(Date(), variant: variant)
      }
      Spacer()
      ForEach(PBDatestamp.Variant.showCases, id: \.self) {  variant in
        PBDatestamp(Date(), variant: variant, typography: .title4)
      }
    }
  }

  var variantView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDatestamp(Date(), variant: .withIcon(isStandard: true), typography: .caption, iconSize: .small)
      PBDatestamp(Date(), variant: .standard, typography: .title4)
      PBDatestamp(Date(), variant: .withIcon(isStandard: true), typography: .title4, iconSize: .large)
      PBDatestamp(Date(), variant: .dayDate, typography: .title4)
      PBDatestamp(Date(), variant: .withIcon(isStandard: false), typography: .title4, iconSize: .large)
    }
  }

  var alignmentView: some View {
    VStack(spacing: Spacing.small) {
      PBDatestamp(Date(), variant: .standard, typography: .title4, alignment: .leading)
      PBDatestamp(Date(), variant: .withIcon(isStandard: true), typography: .title4, alignment: .center)
      PBDatestamp(Date(), variant: .short, typography: .title4, alignment: .trailing)
    }
  }

  var unstyledView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDatestamp(Date(), variant: .short, typography: .body)
      PBDatestamp(Date(), variant: .standard, typography: .title1)
      PBDatestamp(Date(), variant: .withIcon(isStandard: false), typography: .subcaption)
    }
  }
}
