//
//  DialogHeaderView.swift
//  
//
//  Created by Isis Silva on 03/04/23.
//

import SwiftUI

struct DialogHeaderView: View {
  let title: String?
  let dismissAction: (() -> Void)

  public init(title: String?, dismissAction: @escaping () -> Void) {
    self.title = title
    self.dismissAction = dismissAction
  }

  var body: some View {
    HStack {
      if let title = title {
        Text(title).pbFont(.body()).padding(.pbSmall)
      }
      Spacer()
      Button {
        dismissAction()
      } label: {
        PBIcon(FontAwesome.times, size: .medium)
          .foregroundColor(.pbTextDefault)
      }
      .buttonStyle(.borderless)
      .padding()
    }
  }
}

struct DialogHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return DialogHeaderView(title: "Dialog Header", dismissAction: {})
  }
}
