//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PopoverCatalog: View {
  @State var viewFrame1: CGRect = .zero
  @State var viewFrame2: CGRect = .zero
  @State var viewFrame3: CGRect = .zero
  @State var viewFrame4: CGRect = .zero
  @State var viewFrame5: CGRect = .zero
  @State var viewFrame6: CGRect = .zero
  @State var popoverValue: AnyView?

  public init() {}

  public var body: some View {
    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "Scroll") { scrollPopover }
        PBDoc(title: "Close options") { onClosePopover }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .preferredColorScheme(.light)
    .withPopoverHandling(popoverValue)
    .navigationTitle("Popover")
  }

  private func closePopover() {
    popoverValue = nil
  }

  private var defaultPopover: some View {
    HStack {
      Text("Click info for more details")
        .pbFont(.body, color: .text(.default))

      PBButton(
        variant: .secondary,
        shape: .circle,
        icon: .fontAwesome(.info)
      ) {
        popoverValue = AnyView(
          PBPopover(parentFrame: $viewFrame1, dismissAction: closePopover) {
            Text("I'm a popover. I can show content of any size.")
              .pbFont(.body, color: .text(.default))
          }
        )
      }
      .frameGetter($viewFrame1)
    }
  }

  private var dropdownPopover: some View {
    PBButton(
      variant: .secondary,
      title: "Filter By",
      icon: .fontAwesome(.chevronDown),
      iconPosition: .right
    ) {
      popoverValue = AnyView(
        PBPopover(cardPadding: Spacing.none, parentFrame: $viewFrame2, dismissAction: closePopover) {
          List {
            PBButton(variant: .link, title: "Popularity")
            PBButton(variant: .link, title: "Title")
            PBButton(variant: .link, title: "Duration")
            PBButton(variant: .link, title: "Date Started")
            PBButton(variant: .link, title: "Date Ended")
          }
          .listStyle(.plain)
          .frame(width: 150, height: 100)
          .pbFont(.body, color: .text(.light))
        }
      )
    }
    .frameGetter($viewFrame2)
  }

  private var onClosePopover: some View {
    VStack(spacing: Spacing.medium) {
      PBButton(
        variant: .secondary,
        title: "Click Inside"
      ) {
        popoverValue = AnyView(
          PBPopover(shouldClosePopover: .inside, parentFrame: $viewFrame3, dismissAction: closePopover) {
            Text("Click on me!")
              .pbFont(.body, color: .text(.default))
          }
        )
      }
      .frameGetter($viewFrame3)

      PBButton(
        variant: .secondary,
        title: "Click Outside"
      ) {
        popoverValue = AnyView(
          PBPopover(position: .top, shouldClosePopover: .outside, parentFrame: $viewFrame4, dismissAction: closePopover) {
            Text("Click anywhere but me!")
              .pbFont(.body, color: .text(.default))
          }
        )
      }
      .frameGetter($viewFrame4)

      PBButton(
        variant: .secondary,
        title: "Click Anywhere"
      ) {
        popoverValue = AnyView(
          PBPopover(position: .right, shouldClosePopover: .anywhere, parentFrame: $viewFrame5, dismissAction: closePopover) {
            Text("Click anything!")
              .pbFont(.body, color: .text(.default))
          }
        )
      }
      .frameGetter($viewFrame5)
    }
  }

  private var scrollPopover: some View {
    PBButton(
      variant: .secondary,
      title: "Click Me"
    ) {
      popoverValue = AnyView(
        PBPopover(position: .right, parentFrame: $viewFrame6, dismissAction: closePopover) {
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
          .frame(width: 200, height: 150)
        }
      )
    }
    .frameGetter($viewFrame6)
  }
}
