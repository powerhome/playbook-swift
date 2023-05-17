//
//  NavigationCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct NavigationCatalog: View {

  public init () {}

  enum NavOptions: String, Identifiable, CaseIterable {
    var id: String { rawValue }

    case op1 = "Option 1"
    case op2 = "Option 2"
    case op3 = "Option 3"
  }

  public var body: some View {
    List {
      Section("Normal") {
        VStack(spacing: 20) {
          PBNavigation(
            NavOptions.allCases,
            selected: .constant(NavOptions.op1),
            variant: .normal,
            orientation: .horizontal
          ) { option in
            Label {
              Text("\(option.rawValue)")
            } icon: {
              Image(systemName: "person")
            }
          }
          PBNavigation(
            NavOptions.allCases,
            selected: .constant(NavOptions.op1),
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
      }

      Section("Subtle") {
        VStack(spacing: 20) {
          PBNavigation(
            NavOptions.allCases,
            selected: .constant(NavOptions.op1),
            variant: .subtle,
            orientation: .horizontal
          ) { option in
            Label {
              Text("\(option.rawValue)")
            } icon: {
              Image(systemName: "person")
            }
          }

          PBNavigation(
            NavOptions.allCases,
            selected: .constant(NavOptions.op1),
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
}
