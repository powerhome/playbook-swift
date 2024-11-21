//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverCatalog.swift
//

import SwiftUI

public struct PopoverCatalog: View {
  @State private var isPresented1: Bool = false
  @State private var isPresented2: Bool = false
  @State private var isPresented3: Bool = false
  @State private var isPresented4: Bool = false
  @State private var isPresented5: Bool = false
  @State private var isPresented6: Bool = false
    @State private var isPresented7: Bool = false

  public init() {}
  
  public var body: some View {
    return PBDocStack(title: "Popover") {
      PBDoc(title: "Default") { defaultPopover }
      PBDoc(title: "Dropdrown") { dropdownPopover }
      PBDoc(title: "Scroll") { scrollPopover }
      PBDoc(title: "Close options") { onClosePopover }
        PBDoc(title: "Explorarion Popover") { explorationPopover }
            .padding(.bottom, 500)
            .edgesIgnoringSafeArea(.all)
    }
    .popoverHandler(id: 1)
    .popoverHandler(id: 2)
    .popoverHandler(id: 3)
    .popoverHandler(id: 4)
    .popoverHandler(id: 5)
    .popoverHandler(id: 6)
    .navigationTitle("Popover")
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
        isPresented1.toggle()
      }
      .pbPopover(
        isPresented: $isPresented1,
        id: 1
      ) {
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
      isPresented2.toggle()
    }
    .pbPopover(
      isPresented: $isPresented2,
      id: 2,
      position: .center(0, 4)
    ) {
      List {
        VStack(spacing: Spacing.small) {
          PBButton(variant: .link, title: "Popularity")
            .frame(maxWidth: .infinity, alignment: .leading)
          PBButton(variant: .link, title: "Title")
            .frame(maxWidth: .infinity, alignment: .leading)
          PBButton(variant: .link, title: "Duration")
            .frame(maxWidth: .infinity, alignment: .leading)
          PBButton(variant: .link, title: "Date Started")
            .frame(maxWidth: .infinity, alignment: .leading)
          PBButton(variant: .link, title: "Date Ended")
            .frame(maxWidth: .infinity, alignment: .leading)
        }
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .listStyle(.plain)
      .frame(width: 150, height: 100)
    }
  }

  private var onClosePopover: some View {
    VStack(spacing: Spacing.medium) {
      PBButton(
        variant: .secondary,
        title: "Click Inside"
      ) {
        isPresented3.toggle()
      }
      .pbPopover(
        isPresented: $isPresented3,
        id: 3,
        clickToClose: (.inside, action: {})
      ) {
        Text("Click on me!")
          .pbFont(.body, color: .text(.default))
      }

      PBButton(
        variant: .secondary,
        title: "Click Outside"
      ) {
        isPresented4.toggle()
      }
      .pbPopover(
        isPresented: $isPresented4,
        id: 4,
        position: .top(),
        clickToClose: (.outside, action: {})
      ) {
        Text("Click anywhere but me!")
          .pbFont(.body, color: .text(.default))
      }

      PBButton(
        variant: .secondary,
        title: "Click Anywhere"
      ) {
        isPresented5.toggle()
      }
      .pbPopover(
        isPresented: $isPresented5,
        id: 5,
        position: .trailing(),
        clickToClose: (.anywhere, action: {})
      ) {
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
      isPresented6.toggle()
    }
    .pbPopover(isPresented: $isPresented6, id: 6) {
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

    @State private var viewFrame: CGRect = .zero
    private var explorationPopover: some View {
      HStack {
        Text("This is an exploration Popover")
          .pbFont(.body, color: .text(.default))
          .frameReader { viewFrame = $0 }
        PBButton(
          variant: .secondary,
          shape: .circle,
          icon: .fontAwesome(.info)
        ) {
          isPresented7.toggle()
        }
        .handlerPopoverController(
          isPresented: $isPresented7,
          position: CGPoint(x: viewFrame.midX, y: viewFrame.maxY)
        ) {
          Text("I'm a popover. I can show content of any size.")
            .pbFont(.body, color: .text(.default))
        }
      }
    }
}
