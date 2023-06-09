//
//  PBTextArea.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public extension PBTextArea {

  func placeHolderTextView(_ placeholder: String) -> some View {
    Text(placeholder)
      .padding(.top, -32)
      .padding(.horizontal, 16)
      .foregroundColor(Color(uiColor: .placeholderText))
      .pbFont(.body())
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
      .padding(.top, 4)
      .padding(.horizontal, 12)
      .frame(height: 88)
      .foregroundColor(.text(.default))
      .pbFont(.body())
      .focused($isTextAreaFocused, equals: true)
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
      return error
    } else {
      return ""
    }
  }

  var countView: some View {
    HStack {
      Text(errorText)
        .foregroundColor(.status(.error))
        .pbFont(.body())
        .padding(.top, 4)

      Spacer()
      Text(characterCount.textCount(text.count))
        .pbFont(.subcaption)
        .padding(.top, 4)
    }
  }

  enum CharacterCount: Equatable {
    case noCount, count, maxCharacterCount(Int), maxCharacterCountBlock(Int)

    func textCount(_ count: Int) -> String {
      switch self {
      case .noCount: return ""
      case .count: return "\(count)"
      case .maxCharacterCount(let maxCount): return "\(count) / \(maxCount)"
      case .maxCharacterCountBlock(let maxCount): return "\(count) / \(maxCount)"
      }
    }
  }

}

public struct PBTextArea: View {
  var characterCount: CharacterCount
  var error: String?
  var inline: Bool?
  var label: String
  var placeholder: String?
  //  var maxCharacterBlock: Bool?
  //  var maxCharacterCount: Int?

  @FocusState private var isTextAreaFocused: Bool
  @Binding var text: String

