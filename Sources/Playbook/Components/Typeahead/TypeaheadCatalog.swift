//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State var popoverValue: AnyView?
  public var body: some View {
    List {
      PBTypeahead(title: "Colors", variant: .text, popoverValue: $popoverValue)
      PBTypeahead(title: "Users", variant: .pill, popoverValue: $popoverValue)
      PBTypeahead(title: "Colors", variant: .other, popoverValue: $popoverValue)
    }
 //   .withPopoverHandling(popoverValue, position: .bottom)
  }
}
