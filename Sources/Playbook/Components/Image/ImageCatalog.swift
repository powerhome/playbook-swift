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
          VStack(alignment: .leading, spacing: 0) {
            Text(size.name).pbFont(.caption)
            PBImage(
              image: nil,
              placeholder: Image("Forest", bundle: .module),
              size: size,
              rounded: .sharp
            )
          }
        }

        PBImage(image: Image("Forest", bundle: .module))
      }
      .listRowSeparator(.hidden)
      Section("Rounded") {
        ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
          VStack(alignment: .leading, spacing: 0) {
            Text(size.name).pbFont(.caption)
            PBImage(
              image: Image("Forest", bundle: .module),
              size: size,
              rounded: .rounded
            )
          }
        }
      }
      .listRowSeparator(.hidden)
    }
    .navigationTitle("Image")
  }
}

public struct ImageCatalog_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts() 
    return ImageCatalog()
  }
}
