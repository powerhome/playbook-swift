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
  let text: String?
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
    text: String? = nil,
    isStacked: Bool = false,
    cancelButton: (String, (() -> Void)?)? = nil,
    cancelButtonStyle: PBButtonStyle = PBButtonStyle(variant: .link),
    confirmButton: (String, (() -> Void))? = nil,
    confirmButtonStyle: PBButtonStyle = PBButtonStyle(variant: .primary),
    onClose: (() -> Void)? = nil,
    size: Size = .medium,
    shouldCloseOnOverlay: Bool = true,
    @ViewBuilder _ content: (() -> Content) = { EmptyView() }
  ) {
    self.content = content()
    self.title = title
    self.text = text
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
      .padding(EdgeInsets(top: 0, leading: size.padding, bottom: 0, trailing: size.padding))
      .backgroundViewModifier(alpha: 0.2)
      .onTapGesture {
        if shouldCloseOnOverlay {
          if let onClose = onClose {
            onClose()
          } else {
            dismissDialog()
          }
        }
      }
      .edgesIgnoringSafeArea(.all)
  }

  private func dialogView() -> some View {
    return PBCard(padding: .pbNone) {
      DialogHeaderView(title: title) { dismissDialog() }
      PBSectionSeparator()

      if let text = text {
        Text(text).pbFont(.body()).lineLimit(nil)
          .fixedSize(horizontal: false, vertical: true).padding()
      }
      content

      if let confirmButton = confirmButton {
        DialogActionView(
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
  enum Size {
    case small
    case medium
    case large
    case content

#if os(iOS)
    var padding: CGFloat {
      if UIDevice.current.userInterfaceIdiom == .pad {
        switch self {
        case .small: return 168
        case .medium: return 168
        case .large: return 80
        case .content: return 10
        }
      } else {
        return 30
      }
    }

#elseif os(macOS)
    var padding: CGFloat {
      switch self {
      case .small: return 150
      case .medium: return 100
      case .large: return 50
      case .content: return 30
      }
    }
#endif
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

      VStack(alignment: .leading) {
        Text("Stacked").pbFont(.caption).padding()
        PBDialog(
          title: "This is some informative text",
          text: "öcnwowbsnrnn",
          isStacked: true,
          cancelButton: ("Cancel", foo),
          cancelButtonStyle: PBButtonStyle(variant: .secondary),
          confirmButton: ("Okay", foo)
        )
      }
      .previewDisplayName("Stacked")

      VStack(alignment: .leading) {
        Text("Simple").pbFont(.caption).padding()
        PBDialog(
          title: "This is some informative text",
          text: "öcnwow",
          cancelButton: ("Cancel", foo),
          confirmButton: ("Okay", foo)
        )
      }
      .previewDisplayName("Simple")

      VStack(alignment: .leading) {

        PBDialog(
          cancelButton: ("Back", {}),
          confirmButton: ("Send My Issue", {})
        ) {
          ScrollView {
            Image(systemName: "person")
              .resizable()
              .aspectRatio(contentMode: .fit)
          }
        }
      }
      .previewDisplayName("Complex")

      VStack(alignment: .leading, spacing: nil) {
        Text("Size").pbFont(.caption)
        PBDialog(
          title: "Small Dialog",
          text: infoMessage,
          cancelButton: ("Cancel", foo),
          confirmButton: ("Okay", foo),
          size: .small
        )

        PBDialog(
          title: "Medium Dialog",
          text: infoMessage,
          cancelButton: ("Cancel", nil),
          confirmButton: ("Okay", foo),
          size: .medium
        )

        PBDialog(
          title: "Large Dialog",
          text: infoMessage,
          confirmButton: ("Okay", foo),
          size: .large
        )
      }
      .padding()
      .previewDisplayName("Size")
    }
  }
}
