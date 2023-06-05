//
//  PBUser.swift
//
//
//  Created by Alexandre Hauber on 15/07/21.
//

import SwiftUI

public struct PBUser: View {
  var name: String
  var displayAvatar: Bool = true
  var image: Image?
  var orientation: Orientation = .horizontal
  var size: UserAvatarSize = .medium
  var territory: String?
  var title: String?

  var titleStyle: PBFont {
    switch size {
    case .large: return .title3
    default: return .title4
    }
  }

  var bodyText: Text? {
    if let territory = territory, !territory.isEmpty, let title = title, !title.isEmpty {
      return Text("\(territory) \u{2022} \(title)")
    } else if let territory = territory, !territory.isEmpty {
      return Text(territory)
    } else if let title = title, !title.isEmpty {
      return Text(title)
    } else {
      return nil
    }
  }

  public init(
    name: String = "",
    displayAvatar: Bool = true,
    image: Image? = nil,
    orientation: Orientation = .horizontal,
    size: UserAvatarSize = .medium,
    territory: String? = nil,
    title: String? = nil
  ) {
    self.name = name
    self.displayAvatar = displayAvatar
    self.image = image
    self.orientation = orientation
    self.size = size
    self.territory = territory
    self.title = title
  }

  public var body: some View {
    if orientation == .horizontal {
      HStack(spacing: Spacing.small) {
        if displayAvatar {
          PBAvatar(image: image, name: name, size: size.avatarSize)
        }

        VStack(alignment: .leading, spacing: size == .large ? Spacing.large : 6) {
          Text(name)
            .font(titleStyle.font)
            .foregroundColor(.text(.default))
          bodyText.pbFont(.body(), color: .text(.light))
        }
      }
    } else {
      VStack(spacing: Spacing.large) {
        if displayAvatar {
          PBAvatar(image: image, name: name, size: size.avatarSize)
        }

        VStack(alignment: displayAvatar ? .center : .leading, spacing: 6) {
          Text(name)
            .font(titleStyle.font)
            .foregroundColor(.text(.default))
          bodyText.pbFont(.body(), color: .text(.light))
        }
      }
    }
  }
}

public extension PBUser {
  enum UserAvatarSize {
    case small
    case medium
    case large

    var avatarSize: PBAvatar.Size {
      switch self {
      case .small: return .small
      case .medium: return .medium
      case .large: return .large
      }
    }
  }
}

struct PBUser_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    let img = Image("andrew", bundle: .module)
    let name = "Andrew K"
    let title = "Rebels Developer"

    return Group {
      VStack(alignment: .leading, spacing: 20) {
        PBUser(
          name: name,
          image: img,
          territory: "PHL",
          title: title
        )
        PBUser(
          name: name,
          territory: "PHL",
          title: title
        )
        PBUser(
          name: name,
          image: img,
          size: .small,
          title: title
        )
        PBUser(
          name: name,
          image: img,
          size: .small
        )
      }
      .padding(.horizontal, 20)
      .previewDisplayName("Horizontal")

      VStack(alignment: .center, spacing: 20) {
        PBUser(
          name: name,
          image: img,
          orientation: .vertical,
          size: .small,
          title: title
        )
        PBUser(
          name: name,
          image: img,
          orientation: .vertical,
          title: title
        )
        PBUser(
          name: name,
          image: img,
          orientation: .vertical,
          size: .large,
          title: title
        )
      }
      .padding(.horizontal, 20)
      .previewDisplayName("Vertical")

      VStack(alignment: .center, spacing: 20) {
        PBUser(
          name: name,
          displayAvatar: false,
          size: .large,
          territory: "PHL",
          title: title
        )
        PBUser(
          name: name,
          displayAvatar: false,
          territory: "PHL",
          title: title
        )
      }
      .padding(.horizontal, 20)
      .previewDisplayName("Text Only")

      VStack(alignment: .center, spacing: 20) {
        PBUser(
          name: name,
          image: img,
          size: .small,
          territory: "PHL",
          title: title
        )
        PBUser(
          name: name,
          image: img,
          territory: "PHL",
          title: title
        )
        PBUser(
          name: name,
          image: img,
          size: .large,
          territory: "PHL",
          title: title
        )
      }
      .padding(.horizontal, 20)
      .previewDisplayName("Horizontal Sizes")
    }
  }
}
