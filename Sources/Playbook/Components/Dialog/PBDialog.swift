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
  let variant: DialogVariant
  let isStacked: Bool
  let cancelButton: (String, (() -> Void)?)?
  let confirmButton: (String, (() -> Void))?
  let onClose: (() -> Void)?
  let size: DialogSize
  let shouldCloseOnOverlay: Bool

  public init(
    title: String? = nil,
    message: String? = nil,
    variant: DialogVariant = .default,
    isStacked: Bool = false,
    cancelButton: (String, (() -> Void)?)? = nil,
    confirmButton: (String, (() -> Void))? = nil,
    onClose: (() -> Void)? = nil,
    size: DialogSize = .medium,
    shouldCloseOnOverlay: Bool = true,
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
            .pbFont(.body())
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
          confirmButton: confirmButton,
          cancelButton: cancelButtonAction(),
          variant: variant
        )
        .padding()
      }
    }
    .frame(maxWidth: variant.width(size))
    .padding(padding)
    .preferredColorScheme(.light)
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

  var width: CGFloat {
    switch self {
    case .small: return 300
    case .medium: return 500
    case .large: return 800
    }
  }
}

public enum DialogVariant: Equatable {
  case `default`
  case status(_ status: DialogStatus)

  public func width(_ size: DialogSize) -> CGFloat {
    switch self {
    case .status: return 375
    default: return size.width
    }
  }
}

@available(macOS 13.0, *)
public struct PBDialog_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return DialogCatalog()
  }
}
