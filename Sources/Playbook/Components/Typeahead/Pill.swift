//
//  Pill.swift
//  
//
//  Created by Isis Silva on 13/11/23.
//

import SwiftUI

struct Pill: View {
  private var shape = Capsule()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .font(.custom(ProximaNova.bold.rawValue, size: 14))
        .padding(.vertical, Spacing.xSmall)
        .background(Color.gray)
        .clipShape(shape)
        .overlay(shape.stroke(lineWidth: 1))
       
    }
}

#Preview {
  registerFonts()
    return Pill()
}
