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
  let variant: Variant
  let backgroundColor: Color
  let borderRadius: CGFloat
  let padding: CGFloat
  let shadow: Shadow?
  let width: CGFloat?
  let fontSize: PBFont
  let cardText: String
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let iconPosition: Alignment
  let iconOffsetX: CGFloat?
  let iconOffsetY: CGFloat?
  @State private var isHovering: Bool = false
  @Binding var isSelected: Bool
  @Binding var hasIcon: Bool
  @Binding var isDisabled: Bool
  public init(
    alignment: Alignment = .center,
    variant: Variant = .default,
    backgroundColor: Color = .card,
    borderRadius: CGFloat = BorderRadius.medium,
    padding: CGFloat = Spacing.small,
    shadow: Shadow? = nil,
    width: CGFloat? = .infinity,
    fontSize: PBFont = .body,
    cardText: String = "Selected",
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .small,
    iconPosition: Alignment = .topTrailing,
    iconOffsetX: CGFloat? = 10,
    iconOffsetY: CGFloat? = -10,
    isSelected: Binding<Bool> = .constant(false),
    hasIcon: Binding<Bool> = .constant(false),
    isDisabled: Binding<Bool> = .constant(false)
  ) {
    self.alignment = alignment
    self.variant = variant
    self.backgroundColor = backgroundColor
    self.borderRadius = borderRadius
    self.padding = padding
    self.shadow = shadow
    self.width = width
    self.fontSize = fontSize
    self.cardText = cardText
    self.icon = icon
    self.iconSize = iconSize
    self.iconPosition = iconPosition
    self.iconOffsetX = iconOffsetX
    self.iconOffsetY = iconOffsetY
    self._isSelected = isSelected
    self._hasIcon = hasIcon
    self._isDisabled = isDisabled
  }
  public var body: some View {
    cardView
  }
}

extension PBSelectableCard {
  public enum Variant {
    case `default`, block
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
        width: frameReader(in: { _ in}) as? CGFloat
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
      .onHover { hovering in
        isHovering.toggle()
     #if os(macOS)
     if hovering {
       NSCursor.pointingHand.push()
     } else {
       NSCursor.pointingHand.pop()
     }
     #endif
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
  @ViewBuilder
  var cardTextView: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      switch variant {
      case .default: Text(cardText)
      case .block: blockText
      }
    }
    .pbFont(.body, color: defaultFontColor)
  }
  @ViewBuilder
  var blockText: some View {
    let wholeText = cardText.split { $0.isNewline }
    let blockTitle = wholeText[0]
    let blockSubText = wholeText[1]
    Text(blockTitle).pbFont(.title4, color: defaultFontColor)
    Text(blockSubText)
  }
  var shadowStyle: Shadow {
    isHovering ? .deep : Shadow.none
  }
  var defaultFontColor: Color {
    isDisabled ? .text(.light) : .text(.default)
  }
}


#Preview {
  registerFonts()
  return SelectableCardCatalog()
}