  public init(
    _ label: String,
    text: Binding<String>,
    placeholder: String? = nil,
    error: String? = nil,
    inline: Bool? = nil,
    characterCount: CharacterCount = .noCount
    //    maxCharacterCount: Int? = nil,
    //    maxCharacterBlock: Bool? = false,
    //    isTextAreaFocused: FocusState<Bool?> = .init()
  ) {
    self.label = label
    _text = text
    self.placeholder = placeholder
    self.error = error
    self.inline = inline
    self.characterCount = characterCount
    //    self.maxCharacterCount = maxCharacterCount
    //    self.maxCharacterBlock = maxCharacterBlock
    //    _isTextAreaFocused = isTextAreaFocused
  }
  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      Text(label)
        .pbFont(.caption)
      //      if let inline = inline {
      //        if let error = error, !error.isEmpty, maxCharacterCount == nil {
      //          inlineErrorWithOutMaxCharCountView(error)
      //        } else if let error = error, !error.isEmpty, maxCharacterCount != nil {
      //          inlineErrorWithMaxCharCountView(error)
      //        } else {
      //          inlineDefaultAndMaxCharCountView()
      //        }
      //      } else
      //			if let error = error, !error.isEmpty {
      //				errorWithOutMaxCharCountView(error)
      //			}
      //			else if let error = error, !error.isEmpty {
      //        errorWithMaxCharCountView(error)
      //      }
      //			else {
      //			return VStack {
      PBCard(padding: 0, style: style(isTextAreaFocused)) {
        ZStack(alignment: .leading) {
          textEditorView
          if let placeholder = placeholder, (isTextAreaFocused == false && text.isEmpty) {
            placeHolderTextView(placeholder)
          }
        }
      }
      countView
      //			}
      //			}
    }
  }

  //  func inlineErrorWithOutMaxCharCountView(_ error: String) -> some View {
  //    // This else if let statement will display inline textEditors that have an error string passed in but no maxCharacterCount
  //    return VStack {
  //      PBCard(border: true, padding: 0, style: isTextAreaFocused != nil ? .selected : .error) {
  //        if let placeholder = placeholder {
  //          ZStack(alignment: .leading) {
  //            inlineTextEditorView($text)
  //            if isTextAreaFocused == nil && text.isEmpty || (isTextAreaFocused == false && text.isEmpty) {
  //              inlinePlaceHolderTextView(placeholder)
  //            }
  //          }
  //        } else {
  //          ZStack(alignment: .leading) {
  //            inlineTextEditorView($text)
  //          }
  //        }
  //      }
  //      HStack {
  //        Text(error)
  //          .foregroundColor(.status(.error))
  //          .pbFont(.body())
  //          .padding(.top, 4)
  //        Spacer()
  //        if let showCount = characterCount, showCount {
  //          Text("\(text.count)")
  //            .pbFont(.subcaption)
  //            .padding(.top, 4)
  //        }
  //      }
  //    }
  //  }

  //  func inlineErrorWithMaxCharCountView(_ error: String) -> some View {
  //    // this else if let statment will display inline textEditors with the maxCharacterCount and Error props working together to create a textEditor that has an error state when character count is greater than maxCharacterCount
  //    return VStack {
  //      PBCard(border: isTextAreaFocused != nil, padding: 0,
  //             style: (error != nil && !error.isEmpty && maxCharacterCount != nil && text.count >= maxCharacterCount!) ? .error : .selected) {
  //        if let placeholder = placeholder {
  //          ZStack(alignment: .leading) {
  //            inlineTextEditorView($text)
  //            if isTextAreaFocused == nil && text.isEmpty || (isTextAreaFocused == false && text.isEmpty) {
  //              inlinePlaceHolderTextView(placeholder)
  //            }
  //          }
  //        } else {
  //          inlineTextEditorView($text)
  //        }
  //      }
  //      HStack {
  //        if error != nil && !error.isEmpty && maxCharacterCount != nil && text.count >= maxCharacterCount! {
  //          Text(error)
  //            .foregroundColor(.status(.error))
  //            .pbFont(.body())
  //            .padding(.top, 4)
  //        }
  //        Spacer()
  //        if let maxCharacterCount = maxCharacterCount {
  //          Text("\(text.count) / \(maxCharacterCount)")
  //            .pbFont(.subcaption)
  //            .padding(.top, 4)
  //        }
  //      }
  //    }
  //  }

  //  func inlineDefaultAndMaxCharCountView() -> some View {
  //    // this else if let statment will display textEditors with the maxCharacterCount, characterCount and default textEditors with and without placeholders
  //    return VStack {
  //      PBCard(border: isTextAreaFocused != nil, padding: 0, style: isTextAreaFocused != nil ? .selected : .default) {
  //        if let placeholder = placeholder {
  //          ZStack(alignment: .leading) {
  //            if let blockCount = maxCharacterBlock, blockCount,
  //               let count = maxCharacterCount {
  //              TextEditor(text: $text.max(count))
  //                .padding(.top, 10)
  //                .padding(.horizontal, 12)
  //                .foregroundColor(.text(.default))
  //                .pbFont(.body())
  //                .focused($isTextAreaFocused, equals: true)
  //                .onTapGesture {
  //                  isTextAreaFocused = true
  //                }
  //            } else {
  //              inlineTextEditorView($text)
  //            }
  //            if isTextAreaFocused == nil && text.isEmpty || (isTextAreaFocused == false && text.isEmpty) {
  //              inlinePlaceHolderTextView(placeholder)
  //            }
  //          }
  //        } else {
  //          if let blockCount = maxCharacterBlock, blockCount,
  //             let count = maxCharacterCount {
  //            TextEditor(text: $text.max(count))
  //              .padding(.top, 10)
  //              .padding(.horizontal, 12)
  //              .foregroundColor(.text(.default))
  //              .pbFont(.body())
  //              .focused($isTextAreaFocused, equals: true)
  //              .onTapGesture {
  //                isTextAreaFocused = true
  //              }
  //          } else {
  //            inlineTextEditorView($text)
  //          }
  //        }
  //      }
  //      HStack {
  //        Spacer()
  //        if let showCount = characterCount, showCount {
  //          Text("\(text.count)")
  //            .pbFont(.subcaption)
  //            .padding(.top, 4)
  //        } else if let maxCharacterCount = maxCharacterCount {
  //          Text("\(text.count) / \(maxCharacterCount)")
  //            .pbFont(.subcaption)
  //            .padding(.top, 4)
  //        }
  //      }
  //    }
  //  }

  //	func errorWithOutMaxCharCountView(_ error: String) -> some View {
  //		// This else if let statement will display textEditors that have an error string passed in but no maxCharacterCount
  //		return VStack {
  //			PBCard(padding: 0, style: style(isTextAreaFocused)) {
  //				if let placeholder = placeholder {
  //					ZStack(alignment: .leading) {
  //						textEditorView
  //						if isTextAreaFocused == nil && text.isEmpty || (isTextAreaFocused == false && text.isEmpty) {
  //							placeHolderTextView(placeholder)
  //						}
  //					}
  //				} else {
  //					textEditorView
  //				}
  //			}
  //			//      HStack {
  //			//        Text(error)
  //			//          .foregroundColor(.status(.error))
  //			//          .pbFont(.body())
  //			//          .padding(.top, 4)
  //			//        Spacer()
  //			//        //        if let showCount = characterCount, showCount {
  //			//        Text("\(text.count)")
  //			//          .pbFont(.subcaption)
  //			//          .padding(.top, 4)
  //			//        //        }
  //			//      }
  //
  //			countView
  //		}
  //	}

  //  func errorWithMaxCharCountView(_ error: String) -> some View {
  //    // this else if let statment will display textEditors with the maxCharacterCount and Error props working together to create a textEditor that has an error state when character count is greater than maxCharacterCount
  //    return VStack {
  //      PBCard(padding: 0,
  //             style: (error != nil && !error.isEmpty && maxCharacterCount != nil && text.count >= maxCharacterCount!) ? .error : .default) {
  //        if let placeholder = placeholder {
  //          ZStack(alignment: .leading) {
  //            textEditorView($text)
  //            if isTextAreaFocused == nil && text.isEmpty || (isTextAreaFocused == false && text.isEmpty) {
  //              placeHolderTextView(placeholder)
  //            }
  //          }
  //        } else {
  //          textEditorView($text)
  //        }
  //      }
  //      HStack {
  //        if error != nil && !error.isEmpty && maxCharacterCount != nil && text.count >= maxCharacterCount! {
  //          Text(error)
  //            .foregroundColor(.status(.error))
  //            .pbFont(.body())
  //            .padding(.top, 4)
  //        }
  //        Spacer()
  //        if let maxCharacterCount = maxCharacterCount {
  //          Text("\(text.count) / \(maxCharacterCount)")
  //            .pbFont(.subcaption)
  //            .padding(.top, 4)
  //        }
  //      }
  //    }
  //  }

  //	func defaultAndMaxCharCountView() -> some View {
  //		// this else if let statment will display textEditors with the maxCharacterCount, characterCount and default textEditors with and without placeholders
  //
  //	}

  //  func inlinePlaceHolderTextView(_ placeholder: String) -> some View {
  //    Text(placeholder)
  //      .padding(.horizontal, 12)
  //      .foregroundColor(Color(uiColor: .placeholderText))
  //      .pbFont(.body())
  //      .allowsHitTesting(false)
  //      .focused($isTextAreaFocused, equals: true)
  //  }

  //  func inlineTextEditorView(_ text: Binding<String>) -> some View {
  //    TextEditor(text: $text)
  //      .padding(.top, 10)
  //      .padding(.horizontal, 12)
  //      .foregroundColor(.text(.default))
  //      .pbFont(.body())
  //      .focused($isTextAreaFocused, equals: true)
  //      .onTapGesture {
  //        isTextAreaFocused = true
  //      }
  //  }
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
