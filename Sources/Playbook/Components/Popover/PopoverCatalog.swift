//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PopoverCatalog: View {
  @State private var scrollPosition: CGPoint = .zero

  public var body: some View {
    let defaultPopover = HStack {
      Text("Click info for more details")
        .pbFont(.body, color: .text(.default))
      PBPopover(
        scrollOffset: $scrollPosition,
        content: {
          Text("I'm a popover. I can show content of any size.")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, shape: .circle, icon: .fontAwesome(.info))
        }
      )
    }

    let dropdownPopover = PBPopover(
      position: .center((0, 0)),
      padding: Spacing.none,
      popoverWidth: 140,
      scrollOffset: $scrollPosition,
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
        dismissOptions: .inside,
        scrollOffset: $scrollPosition,
        content: {
          Text("Click on me!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Inside")
        })

      PBPopover(
        position: .top((0, 0)),
        dismissOptions: .outside,
        scrollOffset: $scrollPosition,
        content: {
          Text("Click anywhere but me!")
            .pbFont(.body, color: .text(.light))
      }, label: {
        PBButton(variant: .secondary, title: "Click Outside")
      })

      PBPopover(
        position: .right((0, 0)),
        dismissOptions: .anywhere,
        scrollOffset: $scrollPosition,
        content: {
          Text("Click anything!")
            .pbFont(.body, color: .text(.light))
        }, label: {
          PBButton(variant: .secondary, title: "Click Anywhere")
        })
    }

    let scrollPopover = PBPopover(
      position: .right((0, 130)),
      popoverWidth: 250,
      scrollOffset: $scrollPosition,
      content: {
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
        PBDoc(title: "Close options") { closePopover }
        PBDoc(title: "Scroll") { scrollPopover }
      }
      .padding(Spacing.medium)
      .background(GeometryReader { geometry in
        Color.clear
          .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
      })
      .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
        self.scrollPosition = value
        print("Scroll offset: \(scrollPosition.y)")
      }
    }
    .coordinateSpace(name: "scroll")
    .background(Color.background(Color.BackgroundColor.light))
    .preferredColorScheme(.light)
    .navigationTitle("Popover")
  }
}
