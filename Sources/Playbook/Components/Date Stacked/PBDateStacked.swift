//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateStacked.swift
//

import SwiftUI

public struct PBDateStacked: View {
  let alignment: HorizontalAlignment
  let dateStamp: Date
  let dateString: String
  let variant: PBDate.Variant
  let fontSize: PBFont
  let isReversed: Bool
  let isBold: Bool
  public init(
    alignment: HorizontalAlignment = .leading,
    dateStamp: Date = Date(),
    dateString: String = "",
    variant: PBDate.Variant = .short,
    fontSize: PBFont = .body,
    isReversed: Bool = false,
    isBold: Bool = false
  ){
    self.alignment = alignment
    self.variant = variant
    self.dateStamp = dateStamp
    self.dateString = dateString
    self.fontSize = fontSize
    self.isReversed = isReversed
    self.isBold = isBold
  }
    public var body: some View {
      formattedDate
    }
}

extension PBDateStacked {
  var dateStackedView: some View {
    formattedDate
    
  }
 
@ViewBuilder
  var formattedDate: some View {
    switch variant {
    case .short:
      VStack(alignment: alignment, spacing: Spacing.xxSmall) {
        if !isReversed {
          Text(dateStamp.formatted(.dateTime.month())).pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
          
          Text(dateStamp.formatted(.dateTime.day())).pbFont(fontSize, variant: .bold, color: isBold ? .text(.default) : .text(.default))
        } else {
          Text(dateStamp.formatted(.dateTime.day())).pbFont(fontSize, variant: .bold, color: isBold ? .text(.default) : .text(.default))
          Text(dateStamp.formatted(.dateTime.month())).pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
          
        }
      }
    case .standard:
        Text(dateStamp.formatted(.dateTime.month())).pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
      
        Text(dateStamp.formatted(.dateTime.day())).pbFont(fontSize, variant: .bold, color: isBold ? .text(.default) : .text(.default))
        Text(dateStamp.formatted(.dateTime.year())).pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
    default:
      Text("MMM \nd")
    }
  }
  
  var dateStyle: String {
    switch variant {
    case .short: return "MMM \nd"
    case .standard: return "MMM \nd, \nYYYY"
    default:
      return "MMM \nd"
    }
  }
}
#Preview {
  registerFonts()
   return DateStackedCatalog()
}
