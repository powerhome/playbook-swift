//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PopoverCatalog: View {
  public var body: some View {

    struct SimplePopover: View {

      var body: some View {
        HStack {
          Text("Click info for more details")
            .pbFont(.body, color: .text(.default))
          PBPopover(
            content: {
              
                Text("Testando o Popover. Vamo!!!!")
                  .pbFont(.body, color: .text(.light))
            
            },
            label: {
              PBButton(variant: .secondary, shape: .circle, icon: .fontAwesome(.info))
            },
            onClose: {
              print("ISs")
            }
          )
        }
      }
    }

    struct ComplexPopover: View {
      var body: some View {
        HStack {
          Text("Click info for more details")
            .pbFont(.body, color: .text(.default))
          PBPopover(
            content: {
              PBCard {
                Text("Testando o Popover. Vamo!!!!")
                  .pbFont(.body, color: .text(.light))
              }
            },
            label: {
              PBButton(variant: .secondary, shape: .circle, icon: .fontAwesome(.info))
            },
            onClose: {
              print("ISs")
            }
          )
        }
      }
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { SimplePopover() }
        PBDoc(title: "Dropdrown") { ComplexPopover() }
        PBDoc(title: "Close options") { SimplePopover() }
        PBDoc(title: "Scroll") { ComplexPopover() }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Popover")
  }
}
