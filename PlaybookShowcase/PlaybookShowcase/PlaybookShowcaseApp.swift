//
//  PlaybookShowcase_iOSApp.swift
//  PlaybookShowcase-iOS
//
//  Created by Isis Silva on 4/19/23.
//

import SwiftUI
import Playbook

@main
struct PlaybookShowcaseApp: App {
  var body: some Scene {
    registerFonts()
    return WindowGroup {
    #if os(iOS)
      ContentListView()
        .environment(\.colorScheme, .light)
    #elseif os(macOS)
      EmptyView()
    #endif
    }
  }
}
