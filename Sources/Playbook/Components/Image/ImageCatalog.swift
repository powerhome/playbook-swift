//
//  ImageCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct ImageCatalog: View {

  public init() {}

  public var body: some View {
    List {
      ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
        Section(size.name) {
          HStack {
            PBImage(
              image: nil,
              placeholder: Image("Forest", bundle: .module),
              size: size,
              cornerRadius: .rounded
            )
            Spacer()
            PBImage(
              image: Image("Forest", bundle: .module),
              size: size,
              cornerRadius: .sharp
            )
          }
        }
      }
      .listRowBackground(Color.clear)

      Section("No size") {
        PBImage(image: Image("Forest", bundle: .module))
      }
      .listRowBackground(Color.clear)
    }
  }
}
