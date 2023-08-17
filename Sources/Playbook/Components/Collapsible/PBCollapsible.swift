//
//  PBCollapsible.swift
//
//
//  Created by Lucas C. Feijo on 10/08/21.
//

import SwiftUI

public struct PBCollapsible<HeaderContent: View, Content: View>: View {
  @Binding private var isCollapsed: Bool
  var indicatorPosition: IndicatorPosition
  var indicatorColor: Color
  var headerView: HeaderContent
  var contentView: Content
  var iconSize: PBIcon.IconSize
  var iconColor: IconColor

  public init(
    isCollapsed: Binding<Bool> = .constant(false),
    indicatorPosition: IndicatorPosition = .trailing,
    indicatorColor: Color = .text(.light),
    @ViewBuilder header: @escaping () -> HeaderContent,
    @ViewBuilder content: @escaping () -> Content,
    iconSize: PBIcon.IconSize = .small,
    iconColor: IconColor = .default
  ) {
    _isCollapsed = isCollapsed
    self.indicatorPosition = indicatorPosition
    self.indicatorColor = indicatorColor
    headerView = header()
    contentView = content()
    self.iconSize = iconSize
    self.iconColor = iconColor
  }

  var indicator: some View {
    PBIcon.fontAwesome(.chevronDown, size: iconSize)
      .foregroundColor(.text(.default))
      .padding(Spacing.xxSmall)
      .rotationEffect(
        .degrees(isCollapsed ? 0 : 180)
      )
  }

  public var body: some View {
    VStack {
      Button {
        withAnimation {
          isCollapsed.toggle()
        }
      } label: {
        if indicatorPosition == .leading {
          indicator
          headerView
          Spacer()
        } else {
          headerView
          Spacer()
          indicator
        }
      }
      .tint(indicatorColor)
      .buttonStyle(BorderlessButtonStyle())

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
}

// MARK: - Extensions

public extension PBCollapsible {
  enum IndicatorPosition {
    case leading
    case trailing
  }

  enum IconColor {
    case `default`
    case light
    case lighter
    case link
    case error
    case success
  }
}

public struct PBCollapsible_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return CollapsibleCatalog()
  }
}
