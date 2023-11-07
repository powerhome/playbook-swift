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
      if let dismiss = actionView, let view = dismiss.view {
        view.onTapGesture {
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
    case topLeft, top, topRight, bottomLeft, bottom, bottomRight
    var alignment: Alignment {
      switch self {
      case .top, .bottom: return .center
      case .topLeft, .bottomLeft: return .leading
      case .topRight, .bottomRight: return .trailing
      }
    }
  }

  enum DismissAction {
    case `default`, custom(AnyView), withTimer(TimeInterval)

    var view: AnyView? {
      switch self {
      case .default: return AnyView(PBIcon.fontAwesome(.times))
      case .custom(let view): return view
      case .withTimer: return nil
      }
    }
  }

  enum Variant {
    case error, success, neutral, custom(FontAwesome? = nil, Color)

    func color(_ custom: Color = .pbPrimary) -> Color {
      switch self {
      case .error: return Color.status(.error)
      case .success: return Color.status(.success)
      case .neutral: return Color.status(.neutral)
      case .custom(_, let color): return color
      }
    }

    var icon: FontAwesome? {
      switch self {
      case .error: return FontAwesome.exclamationTriangle
      case .success: return FontAwesome.check
      case .neutral: return FontAwesome.infoCircle
      case .custom(let icon, _): return icon
      }
    }
  }
}

private struct PBToast_Previews: PreviewProvider {  
  private static var previews: some View {
    registerFonts()
    if #available(iOS 16.0, *) {
      return ToastCatalog()
    } else {
      return EmptyView()
    }
  }
}
