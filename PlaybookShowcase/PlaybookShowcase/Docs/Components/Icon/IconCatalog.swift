//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IconCatalog.swift
//

import SwiftUI
import Playbook

public struct IconCatalog: View {
  public var body: some View {
    PBDocStack(title: "Icon") {
      PBDoc(title: "Default") {
        PBIcon.fontAwesome(.user, size: .x1)
      }

      PBDoc(title: "Rotate") {
        HStack(spacing: Spacing.xSmall) {
          PBIcon(FontAwesome.user, rotation: .right)
          PBIcon(FontAwesome.user, rotation: .zero)
          PBIcon(FontAwesome.user, rotation: .obtuse)
        }
      }

      PBDoc(title: "Flipped") {
        HStack(spacing: Spacing.xSmall) {
          PBIcon(FontAwesome.questionCircle, flipped: [.horizontal])
          PBIcon(FontAwesome.questionCircle, flipped: [.vertical])
          PBIcon(FontAwesome.questionCircle, flipped: [.horizontal, .vertical])
        }
      }

      PBDoc(title: "Border") {
        PBIcon(FontAwesome.user, border: true)
      }

      PBDoc(title: "Size") {
        VStack(alignment: .leading, spacing: Spacing.small) {
          ForEach(PBIcon.IconSize.sizeArray, id: \.0) { size in
            HStack(spacing: Spacing.xSmall) {
              PBIcon.fontAwesome(.atlas, size: size.0)
              Text("\(size.1)")
            }
          }
        }
      }
    }
  }
}

#Preview {
  IconCatalog()
}
