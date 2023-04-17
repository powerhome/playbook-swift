//
//  ContentView.swift
//  PlaybookShowcase
//
//  Created by Isis Silva on 4/17/23.
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
                .pbFont(.title1, color: .pbSolar)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
