//
//  PBDialogHeaderView.swift
//  
//
//  Created by Isis Silva on 03/04/23.
//

import SwiftUI

struct PBDialogHeaderView: View {
  let title: String?
  let dismissAction: (() -> Void)

  public init(title: String?, dismissAction: @escaping () -> Void) {
    self.title = title
    self.dismissAction = dismissAction
  }

  var body: some View {
    HStack {
      if let title = title {
        Text(title).pbFont(.body).padding(Spacing.small)
      }
      Spacer()
      Button {
        dismissAction()
      } label: {
        PBIcon(FontAwesome.times, size: .medium)
          .foregroundColor(.text(.default))
      }
      .buttonStyle(.borderless)
      .padding()
    }
  }
}

struct PBDialogHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return PBDialogHeaderView(title: "Dialog Header", dismissAction: {})
  }
}
