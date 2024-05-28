//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Components.swift
//

import SwiftUI

@available(iOS 16.4, *)
@available(macOS 13, *)
public enum Components: String, CaseIterable {
  case avatar
  case badge
  case button
  case card
  case checkbox
  case collapsible
  case contact
  case currency = "Currency"
  case date
  case dateRangeInline = "Date Range Inline"
  case dateRangeStacked = "Date Range Stacked"
  case dateStacked = "Date Stacked"
  case dateTime = "Date Time"
  case dateTimeStacked = "Date Time Stacked"
  case dateYearStacked = "Date Year Stacked"
  case dialog
  case grid
  case toast = "Fixed Confirmation Toast"
  case highlight = "Highlight"
  case homeAddress = "Home Address Street"
  case icon
  case iconCircle = "Icon Circle"
  case image
  case label = "Label Value"
  case loader = "Loading Inline"
  case message
  case multipleUser = "Multiple Users"
  case multipleUsersIndicator = "Multiple Users Indicator"
  case multipleUserStacked = "Multiple Users Stacked"
  case nav
  case person
  case personContact = "Person Contact"
  case pill
  case popover
  case radio
  case sectionSeparator = "Section Separator"
  case select
  case tabBar = "Tab Bar"
  case textArea = "Textarea"
  case textInput = "Text Input"
  case time = "Time"
  case timeStamp = "Time and Date"
  case timeRangeInline = "Time Range Inline"
  case timeStacked = "Time Stacked"
  case typeahead
  case tooltip = "Tooltip"
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
    case .contact: ContactCatalog()
    case .currency: CurrencyCatalog()
    case .date: DateCatalog()
    case .dateRangeInline: DateRangeInlineCatalog()
    case .dateRangeStacked: DateRangeStackedCatalog()
    case .dateStacked: DateStackedCatalog()
    case .dateTime: DateTimeCatalog()
    case .dateYearStacked: DateYearStackedCatalog()
    case .dateTimeStacked: DateTimeStackedCatalog()
    case .dialog: DialogCatalog()
    case .grid: GridCatalog()
    case .toast: ToastCatalog()
    case .highlight: HighlightCatalog()
    case .homeAddress: HomeAddressStreetCatalog()
    case .icon: IconCatalog()
    case .iconCircle: IconCircleCatalog()
    case .image: ImageCatalog()
    case .label: LabelValueCatalog()
    case .loader: LoaderCatalog()
    case .message: MessageCatalog()
    case .multipleUser: MultipleUsersCatalog()
    case .multipleUsersIndicator: MultipleUsersIndicatorCatalog()
    case .multipleUserStacked: MultipleUsersStackedCatalog()
    case .nav: NavCatalog()
    case .person: PersonCatalog()
    case .personContact: PersonContactCatalog()
    case .pill: PillCatalog()
    case .popover: PopoverCatalog()
    case .radio: RadioCatalog()
    case .sectionSeparator: SectionSeparatorCatalog()
    case .select: SelectCatalog()
    case .tabBar: TabBarCatalog()
    case .textArea: TextAreaCatalog()
    case .textInput: TextInputCatalog()
    case .tooltip: TooltipCatalog()
    case .time: TimeCatalog()
    case .timeStamp: TimeStampCatalog()
    case .timeRangeInline: TimeRangeInlineCatalog()
    case .timeStacked: TimeStackedCatalog()
    case .typeahead: TypeaheadCatalog()
    case .toggle: ToggleCatalog()
    case .user: UserCatalog()
    }
  }
}
