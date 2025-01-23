//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBMasonry.swift
//

import SwiftUI

public struct PBMasonry<Item: Identifiable, Content: View>: View {

  let numOfColumns: Int
  let horizontalSpacing: CGFloat
  let verticalSpacing: CGFloat
  let itemSizeRange: ClosedRange<CGFloat>
  let items: [Item]
  let columns: [Column]
  var content: (Item) -> Content


  public init(
    numOfColumns: Int = 3,
    horizontalSpacing: CGFloat = 0,
    verticalSpacing: CGFloat = 0,
    items: [Item],
    columns: [Column] = [],
    itemSizeRange: ClosedRange<CGFloat> = 75...200,
    @ViewBuilder content: @escaping (Item) -> Content

  ) {
    self.numOfColumns = numOfColumns
    self.horizontalSpacing = horizontalSpacing
    self.verticalSpacing = verticalSpacing
    self.items = items
    self.columns = columns
    self.itemSizeRange = itemSizeRange
    self.content = content
  }

  public var body: some View {
    ScrollView {
         HStack(alignment: .top, spacing: horizontalSpacing) {
           ForEach(distributedColumns, id: \.id) { column in
            LazyVStack(spacing: verticalSpacing) {
              ForEach(column.gridItems) { item in
                content(item)
                  .frame(minWidth: 20)
                  .frame(maxWidth: frameReader(in: { _ in}) as? CGFloat)
                  .frame(height: randomHeight())
                  .clipped()
               }
             }
           }
         }
    }
    .scrollIndicators(.hidden)
  }
}

public extension PBMasonry {
  struct Column: Identifiable {
    public let id: UUID = UUID()
    var gridItems: [Item] = []
  }

  var distributedColumns: [Column] {
      var columns = (0..<numOfColumns).map { _ in Column() }

      let itemsPerColumn = items.count / numOfColumns
      let remainder = items.count % numOfColumns

      var startIndex = 0
      for columnIndex in 0..<numOfColumns {

        let columnsItemCount = itemsPerColumn + (columnIndex < remainder ? 1 : 0)
        let endIndex = min(startIndex + columnsItemCount, items.count)
        
        columns[columnIndex].gridItems = Array(items[startIndex..<endIndex])

        startIndex = endIndex
      }

      return columns
    }

  private func randomHeight() -> CGFloat {
    CGFloat.random(in: itemSizeRange)
  }
}

struct ImageModel: Identifiable {
  let id: UUID = UUID()
  let image: Image

}

