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

    public init(isCollapsed: Binding<Bool> = .constant(false),
                indicatorPosition: IndicatorPosition = .leading,
                indicatorColor: Color = .pbTextLight,
                @ViewBuilder header: @escaping () -> HeaderContent,
                @ViewBuilder content: @escaping () -> Content) {
        _isCollapsed = isCollapsed
        self.indicatorPosition = indicatorPosition
        self.indicatorColor = indicatorColor
        self.headerView = header()
        self.contentView = content()
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
                    headerView
                    Spacer()
                } else {
                    headerView
                    Spacer()
                    indicator
                }
            }.tint(indicatorColor)

            contentView
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

        let lorem = """
        Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.

        Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.

        Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
        """

        var header: some View {
            Label(
                title: { Text("Members").pbFont(.title4) },
                icon: { PBIcon.fontAwesome(.users) }
            )
        }

        var content: some View {
            Text(lorem)
                .pbFont(.body())
                .fixedSize(horizontal: false, vertical: true)
        }

        var image: some View {
            PBImage(
                image: Image("Forest", bundle: .module),
                size: .large
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
                        header
                    } content: {
                        image
                    }
                }
                .padding()
            }
        }
    }
}
