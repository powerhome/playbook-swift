//
//  PBToast.swift
//
//
//  Created by Isis Silva on 16/10/23.
//

import SwiftUI

public struct PBToast: View {
  let text: String?
  let variant: Variant
  let actionView: DismissAction?
  let dismissAction: (() -> Void)

  public init(
    text: String? = nil,
    variant: Variant = .custom(nil, .clear),
    actionView: DismissAction? = nil,
    dismissAction: @escaping (() -> Void)
  ) {
    self.text = text
    self.variant = variant
    self.actionView = actionView
    self.dismissAction = dismissAction
  }

  public var body: some View {
    HStack {
      if let icon = variant.icon {
        PBIcon.fontAwesome(icon, size: .x1)
      }
      if let text = text {
        Text(text)
          .pbFont(.title4, color: .white)
          .padding(.horizontal, Spacing.medium)
      }
      if let dismiss = actionView {
        dismiss.view.onTapGesture {
          dismissAction()
        }
      }
    }
    .onAppear {
      if let dismiss = actionView {
        switch dismiss {
        case .withTimer(let time):
          _ = DispatchQueue.main.asyncAfter(deadline: .now() + time) { dismissAction()
          }
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
    case `default`, custom(AnyView), withTimer(TimeInterval)

    var view: AnyView {
      switch self {
      case .default: AnyView(PBIcon.fontAwesome(.times))
      case .custom(let view): view
      case .withTimer: AnyView(EmptyView().frame(width: 0))
      }
    }
  }

  enum Variant {
    case error, success, neutral, custom(FontAwesome? = nil, Color)

    func color(_ custom: Color = .pbPrimary) -> Color {
      switch self {
      case .error: Color.status(.error)
      case .success: Color.status(.success)
      case .neutral: Color.status(.neutral)
      case .custom(_, let color): color
      }
    }

    var icon: FontAwesome? {
      switch self {
      case .error: FontAwesome.exclamationTriangle
      case .success: FontAwesome.check
      case .neutral: FontAwesome.infoCircle
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
