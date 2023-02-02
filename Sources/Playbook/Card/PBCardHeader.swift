//
//  PBCardHeader.swift
//  
//
//  Created by Alexandre Hauber on 27/07/21.
//

import SwiftUI

public struct PBCardHeader<Content: View>: View {
    let content: Content
    let color: Color

    public init(color: Color = .pbWindows, @ViewBuilder content: () -> Content) {
        self.content = content()
        if  Color.pbProductColors.contains(color) || Color.pbCategoryColors.contains(color) {
            self.color = color
        } else {
            self.color = .white
        }
    }

    public var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(color)
    }
}

// MARK: Preview
struct PBCardHeader_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()

        return PBCardHeader {
            Text("Header").pbFont(.caption)
        }
    }
}
