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
    indicatorColor: Color = .pbTextLight,
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

      contentView
        .fixedSize(horizontal: false, vertical: true)
        .pbFont(.body())
        .padding(.bottom, .pbXsmall)
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

struct PBCollapsible_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return Preview()
  }

  struct Preview: View {
    @State var isCollapsed = false
    @State var isCollapsedTrailing = true
    @State var isCollapsedImage = true

    let lorem =
      """
      Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.

      Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.

      Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
      """

    var header: some View {
      Label(
        title: { Text("Title with Icon, Chevron Left") },
        icon: { PBIcon.fontAwesome(.users) }
      )
    }

    var textOnlyHeader: some View {
      Text("Title with Only Text, Chevron Right")
    }

    var imageHeader: some View {
      Text("Image")
    }

    var content: some View {
      Text(lorem)
    }

    var image: some View {
      PBImage(
        image: Image("Forest", bundle: .module),
        size: .none
      )
    }

    var body: some View {
      GeometryReader { _ in
        VStack {
          PBCollapsible(isCollapsed: $isCollapsed) {
            header
          } content: {
            content
          }

          PBCollapsible(isCollapsed: $isCollapsedTrailing, indicatorPosition: .trailing) {
            textOnlyHeader
          } content: {
            content
          }

          PBCollapsible(isCollapsed: $isCollapsedImage, indicatorPosition: .trailing) {
            imageHeader
          } content: {
            image
          }
        }
        .padding()
      }
    }
  }
}
