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
  
  private var isLink: Bool {
    if let actionView, case .link = actionView {
      return true
    } else {
      return false
    }
  }
  
  public var body: some View {
    HStack {
      if let animatedIcon {
        animatedIcon
      } else if let icon = variant.icon {
        PBIcon.fontAwesome(icon, size: .x1)
      }
      
#if os(iOS)
      if let actionView {
        switch actionView {
        case .link:
          VStack {
            textContent
          }
        default:
          textContent
        }
      } else {
        textContent
      }
#else
      textContent
#endif
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
      Capsule().foregroundStyle(AnyShapeStyle(variant.color()))
    )
    .pbShadow(.deeper)
  }
  
  @ViewBuilder
  private var textContent: some View {
    Group {
      if let text = text {
        Text(text)
          .pbFont(font, color: .white)
#if os(iOS)
          .padding(.horizontal, Spacing.medium)
#else
          .padding(self.isLink ? .leading : .horizontal, Spacing.medium)
#endif
      }
      if let content = content {
        content()
      }
      
      if let dismiss = actionView, let view = dismiss.view {
        view.onTapGesture {
          dismissAction()
        }
#if os(macOS)
        .padding(.trailing, self.isLink ? Spacing.small : 0)
#else
        .padding(.top, self.isLink ? -Spacing.xSmall : 0)
#endif
      }
    }
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
    case `default`, custom(AnyView), withTimer(TimeInterval), link(String)
    
    var view: AnyView? {
      switch self {
      case .default: return AnyView(PBIcon.fontAwesome(.times))
      case .custom(let view): return view
      case .withTimer: return nil
      case .link(let text): return AnyView(
        Text(text)
          .underline()
          .pbFont(.title4, color: .white)
          .padding(.leading, -Spacing.xxSmall)
      )
      }
    }
  }
  
  enum Variant {
    case error, success, neutral, tip(FontAwesome? = .infoCircle), custom(FontAwesome? = nil, Color)
    func color(_ custom: Color = .pbPrimary) -> any ShapeStyle   {
      switch self {
      case .error: return Color.status(.error)
      case .success: return Color.status(.success)
      case .neutral: return Color.text(.light)
      case .tip(_): return Color.gradientBackground(.gradient)
      case .custom(_, let color): return color
      }
    }
    var icon: FontAwesome? {
      switch self {
      case .error: return FontAwesome.exclamationTriangle
      case .success: return FontAwesome.check
      case .neutral: return FontAwesome.infoCircle
      case .tip(let icon): return icon
      case .custom(let icon, _): return icon
      }
    }
  }
}

#Preview {
  registerFonts()
  return PBToast(text: "Items Successfully Moved", variant: .success, dismissAction: {})
}
