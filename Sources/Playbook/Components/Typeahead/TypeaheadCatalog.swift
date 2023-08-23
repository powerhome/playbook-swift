//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  public var body: some View {
    List {
      PBTypeahead(title: "Colors", variant: .text)
      PBTypeahead(title: "Users", variant: .pill)
      PBTypeahead(title: "Colors", variant: .other)
    }
  }
}
