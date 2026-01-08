//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBSelectableCard.swift
//

import SwiftUI

public struct PBSelectableCard<Content: View>: View {
  let alignment: Alignment
  let variant: Variant
  let backgroundColor: Color
  let borderRadius: CGFloat
  let cardPadding: CGFloat
  let shadow: Shadow?
  let width: CGFloat?
  let fontSize: PBFont
  let cardText: String?
  let icon: PBIcon?
  let iconOffset: (x: CGFloat?, y: CGFloat?)
  let hasIcon: Bool
  let error: Bool
  let content: Content?
  let id: Int
  let isCardFullWidth: Bool
  let isDisabled: Bool

  @Binding var isSelected: Bool
  @Binding var radioId: Int
  @State private var isHovering: Bool = false

  public init(
    alignment: Alignment = .center,
    variant: Variant = .default,
    backgroundColor: Color = .card,
    borderRadius: CGFloat = BorderRadius.medium,
    cardPadding: CGFloat = Spacing.small,
    shadow: Shadow? = nil,
    width: CGFloat? = .infinity,
    fontSize: PBFont = .body,
    cardText: String? = nil,
    icon: PBIcon? = PBIcon(FontAwesome.check, size: .small),
    hasIcon: Bool = false,
    iconOffset: (x: CGFloat?, y: CGFloat?) = (x: 10, y: -10),
    isSelected: Binding<Bool> = .constant(false),
    isDisabled: Bool = false,
    radioId: Binding<Int> = .constant(0),
    id: Int = 0,
    isCardFullWidth: Bool = false,
    error: Bool = false,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.alignment = alignment
    self.variant = variant
    self.backgroundColor = backgroundColor
    self.borderRadius = borderRadius
    self.cardPadding = cardPadding
    self.shadow = shadow
    self.width = width
    self.fontSize = fontSize
    self.cardText = cardText
    self.icon = icon
    self.hasIcon = hasIcon
    self.iconOffset = iconOffset
    self.id = id
    self._isSelected = isSelected
    self.isDisabled = isDisabled
    self._radioId = radioId
    self.isCardFullWidth = isCardFullWidth
    self.error = error
    self.content = content()
  }

  public var body: some View {
    cardView
  }
}

extension PBSelectableCard {
  public enum Variant {
    case `default`, block, checkedInput, radioInput
  }

  var padding: CGFloat {
    switch variant {
    case .checkedInput, .radioInput: 0
    default:
      cardPadding
    }
  }

  var cardView : some View {
    VStack(spacing: Spacing.medium) {
      PBCard(
        alignment: alignment,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        padding: padding,
        style: cardStyle,
        shadow: shadowStyle,
        width: frameReader(in: { _ in}) as? CGFloat, 
        isHovering: isSelected ? false : isHovering
      ) {
        if let text = cardText {
          AnyView(cardTextView(text))
        }
        if let content = content {
          content
        }
      }
      .pbFont(.body, color: .text(.default))
      .opacity(isDisabled ? 0.6 : 1)
      .globalPosition(alignment: .topTrailing) {
        iconView
      }
       .onTapGesture {
        if variant != .radioInput {
          isSelected.toggle()
        } else {
          radioId = id
        }
      }
      .onHover(disabled: isDisabled) { hovering in
        if !isDisabled {
          isHovering.toggle()
        }
      }
    }
    .onChange(of: radioId) { _, newValue in
      isSelected = (newValue == id)
    }
  }

    var cardStyle: PBCardStyle {
      if isSelected {
        return .selected(type: .card)
      } else {
        return error ? .error : .default
      }
    }

  var iconView: some View {
    Group {
      if let icon = icon, hasIcon {
        Circle()
          .stroke(Color.white, lineWidth: 2)
          .background(Circle().fill(Color.pbPrimary))
          .frame(width: 24, height: 24)
          .overlay {
            icon.foregroundStyle(Color.white)
          }
            .offset(x: iconOffset.x ?? 0, y: iconOffset.y ?? 0)
            .opacity(isSelected ? 1 : 0)
        } else {
          Color.clear
        }
      }
  }

  func cardTextView(_ text: String) -> any View {
    switch variant {
    case .default: return Text(text)
    case .block: return blockText(text)
    case .checkedInput: return checkedInputView(text)
    case .radioInput: return radioInputView(text)
    }
  }

  func blockText(_ text: String) -> some View {
    let wholeText = text.split { $0.isNewline }
    let blockTitle = wholeText[0]
    let blockSubText = wholeText.dropFirst().joined(separator: "\n")
    return VStack(alignment: .leading) {
      Text(blockTitle).pbFont(.title4)
      Text(blockSubText).pbFont(.body)
    }
  }

  func checkedInputView(_ text: String) -> some View {
    HStack(spacing: Spacing.none) {
      PBCheckbox(checked: $isSelected, checkboxType: .default)
        .padding()
      separatorView
      Text(text)
        .pbFont(.body)
        .padding(.horizontal, isSelected ? cardPadding - 1 : cardPadding - 0.10)
    }
    .frame(maxWidth: isCardFullWidth ? .infinity : nil, alignment: .leading)
  }

  func radioInputView(_ text: String) -> some View {
    HStack(spacing: Spacing.none) {
      Button("") {
        radioId = id
      }
      .buttonStyle(
        radioButtonStyle
      )
      .padding(.horizontal, 10)
      separatorView
      Text(text)
        .pbFont(.body)
        .padding(cardPadding)
        .padding(.horizontal, isSelected ? padding - 1 : padding - 0.10)
    }
    .frame(maxWidth: isCardFullWidth ? .infinity : nil, alignment: .leading)
  }

  var radioButtonStyle: PBRadioButtonStyle {
    PBRadioButtonStyle(
      subtitle: nil,
      isSelected: isSelected,
      textAlignment: .horizontal,
      padding: padding,
      errorState: false
    )
  }

  var separatorView: some View {
    HStack {
        PBSectionSeparator(orientation: .vertical, variant: .card, dividerColor: separatorColor)
        .frame(width: isSelected || error ? 2 : 1)
        .background(separatorColor)
        .foregroundStyle(isSelected ? Color.pbPrimary : Color.border)
    }
  }

    var separatorColor: Color {
      if isSelected {
        return .pbPrimary
      } else {
        return error ? .status(.error) : .border
      }
    }

  var shadowStyle: Shadow {
    isHovering ? .deep : Shadow.none
  }
}

#Preview {
  registerFonts()
  return PBSelectableCard {
    Text("card").padding()
  }
}
