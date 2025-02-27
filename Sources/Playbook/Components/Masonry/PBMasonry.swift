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
  @State private var isLoading: Bool = true
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
    masonryScrollView
  }
}

public extension PBMasonry {
  struct Column: Identifiable {
    public let id: UUID = UUID()
    var gridItems: [Item] = []
  }

  var masonryScrollView: some View {
    ScrollView {
      if isLoading {
        skeletonGrid
      } else {
        masonryGrid
      }
    }
    .scrollIndicators(.hidden)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now()) {
        isLoading = false
      }
    }
  }

  var skeletonGrid: some View {
    HStack(alignment: .top, spacing: horizontalSpacing) {
      ForEach(0..<numOfColumns, id: \.self) { column in
        VStack(spacing: verticalSpacing) {
          ForEach(0..<20) { _ in
            RoundedRectangle(cornerRadius: 5)
              .foregroundStyle(Color.text(.lighter).opacity(0.2))
              .frame(minWidth: 20)
              .frame(maxWidth: frameReader(in: { _ in}) as? CGFloat)
              .frame(height: randomHeight())
              .clipped()
          }
        }
      }
    }
  }

  var masonryGrid: some View {
    HStack(alignment: .top, spacing: horizontalSpacing) {
      ForEach(distributedColumns) { column in
        VStack(spacing: verticalSpacing) {
          ForEach(column.gridItems) { item in
            content(item)
              .frame(minWidth: 20)
              .frame(maxWidth: frameReader(in: { _ in}) as? CGFloat)
              .frame(height: randomHeight())
              .clipShape(RoundedRectangle(cornerRadius: 5))
          }
        }
      }
    }
  }

  var distributedColumns: [Column] {
    (0..<numOfColumns).map { columnIndex in
      let itemsPerColumn = items.count / numOfColumns
      let remainder = items.count % numOfColumns

      let startIndex = columnIndex * itemsPerColumn + min(columnIndex, remainder)
      let endIndex = startIndex + itemsPerColumn + (columnIndex < remainder ? 1 : 0)

      return Column(gridItems: Array(items[startIndex..<min(endIndex, items.count)]))
    }
  }

  private func randomHeight() -> CGFloat {
    CGFloat.random(in: itemSizeRange)
  }
}
