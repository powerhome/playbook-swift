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
  let dateStamp: Date
  let dateString: String
  let variant: PBDate.Variant
  let fontSize: PBFont
  public init(
    dateStamp: Date = Date(),
    dateString: String = "",
    variant: PBDate.Variant = .short,
    fontSize: PBFont = .body
  ){
    self.variant = variant
    self.dateStamp = dateStamp
    self.dateString = dateString
    self.fontSize = fontSize
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
      VStack(alignment: .leading) { Text(dateStamp.formatted(.dateTime.month())).pbFont(.caption, variant: .bold, color: .text(.light))
        
        Text(dateStamp.formatted(.dateTime.day())).pbFont(fontSize, variant: .bold, color: .text(.default))
      }
    case .standard: 
      VStack(alignment: .leading) { Text(dateStamp.formatted(.dateTime.month())).pbFont(.caption, variant: .bold, color: .text(.light))
      
      Text(dateStamp.formatted(.dateTime.day())).pbFont(fontSize, variant: .bold, color: .text(.default))
      Text(dateStamp.formatted(.dateTime.year())).pbFont(.caption, variant: .bold, color: .text(.light))
    }
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
