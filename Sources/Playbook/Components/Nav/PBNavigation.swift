//
//  PBNavigation.swift
//  Playbook
//
//  Created by Lucas C. Feijo on 14/06/22.
//

import SwiftUI

struct PBNavigation<Item: Equatable & Identifiable, Content: View>: View {
  var items: [Item]
  @Binding var selected: Item
  var variant: PBNavigationVariant
  var orientation: Orientation
  var border: Bool = true
  var renderOption: (Item) -> Content

  init(
    _ items: [Item],
    selected: Binding<Item>,
    variant: PBNavigationVariant = .normal,
    orientation: Orientation = .vertical,
    @ViewBuilder renderOption: @escaping (Item) -> Content
  ) {
    self.items = items
    self._selected = selected
    self.variant = variant
    self.orientation = orientation
    self.renderOption = renderOption
  }

  func item(_ item: Item) -> some View {
    VStack(alignment: .leading, spacing: 0) {
//      HStack(spacing: 0) {
        PBNavigationItem(
          label: "lll",
          selected: selected == item,
          variant: variant,
          orientation: orientation,
          onTap: { selected = item },
          content: { HStack { renderOption(item) } }
        )
//      }

      if orientation == .vertical, variant == .normal, border {
        Divider()
      }
    }
  }

  var contentItems: some View {
    ForEach(items) { option in
      item(option)
    }
  }

  var spacing: CGFloat {
    return variant == .normal ? 0 : 2
  }

  var body: some View {
    if orientation == .horizontal {
      HStack(spacing: spacing) {
        contentItems
      }
    } else {
      VStack(spacing: spacing) {
        contentItems
      }
    }
  }
}

struct PBNavigation_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return NavigationCatalog()
  }
}
