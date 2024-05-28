//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  GridCatalog.swift
//

import SwiftUI

public struct GridCatalog: View {
  @State private var count = 1
  @State private var cities = Mocks.cities
 
  public var body: some View {
    PBDocStack(title: "Grid") {
      PBDoc(title: "Alignment") { alignmentView }
      PBDoc(title: "Spacing") { spacingView }
    }
  }
}

extension GridCatalog {
  
  var alignmentView: some View {
    return VStack(alignment: .leading, spacing: Spacing.medium) {
      gridView(title: "Leading", alignment: .leading, hSpace: 8, vSpace: 4)
      gridView(title: "Center", alignment: .center, hSpace: 8, vSpace: 4)
      gridView(title: "Trailing", alignment: .trailing, hSpace: 8, vSpace: 4)
    }
  }
  
  var spacingView: some View {
    return VStack(alignment: .leading, spacing: Spacing.medium) {
      return VStack(alignment: .leading, spacing: Spacing.medium) {
        gridView(title: "Horizontal", alignment: .leading, hSpace: 10, vSpace: 0)
        gridView(title: "Vertical", alignment: .leading, hSpace: 0, vSpace: 10)
        gridView(title: "Zero", alignment: .leading, hSpace: 0, vSpace: 0)
      }
    }
  }
  
  var fitContentView: some View {
    return VStack(alignment: .leading, spacing: Spacing.medium) {
      return VStack(alignment: .leading, spacing: Spacing.medium) {
        gridView(title: "True", alignment: .leading, hSpace: 8, vSpace: 4, fitContent: true)
        gridView(title: "False", alignment: .leading, hSpace: 8, vSpace: 4, fitContent: false)
      }
    }
  }
  
  func gridView(title: String, alignment: Alignment, hSpace: CGFloat, vSpace: CGFloat, fitContent: Bool = true) -> some View {
    VStack(alignment: .leading) {
      Text(title).pbFont(.caption)
      PBGrid(alignment: alignment, horizontalSpacing: hSpace, verticalSpacing: vSpace, fitContent: fitContent) {
        ForEach(cities, id: \.count) { city in
          tagView("\(city)")
        }
      }
      .overlay {
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(Color.text(.light), lineWidth: 1)
      }
      .clipShape(RoundedRectangle(cornerRadius: BorderRadius.medium, style: .circular))
    }
  }
  func tagView(_ tag: String) -> some View {
    PBPill(tag, variant: .primary)
      .pbFont(.title4, variant: .bold, color: .white)
      .foregroundColor(Color.white)
      .cornerRadius(16)
  }
}

#Preview {
  registerFonts()
  return GridCatalog()
}
