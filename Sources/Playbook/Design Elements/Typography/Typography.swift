//
//  Typography.swift
//
//
//  Created by Lucas C. Feijo on 14/07/21.
//

import SwiftUI

public struct Typography: ViewModifier {
  var font: PBFont
  var variant: Variant
  var color: Color

  var foregroundColor: Color {
    switch variant {
    case .link:
      return .pbPrimary
    default: return color
    }
  }

  var spacing: CGFloat {
    switch font {
    case .title1: return 3
    case .title2: return -1
    case .title3, .title4: return 2
    case .body, .badgeText: return 0
    case .monogram: return 2.5
    default: return 6
    }
  }

  var casing: Text.Case? {
    switch font {
    case .largeCaption, .caption: return .uppercase
    default: return nil
    }
  }

  public func body(content: Content) -> some View {
    content
      .font(font.font)
      .lineSpacing(spacing)
      .padding(.vertical, spacing)
      .textCase(casing)
      .foregroundColor(foregroundColor)
  }
}

public extension Typography {
  enum Variant {
    case none
    case link
  }
}

public extension View {
  func pbFont(
    _ font: PBFont,
    variant: Typography.Variant = .none,
    color: Color = .text(.default)
  ) -> some View {
    self.modifier(Typography(font: font, variant: variant, color: color))
  }
}

struct Typography_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return List {
      Section("Title") {
        Text("Title 1\nTitle 1")
          .pbFont(.title1)
        Text("Title 2\nTitle 2")
          .pbFont(.title2)
        Text("Title 3\nTitle 3")
          .pbFont(.title3)
        Text("Title 4\nTitle 4")
          .pbFont(.title4)
        Text("Title 4 Link Variant")
          .pbFont(.title4, variant: .link)
      }

      Section("Body") {
        ForEach(TextSize.Body.allCases, id: \.rawValue) { size in
          Text("Body: Text size \(Int(size.rawValue)) px")
            .pbFont(.body(size))
            .padding(6)
        }
      }

      Section("Components Text") {
        Text("Button Text")
          .pbFont(.buttonText())

        Text("Badge Text")
          .pbFont(.badgeText)
      }

      Section("Caption") {
        Text("Large Caption")
          .pbFont(.largeCaption)
        Text("Caption")
          .pbFont(.caption)
        Text("Subcaption")
          .pbFont(.subcaption)
        Text("Subcaption Link Variant")
          .pbFont(.subcaption, variant: .link)
      }
    }
  }
}
