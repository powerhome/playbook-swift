//
//  ContentListView.swift
//  PlaybookShowcase-iOS
//
//  Created by Isis Silva on 4/19/23.
//

import SwiftUI
import Playbook
import UIKit

@available(iOS 16.0, *)
struct ContentListView: View {
  @State var selectedItem: Int = 0
  let columns = Array(repeating: GridItem(.flexible()), count: 2)
  var body: some View {
    NavigationView {
      contentView.padding(.bottom, 80)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            HStack {
              Image("Playbook")
              Text("Playbook")
                .pbFont(.title4, variant: .link)
            }
          }
        }
        .toolbarBackground(.white)
        .toolbarBackground(.visible, for: .navigationBar)
        .background {
          Color.background(.light)
        }
        .overlay {
          VStack {
            Spacer()
            bottomBar
          }
        }
        .toolbar(.visible, for: .navigationBar)
        .edgesIgnoringSafeArea(.bottom)
    }
  }

  var bottomBar: some View {
    PBNav(
      selected: $selectedItem,
      variant: .subtle,
      orientation: .horizontal
    ) {
      PBNavItem(DesignElements.title)
        .environment(\.selected, selectedItem == 0 ? true : false)
        .environment(\.hovering, selectedItem == 0 ? true : false)
      PBNavItem(Componenets.title)
        .environment(\.selected, selectedItem == 1 ? true : false)
        .environment(\.hovering, selectedItem == 1 ? true : false)
    }
    .offset(y: -8)
    .frame(maxWidth: .infinity, minHeight: 80)
    .background(Color.white)
  }

  @ViewBuilder
  var contentView: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
        if selectedItem == 0 {
          Text(DesignElements.title).pbFont(.title3)
          LazyVGrid(columns: columns) {
            ForEach(DesignElements.allCases, id: \.self) { element in
              NavigationLink {
                element.destination
              } label: {
                PBCard(padding: Spacing.xSmall, shadow: .deep) {
                  HStack {
                    PBIcon.fontAwesome(element.icon, size: .small).foregroundColor(.black)
                    Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                  }
                }
              }
            }
          }
        } else {
          Text(Componenets.title).pbFont(.title3)
          ForEach(Componenets.allCases, id: \.self) { element in
            NavigationLink {
              element.destination
            } label: {
              PBCard(padding: Spacing.xSmall, shadow: .deep) {
                HStack {
                  Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                }
              }
            }
          }
        }
      }
      .padding()
    }
    .frame(maxWidth: .infinity)
  }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return ContentListView()
  }
}
