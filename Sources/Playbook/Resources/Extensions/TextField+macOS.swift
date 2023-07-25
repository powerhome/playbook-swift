//
//  TextField+macOS.swift
//  
//
//  Created by Isis Silva on 25/07/23.
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
    textField.placeholderString = prompt
    return textField
  }

  func updateNSView(_ nsView: NSTextField, context: Context) {
    nsView.stringValue = text
    nsView.backgroundColor = .clear
    nsView.placeholderString = prompt
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
