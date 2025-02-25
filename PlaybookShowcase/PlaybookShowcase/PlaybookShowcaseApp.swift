//
//  Playbook Swift Design System
//
//  Copyright © 2022 - 2023 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PlaybookShowcaseApp.swift
//

import SwiftUI
import Playbook

@main
struct PlaybookShowcaseApp: App {
  var body: some Scene {
    registerFonts()
    return WindowGroup {
      ContentListView()
    }
  }
}
