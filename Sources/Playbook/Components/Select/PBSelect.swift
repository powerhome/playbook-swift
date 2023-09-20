//
//  PBSelect.swift
//
//
//  Created by Everton Cunha on 14/06/22.
//

import SwiftUI

public struct PBSelect: View {
  let title: String?
  let options: [(value: String, text: String?)]
  let style: Variant
  let  selectedOption: ((String) -> Void)
  @State private var selected: String = ""

  public init(
    title: String? = nil,
    options: [(value: String, text: String?)],
    style: Variant = .default,
    selectedOption: @escaping (String) -> Void = { _ in}
  ) {
    self.title = title
    self.options = options
    self.style = style
    self.selected = options[0].text ?? options[0].value
    self.selectedOption = selectedOption
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      if let title = title {
        Text(title)
          .pbFont(.caption, color: .text(.light))
          .padding(.bottom, Spacing.xSmall)
      }

      let array = options.map { $0.text ?? $0.value }

      Menu {
        Picker("", selection: $selected) {
          ForEach(array, id: \.self) { value in
            Text(value)
          }
        }
      } label: {
        PBCard(padding: 0, style: style.card) {
          HStack {
            Text(selected)
              .pbFont(.body, color: style.textColor)
            Spacer()
            PBIcon.fontAwesome(.chevronDown)
              .foregroundColor(style.textColor)
          }
          .padding(.horizontal, Spacing.small)
          .padding(.vertical, Spacing.xSmall + 4)
          .background(style.backgroundColor)
        }
      }
      .disabled(style == .disabled)
      .onChange(of: selected, perform: { newValue in
        selectedOption(newValue)
      })

      if let errorMessage = style.errorMessage {
        Text(errorMessage)
          .pbFont(.body, color: .status(.error))
          .padding(.top, Spacing.xxSmall)
      }
    }
  }
}

public extension PBSelect {
  enum Variant: Equatable {
    case `default`, disabled
    case error(_ text: String? = nil)

    var card: PBCardStyle {
      switch self {
      case .`default`, .disabled:
        return .default
      case .error:
        return .error
      }
    }

    var errorMessage: String? {
      switch self {
      case .`default`, .disabled:
        return nil
      case .error(let message):
        return message
      }
    }

    @ViewBuilder
    var backgroundColor: some View {
      switch self {
      case .`default`, .error:
        LinearGradient(colors: [.card, .pbPrimary.opacity(0.05)], startPoint: .top, endPoint: .bottom)
      case .disabled:
        Color.init(hex: "#f4f4f6").opacity(0.5)
      }
    }

    var textColor: Color {
      switch self {
      case .`default`, .error:
        return .text(.default)
      case .disabled:
        return .text(.light)
      }
    }
  }
}

public struct PBSelect_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return SelectCatalog()
  }
}
