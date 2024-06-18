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
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let iconPosition: Alignment
  let iconOffsetX: CGFloat?
  let iconOffsetY: CGFloat?
  let content: Content?
  let id: Int
  let isCardFullWidth: Bool
  @State private var isHovering: Bool = false
  @Binding var isSelected: Bool
  @Binding var hasIcon: Bool
  @Binding var isDisabled: Bool
  @Binding var radioId: Int
  
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
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .small,
    iconPosition: Alignment = .topTrailing,
    iconOffsetX: CGFloat? = 10,
    iconOffsetY: CGFloat? = -10,
    isSelected: Binding<Bool> = .constant(false),
    hasIcon: Binding<Bool> = .constant(false),
    isDisabled: Binding<Bool> = .constant(false),
    radioId: Binding<Int> = .constant(0),
    id: Int = 0,
    isCardFullWidth: Bool = false,
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
    self.iconSize = iconSize
    self.iconPosition = iconPosition
    self.iconOffsetX = iconOffsetX
    self.iconOffsetY = iconOffsetY
    self.id = id
    self._isSelected = isSelected
    self._hasIcon = hasIcon
    self._isDisabled = isDisabled
    self._radioId = radioId
    self.isCardFullWidth = isCardFullWidth
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
        style: isSelected ? .selected(type: .card) : .default,
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
      .globalPosition(alignment: iconPosition) {
        iconView
      }
       .onTapGesture {
        if variant != .radioInput {
          isSelected.toggle()
        } else {
          radioId = id
        }
        hasIcon.toggle()
      }
      .onHover { hovering in
        if !isDisabled {
          isHovering.toggle()
        }
        #if os(macOS)
        if hovering {
          NSCursor.pointingHand.push()
          if isDisabled {
            NSCursor.operationNotAllowed.push()
          }
        } else {
          NSCursor.pointingHand.pop()
          NSCursor.operationNotAllowed.pop()
        }
        #endif
      }
    }
    .onChange(of: radioId) { newValue in
      isSelected = (newValue == id)
    }
  }
  var iconView: some View {
    Circle()
      .stroke(Color.white, lineWidth: 2)
      .background(Circle().fill(Color.pbPrimary))
      .frame(width: 24, height: 24)
      .overlay {
        PBIcon(icon, size: iconSize)
          .foregroundStyle(Color.white)
      }
      .offset(x: iconOffsetX ?? 0, y: iconOffsetY ?? 0)
      .opacity(isSelected && hasIcon ? 1 : 0)
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
      Text(blockSubText)
    }
  }
  func checkedInputView(_ text: String) -> some View {
    HStack(spacing: Spacing.none) {
      PBCheckbox(checked: $isSelected, checkboxType: .default)
        .padding()
      separatorView
      Text(text)
        .padding(.horizontal, isSelected ? cardPadding - 1 : cardPadding - 0.10)
      if isCardFullWidth {
        Spacer()
      }
    }
    .padding(.vertical, -4)
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
        .padding(cardPadding)
        .padding(.horizontal, isSelected ? padding - 1 : padding - 0.10)
      if isCardFullWidth {
        Spacer()
      }
    }
    .padding(.vertical, -4)
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
      Divider()
        .frame(width: isSelected ? 2 : 1)
        .background(isSelected ? Color.pbPrimary : .border)
        .foregroundStyle(isSelected ? Color.pbPrimary : Color.border)
    }
  }
  var shadowStyle: Shadow {
    isHovering ? .deep : Shadow.none
  }
}

#Preview {
  registerFonts()
  return PBSelectableCard()
}
