//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PopoverCatalog: View {
  public var body: some View {
    let defaultPopover = HStack {
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
          print("Close action")
        }
      )
    }

    let dropdownPopover = PBPopover(padding: Spacing.none, content: {
      List {
        Text("Testando o Popover. Vamo!!!!")

        Text("Testando o Popover. Vamo!!!!")

        Text("Testando o Popover. Vamo!!!!")

      }
      .frame(width: 200, height: 100)
      .listStyle(.plain)
      .pbFont(.body, color: .text(.light))
    },
                                    label: {
      PBButton(
        variant: .secondary,
        title: "Filter By",
        icon: .fontAwesome(.chevronDown),
        iconPosition: .right
      )
    }, onClose: {
      print("Close action")
    }
    )

    let withBAckgroudPopover = PBPopover(backgroundAlpha: 0.2, content: {
      Text("Testando o Popover. Vamo!!!!")
        .pbFont(.body, color: .text(.light))
    }, label: {
      PBButton(
        variant: .secondary,
        title: "Click Me"
      )
    }, onClose: {
      print("Close action")
    }
    )

    let closePopover = VStack(spacing: Spacing.medium) {
      PBPopover(position: .bottom,
        content: {
          Text("Testando o Popover. Vamo!!!!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Inside")
        },
        onClose: {
          print("Close action")
        }
      )

      PBPopover(position: .top,
        content: {
          Text("Testando o Popover. Vamo!!!!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Outside")
        }, onClose: {
          print("Close action")
        }
      )

      PBPopover(position: .right, content: {
          Text("Testando o Popover. Vamo!!!!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Anywhere")
        }, onClose: {
          print("Close action")
        }
      )
    }

    let scrollPopover = PBPopover( content: {
        ScrollView {
          Text("Testando o Popover. Vamo!!!!")
            .pbFont(.body, color: .text(.light))
        }
        .frame(height: 100)
      }, label: {
        PBButton(variant: .secondary, title: "Click Me")
      }, onClose: {
        print("Close action")
      }
    )

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "With Background") { withBAckgroudPopover }
        PBDoc(title: "Close options") { closePopover }
        PBDoc(title: "Scroll") { scrollPopover }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Popover")
  }
}
