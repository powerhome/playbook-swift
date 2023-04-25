//
//  PBStatusDialogView.swift
//  
//
//  Created by Isis Silva on 03/04/23.
//

import SwiftUI

struct PBStatusDialogView: View {
  let status: DialogStatus
  let title: String
  let description: String

  var body: some View {
    VStack {
      PBIconCircle(status.icon.0, size: .x3, color: status.icon.1)
        .frame(width: 80)
      Text(title)
        .pbFont(.body(.larger))
        .padding(.vertical)
        .multilineTextAlignment(.center)
      Text(description)
        .pbFont(.body())
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
    }
    .padding()
  }
}

  public enum DialogStatus: String, CaseIterable {
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

struct PBStatusDialogView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return List(DialogStatus.allCases, id: \.self) { status in
      Section {
        PBStatusDialogView(
          status: status,
          title: status.rawValue.capitalized,
          description: "Some description Some description Some description Some description Some description "
        )
        .frame(maxWidth: .infinity)
      }
    }
  }
}
