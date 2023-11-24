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
  case date
  case dialog
  case toast = "Fixed Confirmation Toast"
  case homeAddress = "Home Address Street"
  case icon
  case iconCircle = "Icon Circle"
  case image
  case label = "Label Value"
  case message
  case multipleUser = "Multiple Users"
  case multipleUsersIndicator = "Multiple Users Indicator"
  case multipleUserStacked = "Multiple Users Stacked"
  case nav
  case person
  case pill
  case popover
  case progressIndicator = "Progress Indicator"
  case radio
  case sectionSeparator = "Section Separator"
  case select
  case textArea = "Textarea"
  case textInput = "Text Input"
  case timeStamp = "TimeStamp"
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
    case .date: DateCatalog()
    case .dialog: DialogCatalog()
    case .toast: if #available(iOS 16.0, *) {
      ToastCatalog()
    } else {
      EmptyView()
      // Fallback on earlier versions
    }
    case .homeAddress: HomeAddressStreetCatalog()
    case .icon: IconCatalog()
    case .iconCircle: IconCircleCatalog()
    case .image: PBImage_Previews.previews
    case .label: PBLabelValue_Previews.previews
    case .message: PBMessage_Previews.previews
    case .multipleUser: MultipleUsersCatalog()
    case .multipleUsersIndicator: MultipleUsersIndicatorCatalog()
    case .multipleUserStacked: MultipleUsersStackedCatalog()
    case .nav: PBNav_Previews.previews
    case .person: PersonCatalog()
    case .pill: PillCatalog()
    case .popover: PopoverCatalog()
    case .progressIndicator: PBSpinner_Previews.previews
    case .radio: RadioCatalog()
    case .sectionSeparator: PBSectionSeparator_Previews.previews
    case .select: PBSelect_Previews.previews
    case .textArea: TextAreaCatalog()
    case .textInput: PBTextInput_Previews.previews
    case .timeStamp: TimeStampCatalog()
    case .toggle: ToggleCatalog()
    case .user: UserCatalog()
    }
  }
}
