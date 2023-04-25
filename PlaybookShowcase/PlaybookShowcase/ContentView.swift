//
//  ContentView.swift
//  PlaybookShowcase-iOS
//
//  Created by Isis Silva on 4/19/23.
//

import SwiftUI
import Playbook

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
        .pbFont(.caption, color: .status(.error))
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
