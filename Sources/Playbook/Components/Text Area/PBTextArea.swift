//
//  PBTextArea.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public extension PBTextArea {

  func placeHolderTextView(_ placeholder: String, topPadding: CGFloat) -> some View {
    Text(placeholder)
      .padding(.top, topPadding)
      .padding(.horizontal, Spacing.small)
      .foregroundColor(Color(uiColor: .placeholderText))
      .pbFont(.body())
      .allowsHitTesting(false)
      .focused($isTextAreaFocused, equals: true)
  }

  var editorText: Binding<String> {
    switch characterCount {
    case .maxCharacterCountBlock(let maxCount):
      return $text.max(maxCount)
    case .maxCharacterCountError(let maxCount):
      return $text
    default: return $text
    }
  }

  var textEditorView: some View {
    TextEditor(text: editorText)
      .padding(.top, Spacing.xxSmall)
      .padding(.horizontal, 12)
      .frame(height: 88)
      .foregroundColor(.text(.default))
      .pbFont(.body())
      .accentColor(.text(.default))
      .focused($isTextAreaFocused, equals: true)
  }

  var inlineTextEditorView: some View {
    TextEditor(text: editorText)
      .padding(.top, 10)
      .padding(.horizontal, 12)
      .foregroundColor(.text(.default))
      .pbFont(.body())
      .focused($isTextAreaFocused, equals: true)
      .accentColor(.text(.default))
      .onTapGesture {
        isTextAreaFocused = true
      }
  }

  func style(_ isTextAreaFocused: Bool) -> PBCardStyle {
    if let error = error {
      return .error
    } else {
      return isTextAreaFocused ? .selected : .`default`
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
          .pbFont(.body())
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

public struct PBTextArea: View {
  var characterCount: CharacterCount
  var inline: Bool
  var label: String
  var placeholder: String?

  @FocusState private var isTextAreaFocused: Bool
  @Binding var text: String
  @State var error: String?

  public init(
    _ label: String,
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
      Text(label)
        .pbFont(.caption)
        .padding(.bottom, Spacing.xSmall)
      if inline {
        PBCard(border: isTextAreaFocused, padding: 0, style: style(isTextAreaFocused)) {
          inlineTextEditorView
          if let placeholder = placeholder, (isTextAreaFocused == false && text.isEmpty) {
            placeHolderTextView(placeholder, topPadding: -40)
          }
        }
      } else {
        PBCard(padding: 0, style: style(isTextAreaFocused)) {
          ZStack(alignment: .leading) {
            textEditorView
            if let placeholder = placeholder, (isTextAreaFocused == false && text.isEmpty) {
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
    .onChange(of: text) { text in
      if case let .maxCharacterCountError(maxCount, message) = characterCount {
        error = text.count >= maxCount ? message : nil
      }
    }
  }
}

struct PBTextArea_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return TextAreaCatalog()
      .background(Color.card)
  }
}

extension Binding where Value == String {
  func max(_ limit: Int) -> Self {
    if self.wrappedValue.count > limit {
      DispatchQueue.main.async {
        self.wrappedValue = String(self.wrappedValue.dropLast())
      }
    }
    return self
  }
}
