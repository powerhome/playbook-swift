//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MultipleUsersIndicatorCatalog.swift
//

import SwiftUI
import Playbook

public struct MultipleUsersIndicatorCatalog: View {
  public var body: some View {
    PBDocStack(title: "Multiple Users Indicator") {
      PBDoc(title: "Multiple Users Indicator") {
        multiUserIndicatorView
      }
    }
  }
}

extension MultipleUsersIndicatorCatalog {
  var multiUserIndicatorView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBMultipleUsersIndicator(usersCount: 4, size: .xxSmall)
      PBMultipleUsersIndicator(usersCount: 4, size: .xSmall)
    }
  }
}
