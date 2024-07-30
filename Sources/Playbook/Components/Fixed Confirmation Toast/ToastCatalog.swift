//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ToastCatalog.swift
//

import SwiftUI

@available(iOS 16.0, *)
public struct ToastCatalog: View {
  @State private var toastView: PBToast?
  @State private var position: PBToast.Position = .top

  private let message = "Design & Handoff Process was moved to UX Designer."

  public var body: some View {
    PBDocStack(title: "Fixed Confirmation Toast") {
      PBDoc(title: "Default") { defaultToast }
      PBDoc(title: "Multi Line") { multiLine }
      PBDoc(title: "Simple") { positionButton }
      PBDoc(title: "Children") { children }
      PBDoc(title: "Dismiss with timer") { withTimer }
      PBDoc(title: "Custom Icon") { customIcon }
    }
    .withToastHandling(toastView, position: position)
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
    PBToast(
      text: message,
      variant: .custom(.infoCircle, .pbPrimary),
      dismissAction: closeToast
    )
  }

  private var clickToClose: some View {
    VStack(alignment: .leading) {
      PBToast(
        text: "Error Message",
        variant: .error,
        actionView: .default,
        dismissAction: closeToast
      )
      PBToast(
        text: "Items Successfully Moved",
        variant: .success,
        actionView: .default,
        dismissAction: closeToast
      )
      PBToast(
        text: "Scan to Assign Selected Items",
        variant: .neutral,
        actionView: .default,
        dismissAction: closeToast
      )
    }
  }

  private var positionButton: some View {
    return Grid {
      GridRow {
        PBButton(variant: .secondary, title: "Top Left") {
          position = .topLeft
          toastView = PBToast(
            text: "Top Left",
            variant: .neutral,
            actionView: .default,
            dismissAction: closeToast
          )
        }
        PBButton(variant: .secondary, title: "Top Right") {
          position = .topRight
          toastView = PBToast(
            text: "Top Right",
            variant: .neutral,
            actionView: .default,
            dismissAction: closeToast
          )
        }
      }
      GridRow {
        PBButton(variant: .secondary, title: "Top Center") {
          position = .top
          toastView = PBToast(
            text: "Top Center",
            variant: .neutral,
            actionView: .default,
            dismissAction: closeToast
          )
        }
        PBButton(variant: .secondary, title: "Bottom Center") {
          position = .bottom
          toastView = PBToast(
            text: "Bottom Center",
            variant: .custom(.user, .status(.neutral)),
            actionView: .default,
            dismissAction: closeToast
          )
        }
      }
      GridRow {
        PBButton(variant: .secondary, title: "Bottom Left") {
          position = .bottomLeft
          toastView = PBToast(
            text: "Bottom Left",
            variant: .custom(.user, .status(.neutral)),
            actionView: .default,
            dismissAction: closeToast
          )
        }
        PBButton(variant: .secondary, title: "Bottom Right") {
          position = .bottomRight
          toastView = PBToast(
            text: "Bottom Right",
            variant: .custom(.user, .status(.neutral)),
            actionView: .default,
            dismissAction: closeToast
          )
        }
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
        position = .top
        toastView = PBToast(
          text: "Top Center",
          variant: .neutral,
          actionView: .withTimer(3),
          dismissAction: closeToast
        )
      }

      PBButton(variant: .secondary, title: "Bottom Center") {
        position = .bottom
        toastView = PBToast(
          text: "Bottom Center",
          variant: .neutral,
          actionView: .withTimer(2),
          dismissAction: closeToast
        )
      }
    }
  }
  var customIcon: some View {
    VStack(alignment: .leading) {
      PBToast(
        text: "Fix before proceeding",
        variant: .custom(.wrench, Color.status(.error)),
        dismissAction: closeToast
      )
      PBToast(
        text: "Thank you for completing the form!",
        variant: .custom(.star, Color.status(.success)),
        dismissAction: closeToast
      )
      PBToast(
        text: "Saved as PDF",
        variant: .custom(.filePdf, Color.status(.neutral)),
        dismissAction: closeToast
      )
      PBToast(
        text: "New Messages",
        variant: .custom(.arrowDown, .pbPrimary),
        dismissAction: closeToast
      )
      
    }
  }
}
