//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  GlobalPosition.swift
//

import SwiftUI

public struct GlobalPosition<T: View>: ViewModifier {
  let alignment: Alignment
  let top: CGFloat
  let leading: CGFloat
  let bottom: CGFloat
  let trailing: CGFloat
  let isCard: Bool
  var view: () -> T
  
  public init(
    alignment: Alignment = .center,
    top: CGFloat = 0,
    leading: CGFloat = 0,
    bottom: CGFloat = 0,
    trailing: CGFloat = 0,
    isCard: Bool = false,
    view: @escaping () -> T
  ) {
    self.alignment = alignment
    self.top = top
    self.leading = leading
    self.bottom = bottom
    self.trailing = trailing
    self.isCard = isCard
    self.view = view
  }

  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        if #available(iOS 17.0, *), #available(macOS 14.0, *) {
          view()
            .scaledToFill()
            .visualEffect { content, geo in
              if isCard {
                content.offset(x: -geo.size.width/2, y: geo.size.height/2)
              } else {
                content.offset(x: 0, y: 0)
              }
            }
            .edgeInsets(
              EdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
              )
            )
        } else {
          view()
            .scaledToFill()
            .edgeInsets(
              EdgeInsets(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
              )
            )
        }
      }
  }
}

public extension View {
  func globalPosition<T: View>(
    alignment: Alignment,
    top: CGFloat = 0,
    leading: CGFloat = 0,
    bottom: CGFloat = 0,
    trailing: CGFloat = 0,
    isCard: Bool = false,
    view: @escaping (() -> T)
  ) -> some View {
    self.modifier(
      GlobalPosition(
        alignment: alignment,
        top: top,
        leading: leading,
        bottom: bottom,
        trailing: trailing,
        isCard: isCard,
        view: view
      )
    )
  }

  func edgeInsets(_ insets: EdgeInsets) -> some View {
    self.modifier(EdgeInsetModifier(insets: insets))
  }
}

struct EdgeInsetModifier: ViewModifier {
  let insets: EdgeInsets
  func body(content: Content) -> some View {
    content.padding(insets)
  }
}

#Preview {
  registerFonts()
  return GlobalPositionCatalog()
}
