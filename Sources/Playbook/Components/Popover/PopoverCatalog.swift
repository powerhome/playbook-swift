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
          Text("I'm a popover. I can show content of any size.")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, shape: .circle, icon: .fontAwesome(.info))
        }
      )
    }

    let dropdownPopover = PBPopover(
      position: .center,
      padding: Spacing.none,
      popoverWidth: 140,
      content: {
        List {
          PBButton(variant: .link, title: "Popularity")
          PBButton(variant: .link, title: "Title")
          PBButton(variant: .link, title: "Duration")
          PBButton(variant: .link, title: "Date Started")
          PBButton(variant: .link, title: "Date Ended")
        }
        .listStyle(.plain)
        .frame(height: 220)
        .pbFont(.body, color: .text(.light))
      }, label: {
        PBButton(
          variant: .secondary,
          title: "Filter By",
          icon: .fontAwesome(.chevronDown),
          iconPosition: .right
        )
      })

    let closePopover = VStack(spacing: Spacing.medium) {
      PBPopover(
        position: .bottom,
        dismissOptions: .inside,
        content: {
          Text("Click on me!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Inside")
        })

      PBPopover(
        position: .top,
        dismissOptions: .outside,
        content: {
          Text("Click anywhere but me!")
            .pbFont(.body, color: .text(.light))
      }, label: {
        PBButton(variant: .secondary, title: "Click Outside")
      })

      PBPopover(
        position: .right,
        dismissOptions: .anywhere,
        content: {
          Text("Click anything!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Anywhere")
        })
    }

    let scrollPopover = PBPopover(popoverWidth: 250, content: {
      ScrollView {
        Text(
          """
          So many people live within unhappy circumstances and yet will not take
          the initiative to change their situation
          because they are conditioned to a life of security,
          conformity, and conservation, all of which may appear to give one peace of mind,
          but in reality, nothing is more damaging to the adventurous spirit.
          - Christopher McCandless
          """
        )
        .multilineTextAlignment(.leading)
        .pbFont(.body, color: .text(.default))
      }
      .frame(height: 150)
    }, label: {
      PBButton(variant: .secondary, title: "Click Me")
    })

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        //      PBDoc(title: "With Background") { withBackgroudPopover }
        PBDoc(title: "Close options") { closePopover }
        PBDoc(title: "Scroll") { scrollPopover }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .preferredColorScheme(.light)
    .navigationTitle("Popover")
  }
}
