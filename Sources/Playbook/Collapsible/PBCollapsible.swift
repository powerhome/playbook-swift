//
//  PBCollapsible.swift
//  
//
//  Created by Lucas C. Feijo on 10/08/21.
//

import SwiftUI

public struct PBCollapsible<HeaderContent: View, Content: View>: View {
    @Binding private var isCollapsed: Bool
    @State private var opacity = 1.0
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
            .foregroundColor(indicatorColor)
            .animation(.easeOut, value: true)
            .rotation3DEffect(
                .degrees(isCollapsed ? 180 : 0),
                axis: (x: 1.0, y: 1.0, z: 0.0)
            )
    }

    public var body: some View {
        VStack {
            HStack {
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
            .onTapGesture {
                isCollapsed.toggle()
            }
            .padding(.vertical, .pbXsmall)

            contentView
                .padding(.bottom, .pbXsmall)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: isCollapsed ? 0 : .none)
                .opacity(isCollapsed ? 0.4 : 1.0)
                .animation(.easeOut, value: true)
                .clipped()
                .transition(.moveBottom)
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

extension AnyTransition {
    static var moveBottom: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .scale(scale: 0.2, anchor: .topTrailing))
        let removal = AnyTransition.move(edge: .top)
        return .asymmetric(insertion: insertion, removal: removal)
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
            Text(lorem).pbFont(.body())
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
                        content
                    }
                }
            }
        }
    }
}
