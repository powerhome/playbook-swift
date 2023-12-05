//
//  PBContact.swift
//
//
//  Created by Stephen Marshall on 11/28/23.
//

import SwiftUI
import PhoneNumberKit

public struct PBContact: View {
  let detail: Bool
  let contactValue: String
  let type: ContactType
  public init(type: ContactType = .home, value: String, detail: Bool = false) {
    self.type = type
    self.contactValue = value
    self.detail = detail
  }
  public var body: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBIcon.fontAwesome(type.icon)
        .foregroundStyle(Color.text(.light))
        .padding(.trailing, Spacing.xxSmall - 2)
      Text(parsedValue)
        .foregroundStyle(Color.text(.light))
        .pbFont(.body)
      if self.detail {
        Text(type.text)
          .foregroundStyle(Color.text(.light))
          .padding(.top, Spacing.xxSmall - 1)
          .pbFont(.subcaption)
      }
    }
  }
}

public extension PBContact {
  enum ContactType {
    case cell
    case email
    case home
    case work
    case workCell
    case wrongPhone
    case ext
    case custom(String, FontAwesome)
    var icon: FontAwesome {
      switch self {
      case .cell: return .mobile
      case .email: return .envelope
      case .ext: return .phonePlus
      case .home: return .phone
      case .work: return .phoneOffice
      case .workCell: return .laptopMobile
      case .custom(_, let icon): return icon
      default: return .home
      }
    }
    var text: String {
      switch self {
      case .cell: return "Cell"
      case .email: return "Email"
      case .ext: return "Ext"
      case .home: return "Home"
      case .work: return "Work"
      case .workCell: return "Work Cell"
      case .custom(let text, _): return text
      default: return ""
      }
    }
  }
  var parsedValue: String {
    let phoneNumberKit = PhoneNumberKit()
    let dialContext: PhoneNumberFormat = self.contactValue.prefix(1) == "1" ? .international : .national
    let phoneNum: PhoneNumber
    do {
      phoneNum = try phoneNumberKit.parse(self.contactValue, ignoreType: true)
      return phoneNumberKit.format(phoneNum, toType: dialContext)
    }
    catch {
      return self.contactValue
    }
  }
}

public struct PBPContact_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PBContact(type: .cell, value: "8888888888", detail: true)
  }
}
