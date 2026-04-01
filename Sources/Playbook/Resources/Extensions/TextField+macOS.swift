//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MacOSTextField.swift
//

import SwiftUI

#if os(macOS)
struct MacOSTextField: NSViewRepresentable {
  @Binding var text: String
  let prompt: String

  func makeNSView(context: Context) -> NSTextField {
    let textField = NSTextField()
    textField.delegate = context.coordinator
    textField.backgroundColor = .clear
    textField.isBordered = false
    textField.placeholderAttributedString = NSAttributedString(
      string: prompt,
      attributes: [
        .font: NSFont(name: Font.PowerCentra.light.rawValue, size: TextSize.Body.base.rawValue) ?? NSFont.systemFont(ofSize: TextSize.Body.base.rawValue)
      ]
    )
      
    return textField
  }

  func updateNSView(_ nsView: NSTextField, context: Context) {
    nsView.stringValue = text
    nsView.backgroundColor = .clear
    nsView.placeholderAttributedString = NSAttributedString(
      string: prompt,
      attributes: [
        .font: NSFont(name: Font.PowerCentra.light.rawValue, size: TextSize.Body.base.rawValue) ?? NSFont.systemFont(ofSize: TextSize.Body.base.rawValue)
      ]
    )
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text, placeholder: prompt)
  }

  class Coordinator: NSObject, NSTextFieldDelegate {
    @Binding var text: String
    let prompt: String

    init(text: Binding<String>, placeholder: String) {
      _text = text
      prompt = placeholder
    }

    func controlTextDidChange(_ obj: Notification) {
      if let textField = obj.object as? NSTextField {
        text = textField.stringValue
      }
    }
  }
}
#endif
