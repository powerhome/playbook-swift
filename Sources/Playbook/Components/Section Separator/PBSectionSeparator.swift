//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBSectionSeparator.swift
//

import SwiftUI

public struct PBSectionSeparator<Content>: View where Content: View {
    var text: String?
    var orientation: Orientation
    var variant: Variant
    var dividerOpacity: CGFloat
    var dividerColor: Color
    var textColor: Color
    var content: () -> Content?
    var margin: CGFloat

    public init(
        _ text: String? = nil,
        orientation: Orientation = .horizontal,
        variant: Variant = .card,
        dividerOpacity: CGFloat? = 1,
        dividerColor: Color = .border,
        textColor: Color = .text(.light),
        margin: CGFloat = Spacing.xSmall,
        @ViewBuilder content: @escaping () -> Content? = { nil }
    ) {
        self.text = text
        self.orientation = orientation
        self.variant = variant
        self.dividerOpacity = dividerOpacity ?? 1
        self.dividerColor = dividerColor
        self.textColor = textColor
        self.content = content
        self.margin = margin
    }

    public var body: some View {
        dividerView
    }
}

public extension PBSectionSeparator where Content == EmptyView {
    init(_ text: String? = nil, orientation: Orientation = .horizontal, variant: Variant = .card, dividerColor: Color? = .border, textColor: Color? = .text(.light)) {
        self.init(text, orientation: orientation, variant: variant, dividerColor: dividerColor ?? .border, textColor: textColor ?? .text(.light), content: { EmptyView() })
    }
}

public extension PBSectionSeparator {
    enum Variant {
        case dashed
        case card
    }
    var dividerView: some View {
        Group {
            if orientation == .horizontal {
                HStack(alignment: .center, spacing: Spacing.none) {
                    divider

                    if let text = text, !text.isEmpty {
                        Text(text)
                            .foregroundStyle(textColor)
                            .pbFont(.caption)
                            .padding(textPadding)
                            .background(Color.clear)
                            .layoutPriority(1)
                            .lineLimit(1)

                        divider
                    } else if let content = content() {
                        content
                            .layoutPriority(1)
                        divider
                    }
                }
                .frame(maxWidth: .infinity)

            } else {
                VStack(spacing: Spacing.xSmall) {
                    dividerVariantView
                        .frame(width: 1)
                        .background(dividerColor)

                    if let text = text, !text.isEmpty {
                        Text(text)
                            .foregroundStyle(textColor)
                            .pbFont(.caption)
                            .padding(textPadding)
                            .background(Color.clear)
                            .layoutPriority(1)
                            .lineLimit(1)
                        dividerVariantView
                            .frame(width: 1)
                            .background(dividerColor)
                    } else if let content = content() {
                        content
                            .layoutPriority(1)
                        divider
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var dividerVariantView: some View {
        switch variant {
        case .dashed:
            PBLine()
                .stroke(dividerColor, style: StrokeStyle(lineWidth: 1, dash: [3, 2]))
        default:
            PBLine()
                .background(dividerColor)
        }
    }

    var divider: some View {
        VStack {
            dividerVariantView.frame(minWidth: 24)
                .frame(height: 1)
        }
        .opacity(dividerOpacity)
    }

    private var textPadding: EdgeInsets {
        switch variant {
        case .dashed: return EdgeInsets(.init(top: 4, leading: Spacing.xSmall, bottom: 4, trailing: Spacing.xSmall))
        default: return EdgeInsets(.init(top: 0, leading: Spacing.xSmall, bottom: 0, trailing: Spacing.xSmall))
        }
    }
}

#Preview {
    registerFonts()
    return PBSectionSeparator()
}
