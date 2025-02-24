//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBShadow.swift
//

import SwiftUI
import Playbook

public struct PBShadow_Previews: PreviewProvider {
  public static var previews: some View {
    let shape = RoundedRectangle(cornerRadius: 7)
    List(Shadow.allCases, id: \.hashValue) { shadow in
      Section(shadow.rawValue.uppercased()) {
        shape
          .frame(height: 80)
          .foregroundColor(.white)
          .pbShadow(shadow)
          .overlay {
            shape
              .stroke(.gray, lineWidth: 0.1)
          }
          .padding(EdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10))
      }
      .listRowBackground(Color.clear)
      .navigationTitle("Shadows")
    }
   
  }
}
