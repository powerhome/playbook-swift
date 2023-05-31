//
//  SpacingCatalog.swift
//  
//
//  Created by Isis Silva on 17/05/23.
//

import SwiftUI

public struct SpacingCatalog: View {

  public init() {}

  public var body: some View {
    VStack(alignment: .leading) {
      List(Spacing.allCase, id: \.self.0) { space in
        Section("\(space.1) - \(Int(space.0)) px") {
          ZStack(alignment: .leading) {
            Rectangle()
              .fill(Color.background(.default))
            Rectangle()
              .fill(Color.product(.product1, category: .highlight))
              .frame(width: space.0)
          }
          .frame(height: Spacing.large)
          .border(Color.border, width: 1)
        }
        .padding()
        .listRowBackground(Color.card)
      }
    }
    .navigationTitle("Spacing")
  }
}

struct SpacingCatalog_Previews: PreviewProvider {
  static var previews: some View {
    SpacingCatalog()
  }
}
