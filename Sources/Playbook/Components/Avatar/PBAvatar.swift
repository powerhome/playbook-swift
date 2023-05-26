//
//  PBAvatar.swift
//
//
//  Created by Lucas C. Feijo on 12/07/21.
//
import SwiftUI

public struct PBAvatar: View {
  var image: Image?
  var name: String?
  var size: Size
  var status: PresenceStatus?
  var wrapped: Bool

  public init(
    image: Image? = nil,
    name: String? = nil,
    size: Size = .medium,
    status: PresenceStatus? = nil,
    wrapped: Bool = false
  ) {
    self.image = image
    self.name = name
    self.size = size
    self.status = status
    self.wrapped = wrapped
  }

  var initials: String? {
    guard let name = name else { return nil }
    let names = name.split(separator: " ")
    let firstNameInitial = String(names.first ?? " ").first
    let lastNameInitial = String(names.last ?? " ").first
    return "\(firstNameInitial!.uppercased())\(lastNameInitial!.uppercased())"
  }

  public var body: some View {
    ZStack {
      Group {
        if let image = image {
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .tag("userImage")
        } else if let initials = initials {
          Text(initials)
            .tag("monogram")
            .pbFont(.monogram(size.fontSize), color: .white)
        }
      }
      .foregroundColor(.white)
      .frame(width: size.diameter, height: size.diameter)
      .background(Color.status(.neutral))
      .clipShape(Circle())

      if wrapped {
        Circle()
          .strokeBorder(Color.background(.default), lineWidth: 1)
          .frame(width: size.diameter + 1, height: size.diameter + 1)
      }

      if let statusColor = self.status?.color {
        Circle()
          .foregroundColor(statusColor)
          .overlay(
            Circle().stroke(Color.white, lineWidth: 2)
          )
          .frame(width: 8.0, height: 8.0)
          .offset(
            x: (size.diameter/2 - size.diameter/9) * size.statusXModifier,
            y: (size.diameter/2 - size.diameter/6) * size.statusYModifier
          )
      }
    }
  }
}

public extension PBAvatar {
  enum Size: CaseIterable {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case defaultStacked
    case defaultStackedIndicator
    case smallStacked
    case smallStackedIndicator

    var diameter: CGFloat {
      switch self {
      case .xxSmall: return 20
      case .xSmall: return 28
      case .small: return 38
      case .medium: return 60
      case .large: return 80
      case .xLarge: return 100
      case .defaultStacked: return 34
      case .defaultStackedIndicator: return 18
      case .smallStacked: return 22
      case .smallStackedIndicator: return 16
      }
    }

    var fontSize: CGFloat {
      return diameter * 0.38
    }

    var statusXModifier: CGFloat {
      switch self {
      case .xxSmall: return 1.3
      case .xSmall: return 1.2
      case .small: return 0.95
      case .medium: return 1.05
      case .large: return 1.12
      case .xLarge: return 1.16
      default: return 0
      }
    }

    var statusYModifier: CGFloat {
      switch self {
      case .xxSmall: return -0.8
      case .xSmall: return -1
      case .small: return -1.1
      case .medium: return 1
      case .large: return 0.78
      case .xLarge: return 0.68
      default: return 0
      }
    }

    var avatarCases: [Size] {
      [.xLarge, .large, .medium, .small, .xSmall, .xxSmall]
    }
  }

  enum PresenceStatus {
    case away
    case offline
    case online

    var color: Color {
      switch self {
      case .online: return .status(.success)
      case .away: return .status(.warning)
      case .offline: return .status(.neutral)
      }
    }
  }
}

struct PBAvatar_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return AvatarCatalog()
  }
}
