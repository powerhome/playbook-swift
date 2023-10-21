//
//  SwiftUIView.swift
//
//
//  Created by Isis Silva on 18/10/23.
//

import SwiftUI

public struct ToastCatalog: View {
  let infoMessage = "This is a message for informational purposes only and requires no action."
  @State private var toastView: PBToast?

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultToast }
        PBDoc(title: "Multi Line") { multiLine }
        PBDoc(title: "Click to Close") { clickToClose }
        PBDoc(title: "Simple") { simpleButton }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Dialog")
    .withToastHandling(toastView)
  }

  func closeDialog() {
    toastView = nil
  }

  var simpleButton: some View {
    PBButton(title: "Simple") {
      toastView = PBToast(text: "Some mesage here", variant: .custom(.addressBook, .pink), dismissAction: .default { closeDialog() })
    }
  }

  var defaultToast: some View {
    VStack(alignment: .leading) {
      PBToast(text: "Error Message", variant: .error)
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
}
