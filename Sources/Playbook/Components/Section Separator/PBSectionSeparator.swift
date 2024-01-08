//
//  PBSectionSeparator.swift
//
//
//  Created by Alexandre Hauber on 25/07/21.
//

import SwiftUI

public struct PBSectionSeparator<Content>: View where Content: View {
  var text: String?
  var orientation: Orientation
  var variant: Variant
  var dividerOpacity: CGFloat
  var content: () -> Content?
  var margin: CGFloat

  public init(
    _ text: String? = nil,
    orientation: Orientation = .horizontal,
    variant: Variant = .card,
    dividerOpacity: CGFloat? = 1,
    margin: CGFloat = Spacing.xSmall,
    @ViewBuilder content: @escaping () -> Content? = { nil }
  ) {
    self.text = text
    self.orientation = orientation
    self.variant = variant
    self.dividerOpacity = dividerOpacity ?? 1
    self.content = content
    self.margin = margin
  }

  @ViewBuilder
  private var dividerView: some View {
    switch variant {
    case .dashed:
      PBLine()
        .stroke(Color.border, style: StrokeStyle(lineWidth: 1, dash: [3, 2]))
        .frame(height: 1)
    default:
      PBLine()
        .frame(height: 1)
        .background(Color.border)
    }
  }

  private var textPadding: EdgeInsets {
    switch variant {
    case .dashed: return EdgeInsets(.init(top: 4, leading: Spacing.xSmall, bottom: 4, trailing: Spacing.xSmall))
    default: return EdgeInsets(.init(top: 0, leading: Spacing.xSmall, bottom: 0, trailing: Spacing.xSmall))
    }
  }

  var divider: some View {
    VStack { dividerView.frame(minWidth: 24) }
      .opacity(dividerOpacity)
  }

  public var body: some View {
    if orientation == .horizontal {
      HStack(alignment: .center, spacing: Spacing.none, content: {
        divider

        if let text = text, !text.isEmpty {
          Text(text)
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
      }).frame(maxWidth: .infinity)

    } else {
      Divider()
        .background(Color.border)
        .frame(width: 1)
        .padding(.horizontal, margin)
    }
  }
}

public extension PBSectionSeparator where Content == EmptyView {
  init(_ text: String? = nil, orientation: Orientation = .horizontal, variant: Variant = .card) {
    self.init(text, orientation: orientation, variant: variant, content: { EmptyView() })
  }
}

public extension PBSectionSeparator {
  enum Variant {
    case dashed
    case card
  }
}

public struct PBSectionSeparator_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    return SectionSeparatorCatalog()
  }
}
