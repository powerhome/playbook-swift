//
//  PBTextArea.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

// extension View {
//	@ViewBuilder
//	func ifLet<V>(_ value: V?, transform: (Self, V) -> Self) -> some View {
//		if let value = value {
//			transform(self, value)
//		} else {
//			self
//		}
//	}
// }

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
      if let error = error, !error.isEmpty {
        PBCard(padding: 0, style: .error) {
          if let placeholder = placeholder {
            ZStack(alignment: .leading) {
              TextEditor(text: $text)
                .padding(.top, 4)
                .padding(.horizontal, 12)
                .frame(height: 88)
                .foregroundColor(.text(.default))
                .pbFont(.body())
                .focused($isNoteFocused)
              //								.disabled(text.count == maxCharacterCount)
              if !isNoteFocused && text.isEmpty {
                Text(placeholder)
                  .padding(.top, -32)
                  .padding(.horizontal, 16)
                  .foregroundColor(Color(uiColor: .placeholderText))
                  .pbFont(.body())
                  .allowsHitTesting(false)
              }
            }
          } else {
            TextEditor(text: $text)
              .padding(.top, 4)
              .padding(.horizontal, 12)
              .frame(height: 88)
              .foregroundColor(.text(.default))
              .pbFont(.body())
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
      } else {
        PBCard(padding: 0) {
          if let placeholder = placeholder {
            ZStack(alignment: .leading) {
              TextEditor(text: $text)
                .padding(.top, 4)
                .padding(.horizontal, 12)
                .frame(height: 88)
                .foregroundColor(.text(.default))
                .pbFont(.body())
                .focused($isNoteFocused)
              //								.disabled(text.count == maxCharacterCount)
              if !isNoteFocused && text.isEmpty {
                Text(placeholder)
                  .padding(.top, -32)
                  .padding(.horizontal, 16)
                  .foregroundColor(Color(uiColor: .placeholderText))
                  .pbFont(.body())
                  .allowsHitTesting(false)
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
            } else {
              TextEditor(text: $text)
                .padding(.top, 4)
                .padding(.horizontal, 12)
                .frame(height: 88)
                .foregroundColor(.text(.default))
                .pbFont(.body())
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
  // struct DisableModifier: ViewModifier {
  //	let maxCharacterCount: Int
  //	let text: String
  //
  //	func body(content: Content) -> some View {
  //		if maxCharacterCount == $text.count {
  //			return AnyView(content)
  //		} else {
  //			return AnyView(content.border(Color.red))
  //		}
  //	}
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
