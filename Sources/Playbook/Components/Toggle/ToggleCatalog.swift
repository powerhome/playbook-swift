//
//  SwiftUIView.swift
//
//
//  Created by Nick Amantia on 7/5/23.
//
//
import SwiftUI

public struct ToggleCatalog: View {

  public var body: some View {
    List {
      Section("Default") {
        PBToggle(checked: true)
        PBToggle(checked: false)
      }
      Section("Name") {
        PBToggle(label: "car", checked: false)
        PBToggle(label: "bike", checked: false)
      }
    }
    .navigationTitle("Toggle")

  }

}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    ToggleCatalog()
  }
}
