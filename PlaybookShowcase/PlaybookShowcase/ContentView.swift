//
//  ContentView.swift
//  PlaybookShowcase-iOS
//
//  Created by Isis Silva on 4/19/23.
//

import SwiftUI
import Playbook

struct ContentView: View {
  @State var selectedItem: Int = 0
  let columns = Array(repeating: GridItem(.flexible()), count: 2)
  var body: some View {
    NavigationView {
      contentView
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            HStack {
              Image("Playbook")
              Text("Playbook")
                .pbFont(.title4, variant: .link)
            }
          }
        }
        .background {
          Color.pbBackgroundLight
        }
        .overlay {
          VStack {
            Spacer()
            bottomBar
          }
        }
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
      PBNavItem(Componenets.title)
    }
    .frame(maxWidth: .infinity)
    .background(Color.white)
  }

  @ViewBuilder
  var contentView: some View {
    ScrollView {
      VStack(alignment: .leading) {
        if selectedItem == 0 {
          Text(DesignElements.title).pbFont(.title3)
          LazyVGrid(columns: columns) {
            ForEach(DesignElements.allCases, id: \.self) { element in
              NavigationLink {
                element.destination
              } label: {
                PBCard(padding: .pbXsmall, shadow: .deep) {
                  HStack {
                    PBIcon.fontAwesome(.cog, size: .small).foregroundColor(.black)
                    Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                  }
                }
              }
            }
          }
        } else {
          Text(Componenets.title).pbFont(.title3)
          LazyVGrid(columns: columns) {
            ForEach(Componenets.allCases, id: \.self) { element in
              NavigationLink {
                element.destination
              } label: {
                PBCard(padding: .pbXsmall, shadow: .deep) {
                  HStack {
                    PBIcon.fontAwesome(.cog, size: .small).foregroundColor(.black)
                    Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                  }
                }
              }
            }
          }
        }
      }
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return ContentView()
  }
}

enum DesignElements: String, CaseIterable {
  case color, shadows, typography, iconography, spacing
  static let title: String = "Design Elements"

  @ViewBuilder
  var destination: some View {
    switch self {
    case .color: EmptyView()
    case .shadows: PBShadow_Previews.previews
    case .typography: Typography_Previews.previews
    case .iconography: PBIcon_Previews.previews
    case .spacing: EmptyView()
    }
  }
}

enum Componenets: String, CaseIterable {
  case avatar, button, card, collapsible

  static let title: String = "Components"

  @ViewBuilder
  var destination: some View {
    switch self {
    case .avatar: PBAvatar_Previews.previews
    case .button: PBButtonStyle_Previews.previews
    case .card: PBCard_Previews.previews
    case .collapsible: PBCollapsible_Previews.previews
    }
  }
}
