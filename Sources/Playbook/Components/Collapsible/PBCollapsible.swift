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

  public init(
    isCollapsed: Binding<Bool> = .constant(false),
    indicatorPosition: IndicatorPosition = .leading,
    indicatorColor: Color = .text(.light),
    @ViewBuilder header: @escaping () -> HeaderContent,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _isCollapsed = isCollapsed
    self.indicatorPosition = indicatorPosition
    self.indicatorColor = indicatorColor
    headerView = header()
    contentView = content()
  }

  var indicator: some View {
    PBIcon.fontAwesome(.chevronDown, size: .small)
      .padding(.pbXxsmall)
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
          headerView.pbFont(.title4)
          Spacer()
        } else {
          headerView.pbFont(.title4)
          Spacer()
          indicator
        }
      }
      .tint(indicatorColor)
      .buttonStyle(BorderlessButtonStyle())

      VStack {
        if !isCollapsed {
          contentView
            .padding(.bottom, .pbXsmall)
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
}

public struct PBCollapsible_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return CollapsibleCatalog()
  }
}
