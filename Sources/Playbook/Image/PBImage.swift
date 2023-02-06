//
//  PBImage.swift
//  
//
//  Created by Isis Silva on 06/02/23.
//

import SwiftUI

public struct PBImage: View {
    let image: Image
    let size: Size
    let cornerRadius: ImageCornerRadius

    public var body: some View {
        image
            .resizable()
            .cornerRadius(cornerRadius.rawValue)
            .frame(width: size.rawValue, height: size.rawValue)
    }
}

public extension PBImage {
    enum Size: CGFloat, CaseIterable {
        case xxSmall = 60
        case xSmall = 80
        case small = 100
        case medium = 120
        case large = 140
        case none

        var name: String {
            switch self {
            case .xxSmall: return "xxSmall"
            case .xSmall: return "xSmall"
            case .small: return "small"
            case .medium: return "medium"
            case .large: return "large"
            case .none: return "none"
            }
        }
    }

    enum ImageCornerRadius: CGFloat {
        case rounded = 7
        case sharp = 0
    }
}

struct PBImage_Previews: PreviewProvider {
    static var previews: some View {
        List(PBImage.Size.allCases, id: \.rawValue) { size in
            Section(size.name) {
                HStack {
                    PBImage(image: Image("Forest", bundle: .module), size: size, cornerRadius: .rounded)
                    Spacer()
                    PBImage(image: Image("Forest", bundle: .module), size: size, cornerRadius: .sharp)
                }
            }
        }
        .listStyle(.plain)
    }
}
