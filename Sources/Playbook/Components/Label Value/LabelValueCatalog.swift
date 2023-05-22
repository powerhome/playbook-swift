//
//  LabelValueCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct LabelValueCatalog: View {

  public init() {}

  public var body: some View {
    VStack(alignment: .leading) {
      PBLabelValue("Room", "this is value")
        .preferredColorScheme(.light)
      PBLabelValue("label", "this is a value")
        .preferredColorScheme(.dark)
    }
    .navigationTitle("Label Value")
  }
}
