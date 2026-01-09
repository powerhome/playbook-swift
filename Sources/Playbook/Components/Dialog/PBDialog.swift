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
    @Binding var isTypeaheadPresentationMode: Bool?
    let content: Content?
    let title: String?
    let message: String?
    let variant: DialogVariant
    let isStacked: Bool
    let cancelButton: PBButton?
    let confirmButton: PBButton?
    let onClose: (() -> Void)?
    let size: DialogSize
    let shouldCloseOnOverlay: Bool
    
    public init(
        isTypeaheadPresentationMode: Binding<Bool?> = .constant(false),
        title: String? = nil,
        message: String? = nil,
        variant: DialogVariant = .default,
        isStacked: Bool = false,
        cancelButton: PBButton? = nil,
        confirmButton: PBButton? = nil,
        onClose: (() -> Void)? = nil,
        size: DialogSize = .medium,
        shouldCloseOnOverlay: Bool = false,
        @ViewBuilder content: (() -> Content) = { EmptyView() }
    ) {
        self._isTypeaheadPresentationMode = isTypeaheadPresentationMode
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
    }
}

extension PBDialog {
    private func dialogView() -> some View {
        return PBCard(alignment: .center, padding: Spacing.none, style: .inline) {
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
              confirmButton: dismissButtonAction(confirmButton),
              cancelButton: dismissButtonAction(cancelButton),
              variant: variant
            )
            .padding()
          }
        }
        .frame(maxWidth: variant.width(size))
        .preferredColorScheme(.light)
    }
    
    func dismissButtonAction(_ button: PBButton?) -> (PBButton, (() -> Void)?)? {
        if let dismissButton = button {
            if let dismissButtonAction = dismissButton.action {
                return (dismissButton, dismissButtonAction)
            }
            return (dismissButton, { dismissDialog() })
        }
        return nil
    }
    
    var padding: EdgeInsets {
        #if os(macOS)
        return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        #elseif os(iOS)
        return EdgeInsets(top: 0, leading: Spacing.medium, bottom: 0, trailing: Spacing.medium)
        #endif
    }
    
    func dismissDialog() {
      if isTypeaheadPresentationMode != nil {
            onClose?()
        } else {
            presentationMode.wrappedValue.dismiss()
            onClose?()
        }
    }
}

public enum DialogSize: String, CaseIterable, Identifiable {
  public var id: UUID { UUID() }
  case small
  case medium
  case large
  
  public var width: CGFloat {
    switch self {
    case .small: return 300
    case .medium: return 500
    case .large: return 800
    }
  }
}

public enum DialogVariant: Equatable {
    case `default`
    case status(_ status: Status)
    
    public func width(_ size: DialogSize) -> CGFloat {
        switch self {
            case .status: return 375
            default: return size.width
        }
    }
}

//#Preview {
//    registerFonts()
//    return DialogCatalog()
//}
