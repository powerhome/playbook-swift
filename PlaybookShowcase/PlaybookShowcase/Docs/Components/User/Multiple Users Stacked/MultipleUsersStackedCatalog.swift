//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MultipleUsersStackedCatalog.swift
//

import SwiftUI
import Playbook

public struct MultipleUsersStackedCatalog: View {
  public var body: some View {
    PBDocStack(title: "Multiple Users Stacked") {
      PBDoc(title: "Default") {
        defaultView
      }

      PBDoc(title: "Small") {
        smallView
      }

      PBDoc(title: "Xsmall") {
        xsmallView
      }
    }
  }
}

extension MultipleUsersStackedCatalog {
  var defaultView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBMultipleUsersStacked(users: Mocks.oneUser, size: .default)
      PBMultipleUsersStacked(users: Mocks.twoUsers, size: .default)
      PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .default)
    }
  }
  var smallView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBMultipleUsersStacked(users: Mocks.oneUser)
      PBMultipleUsersStacked(users: Mocks.twoUsers)
      PBMultipleUsersStacked(users: Mocks.multipleUsers)
    }
  }
  var xsmallView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBMultipleUsersStacked(users: Mocks.oneUser, size: .xSmall)
      PBMultipleUsersStacked(users: Mocks.twoUsers, size: .xSmall)
      PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .xSmall)
    }
  }
}
