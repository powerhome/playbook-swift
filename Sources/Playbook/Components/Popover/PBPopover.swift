//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PBPopover<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode
  let content: Content?
  let onClose: (() -> Void)?
  let shouldCloseOnOverlay: Bool

  public init(
    onClose: (() -> Void)? = nil,
    shouldCloseOnOverlay: Bool = true,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.content = content()
    self.onClose = onClose
    self.shouldCloseOnOverlay = shouldCloseOnOverlay
  }

  public var body: some View {
    popoverView()
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

  private func popoverView() -> some View {
    return PBCard(alignment: .center, padding: Spacing.none) {
      content
    }
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

@available(macOS 13.0, *)
public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}
