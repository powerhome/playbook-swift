//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PopoverCatalog: View {
  @State private var scrollPosition: CGPoint = .zero
  @State private var tabHeight: CGFloat = .zero
  @State var viewFrame1: CGRect = .zero
  @State var viewFrame2: CGRect = .zero
  @State var viewFrame3: CGRect = .zero
  @State var viewFrame4: CGRect = .zero
  @State var viewFrame5: CGRect = .zero
  @State var viewFrame6: CGRect = .zero
  @State var isPresente1: Bool = false
  @State var isPresente2: Bool = false
  @State var isPresente3: Bool = false
  @State var isPresente4: Bool = false
  @State var isPresente5: Bool = false
  @State var isPresente6: Bool = false
  
  @State var popoverValue: AnyView?

  public init() {
  
    
  }

  public var body: some View {
    let defaultPopover = HStack {
      Text("Click info for more details")
        .pbFont(.body, color: .text(.default))

      PBButton(
        variant: .secondary,
        shape: .circle,
        icon: .fontAwesome(.info)
      ) {
        popoverValue = AnyView(PBPopover(parentFrame: $viewFrame1) {
        
          Text("I'm a popover. I can show content of any size.")
                  .pbFont(.body, color: .text(.default))
       })
      }
      .frameGetter($viewFrame1)
     
    }

    let dropdownPopover = PBButton(
      variant: .secondary,
      title: "Filter By",
      icon: .fontAwesome(.chevronDown),
      iconPosition: .right
    ) {
      isPresente2 = true
    }
      .frameGetter($viewFrame2)

    let closePopover = VStack(spacing: Spacing.medium) {
      PBButton(
        variant: .secondary,
        title: "Click Inside"
      ) {
        isPresente3 = true
      }
      .frameGetter($viewFrame3)

      PBButton(
        variant: .secondary,
        title: "Click Outside"
      ) {
        isPresente4 = true
      }
      .frameGetter($viewFrame4)

      PBButton(
        variant: .secondary,
        title: "Click Anywhere"
      ) {
        isPresente5 = true
      }
      .frameGetter($viewFrame5)
    }

    let scrollPopover = PBButton(
      variant: .secondary,
      title: "Click Me"
    ) {
      isPresente6 = true
    }
      .frameGetter($viewFrame6)

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultPopover }
         
        PBDoc(title: "Dropdrown") { dropdownPopover }
        PBDoc(title: "Scroll") { scrollPopover }
        PBDoc(title: "Close options") { closePopover }
      }
      .padding(Spacing.medium)
      

    }
    .background(Color.background(.light))
    .preferredColorScheme(.light)
    
//    .pbPopover(isPresented: $isPresente1, position: .bottom(), viewFrame: $viewFrame1) {
//      Text("I'm a popover. I can show content of any size.")
//        .pbFont(.body, color: .text(.default))
//    }
//    .pbPopover(isPresented: $isPresente2, position: .bottom(), cardPadding: Spacing.none, viewFrame: $viewFrame2) {
//      List {
//        PBButton(variant: .link, title: "Popularity")
//        PBButton(variant: .link, title: "Title")
//        PBButton(variant: .link, title: "Duration")
//        PBButton(variant: .link, title: "Date Started")
//        PBButton(variant: .link, title: "Date Ended")
//      }
//      .listStyle(.plain)
//      .frame(width: 150, height: 100)
//      .pbFont(.body, color: .text(.light))
//    }
//    .pbPopover(
//      isPresented: $isPresente3,
//      position: .bottom(),
//      shouldClosePopover: .inside,
//      viewFrame: $viewFrame3
//    ) {
//      Text("Click on me!")
//        .pbFont(.body, color: .text(.default))
//    }
//    .pbPopover(
//      isPresented: $isPresente4,
//      position: .top(),
//      shouldClosePopover: .outside,
//      viewFrame: $viewFrame4
//    ) {
//      Text("Click anywhere but me!")
//        .pbFont(.body, color: .text(.default))
//    }
//    .pbPopover(
//      isPresented: $isPresente5,
//      position: .right(),
//      shouldClosePopover: .anywhere,
//      viewFrame: $viewFrame5
//    ) {
//      Text("Click anything!jsfc[pwJFC[jwfc[jqw[ovjpqnevonq[onvponqw")
//        .pbFont(.body, color: .text(.default))
//    }
//    .pbPopover(
//      isPresented: $isPresente6,
//      position: .right(),
//      viewFrame: $viewFrame6
//    ) {
//      ScrollView {
//        Text(
//          """
//          So many people live within unhappy circumstances and yet will not take
//          the initiative to change their situation
//          because they are conditioned to a life of security,
//          conformity, and conservation, all of which may appear to give one peace of mind,
//          but in reality, nothing is more damaging to the adventurous spirit.
//          - Christopher McCandless
//          """
//        )
//        .multilineTextAlignment(.leading)
//        .pbFont(.body, color: .text(.default))
//      }
//      .frame(width: 200, height: 150)
//    }
    .navigationTitle("Popover")
    .withPopoverHandling(popoverValue)
  }

}
