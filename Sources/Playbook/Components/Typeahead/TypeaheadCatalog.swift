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
        PBTypeahead(variant: .text)
        PBTypeahead(variant: .pill)
        PBTypeahead(variant: .other)
      }
    }
}
