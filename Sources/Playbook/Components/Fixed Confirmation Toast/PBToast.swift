//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBToast.swift
//

import SwiftUI

public struct PBToast: View {
  let text: String?
  let font: PBFont
  let variant: Variant
  let animatedIcon: AnyView?
  let actionView: DismissAction?
  let dismissAction: (() -> Void)
  let content: (() -> AnyView)?
  public init(
    text: String? = nil,
    font: PBFont = .title4,
    variant: Variant = .custom(nil, .clear),
    animatedIcon: AnyView? = nil,
    actionView: DismissAction? = nil,
    dismissAction: @escaping (() -> Void),
    content: (() -> AnyView)? = nil
  ) {
    self.text = text
    self.font = font
    self.variant = variant
    self.animatedIcon = animatedIcon
    self.actionView = actionView
    self.dismissAction = dismissAction
    self.content = content
  }

  public var body: some View {
    HStack {
      if let animatedIcon {
        animatedIcon
      } else if let icon = variant.icon {
        PBIcon.fontAwesome(icon, size: .x1)
      }
      if let text = text {
        Text(text)
          .pbFont(font, color: .white)
          .padding(.horizontal, Spacing.medium)
      }
      if let content = content {
        content()
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
                DispatchQueue.main.asyncAfter(deadline: .now() + time) { dismissAction() }
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

#Preview {
  registerFonts()
  return PBToast(text: "Items Successfully Moved", variant: .success, dismissAction: {})
}
