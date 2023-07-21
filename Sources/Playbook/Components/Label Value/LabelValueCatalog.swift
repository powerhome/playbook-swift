//
//  LabelValueCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct LabelValueCatalog: View {
  public var body: some View {
    Section("Default") {
      PBLabelValue("Role", "Administrator, Moderator")
      PBLabelValue("EMail", "anna.black@powerhrg.com")
    }
    .navigationTitle("Label Value")
  }
}
