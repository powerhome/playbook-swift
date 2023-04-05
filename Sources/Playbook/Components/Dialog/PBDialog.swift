//
//  PBDialog.swift
//
//
//  Created by Michael Campbell on 7/15/21.
//

import SwiftUI

public struct PBDialog<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode
  let content: Content?
  let title: String?
  let message: String?
  let variant: PBDialog.Variant
  let isStacked: Bool
  let cancelButton: (String, (() -> Void)?)?
  let cancelButtonStyle: PBButtonStyle
  let confirmButton: (String, (() -> Void))?
  let confirmButtonStyle: PBButtonStyle
  let onClose: (() -> Void)?
  let size: Size
  let shouldCloseOnOverlay: Bool

  public init(
    title: String? = nil,
    message: String? = nil,
    variant: PBDialog.Variant = .default,
    isStacked: Bool = false,
    cancelButton: (String, (() -> Void)?)? = nil,
    cancelButtonStyle: PBButtonStyle = PBButtonStyle(variant: .link),
    confirmButton: (String, (() -> Void))? = nil,
    confirmButtonStyle: PBButtonStyle = PBButtonStyle(variant: .primary),
    onClose: (() -> Void)? = nil,
    size: Size = .medium,
    shouldCloseOnOverlay: Bool = true,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.content = content()
    self.title = title
    self.message = message
    self.variant = variant
    self.isStacked = isStacked
    self.cancelButton = cancelButton
    self.cancelButtonStyle = cancelButtonStyle
    self.confirmButton = confirmButton
    self.confirmButtonStyle = confirmButtonStyle
    self.onClose = onClose
    self.size = size
    self.shouldCloseOnOverlay = shouldCloseOnOverlay
  }

  public var body: some View {
    dialogView()
      .frame(maxWidth: size.width)
      .padding(EdgeInsets(top: 0, leading: size.padding, bottom: 0, trailing: size.padding))
      .onTapGesture {
        if shouldCloseOnOverlay {
          if let onClose = onClose {
            onClose()
          } else {
            dismissDialog()
          }
        }
      }
  }

  private func dialogView() -> some View {
    return PBCard(alignment: .center, padding: .pbNone) {
      switch variant {
      case .default:
        if let title = title {
          PBDialogHeaderView(title: title) { dismissDialog() }
          PBSectionSeparator()
        }

        if let message = message {
          Text(message)
            .pbFont(.body())
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
        }
        content
      case .status(let status):
        PBStatusDialogView(status: status, title: title ?? "", description: message ?? "")
          .frame(maxWidth: Size.medium.width)
      }

      if let confirmButton = confirmButton {
        PBDialogActionView(
          isStacked: isStacked,
          confirmButton: confirmButton,
          confirmButtonStyle: confirmButtonStyle,
          cancelButton: cancelButtonAction(),
          cancelButtonStyle: cancelButtonStyle
        )
        .padding()
      }
    }
  }

  func cancelButtonAction() -> (String, (() -> Void))? {
    if let cancelButton = cancelButton {
      if let cancelButtonAction = cancelButton.1 {
        return (cancelButton.0, cancelButtonAction)
      } else {
        return (cancelButton.0, { dismissDialog() })
      }
    } else {
      return nil
    }
  }

  func dismissDialog() {
    presentationMode.wrappedValue.dismiss()
  }
}

public extension PBDialog {
  enum Size: String, CaseIterable {
    case small
    case medium
    case large

    var padding: CGFloat { 32 }

    var width: CGFloat {
      switch self {
      case .small: return 300
      case .medium: return 500
      case .large: return 800
      }
    }
  }

  enum Variant {
    case `default`
    case status(_ status: DialogStatus)
  }
}

struct PBBDialog_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    let infoMessage = "This is a message for informational purposes only and requires no action."

    func foo() {
      print("alal")
    }

    return Group {
      PBDialog(
        title: "This is some informative text",
        message: infoMessage,
        cancelButton: ("Cancel", foo),
        confirmButton: ("Okay", foo)
      )
      .backgroundViewModifier(alpha: 0.2)
      .previewDisplayName("Simple")

      PBDialog(
        title: "Header header",
        cancelButton: ("Back", foo),
        confirmButton: ("Send My Issue", foo),
        content: ({
          ScrollView {
            Image(systemName: "person")
              .resizable()
              .aspectRatio(contentMode: .fit)

            Text("Hello Complex Dialog!\n Anything can be placed here")
              .pbFont(.title2)
              .multilineTextAlignment(.center)
          }
          .padding()
        }))
      .backgroundViewModifier(alpha: 0.2)
      .previewDisplayName("Complex")

      List(PBDialog<EmptyView>.Size.allCases, id: \.self) { size in
        PBDialog(
          title: "\(size.rawValue.capitalized) Dialog",
          message: infoMessage,
          cancelButton: ("Cancel", foo),
          confirmButton: ("Okay", foo),
          size: size
        )
        .backgroundViewModifier(alpha: 0.2)
      }
      .previewDisplayName("Size")

      List {
        Section("stacked") {
          HStack {
            PBDialog(
              title: "Success!",
              message: infoMessage,
              variant: .status(.success),
              isStacked: true,
              cancelButton: ("Cancel", foo),
              cancelButtonStyle: PBButtonStyle(variant: .secondary),
              confirmButton: ("Okay", foo),
              size: .small
            )

            PBDialog(
              title: "Error!",
              message: infoMessage,
              variant: .status(.error),
              isStacked: true,
              confirmButton: ("Okay", foo),
              size: .small
            )

          }
          .backgroundViewModifier(alpha: 0.2)
          .frame(maxWidth: .infinity)
        }

        Section("Default") {
          PBDialog(
            title: "Caution!",
            message: infoMessage,
            variant: .status(.caution),
            isStacked: false,
            cancelButton: ("Cancel", foo),
            cancelButtonStyle: PBButtonStyle(variant: .secondary),
            confirmButton: ("Okay", foo),
            size: .small
          )
          .backgroundViewModifier(alpha: 0.2)
          .frame(maxWidth: .infinity)
        }
      }
      .previewDisplayName("Stacked")

      List(DialogStatus.allCases, id: \.self) { status in
        Section(status.rawValue) {
            PBDialog(
              title: status.rawValue.capitalized,
              message: infoMessage,
              variant: .status(status),
              isStacked: false,
              cancelButton: ("Cancel", foo),
              cancelButtonStyle: PBButtonStyle(variant: .secondary),
              confirmButton: ("Okay", foo)
            )
            .frame(maxWidth: .infinity)
          .backgroundViewModifier(alpha: 0.2)
        }
      }
      .previewDisplayName("Status")
    }
  }
}
