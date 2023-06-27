//
//  Components.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
public enum Componenets: String, CaseIterable {
  case avatar
  case badge
  case button
  case card
  case checkbox
  case collapsible
  case dialog
  case iconCircle
  case image
  case label
  case message
  case multipleUserStacked = "Multiple User Stacked"
  case nav
  case pill
  case progressIndicator = "Progress Indicator"
  case radio
  case sectionSeparator = "Section Separator"
  case select
  case textArea = "Text Area"
  case textInput = "Text Input"
  case timeAndDate = "Time and Date"
  case toggle
  case user

  public static let title: String = "Components"

  @ViewBuilder
  public var destination: some View {
    switch self {
    case .avatar: AvatarCatalog()
    case .badge: BadgeCatalog()
    case .button: ButtonsCatalog()
    case .card: CardCatalog()
    case .checkbox: CheckboxCatalog()
    case .collapsible: CollapsibleCatalog()
    case .dialog: DialogCatalog()
    case .iconCircle: IconCircleCatalog()
    case .image: PBImage_Previews.previews
    case .label: PBLabelValue_Previews.previews
    case .message: PBMessage_Previews.previews
    case .multipleUserStacked: MultipleUsersStackedCatalog()
    case .nav: PBNav_Previews.previews
    case .pill: PillCatalog()
    case .progressIndicator: PBSpinner_Previews.previews
    case .radio: RadioCatalog()
    case .sectionSeparator: PBSectionSeparator_Previews.previews
    case .select: PBSelect_Previews.previews
    case .textArea: TextAreaCatalog()
    case .textInput: PBTextInput_Previews.previews
    case .timeAndDate: TimeStampCatalog()
    case .toggle: PBRadio_Previews.previews
    case .user: PBMultipleUsers_Previews.previews
    }
  }
}
