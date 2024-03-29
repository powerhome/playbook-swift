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
  @State private var isPresented: Bool = false
  @State private var isPresented2: Bool = false
  @State private var isPresented3: Bool = false
  @State private var isPresented4: Bool = false
  @State private var isPresented5: Bool = false
  @State private var isPresented6: Bool = false
  var popoverManager = PopoverManager()

  public init() {}

  public var body: some View {
    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "Scroll") { scrollPopover }
        PBDoc(title: "Close options") { onClosePopover }
        
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "Scroll") { scrollPopover }
        PBDoc(title: "Close options") { onClosePopover }
        
        
        PBDoc(title: "Default") { defaultPopover }
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "Scroll") { scrollPopover }
        PBDoc(title: "Close options") { onClosePopover }
      }
      .padding(Spacing.medium)
      .withPopoverHandling(popoverManager)
    }
    .background(Color.background(.light))
    .preferredColorScheme(.light)
  
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
        isPresented.toggle()
      }
      .pbPopover(
        isPresented: $isPresented,
        popoverManager: popoverManager
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
      position: .center(),
      popoverManager: popoverManager
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
        popoverManager: popoverManager
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
        position: .top(),
        popoverManager: popoverManager
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
        position: .trailing(),
        popoverManager: popoverManager) {
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
    .pbPopover(isPresented: $isPresented6, popoverManager: popoverManager) {
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
