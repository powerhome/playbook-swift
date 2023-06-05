//
//  PBTextArea.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public struct PBTextArea: View {
  var characterCount: Bool?
  var error: String?
  var label: String
  var placeholder: String?
  var maxCharacterBlock: Bool?
  var maxCharacterCount: Int?

  @FocusState private var isNoteFocused: Bool
  @Binding var text: String

  public init(
    _ label: String,
    text: Binding<String>,
    placeholder: String? = nil,
    error: String? = nil,
    characterCount: Bool? = false,
    maxCharacterCount: Int? = nil,
    maxCharacterBlock: Bool? = false
  ) {
    self.label = label
    _text = text
    self.placeholder = placeholder
    self.error = error
    self.characterCount = characterCount
    self.maxCharacterCount = maxCharacterCount
    self.maxCharacterBlock = maxCharacterBlock
  }
  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      Text(label)
        .pbFont(.caption)
      if let error = error, !error.isEmpty, maxCharacterCount == nil {
        PBCard(padding: 0, style: .error) {
          if let placeholder = placeholder {
            ZStack(alignment: .leading) {
              if let blockCount = maxCharacterBlock, blockCount,
                 let count = maxCharacterCount,
                 let showCharacterCount = characterCount,
                 showCharacterCount {
                TextEditor(text: $text.max(count))
                  .padding(.top, 4)
                  .padding(.horizontal, 12)
                  .frame(height: 88)
                  .foregroundColor(.text(.default))
                  .pbFont(.body())
                  .focused($isNoteFocused)
              } else {
                placeHolderTextEditorView($text)
              }
              if !isNoteFocused && text.isEmpty {
                placeHolderTextView(placeholder)
              }
            }
          } else {
            if let blockCount = maxCharacterBlock, blockCount,
               let count = maxCharacterCount,
               let showCharacterCount = characterCount,
               showCharacterCount {
              TextEditor(text: $text.max(count))
                .padding(.top, 4)
                .padding(.horizontal, 12)
                .frame(height: 88)
                .foregroundColor(.text(.default))
                .pbFont(.body())
                .focused($isNoteFocused)
            } else {
              textEditorView($text)
            }
          }
        }
        HStack {
          Text(error)
            .foregroundColor(.status(.error))
            .pbFont(.body())
            .padding(.top, 4)
          Spacer()
          if let showCount = characterCount, showCount {
            if let maxCharacterCount = maxCharacterCount {
              Text("\(text.count)/\(maxCharacterCount)")
                .pbFont(.subcaption)
                .padding(.top, 4)
            } else {
              Text("\(text.count)")
                .pbFont(.subcaption)
                .padding(.top, 4)
            }
          }
        }
      } else if let error = error, !error.isEmpty, maxCharacterCount != nil {
        PBCard(padding: 0,
               style: (error != nil && !error.isEmpty && maxCharacterCount != nil && text.count >= maxCharacterCount!) ? .error : .default) {
          if let placeholder = placeholder {
            ZStack(alignment: .leading) {
              if let blockCount = maxCharacterBlock, blockCount,
                 let count = maxCharacterCount,
                 let showCharacterCount = characterCount,
                 showCharacterCount {
                TextEditor(text: $text.max(count))
                  .padding(.top, 4)
                  .padding(.horizontal, 12)
                  .frame(height: 88)
                  .foregroundColor(.text(.default))
                  .pbFont(.body())
                  .focused($isNoteFocused)
              } else {
                placeHolderTextEditorView($text)
              }
              if !isNoteFocused && text.isEmpty {
                placeHolderTextView(placeholder)
              }
            }
          } else {
            if let blockCount = maxCharacterBlock, blockCount,
               let count = maxCharacterCount,
               let showCharacterCount = characterCount,
               showCharacterCount {
              TextEditor(text: $text.max(count))
                .padding(.top, 4)
                .padding(.horizontal, 12)
                .frame(height: 88)
                .foregroundColor(.text(.default))
                .pbFont(.body())
                .focused($isNoteFocused)
            } else {
              textEditorView($text)
            }
          }
        }
        HStack {
          if error != nil && !error.isEmpty && maxCharacterCount != nil && text.count >= maxCharacterCount! {
            Text(error)
              .foregroundColor(.status(.error))
              .pbFont(.body())
              .padding(.top, 4)
          }
          Spacer()
          if let showCount = characterCount, showCount {
            if let maxCharacterCount = maxCharacterCount {
              Text("\(text.count)/\(maxCharacterCount)")
                .pbFont(.subcaption)
                .padding(.top, 4)
            } else {
              Text("\(text.count)")
                .pbFont(.subcaption)
                .padding(.top, 4)
            }
          }
        }
      } else {
        PBCard(padding: 0, style: isNoteFocused ? .selected : .default) {
          if let placeholder = placeholder {
            ZStack(alignment: .leading) {
              if let blockCount = maxCharacterBlock, blockCount,
                 let count = maxCharacterCount,
                 let showCharacterCount = characterCount,
                 showCharacterCount {
                TextEditor(text: $text.max(count))
                  .padding(.top, 4)
                  .padding(.horizontal, 12)
                  .frame(height: 88)
                  .foregroundColor(.text(.default))
                  .pbFont(.body())
                  .focused($isNoteFocused)
              } else {
                placeHolderTextEditorView($text)
              }
              if !isNoteFocused && text.isEmpty {
                placeHolderTextView(placeholder)
              }
            }
          } else {
            if let blockCount = maxCharacterBlock, blockCount,
               let count = maxCharacterCount,
               let showCharacterCount = characterCount,
               showCharacterCount {
              TextEditor(text: $text.max(count))
                .padding(.top, 4)
                .padding(.horizontal, 12)
                .frame(height: 88)
                .foregroundColor(.text(.default))
                .pbFont(.body())
                .focused($isNoteFocused)
            } else {
              textEditorView($text)
            }
          }
        }
        HStack {
          Spacer()
          if let showCount = characterCount, showCount {
            if let maxCharacterCount = maxCharacterCount {
              Text("\(text.count)/\(maxCharacterCount)")
                .pbFont(.subcaption)
                .padding(.top, 4)
            } else {
              Text("\(text.count)")
                .pbFont(.subcaption)
                .padding(.top, 4)
            }
          }
        }
      }
    }
  }

  func placeHolderTextView(_ placeholder: String) -> some View {
    Text(placeholder)
      .padding(.top, -32)
      .padding(.horizontal, 16)
      .foregroundColor(Color(uiColor: .placeholderText))
      .pbFont(.body())
      .allowsHitTesting(false)
      .focused($isNoteFocused)
  }

  func placeHolderTextEditorView(_ text: Binding<String>) -> some View {
    TextEditor(text: text)
      .padding(.top, 4)
      .padding(.horizontal, 12)
      .frame(height: 88)
      .foregroundColor(.text(.default))
      .pbFont(.body())
      .focused($isNoteFocused)
  }

  func textEditorView(_ text: Binding<String>) -> some View {
    TextEditor(text: $text)
      .padding(.top, 4)
      .padding(.horizontal, 12)
      .frame(height: 88)
      .foregroundColor(.text(.default))
      .pbFont(.body())
      .focused($isNoteFocused)
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
