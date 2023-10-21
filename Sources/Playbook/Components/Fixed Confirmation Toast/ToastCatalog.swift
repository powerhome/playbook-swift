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
        PBDoc(title: "Click to Close") { clickToClose }
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

  private func closeDialog() {
    toastView = nil
  }

  private var defaultToast: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error, dismissAction: .default { closeDialog() })
      PBToast(text: "Items Successfully Moved", variant: .success)
      PBToast(text: "Scan to Assign Selected Items", variant: .neutral)
    }
  }

  private var multiLine: some View {
    PBToast(text: message, variant: .custom(.infoCircle, .pbPrimary))
  }

  private var clickToClose: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error, dismissAction: .default { closeDialog() })
      PBToast(text: "Items Successfully Moved", variant: .success, dismissAction: .default { closeDialog() })
      PBToast(text: "Scan to Assign Selected Items", variant: .neutral, dismissAction: .default { closeDialog() })
    }
  }

  private var positionButton: some View {
    HStack {
      PBButton(variant: .secondary, title: "Top Center") {
        toastPosition = .top
        toastView = PBToast(
          text: "Top Center",
          variant: .neutral,
          dismissAction: .default { closeDialog() }
        )
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        toastPosition = .bottom
        toastView = PBToast(
          text: "Bottom Center",
          variant: .custom(.user, .pbPrimary),
          dismissAction: .default { closeDialog() }
        )
      }
    }
  }

  private var children: some View {
    PBToast(
      text: message,
      variant: .success,
      dismissAction: .custom(
        AnyView(Text("Undo").pbFont(.title4, color: .white)), { closeDialog() }
      )
    )
  }

  private var withTimer: some View {
    HStack {
      PBButton(variant: .secondary, title: "Top Center") {
        toastPosition = .top
        toastView = PBToast(
          text: "Top Center",
          variant: .neutral,
          dismissAction: .withTimer(3, { closeDialog() })
        )
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        toastPosition = .bottom
        toastView = PBToast(
          text: "Bottom Center",
          variant: .neutral,
          dismissAction: .withTimer(2, { closeDialog() })
        )
      }
    }
  }
}
