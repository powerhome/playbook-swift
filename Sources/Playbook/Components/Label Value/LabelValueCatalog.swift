//
//  LabelValueCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct LabelValueCatalog: View {
  public var body: some View {
    List {
      Section("Default") {
        PBLabelValue("Role", "Administrator, Moderator")
        PBLabelValue("EMail", "anna.black@powerhrg.com")
        PBLabelValue("Bio", "Proin pulvinar feugiat massa in luctus. Donec urna nulla, elementum sit amet tincidunt")
      }
      .listRowSeparator(.hidden)
    }
    .navigationTitle("Label Value")
  }
}
