//
//  Icon.swift
//
//
//  Created by Lucas C. Feijo on 15/07/21.
//

import SwiftUI

public protocol PlaybookGenericIcon {
  var unicodeString: String { get }
  var fontFamily: String { get }
}

public struct PBIcon: View {
  var icon: PlaybookGenericIcon
  var size: IconSize
  var rotation: IconRotation
  var border: Bool
  var flipped: [Axis]?

  public init(
    _ icon: PlaybookGenericIcon,
    size: IconSize = .medium,
    rotation: IconRotation = .zero,
    border: Bool = false,
    flipped: [Axis]? = nil
  ) {
    self.size = size
    self.icon = icon
    self.rotation = rotation
    self.border = border
    self.flipped = flipped
  }

  public var body: some View {
    Text(icon.unicodeString)
      .font(Font.custom(icon.fontFamily, size: size.fontSize))
      .rotationEffect(rotation.angle)
      .padding(.horizontal, border ? 11 : 0)
      .padding(.top, border ? 6.4 : 0)
      .padding(.bottom, border ? 4.8 : 0)
      .border(border ? Color.border : .clear, width: 2.5)
      .flipped(flipped)
  }
}

public extension PBIcon {
  enum IconSize: String, CaseIterable {
    case small
    case medium
    case large
    case x1
    case x2
    case x3
    case x4
    case x5
    case x6
    case x7
    case x8
    case x9
    case x10

    var fontSize: CGFloat {
      let emToPt: CGFloat = 11.955168

      switch self {
      case .small: return 16
      case .medium: return 20
      case .large: return 24

      case .x1: return 1 * emToPt
      case .x2: return 2 * emToPt
      case .x3: return 3 * emToPt
      case .x4: return 4 * emToPt
      case .x5: return 5 * emToPt
      case .x6: return 6 * emToPt
      case .x7: return 7 * emToPt
      case .x8: return 8 * emToPt
      case .x9: return 9 * emToPt
      case .x10: return 10 * emToPt
      }
    }
  }

  enum IconRotation {
    case zero
    case right
    case straight
    case obtuse

    var angle: Angle {
      switch self {
      case .zero: return Angle(degrees: 0)
      case .right: return Angle(degrees: 90)
      case .straight: return Angle(degrees: 180)
      case .obtuse: return Angle(degrees: 270)
      }
    }
  }
}

public struct PBIcon_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return IconCatalog()
  }
}

extension View {
  func flipped(_ axis: [Axis]? = nil) -> some View {

    switch axis {
    case [.horizontal]:
      return scaleEffect(CGSize(width: -1, height: 1), anchor: .center)
    case [.vertical]:
      return scaleEffect(CGSize(width: 1, height: -1), anchor: .center)
    case [.horizontal, .vertical], [.vertical, .horizontal]:
      return scaleEffect(CGSize(width: -1, height: -1), anchor: .center)
    default: return scaleEffect(CGSize(width: 1, height: 1), anchor: .center)
    }
  }
}
