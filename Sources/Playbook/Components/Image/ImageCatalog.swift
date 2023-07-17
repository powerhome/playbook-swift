//
//  ImageCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct ImageCatalog: View {
  public var body: some View {
    List {
      Section("Default") {
        ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
          PBImage(
            image: nil,
            placeholder: Image("Forest", bundle: .module),
            size: size,
            rounded: false
          )
        }

        PBImage(image: Image("Forest", bundle: .module), rounded: false)
      }
      .listRowSeparator(.hidden)
      Section("Rounded") {
        ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
          PBImage(
            image: Image("Forest", bundle: .module),
            size: size,
            rounded: true
          )
        }
      }
      .listRowSeparator(.hidden)
    }
    .navigationTitle("Image")
  }
}

public struct ImageCatalog_Previews: PreviewProvider {
  public static var previews: some View {
    ImageCatalog()
  }
}
