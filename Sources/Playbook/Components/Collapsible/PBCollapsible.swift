//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCollapsible.swift
//

import SwiftUI

public struct PBCollapsible<HeaderContent: View, Content: View>: View {
  @Binding var isCollapsed: Bool
  var indicatorPosition: IndicatorPosition
  var indicatorColor: Color
  var headerView: HeaderContent
  var contentView: Content
  var iconSize: PBIcon.IconSize
  var iconColor: CollapsibleIconColor
  var actionButton: PBButton?

  public init(
    isCollapsed: Binding<Bool> = .constant(false),
    indicatorPosition: IndicatorPosition = .leading,
    indicatorColor: Color = .text(.light),
    iconSize: PBIcon.IconSize = .small,
    iconColor: CollapsibleIconColor = .default,
    actionButton: PBButton? = nil,
    @ViewBuilder header: @escaping () -> HeaderContent,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _isCollapsed = isCollapsed
    self.indicatorPosition = indicatorPosition
    self.indicatorColor = indicatorColor
    self.actionButton = actionButton
    headerView = header()
    contentView = content()
    self.iconSize = iconSize
    self.iconColor = iconColor
  }

  public var body: some View {
    fullHeaderView
  }
}


public extension PBCollapsible {
  enum IndicatorPosition {
    case leading
    case trailing
  }

  var fullHeaderView: some View {
    VStack {
      HStack {
        if indicatorPosition == .leading {
          chevronHeaderView
          Spacer()
          actionButtonView
        } else {
          actionButtonView
          chevronHeaderView
        }
      }
      dropdownContentView
    }
  }

  var chevronHeaderView: some View {
    Button {
      withAnimation {
        isCollapsed.toggle()
      }
    } label: {
      HStack {
        if indicatorPosition == .leading {
          indicator
          headerView
        } else {
          headerView
          Spacer()
          indicator
        }

      }
    }
    .buttonStyle(BorderlessButtonStyle())
    .tint(indicatorColor)
  }

  var indicator: some View {
    PBIcon.fontAwesome(.chevronDown, size: iconSize)
      .foregroundColor(iconColor.iconColor)
      .padding(Spacing.xxSmall)
      .rotationEffect(
        .degrees(isCollapsed ? 0 : 180)
      )
  }

  @ViewBuilder
  var actionButtonView: some View {
    if let button = actionButton {
      button
    }
  }

  var dropdownContentView: some View {
    VStack {
      if !isCollapsed {
        contentView
          .padding(.top, Spacing.small)
      }
    }
    .frame(maxWidth: .infinity)
    .fixedSize(horizontal: false, vertical: true)
    .frame(height: isCollapsed ? 0 : .none, alignment: .top)
    .clipped()
  }
}

public enum CollapsibleIconColor {
  case `default`
  case light
  case lighter
  case link
  case error
  case success

  var iconColor: Color {
    switch self {
    case .`default`: return .text(.default)
    case .light: return .text(.light)
    case .lighter: return .text(.lighter)
    case .link: return .pbPrimary
    case .error: return .status(.error)
    case .success: return .status(.success)
    }
  }
}
