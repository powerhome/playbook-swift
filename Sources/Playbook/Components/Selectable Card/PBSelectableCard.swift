//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBSelectableCard.swift
//

import SwiftUI

public struct PBSelectableCard: View {
  let alignment: Alignment
  let backgroundColor: Color
  let border: Bool
  let borderRadius: CGFloat
  let padding: CGFloat
  let shadow: Shadow?
  let width: CGFloat?
  let fontSize: PBFont
  let cardText: String
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let iconPosition: Alignment
  let boldText: String?
  let iconOffsetX: CGFloat?
  let iconOffsetY: CGFloat?
  @Binding var isSelected: Bool
  @Binding var hasIcon: Bool
  @Binding var isDisabled: Bool
  @Binding var isBlockText: Bool
  public init(
    alignment: Alignment = .center,
    backgroundColor: Color = .card,
    border: Bool = true,
    borderRadius: CGFloat = BorderRadius.medium,
    padding: CGFloat = Spacing.small,
    shadow: Shadow? = nil,
    width: CGFloat? = .infinity,
    fontSize: PBFont = .body,
    cardText: String = "Selected",
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .x1,
    iconPosition: Alignment = .topTrailing,
    boldText: String? = nil,
    iconOffsetX: CGFloat? = 10,
    iconOffsetY: CGFloat? = -10,
    isSelected: Binding<Bool> = .constant(false),
    hasIcon: Binding<Bool> = .constant(false),
    isDisabled: Binding<Bool> = .constant(false),
    isBlockText: Binding<Bool> = .constant(false)
  ) {
    self.alignment = alignment
    self.backgroundColor = backgroundColor
    self.border = border
    self.borderRadius = borderRadius
    self.padding = padding
    self.shadow = shadow
    self.width = width
    self.fontSize = fontSize
    self.cardText = cardText
    self.icon = icon
    self.iconSize = iconSize
    self.iconPosition = iconPosition
    self.boldText = boldText
    self.iconOffsetX = iconOffsetX
    self.iconOffsetY = iconOffsetY
    self._isSelected = isSelected
    self._hasIcon = hasIcon
    self._isDisabled = isDisabled
    self._isBlockText = isBlockText
  }
  public var body: some View {
    cardView
  }
  var textToBold: AttributedString {
    return colorAttributedText(cardText, characterToChange: boldText ?? "", color: .text(.light))
  }
}

extension PBSelectableCard {
  var cardView : some View {
    VStack(spacing: Spacing.medium) {
      PBCard(
        alignment: alignment,
        backgroundColor: backgroundColor,
        border: border,
        borderRadius: borderRadius,
        padding: padding,
        style: isSelected ? .selected(type: .card) : .default,
        width: frameReader(isPresented: false, in: { _ in}) as? CGFloat
      ) {
        cardTextView
      }
      .globalPosition(alignment: iconPosition) {
        iconView
      }
      .onTapGesture {
        isSelected.toggle()
        hasIcon.toggle()
      }
      .disabled(isDisabled)
      .onAppear {
        // might not need this
        if isBlockText {
          isBlockText = true
        }
      }
    }
  }
  var iconView: some View {
    PBIcon(icon, size: iconSize)
      .frame(width: 24, height: 24)
      .background(Color.pbPrimary)
      .clipShape(Circle())
      .foregroundStyle(Color.white)
      .offset(x: iconOffsetX ?? 0, y: iconOffsetY ?? 0)
      .opacity(isSelected && hasIcon ? 1 : 0)
  }
  var cardTextView: some View {
    Text(cardText)
      .pbFont(fontSize, variant: .bold, color: isDisabled ? .text(.light) : .text(.default))
  }
}


#Preview {
  registerFonts()
  return SelectableCardCatalog()
}
