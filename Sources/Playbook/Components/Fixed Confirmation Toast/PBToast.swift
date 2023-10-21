//
//  PBToast.swift
//
//
//  Created by Isis Silva on 16/10/23.
//

import SwiftUI

public struct PBToast: View {
  let text: String
  let variant: Variant
  let dismissAction: DismissAction?

  public init(
    text: String,
    variant: Variant,
    dismissAction: DismissAction? = nil
  ) {
    self.text = text
    self.variant = variant
    self.dismissAction = dismissAction
  }

  public var body: some View {
    HStack {
      if let icon = variant.icon {
        PBIcon.fontAwesome(icon)
      }
      Text(text)
        .pbFont(.title4, color: .white)
        .padding(.horizontal, 24)

      if let dismiss = dismissAction {
        Button { dismiss.action() }
      label: {
        dismiss.view
      }
      }
    }
    .foregroundColor(.white)
    .padding(7)
    .padding(.horizontal)
    .background(
      Capsule().fill(variant.color())
    )
  }
}

// extension PBToast {
  public enum DismissAction {
    case `default`(() -> Void), custom(AnyView, (() -> Void))

    var view: AnyView {
      switch self {
      case .default: AnyView(PBIcon.fontAwesome(.times))
      case .custom(let view, _): view
      }
    }

    var action: (() -> Void) {
      switch self {
      case .default(let action): action
      case .custom(_, let action): action
      }
    }
  }

  public enum Variant {
    case error, success, neutral, custom(FontAwesome? = nil, Color)

    func color(_ custom: Color = .pbPrimary) -> Color {
      switch self {

      case .error: .status(.error)
      case .success: .status(.success)
      case .neutral: .status(.neutral)
      case .custom(_, let color): color
      }
    }

    var icon: FontAwesome? {
      switch self {
      case .error: .exclamationTriangle
      case .success: .check
      case .neutral: .infoCircle
      case .custom(let icon, _): icon
      }
    }
  }
// }

#Preview {
  @State var isPresented = false
  registerFonts()
  return ToastCatalog()
}
