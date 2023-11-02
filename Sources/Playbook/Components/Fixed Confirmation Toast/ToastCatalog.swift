//
//  SwiftUIView.swift
//
//
//  Created by Isis Silva on 18/10/23.
//

import SwiftUI

public struct ToastCatalog: View {
  @State private var toastView: PBToast?
  @State private var toastPosition: PBToast.Position = .top

  private let message = "Design & Handoff Process was moved to UX Designer."

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultToast }
        PBDoc(title: "Multi Line") { multiLine }
        PBDoc(title: "Simple") { positionButton }
        PBDoc(title: "Children") { children }
        PBDoc(title: "Dismiss with timer") { withTimer }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Toast")
    .withToastHandling(toastView, position: toastPosition)
  }

  private func closeToast() {
    toastView = nil
  }

  private var defaultToast: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error, dismissAction: closeToast)
      PBToast(text: "Items Successfully Moved", variant: .success, dismissAction: closeToast)
      PBToast(text: "Scan to Assign Selected Items", variant: .neutral, dismissAction: closeToast)
    }
  }

  private var multiLine: some View {
    PBToast(text: message, variant: .custom(.infoCircle, .pbPrimary), dismissAction: closeToast)
  }

  private var clickToClose: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error, actionView: .default, dismissAction: closeToast)
      PBToast(text: "Items Successfully Moved", variant: .success, actionView: .default, dismissAction: closeToast)
      PBToast(text: "Scan to Assign Selected Items", variant: .neutral, actionView: .default, dismissAction: closeToast)
    }
  }

  private var positionButton: some View {
    HStack {
      PBButton(variant: .secondary, title: "Top Center") {
        toastPosition = .top
        toastView = PBToast(
          text: "Top Center",
          variant: .neutral,
          actionView: .default,
          dismissAction: closeToast
        )
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        toastPosition = .bottom
        toastView = PBToast(
          text: "Bottom Center",
          variant: .custom(.user, .pbPrimary),
          actionView: .default,
          dismissAction: closeToast
        )
      }
    }
  }

  private var children: some View {
    VStack(alignment: .leading) {
      PBToast(
        text: message,
        variant: .success,
        actionView: .custom(AnyView(Text("Undo").pbFont(.title4, color: .white))),
        dismissAction: closeToast
      )

      PBToast(
        variant: .custom(nil, .pbPrimary),
        actionView: .custom(
          AnyView(
            HStack {
              Text("Undo action").pbFont(.caption, color: .white)
              PBButton(variant: .primary, title: "Undo").disabled(true)
            }
          )),
        dismissAction: closeToast
      )
    }
  }

  private var withTimer: some View {
    HStack {
      PBButton(variant: .secondary, title: "Top Center") {
        toastPosition = .top
        toastView = PBToast(
          text: "Top Center",
          variant: .neutral,
          actionView: .withTimer(3),
          dismissAction: closeToast
        )
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        toastPosition = .bottom
        toastView = PBToast(
          text: "Bottom Center",
          variant: .neutral,
          actionView: .withTimer(2),
          dismissAction: closeToast
        )
      }
    }
  }
}
