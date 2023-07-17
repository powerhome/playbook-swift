//
//  NavigationCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct NavigationCatalog: View {
  @State private var selected: NavOptions = .op1

  enum NavOptions: String, Identifiable, CaseIterable {
    var id: String { rawValue }

    case op1 = "Option 1"
    case op2 = "Option 2"
    case op3 = "Option 3"
  }

  public var body: some View {
    List {

      Section("Default ") {
        PBNavigation(
          NavOptions.allCases,
          selected: $selected,
          variant: .normal,
          orientation: .vertical
        ) { option in
          Label {
            Text("\(option.rawValue)")
          } icon: {
            Image(systemName: "person")
          }
        }
      }

      Section("Default with icons") {
        PBNavigation(
          NavOptions.allCases,
          selected: $selected,
          variant: .normal,
          orientation: .vertical
        ) { option in
          Label {
            Text("\(option.rawValue)")
          } icon: {
            Image(systemName: "person")
          }
        }
      }

      Section("Default") {

        PBNavigation(
          NavOptions.allCases,
          selected: $selected,
          variant: .normal,
          orientation: .horizontal
        ) { option in
          Label {
            Text("\(option.rawValue)")
          } icon: {
            Image(systemName: "person")
          }
        }
      }

      Section("Subtle") {

        PBNavigation(
          NavOptions.allCases,
          selected: $selected,
          variant: .subtle,
          orientation: .horizontal
        ) { option in
          Label {
            Text("\(option.rawValue)")
          } icon: {
            Image(systemName: "person")
          }
        }
      }

      Section("Subtle") {
        PBNavigation(
          NavOptions.allCases,
          selected: $selected,
          variant: .subtle,
          orientation: .vertical
        ) { option in
          Label {
            Text("\(option.rawValue)")
          } icon: {
            Image(systemName: "person")
          }
        }
      }
    }
  }
}
