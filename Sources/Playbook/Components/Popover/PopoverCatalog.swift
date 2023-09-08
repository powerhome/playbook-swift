//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

@available(iOS 16.4, *)
public struct PopoverCatalog: View {
  @State private var scrollPosition: CGPoint = .zero
  @State private var tabHeight: CGFloat = .zero

  public init() {}

  public var body: some View {
    let defaultPopover = HStack {
      Text("Click info for more details")
        .pbFont(.body, color: .text(.default))

      PBButton(variant: .secondary, shape: .circle, icon: .fontAwesome(.info)).popup {
        Text("I'm a popover. I can show content of any size.")
          .pbFont(.body, color: .text(.light))
      }
        }

    let dropdownPopover = PBButton(
          variant: .secondary,
          title: "Filter By",
          icon: .fontAwesome(.chevronDown),
          iconPosition: .right
        ).popup {
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
        }

    let closePopover = VStack(spacing: Spacing.medium) {

      PBButton(variant: .secondary, title: "Click Inside").popup {
        Text("Click on me!").pbFont(.body, color: .text(.light))
      }

      PBButton(variant: .secondary, title: "Click Outside").popup {
        Text("Click anywhere but me!").pbFont(.body, color: .text(.light))
      }

      PBButton(variant: .secondary, title: "Click Anywhere").popup {
        Text("Click anything!")
      }
    }

    let scrollPopover = PBButton(variant: .secondary, title: "Click Me").popup {
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
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "Close options") { closePopover }
        PBDoc(title: "Scroll") { scrollPopover }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .preferredColorScheme(.light)
    .navigationTitle("Popover")
  }
}
