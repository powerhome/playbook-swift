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
        PBIcon.fontAwesome(icon, size: .x1)
      }
      Text(text)
        .pbFont(.title4, color: .white)
        .padding(.horizontal, Spacing.medium)

      if let dismiss = dismissAction {
        dismiss.view.onTapGesture {
          dismiss.action()
        }
      }
    }
    .onAppear {
      if let dismiss = dismissAction {
        switch dismiss {
        case .withTimer:  dismiss.action()
        default: break
        }
      }
    }
    .foregroundColor(.white)
    .padding(.vertical, Spacing.xSmall)
    .padding(.horizontal, Spacing.medium)
    .background(
      Capsule().fill(variant.color())
    )
    .pbShadow(.deeper)
  }
}

public extension PBToast {
  enum Position {
    case top, bottom
  }

  enum DismissAction {
    case `default`(() -> Void), custom(AnyView, (() -> Void)), withTimer(TimeInterval, (() -> Void))

    var view: AnyView {
      switch self {
      case .default: AnyView(PBIcon.fontAwesome(.times))
      case .custom(let view, _): view
      case .withTimer: AnyView(EmptyView().frame(width: 0))
      }
    }

    var action: (() -> Void) {
      switch self {
      case .default(let currentAction): currentAction
      case .custom(_, let currentAction): currentAction
      case .withTimer(let time, let currentAction): { _ = DispatchQueue.main.asyncAfter(deadline: .now() + time) { currentAction() } }
      }
    }
  }

  enum Variant {
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
      case .error: FontAwesome.exclamationTriangle
      case .success: .check
      case .neutral: .infoCircle
      case .custom(let icon, _): icon
      }
    }
  }
}

private struct PBToast_Previews: PreviewProvider {
  public static var previews: some View {
    @State var isPresented = false
    registerFonts()
    return ToastCatalog()
  }
}
