//
//  PBImage.swift
//  
//
//  Created by Isis Silva on 06/02/23.
//

import SwiftUI

public struct PBImage: View {
    let image: Image?
    let placeholder: Image?
    let size: Size?
    let cornerRadius: ImageCornerRadius

    public init(
        image: Image?,
        placeholder: Image? = nil,
        size: Size? = nil,
        cornerRadius: ImageCornerRadius
    ) {
        self.image = image
        self.placeholder = placeholder
        self.size = size
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        if let size = size {
            imageView.frame(width: size.rawValue, height: size.rawValue)
        } else {
            imageView
        }
    }

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            image
                .resizable()
                .cornerRadius(cornerRadius.rawValue)
        } else {
            placeholder?
                .resizable()
                .background(Color.pbNeutral)
                .cornerRadius(cornerRadius.rawValue)
        }
    }
}

public extension PBImage {
    enum Size: CGFloat, CaseIterable {
        case xxSmall = 60
        case xSmall = 80
        case small = 100
        case medium = 120
        case large = 140

        var name: String {
            switch self {
            case .xxSmall: return "xxSmall"
            case .xSmall: return "xSmall"
            case .small: return "small"
            case .medium: return "medium"
            case .large: return "large"
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
        ScrollView {
            ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
                VStack(alignment: .leading) {
                    Text(size.name)
                        .font(.callout)
                        .opacity(0.5)
                    HStack {
                        PBImage(
                            image: nil,
                            placeholder: Image("Forest", bundle: .module),
                            size: size,
                            cornerRadius: .rounded
                        )
                        Spacer()
                        PBImage(
                            image: Image("Forest", bundle: .module),
                            size: size,
                            cornerRadius: .sharp
                        )
                    }
                }
                .padding(.vertical)
            }
            VStack(alignment: .leading) {
                Text("No size")
                    .font(.callout)
                    .opacity(0.5)
                HStack {
                    PBImage(
                        image: nil,
                        placeholder: Image("Forest", bundle: .module),
                        cornerRadius: .rounded
                    )
                    Spacer()
                    PBImage(
                        image: Image("Forest", bundle: .module),
                        cornerRadius: .sharp
                    )
                }
            }
        }
        .padding()
    }
}
