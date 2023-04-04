//
//  StatusDialogView.swift
//  
//
//  Created by Isis Silva on 03/04/23.
//

import SwiftUI

struct StatusDialogView: View {
  let status: (PlaybookGenericIcon, Color)
  let title: String
  let description: String

  var body: some View {
    VStack {
      PBIconCircle(status.0, size: .x3, color: status.1)
        .frame(width: 80)
      Text(title)
        .pbFont(.body(.larger))
        .padding(.vertical)
      Text(description).pbFont(.body())
    }
    .padding()
    .frame(maxWidth: .infinity)
  }
}

struct StatusDialogView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return StatusDialogView(
      status: (FontAwesome.rocket, .pbGreen),
      title: "Success!",
      description: "Text explaining what is successful"
    )
  }
}
