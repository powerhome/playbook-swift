//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDialog.swift
//

import SwiftUI

public struct PBDialog<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode
  let content: Content?
  let title: String?
  let message: String?
  let variant: DialogVariant
  let isStacked: Bool
  let cancelButton: PBButton?
  let confirmButton: PBButton?
  let onClose: (() -> Void)?
  let size: DialogSize
  let buttonSize: PBButton.Size
  let shouldCloseOnOverlay: Bool
  let isButtonFullWidth: Bool?
  
  public init(
    title: String? = nil,
    message: String? = nil,
    variant: DialogVariant = .default,
    isStacked: Bool = false,
    cancelButton: PBButton? = PBButton(variant: .primary, title: "Cancel", action: nil),
    confirmButton: PBButton? = PBButton(variant: .secondary, title: "Cancel", action: nil),
    onClose: (() -> Void)? = nil,
    size: DialogSize = .medium,
    buttonSize: PBButton.Size = .medium,
    shouldCloseOnOverlay: Bool = false,
    isButtonFullWidth: Bool? = false,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.content = content()
    self.title = title
    self.message = message
    self.variant = variant
    self.isStacked = isStacked
    self.cancelButton = cancelButton
    self.confirmButton = confirmButton
    self.onClose = onClose
    self.size = size
    self.buttonSize = buttonSize
    self.isButtonFullWidth = isButtonFullWidth
    self.shouldCloseOnOverlay = shouldCloseOnOverlay
  }

  public var body: some View {
    dialogView()
      .onTapGesture {
        if shouldCloseOnOverlay {
          if let onClose = onClose {
            onClose()
          } else {
            dismissDialog()
          }
        }
      }
      .environment(\.colorScheme, .light)
  }

  private func dialogView() -> some View {
    return PBCard(alignment: .center, padding: Spacing.none) {
      switch variant {
      case .default:
        if let title = title {
          PBDialogHeaderView(title: title) { dismissDialog() }
          PBSectionSeparator()
        }

        if let message = message {
          Text(message)
            .pbFont(.body)
            .padding()
        }

        content

      case .status(let status):
        PBStatusDialogView(status: status, title: title ?? "", description: message ?? "")
          .frame(maxWidth: .infinity)
      }

      if let confirmButton = confirmButton {
        PBDialogActionView(
          isStacked: isStacked,
          cancelButton: cancelButton, 
          confirmButton: confirmButton,
          variant: variant,
          isButtonFullWidth: isButtonFullWidth,
          buttonSize: buttonSize
        )
        .padding()
      }
    }
    .frame(maxWidth: variant.width(size))
    .padding(padding)
    .preferredColorScheme(.light)
  }

  var padding: EdgeInsets {
    #if os(macOS)
      return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    #elseif os(iOS)
      return EdgeInsets(top: 0, leading: Spacing.medium, bottom: 0, trailing: Spacing.medium)
    #endif
  }

  func dismissDialog() {
    presentationMode.wrappedValue.dismiss()
  }
}

public enum DialogSize: String, CaseIterable, Identifiable {
  public var id: UUID { UUID() }

  case small
  case medium
  case large
  case flex

  var width: CGFloat? {
    switch self {
    case .small: return 300
    case .medium: return 500
    case .large: return 800
    case .flex: return nil
    }
  }
}

public enum DialogVariant: Equatable {
  case `default`
  case status(_ status: DialogStatus)

  public func width(_ size: DialogSize) -> CGFloat? {
    switch self {
    case .status: return 375
    default: return size.width
    }
  }
}

public struct PBDialog_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return DialogCatalog()
  }
}
