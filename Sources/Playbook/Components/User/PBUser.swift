//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBUser.swift
//

import SwiftUI

public struct PBUser<Content: View>: View {
  var name: String
  var displayAvatar: Bool = true
  var image: Image?
  var orientation: Orientation = .horizontal
  var size: UserAvatarSize = .medium
  var territory: String?
  var title: String?
  var subtitle: BlockContent?
  var role: String?
  var icon: FontAwesome?
  var contacts: [PBContact]?
  var content: Content?

  public init(
    name: String = "",
    displayAvatar: Bool = true,
    image: Image? = nil,
    orientation: Orientation = .horizontal,
    size: UserAvatarSize = .medium,
    territory: String? = nil,
    title: String? = nil,
    subtitle: BlockContent? = .contact,
    role: String? = "",
    icon: FontAwesome? = .users,
    contacts: [PBContact]? = nil,
    @ViewBuilder content: () -> Content? = { nil }
  ) {
    self.name = name
    self.displayAvatar = displayAvatar
    self.image = image
    self.orientation = orientation
    self.size = size
    self.territory = territory
    self.title = title
    self.subtitle = subtitle
    self.role = role
    self.icon = icon
    self.contacts = contacts
    self.content = content()
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
          contentBlock
          if let content = content {
            content
          }
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
          contentBlock
          if let content = content {
            content
          }
        }
      }
    }
  }
}

public extension PBUser {
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

  @ViewBuilder
  var contentBlock: some View {
    switch subtitle {
    case .contact: subtitleContactBlock
    case .iconRole: subtitleIconRoleBlock
    case .contactIconRole:
      subtitleIconRoleBlock
      subtitleContactBlock
    case .none:
      EmptyView()
    }
  }

  var subtitleIconRoleBlock: some View {
    HStack {
      PBIcon(icon ?? .users, size: .small)
      Text(role ?? "ADMIN")
        .pbFont(.caption, color: .text(.light))
    }
  }

  var subtitleContactBlock: some View {
    return ForEach(contacts ?? [], id: \.parsedValue) { contact in
      PBContact(type: contact.type, value: contact.contactValue, detail: contact.detail)
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
    case iconRole, contact, contactIconRole
  }
}

public extension PBUser where Content == AnyView {
  init(
    name: String = "",
    displayAvatar: Bool = true,
    image: Image? = nil,
    orientation: Orientation = .horizontal,
    size: UserAvatarSize = .medium,
    territory: String? = nil,
    title: String? = nil,
    subtitle: BlockContent? = .contact
  ) {
    self.init(
      name: name,
      displayAvatar: displayAvatar,
      image: image ,
      orientation: .horizontal,
      size: .medium,
      territory: nil,
      title: nil,
      subtitle: subtitle,
      contacts: [],
      content: { AnyView(EmptyView()) }
    )
  }
}

struct PBUser_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return UserCatalog()
  }
}
