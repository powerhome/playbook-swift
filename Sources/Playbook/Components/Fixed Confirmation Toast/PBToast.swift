//
//  PBToast.swift
//
//
//  Created by Isis Silva on 16/10/23.
//

import SwiftUI

struct PBToast: View {
  @Environment(\.presentationMode) var presentationMode
  let text: String
  let color: Color
  
  var body: some View {
    HStack {
      PBIcon.fontAwesome(.user, size: .x1)
      
      Text(text).pbFont(.title4, color: .white)
        
      PBIcon(FontAwesome.times, size: .x1)
        .onTapGesture {
          dismissDialog()
        }
       
    }
    .foregroundColor(.white)
    .padding()
    .background(
      Capsule()
        .fill(color)
    )
    
  }
  
  func dismissDialog() {
    presentationMode.wrappedValue.dismiss()
  }
}

#Preview {
  registerFonts()
  return PBToast(text: "Some text", color: Color.status(.error))
}
