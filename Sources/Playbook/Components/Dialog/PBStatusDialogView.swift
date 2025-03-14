//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBStatusDialogView.swift
//

import SwiftUI

struct PBStatusDialogView: View {
  let status: Status
  let title: String
  let description: String

  var body: some View {
    VStack {
      PBIconCircle(status.icon.0, size: .large, color: .custom(status.icon.1))
        .frame(width: 80)
      Text(title)
        .pbFont(.title3)
        .padding(.vertical)
        .multilineTextAlignment(.center)
      Text(description)
        .pbFont(.body)
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: false)
    }
    .padding()
  }
}
public enum Status: String, CaseIterable, Identifiable {
  public var id: UUID { UUID() }

  case `default`, caution, delete, information, error, success
  var icon: (PlaybookGenericIcon, Color) {
    switch self {
    case .default: return (FontAwesome.exclamationCircle, .status(.neutral))
    case .caution: return (FontAwesome.exclamationTriangle, .status(.warning))
    case .delete: return (FontAwesome.trashAlt, .status(.error))
    case .information: return (FontAwesome.infoCircle, .status(.neutral))
    case .error: return (FontAwesome.timesCircle, .status(.error))
    case .success: return (FontAwesome.checkCircle, .status(.success))
    }
  }
}

#Preview {
  registerFonts()
  return List(Status.allCases, id: \.self) { status in
    Section {
      PBStatusDialogView(
        status: status,
        title: status.rawValue.capitalized,
        description: "Some description Some description Some description Some description Some description"
      )
      .frame(maxWidth: .infinity)
    }
  }
}
