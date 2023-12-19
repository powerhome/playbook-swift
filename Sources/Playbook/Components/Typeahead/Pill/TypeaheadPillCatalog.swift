//
//  TypeaheadPillCatalog.swift
//  
//
//  Created by Isis Silva on 15/12/23.
//

import SwiftUI

struct TypeaheadPillCatalog: View {
  var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default", spacing: Spacing.small) {
          ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
              HStack {
                TypeaheadPill("Default")
                
                TypeaheadPill("Focus")
                  .environment(\.focus, true)
                
                TypeaheadPill("Active")
                  .environment(\.active, true)
              }
              
              HStack {
                TypeaheadPill("Hovering")
                  .environment(\.hovering, true)
                
                TypeaheadPill("Hovering/Focus")
                  .environment(\.hovering, true)
                  .environment(\.focus, true)
              }
              
              TypeaheadPill("Default")
                .environment(\.hovering, true)
                .environment(\.active, true)
                .environment(\.focus, true)
              
            }
            .padding(2)
          }
        }
        
        PBDoc(title: "With icons") {
          HStack {
            TypeaheadPill("Desktop", icon: .desktop)
            TypeaheadPill("Laptop", icon: .laptop)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Pill")
  }
}
