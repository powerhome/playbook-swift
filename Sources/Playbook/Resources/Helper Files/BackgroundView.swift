//
//  BackgroundView.swift
//
//
//  Created by Alexandre Hauber on 05/08/21.
//
//  View that enables .sheet. and .fullScreenCover to have transparent background (iOS)
//  Src: https://stackoverflow.com/a/66925883/2496187
//

import SwiftUI

#if os(iOS)
  struct BackgroundView: UIViewRepresentable {
    var color: Color
    var alpha: CGFloat

    func makeUIView(context _: Context) -> some UIView {
      let view = UIView()
      DispatchQueue.main.async {
        view.superview?.superview?.backgroundColor = UIColor(color).withAlphaComponent(alpha)
      }
      return view
    }

    func updateUIView(_: UIViewType, context _: Context) {}
  }
#endif

struct BackgroundViewModifier: ViewModifier {
  var color: Color
  var alpha: CGFloat

  func body(content: Content) -> some View {
    #if os(iOS)
      content
        .background(BackgroundView(color: color, alpha: alpha))
    #elseif os(macOS)
    content
      .background { Color.black.opacity(0.001).frame(maxWidth: .infinity) }
    #endif
  }
}

public extension View {
  func backgroundViewModifier(color: Color = .clear, alpha: CGFloat = 0.0) -> some View {
    modifier(BackgroundViewModifier(color: color, alpha: alpha))
  }
}
