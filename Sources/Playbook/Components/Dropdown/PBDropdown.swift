//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDropdown.swift
//

import SwiftUI
import Foundation

public struct PBDropdown: View {
  @Namespace private var dropdownNamespace
  @Binding var options: [String]
  @Binding var selectedText: String
  @State var isOpen: Bool = false
  @State var isHovering: Bool = false
  @State var optionIndex: Int = -1
  var cardPosition: Alignment
  var buttonIcon: FontAwesome
  var buttonIconSize: PBIconCircle.Size
  var buttonIconColor: PBIconCircle.IconColor
  var dropdownIcon: FontAwesome?
  var dropdownIconSize: PBIcon.IconSize
  var topSpacing: CGFloat
  var bottomSpacing: CGFloat
  var leadingSpacing: CGFloat
  var trailingSpacing: CGFloat
  var variant: Variant
  var hasIcon: Bool = true
  var hasRowSeparator: Bool
  var hasCheckmark: Bool?
  var width: CGFloat?
  var dropdownHeight: CGFloat?
  let content: () -> AnyView

  public init(
    options: Binding<[String]> = .constant(["Philadelphia", "New York", "San Francisco", "Los Angeles", "Chicago"]),
    selectedText: Binding<String> = .constant(""),
    cardPosition: Alignment = .top,
    buttonIcon: FontAwesome = .flag,
    buttonIconSize: PBIconCircle.Size = .medium,
    buttonIconColor: PBIconCircle.IconColor = .green,
    dropdownIcon: FontAwesome? = nil,
    dropdownIconSize: PBIcon.IconSize = .small,
    topSpacing: CGFloat = 0,
    bottomSpacing: CGFloat = 0,
    leadingSpacing: CGFloat = 0,
    trailingSpacing: CGFloat = 0,
    variant: Variant = .select,
    hasIcon: Bool = true,
    hasRowSeparator: Bool = true,
    hasCheckmark: Bool? = false,
    width: CGFloat? = 300,
    dropdownHeight: CGFloat? = 140,
    @ViewBuilder content: @escaping () -> some View
  ) {
    self._options = options
    self._selectedText = selectedText
    self.buttonIcon = buttonIcon
    self.buttonIconSize = buttonIconSize
    self.buttonIconColor = buttonIconColor
    self.cardPosition = cardPosition
    self.dropdownIcon = dropdownIcon
    self.dropdownIconSize = dropdownIconSize
    self.topSpacing = topSpacing
    self.bottomSpacing = bottomSpacing
    self.leadingSpacing = leadingSpacing
    self.trailingSpacing = trailingSpacing
    self.variant = variant
    self.hasIcon = hasIcon
    self.hasRowSeparator = hasRowSeparator
    self.hasCheckmark = hasCheckmark
    self.width = width
    self.dropdownHeight = dropdownHeight
    self.content = { AnyView(content()) }
  }

  public var body: some View {

    dropdownView

  }
}

public extension PBDropdown {
  enum Variant {
    case select, button, content
  }

  @ViewBuilder
  var dropdownView: some View {
    ZStack {

      dropDownVariant
        .zIndex(1000)
    }
    .clickOutsideToClose(isOpen: isOpen) {
      isOpen = false
    }
  }

  @ViewBuilder
  var dropDownVariant: some View {
    switch variant {
    case .select: selectDropdown
    case .button, .content: buttonDropdown
    }
  }

  var selectDropdown: some View {
    VStack {
      Button {
        isOpen.toggle()
      } label: {
        ReadOnlyTextFieldView(isOpen: $isOpen, selectedText: $selectedText)
      }
      .globalPosition(alignment: cardPosition, top: topSpacing == 0 ? 45 : topSpacing, leading: leadingSpacing, bottom: bottomSpacing == 0 ? 45 : bottomSpacing, trailing: trailingSpacing) {
        dropdownCardView(options: options, optionIndex: optionIndex, selectedText: selectedText, isOpen: isOpen)
      }
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(isOpen ? Color.pbPrimary : Color.text(.lighter), lineWidth: 2)
      }
      .frame(width: width)
      .buttonStyle(PlainButtonStyle())
      Spacer()
    }
  }

  @ViewBuilder
  var buttonDropdown: some View {
    VStack(spacing: Spacing.none) {
      Button {
        isOpen.toggle()
      } label: {
        if variant == .button {
          PBIconCircle(buttonIcon, size: buttonIconSize, color: buttonIconColor)
        } else {
          content()
        }
      }
      .globalPosition(alignment: cardPosition, top: topSpacing == 0 ? 45 : topSpacing, leading: leadingSpacing, bottom: bottomSpacing, trailing: trailingSpacing) {
        dropdownCardView(options: options, optionIndex: optionIndex, selectedText: selectedText, isOpen: isOpen)
      }
    }
    .buttonStyle(PlainButtonStyle())
  }

  func dropdownCardView(options: [String], optionIndex: Int, selectedText: String, isOpen: Bool) -> some View {
    ZStack {
      if isOpen {
        PBCard(padding: 0, shadow: .deep) {
          List(Array(options.enumerated()), id: \.offset) { index, option in
            HStack(spacing: Spacing.xSmall) {
              selectOptionView(option: option)
            }
            .listRowSeparator(hasRowSeparator ? .visible : .hidden)
            .dropdownStyle(optionIndex: $optionIndex, index: index, option: option, selectedText: $selectedText, isOpen: $isOpen)
          }
          .frame(width: width, height: dropdownHeight)
          .listRowInsets(EdgeInsets())
          .listStyle(.plain)
          .scrollIndicators(.hidden)
        }
        .padding(Spacing.xxSmall)
      }
    }
  }

  func selectOptionView(option: String, checkmark: FontAwesome? = .check) -> some View {
    HStack {
      if let dropDownIcon = dropdownIcon, hasIcon  {
        PBIcon(dropDownIcon, size: dropdownIconSize)
      }

      Text(option)
        .pbFont(.body)

      if hasCheckmark == true {
        Spacer()
        if let checkmark = checkmark {
          PBIcon(checkmark, size: .small)
        }
      }
    }
  }
}

#Preview {
  registerFonts()
  return PBDropdown(content: {})
    .frame(width: 500, height: 500)
}
