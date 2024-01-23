//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ImageCatalog.swift
//

import SwiftUI

public struct ImageCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
              VStack(alignment: .leading) {
                Text(size.name).pbFont(.detail(true), color: .text(.default))
                PBImage(
                  image: nil,
                  placeholder: Image("Forest", bundle: .module),
                  size: size,
                  rounded: .sharp
                )
              }
            }
            VStack(alignment: .leading) {
              Text("None").pbFont(.detail(true), color: .text(.default))
              PBImage(image: Image("Forest", bundle: .module))
            }
          }
        }

        PBDoc(title: "Rounded") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
              VStack(alignment: .leading) {
                Text(size.name).pbFont(.detail(true), color: .text(.default))
                PBImage(
                  image: nil,
                  placeholder: Image("Forest", bundle: .module),
                  size: size,
                  rounded: .rounded
                )
              }
            }
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Image")
  }
}
