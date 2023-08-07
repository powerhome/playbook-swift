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
        VStack(alignment: .leading, spacing: Spacing.xSmall) {
          ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
            VStack(alignment: .leading, spacing: Spacing.xSmall) {
              Text(size.name).pbFont(.caption)
              PBImage(
                image: nil,
                placeholder: Image("Forest", bundle: .module),
                size: size,
                rounded: .sharp
              )
            }
            .padding(.bottom)
          }
          Text("None")
            .pbFont(.caption)
          PBImage(image: Image("Forest", bundle: .module))
        }
        .padding(.vertical)
      }
      .listRowSeparator(.hidden)

      Section("Rounded") {
        VStack(alignment: .leading, spacing: Spacing.xSmall) {
          ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
            VStack(alignment: .leading, spacing: Spacing.xSmall) {
              Text(size.name).pbFont(.caption)
              PBImage(
                image: nil,
                placeholder: Image("Forest", bundle: .module),
                size: size,
                rounded: .rounded
              )
            }
            .padding(.bottom)
          }
        }
        .padding(.top)
      }
      .listRowSeparator(.hidden)
    }
    .navigationTitle("Image")
  }
}
