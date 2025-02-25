//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Components.swift
//

import SwiftUI

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
  case iconStatValue = "Icon Stat Value"
  case iconValue = "Icon Value"
  case image
  case label = "Label Value"
  case labelPill = "Label Pill"
  case loader = "Loading Inline"
  case masonry = "Masonry"
  case message
  case multipleUser = "Multiple Users"
  case multipleUsersIndicator = "Multiple Users Indicator"
  case multipleUserStacked = "Multiple Users Stacked"
  case nav
  case onlineStatus = "Online Status"
  case person
  case personContact = "Person Contact"
  case pill
  case popover
  case progressPill = "Progress Pill"
  case progressStep = "Progress Step"
  case progressSimple = "Progress Simple"
  case radio
  case sectionSeparator = "Section Separator"
  case select
  case selectableCard = "Selectable Card"
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
    case .iconStatValue: IconStatValueCatalog()
    case .iconValue: IconValueCatalog()
    case .image: ImageCatalog()
    case .label: LabelValueCatalog()
    case .labelPill: LabelPillCatalog()
    case .loader: LoaderCatalog()
    case .masonry: MasonryCatalog()
    case .message: MessageCatalog()
    case .multipleUser: MultipleUsersCatalog()
    case .multipleUsersIndicator: MultipleUsersIndicatorCatalog()
    case .multipleUserStacked: MultipleUsersStackedCatalog()
    case .nav: NavCatalog()
    case .onlineStatus: OnlineStatusCatalog()
    case .person: PersonCatalog()
    case .personContact: PersonContactCatalog()
    case .pill: PillCatalog()
    case .popover: PopoverCatalog()
    case .progressPill: ProgressPillCatalog()
    case .progressStep: ProgressStepCatalog()
    case .progressSimple: ProgressSimpleCatalog()
    case .radio: RadioCatalog()
    case .sectionSeparator: SectionSeparatorCatalog()
    case .select: SelectCatalog()
    case .selectableCard: SelectableCardCatalog()
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
