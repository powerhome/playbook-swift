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
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          defaultView
        }
        PBDoc(title: "Custom Text") {
          customTextView
        }
        PBDoc(title: "Solid") {
          solidLoaderView
        }
      }
      .padding(Spacing.medium)
    }
    .navigationTitle("Loader")
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
      PBLoader(text: "Saving")
    }
  }
}
