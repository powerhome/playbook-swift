//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTextArea.swift
//

import SwiftUI

public struct PBTextArea: View {
  var characterCount: CharacterCount
  var inline: Bool
  var label: String?
  var placeholder: String?

  @FocusState private var isTextAreaFocused: Bool
  @Binding var text: String
  @State var error: String?

  public init(
    _ label: String? = nil,
    text: Binding<String>,
    placeholder: String? = nil,
    error: String? = nil,
    inline: Bool = false,
    characterCount: CharacterCount = .noCount
  ) {
    self.label = label
    _text = text
    self.placeholder = placeholder
    self.error = error
    self.inline = inline
    self.characterCount = characterCount
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      if let label = label {
        Text(label)
          .pbFont(.caption)
          .padding(.bottom, Spacing.xSmall)
      }
      if inline {
        PBCard(border: isTextAreaFocused, padding: 0, style: style(isTextAreaFocused)) {
          inlineTextEditorView
          if let placeholder = placeholder, !isTextAreaFocused && text.isEmpty {
            placeHolderTextView(placeholder, topPadding: -40)
          }
        }
      } else {
        PBCard(padding: 0, style: style(isTextAreaFocused)) {
          ZStack(alignment: .leading) {
            textEditorView
            if let placeholder = placeholder, !isTextAreaFocused && text.isEmpty {
              placeHolderTextView(placeholder, topPadding: -32)
            }
          }
        }
      }
      countView
    }
    .onAppear {
      if case let .maxCharacterCountError(maxCount, message) = characterCount {
        error = text.count >= maxCount ? message : nil
      }
    }
    .onChange(of: text) { _, text in
      if case let .maxCharacterCountError(maxCount, message) = characterCount {
        error = text.count >= maxCount ? message : nil
      }
    }
  }
}

public extension PBTextArea {
  func placeHolderTextView(_ placeholder: String, topPadding: CGFloat) -> some View {
    Text(placeholder)
      .padding(.top, topPadding)
      .padding(.horizontal, Spacing.small)
    #if os(iOS)
      .foregroundColor(Color(uiColor: .placeholderText))
    #endif
      .pbFont(.body)
      .allowsHitTesting(false)
      .focused($isTextAreaFocused, equals: true)
  }

  var editorText: Binding<String> {
    switch characterCount {
    case .maxCharacterCountBlock(let maxCount):
      return $text.max(maxCount)
    default: return $text
    }
  }

  var textEditorView: some View {
    TextEditor(text: editorText)
      .padding(.top, Spacing.xxSmall)
      .padding(.horizontal, 12)
      .frame(height: 88)
      .foregroundColor(.text(.default))
      .pbFont(.body)
      .accentColor(.text(.default))
      .focused($isTextAreaFocused, equals: true)
  }

  var inlineTextEditorView: some View {
    TextEditor(text: editorText)
      .foregroundColor(.text(.default))
      .pbFont(.body)
      .padding(.horizontal, 12)
      .frame(minWidth: 44)
      .focused($isTextAreaFocused, equals: true)
      .accentColor(.text(.default))
      .onTapGesture {
        isTextAreaFocused = true
      }
      .frame(height: 44)
  }

  func style(_ isTextAreaFocused: Bool) -> PBCardStyle {
    if error != nil {
      return .error
    } else {
      return isTextAreaFocused ? .selected(type: .textInput) : .`default`
    }
  }

  var errorText: String {
    if let error = error {
      if case let .maxCharacterCountError(_, message) = characterCount {
        return message
      } else {
        return error
      }
    } else {
      return ""
    }
  }

  var countView: some View {
    HStack {
      if error != nil || characterCount != .noCount {
        Text(errorText)
          .foregroundColor(.status(.error))
          .padding(.top, Spacing.xxSmall)
        Spacer()
          .pbFont(.body)
        Text(textCount(text.count))
          .pbFont(.subcaption)
          .padding(.top, Spacing.xxSmall)
      }
    }
  }

  func textCount(_ count: Int) -> String {
    switch characterCount {
    case .noCount: return ""
    case .count: return "\(count)"
    case .maxCharacterCount(let maxCount): return "\(count) / \(maxCount)"
    case .maxCharacterCountBlock(let maxCount): return "\(count) / \(maxCount)"
    case .maxCharacterCountError(let maxCount, _): return "\(count) / \(maxCount)"
    }
  }

  enum CharacterCount: Equatable {
    case noCount, count, maxCharacterCount(Int), maxCharacterCountBlock(Int), maxCharacterCountError(Int, String)
  }
}

struct PBTextArea_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return TextAreaCatalog()
  }
}
