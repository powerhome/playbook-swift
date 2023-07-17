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
  @State var rounded: Bool

  public init(
    image: Image?,
    placeholder: Image? = nil,
    size: Size? = nil,
    rounded: Bool
  ) {
    self.image = image
    self.placeholder = placeholder
    self.size = size
    self.rounded = rounded
  }

  public var body: some View {
    if let size = size {
      imageView
        .cornerRadius(rounded ? 7 : 0)
        .frame(width: size.rawValue, height: size.rawValue)
    } else {
      imageView
    }
  }

  @ViewBuilder
  private var imageView: some View {
    if let image = image {
      image.resizable()
    } else {
      placeholder?.resizable()
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
      case .xxSmall: return "xx3Small"
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

public struct PBImage_Previews: PreviewProvider {
  public static var previews: some View {
    ImageCatalog()
  }
}
