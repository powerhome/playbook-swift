//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  LoaderCatalog.swift
//

import SwiftUI

public struct LoaderCatalog: View {
  public var body: some View {
    PBDocStack(title: "Loading Inline") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Solid") {
        solidLoaderView
      }
      PBDoc(title: "With Text") {
        customTextView
      }
    }
  }
}

extension LoaderCatalog {
  var defaultView: some View {
    VStack(spacing: Spacing.small) {
      PBLoader()
    }
  }
  var solidLoaderView: some View {
    VStack(spacing: Spacing.small) {
      PBLoader(variant: .solid)
    }
  }
  var customTextView: some View {
    VStack(spacing: Spacing.small) {
      PBLoader(text: "Loading")
      PBLoader(variant: .solid, text: "Loading")
    }
  }
}
