//
//  PillCatalog.swift
//
//
//  Created by Israel Molestina on 5/18/23.
//

import SwiftUI

public struct PillCatalog: View {

  public init() {}

  public var body: some View {
    List {
      Section("Default") {
        PBPill("default")
      }

      Section("Variants") {
        PBPill("success", variant: .success)
        PBPill("error", variant: .error)
        PBPill("warning", variant: .warning)
        PBPill("info", variant: .info)
        PBPill("neutral", variant: .neutral)
        PBPill("primary", variant: .primary)
      }
      .listRowSeparator(.hidden)

      Section("Example") {
        PBPill("primary", variant: .primary)
      }
    }
  }
}
