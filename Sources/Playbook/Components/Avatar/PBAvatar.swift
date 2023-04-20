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
      .background(Color.pbNeutral)
      .clipShape(Circle())

      if wrapped {
        Circle()
          .strokeBorder(Color.pbBackground, lineWidth: 1)
          .frame(width: size.diameter + 1, height: size.diameter + 1)
      }

      if let statusColor = self.status?.color {
        Circle()
          .foregroundColor(statusColor)
          .overlay(
            Circle().stroke(Color.pbBackground, lineWidth: 2)
          )
          .frame(width: 10.0, height: 10.0)
          .offset(
            x: size.diameter/2 - size.diameter/9,
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

    var diameter: CGFloat {
      switch self {
      case .xxSmall: return 20
      case .xSmall: return 28
      case .small: return 38
      case .medium: return 60
      case .large: return 80
      case .xLarge: return 100
      }
    }

    var fontSize: CGFloat {
      return diameter * 0.38
    }

    var statusYModifier: CGFloat {
      switch self {
      case .xxSmall, .xSmall, .small: return -1
      default: return 1
      }
    }
  }

  enum PresenceStatus {
    case away
    case offline
    case online

    var color: Color {
      switch self {
      case .online: return .pbSuccess
      case .away: return .pbWarning
      case .offline: return .pbNeutral
      }
    }
  }
}

public struct PBAvatar_Previews: PreviewProvider {
  static var defaultAvatars: some View {
    VStack(alignment: .leading) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .xxSmall, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xLarge, status: .offline)
    }
  }

  static var monograms: some View {
    VStack(alignment: .leading) {
      PBAvatar(name: "Tim Wenhold", size: .xxSmall, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .xSmall, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .small, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .medium, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .large, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .xLarge, status: .offline)
    }
  }

  public static var previews: some View {
    registerFonts()

    return List {
      Section("Default") {
        defaultAvatars
      }

      Section("Monogram") {
        monograms
      }
    }
  }
}
