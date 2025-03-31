//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  UITextField.swift
//

#if os(iOS)
import UIKit
import SwiftUI

class CustomTextField: UITextField {
  var onDelete: (() -> Void)?

  override func deleteBackward() {
    onDelete?()
    super.deleteBackward()
  }
}

struct KeyboardTextField: UIViewRepresentable {
  @Binding var text: String
  var onDelete: () -> Void

  func makeUIView(context: Context) -> CustomTextField {
    let textField = CustomTextField(frame: .zero)
    textField.delegate = context.coordinator
    textField.onDelete = onDelete
    textField.borderStyle = .none
    return textField
  }

  func updateUIView(_ uiView: CustomTextField, context: Context) {
    uiView.text = text
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UITextFieldDelegate {
    var parent: KeyboardTextField

    init(_ parent: KeyboardTextField, placeholder: String = "") {
      self.parent = parent
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
      parent.text = textField.text ?? ""
    }
  }
}
#endif
