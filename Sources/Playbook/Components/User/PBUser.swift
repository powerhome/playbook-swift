//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBUser.swift
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
  var subtitle: BlockContent?
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
    title: String? = nil,
    subtitle: BlockContent? = .contact
  ) {
    self.name = name
    self.displayAvatar = displayAvatar
    self.image = image
    self.orientation = orientation
    self.size = size
    self.territory = territory
    self.title = title
    self.subtitle = subtitle
  }

  public var body: some View {
    if orientation == .horizontal {
      HStack(spacing: Spacing.small) {
        if displayAvatar {
          PBAvatar(image: image, name: name, size: size.avatarSize)
        }

        VStack(alignment: .leading, spacing: Spacing.xSmall) {
          Text(name)
            .font(titleStyle.font)
            .foregroundColor(.text(.default))
          bodyText.pbFont(.body, color: .text(.light))
          subtitleIconTitleBlock
          subtitleContactBlock
          contactIconTitle
        }
      }
    } else {
      VStack(spacing: Spacing.xSmall) {
        if displayAvatar {
          PBAvatar(image: image, name: name, size: size.avatarSize)
        }

        VStack(alignment: displayAvatar ? .center : .leading, spacing: Spacing.xSmall) {
          Text(name)
            .font(titleStyle.font)
            .foregroundColor(.text(.default))
          bodyText.pbFont(.body, color: .text(.light))
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
    enum BlockContent {
      case iconTitle, contact, contactIconTitle
    }
     @ViewBuilder
      var contentBlock: some View {
        switch subtitle {
        case .contact: subtitleContactBlock
        case .iconTitle: subtitleIconTitleBlock
        case .contactIconTitle:
          contactIconTitle
        case .none:
          EmptyView()
       
        }
      }
  @ViewBuilder
  var subtitleIconTitleBlock: some View {
    if subtitle == .iconTitle {
      HStack {
        PBIcon(FontAwesome.users, size: .small)
        Text("ADMIN")
          .pbFont(.subcaption, color: .text(.default))
      }
    }
  }
  @ViewBuilder
  var subtitleContactBlock: some View {
    if subtitle == .contact {
      PBContact(type: .cell, value: "(349) 185-9988", detail: false)
      PBContact(type: .home, value: "(555) 555-5555", detail: false)
      PBContact(type: .email, value: "email@example.com", detail: false)
    }
  }
  @ViewBuilder
  var contactIconTitle: some View {
    if subtitle == .contactIconTitle {
      subtitleIconTitleBlock
      subtitleContactBlock
    }
  }
}

struct PBUser_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return UserCatalog()
  }
}
