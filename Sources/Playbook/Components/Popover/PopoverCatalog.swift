//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PopoverCatalog: View {
  @State var isPresented: Bool = false
  @State var isPresented2: Bool = false
  @State var isPresented3: Bool = false
  @State var isPresented4: Bool = false
  @State var isPresented5: Bool = false
  @State var isPresented6: Bool = false
  @State var popoverValue: AnyView?
  @State var popoverValue2: AnyView?
  @State var popoverValue3: AnyView?
  @State var popoverValue4: AnyView?
  @State var popoverValue5: AnyView?
  @State var popoverValue6: AnyView?

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
    .withPopoverHandling(popoverValue2)
    .withPopoverHandling(popoverValue3)
    .withPopoverHandling(popoverValue4)
    .withPopoverHandling(popoverValue5)
    .withPopoverHandling(popoverValue6)
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
        isPresented.toggle()
      }
      .pbPopover(isPresented: $isPresented, $popoverValue) {
        Text("I'm a popover. I can show content of any size.")
          .pbFont(.body, color: .text(.default))
      }
    }
  }

  private var dropdownPopover: some View {
    PBButton(
      variant: .secondary,
      title: "Filter By",
      icon: .fontAwesome(.chevronDown),
      iconPosition: .right
    ) {
      isPresented2 = true
    }
    .pbPopover(isPresented: $isPresented2, $popoverValue2) {
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
  }

  private var onClosePopover: some View {
    VStack(spacing: Spacing.medium) {
      PBButton(
        variant: .secondary,
        title: "Click Inside"
      ) {
        isPresented3 = true
      }
      .pbPopover(isPresented: $isPresented3, $popoverValue3) {
        Text("Click on me!")
          .pbFont(.body, color: .text(.default))
      }

      PBButton(
        variant: .secondary,
        title: "Click Outside"
      ) {
        isPresented4 = true
      }
      .pbPopover(isPresented: $isPresented4, $popoverValue4) {
        Text("Click anywhere but me!")
          .pbFont(.body, color: .text(.default))
      }

      PBButton(
        variant: .secondary,
        title: "Click Anywhere"
      ) {
        isPresented5 = true
      }
      .pbPopover(isPresented: $isPresented5, $popoverValue5) {
        Text("Click anything!")
          .pbFont(.body, color: .text(.default))
      }
    }
  }

  private var scrollPopover: some View {
    PBButton(
      variant: .secondary,
      title: "Click Me"
    ) {
      isPresented6 = true
    }
    .pbPopover(isPresented: $isPresented6, $popoverValue6) {
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
  }
}
