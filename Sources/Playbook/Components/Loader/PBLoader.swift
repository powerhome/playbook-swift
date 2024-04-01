//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBLoader.swift
//

import SwiftUI

struct PBLoader: View {
  @Binding var rotationAngle: Double
  var icon: PBIcon
  var iconSize: PBIcon.IconSize
  var iconFont: PBFont
  var loaderText: String
  public init(
    rotationAngle: Binding<Double> = .constant(0),
    icon: PBIcon = .fontAwesome(.spinner),
    iconSize: PBIcon.IconSize = .x1,
    iconFont: PBFont = .body,
    loaderText: String = "Loading"
  ) {
    self._rotationAngle = rotationAngle
    self.icon = icon
    self.iconSize = iconSize
    self.iconFont = iconFont
    self.loaderText = loaderText
  }
  var body: some View {
    iconView
  }
}

extension PBLoader {
  var iconView: some View {
    HStack {
      icon
        .loaderSpeed(rotationAngle: rotationAngle)
        .onAppear {
          withAnimation {
            rotationAngle += 360
          }
        }
      textView
    }
    .pbFont(iconFont, variant: .bold, color: .text(.light))
  }
  var textView: some View {
    Text(loaderText)
  }
}

struct Loader: ViewModifier {
  var rotationAngle: Double = 0
  func body(content: Content) -> some View {
    VStack {
      content
        .rotationEffect(Angle(degrees: rotationAngle))
      .animation(.linear(duration: 2.5).repeatForever(autoreverses: false), value: rotationAngle)
    }
  }
}

extension View {
  func loaderSpeed(rotationAngle: Double) -> some View {
    self.modifier(Loader(rotationAngle: rotationAngle))
  }
}
#Preview {
  registerFonts()
   return LoaderCatalog()
}
