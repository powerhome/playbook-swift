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
  var subtitle: AnyView?
  var status: PBAvatar.PresenceStatus?
  public init(
    name: String = "",
    displayAvatar: Bool = true,
    image: Image? = nil,
    orientation: Orientation = .horizontal,
    size: UserAvatarSize = .medium,
    territory: String? = nil,
    title: String? = nil,
    subtitle: AnyView? = nil,
    status: PBAvatar.PresenceStatus? = .none
  ) {
    self.name = name
    self.displayAvatar = displayAvatar
    self.image = image
    self.orientation = orientation
    self.size = size
    self.territory = territory
    self.title = title
    self.subtitle = subtitle
    self.status = status
  }
  
  public var body: some View {
    if orientation == .horizontal {
      HStack(spacing: Spacing.small) {
        if displayAvatar {
          PBAvatar(image: image, name: name, size: size.avatarSize, status: status)
        }
        VStack(alignment: .leading, spacing: Spacing.xSmall) {
          Text(name)
            .font(titleStyle.font)
            .foregroundColor(.text(.default))
          bodyText.pbFont(.body, color: .text(.light))
          if let content = subtitle {
            content
          }
        }
      }
    } else {
      VStack(spacing: Spacing.xSmall) {
        if displayAvatar {
          PBAvatar(image: image, name: name, size: size.avatarSize, status: status)
        }
        VStack(alignment: displayAvatar ? .center : .leading, spacing: Spacing.xSmall) {
          Text(name)
            .font(titleStyle.font)
            .foregroundColor(.text(.default))
          bodyText.pbFont(.body, color: .text(.light))
          if let content = subtitle {
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
  var subtitleIconRoleBlock: some View {
    HStack {
      PBIcon(FontAwesome.users, size: .small)
      Text("ADMIN")
        .pbFont(.caption, color: .text(.light))
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
    return UserCatalog()
  }
}
