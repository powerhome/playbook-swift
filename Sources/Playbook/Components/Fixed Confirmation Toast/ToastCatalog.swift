//
//  SwiftUIView.swift
//
//
//  Created by Isis Silva on 18/10/23.
//

import SwiftUI

public struct ToastCatalog: View {
  let infoMessage = "Design & Handoff Process was moved to UX Designer Learning Track."
  @State private var toastView: PBToast?
  @State private var toastPosition: PBToast.Position = .top

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultToast }
        PBDoc(title: "Multi Line") { multiLine }
        PBDoc(title: "Click to Close") { clickToClose }
        PBDoc(title: "Simple") { positionButton }
        PBDoc(title: "Children") { children }
        PBDoc(title: "Dismiss with timer") { withTimer }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Dialog")
    .withToastHandling(toastView, position: toastPosition)
  }

  func closeDialog() {
    toastView = nil
  }

  var defaultToast: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error, dismissAction: .default { closeDialog() })
      PBToast(text: "Items Successfully Moved", variant: .success)
      PBToast(text: "Scan to Assign Selected Items", variant: .neutral)
    }
  }

  var multiLine: some View {
    PBToast(text: infoMessage, variant: .custom(.infoCircle, .pbPrimary))
  }

  var clickToClose: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error, dismissAction: .default { closeDialog() })
      PBToast(text: "Items Successfully Moved", variant: .success, dismissAction: .default { closeDialog() })
      PBToast(text: "Scan to Assign Selected Items", variant: .neutral, dismissAction: .default { closeDialog() })
    }
  }

  var positionButton: some View {
    HStack {
      PBButton(variant: .secondary, title: "Top Center") {
        toastPosition = .top
        toastView = PBToast(text: "Some mesage here", variant: .custom(.addressBook, .pink), dismissAction: .default { closeDialog() })
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        toastPosition = .bottom
        toastView = PBToast(text: "Some here", variant: .custom(.addressBook, .pink), dismissAction: .default { closeDialog() })
      }
    }
  }
  
  var children: some View {
    PBToast(
      text: infoMessage,
      variant: .success,
      dismissAction: .custom(
        AnyView(Text("Undo").pbFont(.title4, color: .white)),
        { closeDialog() }
      )
    )
  }
  
  var withTimer: some View {
    HStack {
      PBButton(variant: .secondary, title: "Top Center") {
        toastPosition = .top
        toastView = PBToast(text: "Some mesage here", variant: .custom(.addressBook, .pink), dismissAction: .withTimer(3, { closeDialog() }))
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        toastPosition = .bottom
        toastView = PBToast(text: "Some here", variant: .custom(.addressBook, .pink), dismissAction: .withTimer(2, { closeDialog() }))
      }
    }
  }
}
