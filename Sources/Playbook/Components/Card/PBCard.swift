//
//  PBCard.swift
//
//
//  Created by Alexandre Hauber on 23/07/21.
//

import SwiftUI

public enum PBCardStyle {
  case `default`, selected, error
  
  var color: Color {
    switch self {
    case .default:
      return .border
    case .selected:
      return .pbPrimary
    case .error:
      return .status(.error)
    }
  }
  
  var lineWidth: CGFloat {
    switch self {
    case .default, .error:
      return 1
    case .selected:
      return 1.6
    }
  }
}

public struct PBCard<Content: View>: View {
  let content: Content
  let alignment: Alignment
  let border: Bool
  let borderRadius: BorderRadius
  let highlight: Highlight
  let highlightColor: Color
  let isHovering: Bool
  let padding: CGFloat
  let style: PBCardStyle
  let shadow: Shadow?
  let width: CGFloat?
  
  public init(
    alignment: Alignment = .leading,
    border: Bool = true,
    borderRadius: BorderRadius = .medium,
    highlight: Highlight = .none,
    highlightColor: Color = .product(.product1, category: .highlight),
    isHovering: Bool = false,
    padding: CGFloat = .pbMedium,
    style: PBCardStyle = .default,
    shadow: Shadow? = nil,
    width: CGFloat? = .infinity,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.alignment = alignment
    self.border = border
    self.borderRadius = borderRadius
    self.highlight = highlight
    self.isHovering = isHovering
    self.padding = padding
    self.style = style
    self.shadow = shadow
    self.width = width
    self.highlightColor = highlightColor
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      if highlight == .none {
        content
          .padding(padding)
      } else {
        content
          .padding(padding)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
          .background(
            RoundedRectangle(cornerRadius: borderRadius.rawValue)
              .stroke(highlightColor, lineWidth: 10)
              .padding(
                .init(
                  top: highlight == .top ? 0 : -10,
                  leading: highlight == .side ? 0 : -10,
                  bottom: -10,
                  trailing: -10
                )
              )
          )
      }
    }
    .cornerRadius(borderRadius.rawValue)
    .frame(minWidth: 0, maxWidth: width, alignment: alignment)
    .background(
      RoundedRectangle(cornerRadius: borderRadius.rawValue, style: .continuous)
        .fill(Color.card.opacity(isHovering ? 0.4 : 1))
        .pbShadow(shadow ?? .none)
    )
    .overlay(
      RoundedRectangle(cornerRadius: borderRadius.rawValue)
        .stroke(
          style.color,
          lineWidth: border ? style.lineWidth : 0
        )
    )
  }
}

public extension PBCard {
  enum BorderRadius: CGFloat {
    case none = 0
    case xSmall = 2
    case small = 4
    case medium = 6
    case large = 8
    case xLarge = 12
    case rounded = 48
  }
  
  enum Highlight {
    case none
    case side
    case top
  }
}

// MARK: Preview

public struct PBCard_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    
    let text = "Card Content"
    let loremIpsum =
      """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Donec iaculis, risus a fringilla luctus, sapien eros sodales ex, quis molestie est nulla non turpis.
        Vestibulum aliquet at ipsum eget posuere. Morbi sed laoreet erat.
        Sed commodo posuere lectus, at porta nulla ornare a.
      """
    
    return List {
      Section("Default") {
        VStack(alignment: .leading, spacing: 8) {
          Text("Default").pbFont(.caption)
          PBCard {
            Text(text).pbFont(.body())
          }
          .padding(.bottom)
          
          Text("Default with shadow deep").pbFont(.caption)
          PBCard(shadow: .deep) {
            Text(text).pbFont(.body())
          }
        }
      }
      
      Section("Highlight") {
        VStack(alignment: .leading, spacing: 8) {
          PBCard(highlight: .side) {
            Text(text).pbFont(.body())
          }
          PBCard(highlight: .top, highlightColor: .status(.warning)) {
            Text(text).pbFont(.body())
          }
        }
      }
      
      Section("Header cards") {
        PBCard(padding: .pbNone) {
          PBCardHeader {
            Text(text).pbFont(.body()).padding(.pbSmall)
          }
          Text(text).pbFont(.body()).padding(.pbSmall)
        }
        PBCard(padding: .pbNone) {
          PBCardHeader(color: .product(.product2, category: .highlight)) {
            Text(text).pbFont(.body()).padding(.pbSmall)
          }
          Text(text).pbFont(.body()).padding(.pbSmall)
        }
      }
      
      Section("Styles") {
        VStack(alignment: .leading, spacing: nil) {
          Text("Default").pbFont(.caption)
          PBCard {
            Text(text).pbFont(.body())
          }
          Text("Selected").pbFont(.caption)
          PBCard(style: .selected) {
            Text(text).pbFont(.body())
          }
          Text("Error").pbFont(.caption)
          PBCard(style: .error) {
            Text(text).pbFont(.body())
          }
        }
      }

      Section("Padding size") {
        PBCard(padding: .pbNone) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbXsmall) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbSmall) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbMedium) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbLarge) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbXlarge) {
          Text(text).pbFont(.body())
        }
      }

      Section("Separator & Content") {
        PBCard(padding: .pbNone) {
          Text("Header").pbFont(.body()).padding(.pbSmall)
          PBSectionSeparator()
          Text(loremIpsum).pbFont(.body()).padding(.pbSmall)
          PBSectionSeparator()
          Text("Footer").pbFont(.body()).padding(.pbSmall)
        }
      }
      
      Section("No border & border radius") {
        PBCard(border: false) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .none) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .xSmall) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .small) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .medium) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .large) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .xLarge) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .rounded) {
          Text(text).pbFont(.body())
        }
      }

      Section("Complex") {
        PBCard(padding: .pbNone) {
          PBCardHeader(color: .product(.product1, category: .highlight)) {
            Text("Andrew")
              .pbFont(.body(), color: .text(.lighter))
              .padding(.pbSmall)
          }
          Image("andrew", bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text(loremIpsum).pbFont(.caption).padding(.pbSmall)
          PBSectionSeparator()
          Text("A nice guy and great dev").pbFont(.body()).padding(.pbSmall)
        }
      }
    }
  }
}
