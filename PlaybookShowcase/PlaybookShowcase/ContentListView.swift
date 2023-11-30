//
//  ContentListView.swift
//  PlaybookShowcase-iOS
//
//  Created by Isis Silva on 4/19/23.
//

import SwiftUI
import Playbook
#if os(iOS)
import UIKit
#endif

@available(macOS 13.3, *)
@available(iOS 16.4, *)
struct ContentListView: View {

  #if os(iOS)
  init() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white
    appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.text(.default))]
    appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.pbPrimary)]
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
  #endif

  @State var selectedItem: Int = 0
  var body: some View {
    NavigationStack {
      contentView.padding(.bottom, 80)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            playbookLogo
          }
        }
        .background {
          Color.background(.light)
        }
        .overlay {
          VStack {
            Spacer()
            bottomBar
          }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    #if os(iOS)
    .navigationViewStyle(.stack)
#endif
  }

  var bottomBar: some View {
    PBNav(
      selected: $selectedItem,
      variant: .subtle,
      orientation: .horizontal
    ) {
      PBNavItem(DesignElements.title)
      PBNavItem(Components.title)
    }
    .offset(y: -8)
    .frame(maxWidth: .infinity, minHeight: 80)
    .background(Color.white)
  }

  @ViewBuilder
  private var contentView: some View {
    if selectedItem == 0 {
      designElementsView
    } else {
      componentsView
    }
  }

  private var playbookLogo: some View {
    HStack {
      Image("Playbook")
      Text("Playbook")
        .pbFont(.title4, variant: .link)
    }
  }

  private var componentsView: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
        Text(Components.title).pbFont(.title3)
        VStack(spacing: Spacing.small) {
          ForEach(Components.allCases, id: \.self) { element in
            NavigationLink {
              element.destination
            } label: {
              PBCard(borderRadius: BorderRadius.large, padding: Spacing.small, shadow: .deep) {
                HStack {
                  Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                    .multilineTextAlignment(.leading)
                  PBIcon.fontAwesome(.chevronRight, size: .small)
                    .foregroundColor(.text(.default))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
              }
            }
            .buttonStyle(.plain)
          }
        }

      }
    }
    .padding()
  }

  private var designElementsView: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
        Text(DesignElements.title).pbFont(.title3)
        VStack(spacing: Spacing.small) {
          ForEach(DesignElements.allCases, id: \.self) { element in
            NavigationLink {
              element.destination
            } label: {
              PBCard(borderRadius: BorderRadius.large, padding: Spacing.small, shadow: .deep) {
                HStack {
                  PBIcon.fontAwesome(element.icon, size: .small).foregroundColor(.black)
                  Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                    .multilineTextAlignment(.leading)
                  PBIcon.fontAwesome(.chevronRight, size: .small)
                    .foregroundColor(.text(.default))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
              }
            }
            .buttonStyle(.plain)
          }
        }
      }
    }
    .padding()
  }
}

@available(macOS 13.3, *)
@available(iOS 16.4, *)
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return ContentListView()
  }
}
