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
  var maxWidth: CGFloat?
  var onDelete: (() -> Void)?

  override func deleteBackward() {
    onDelete?()
    super.deleteBackward()
  }

  override var intrinsicContentSize: CGSize {
    let original = super.intrinsicContentSize
    let cappedWidth = min(original.width, maxWidth ?? original.width)
    return CGSize(width: cappedWidth, height: original.height)
  }
}

struct KeyboardTextField: UIViewRepresentable {
  @Binding var text: String
  var maxWidth: CGFloat
  var onDelete: () -> Void

  func makeUIView(context: Context) -> CustomTextField {
    let textField = CustomTextField(frame: .zero)
    textField.delegate = context.coordinator
    textField.onDelete = onDelete
    textField.maxWidth = maxWidth
    textField.borderStyle = .none
    textField.font = .init(name: PBFont.proximaNovaLight, size: PBFont.body.size)
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
      DispatchQueue.main.async { [weak self] in
        self?.parent.text = textField.text ?? ""
      }
    }
  }
}
#endif
