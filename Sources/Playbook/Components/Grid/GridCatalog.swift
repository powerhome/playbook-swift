//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  GridCatalog.swift
//

import SwiftUI

public struct GridCatalog: View {
  @State private var count = 1
  @State private var users = Mocks.multipleUsers
  let tagCache: TagCache = TagCache.shared
  
  init() {
    self.tagCache.saveTagsList(Color.ProductColor.allCases.map {
      TagModel(
        text: $0.rawValue,
        horizontalPadding: CGFloat.random(in: 4...14),
        verticalPadding: CGFloat.random(in: 4...14),
        color: .product($0, category: .background)
      )
    })
  }
  
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultView }
        PBDoc(title: "Alignment") { alignmentView }
        PBDoc(title: "Spacing") { spacingView }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Grid")
  }
}

extension GridCatalog {
  var defaultView: some View {
    VStack(alignment: .leading) {
      PBGrid {
        ForEach(0..<count, id: \.self) { index in
          if count <= 4 {
            tagView(users[index].name)
          }
        }
      }
      .border(Color.pbPrimary, width: 1)
      Spacer()
      Stepper("Count: \(count)", value: $count, in: 0...tagCache.tags.count)
        .frame(maxWidth: .infinity)
        .padding()
        .onChange(of: count) { value in
          if value > 4 {
            count = 1
          }
        }
    }
  }
  
  var alignmentView: some View {
    return VStack(alignment: .leading, spacing: Spacing.medium) {
      gridView(title: "Leading", alignment: .leading, hSpace: 8, vSpace: 4)
      gridView(title: "Center", alignment: .center, hSpace: 8, vSpace: 4)
      gridView(title: "Trailing", alignment: .trailing, hSpace: 8, vSpace: 4)
    }
  }
  
  var spacingView: some View {
    return VStack(alignment: .leading, spacing: Spacing.medium) {
      return VStack(alignment: .leading, spacing: Spacing.medium) {
        gridView(title: "Horizontal", alignment: .leading, hSpace: 10, vSpace: 4)
        gridView(title: "Vertical", alignment: .leading, hSpace: 4, vSpace: 10)
        gridView(title: "Zero", alignment: .leading, hSpace: 0, vSpace: 0)
      }
    }
  }
  
  var fitContentView: some View {
    return VStack(alignment: .leading, spacing: Spacing.medium) {
      return VStack(alignment: .leading, spacing: Spacing.medium) {
        gridView(title: "True", alignment: .leading, hSpace: 8, vSpace: 4, fitContent: true)
        gridView(title: "False", alignment: .leading, hSpace: 8, vSpace: 4, fitContent: false)
      }
    }
  }
  
  func gridView(title: String, alignment: Alignment, hSpace: CGFloat, vSpace: CGFloat, fitContent: Bool = true) -> some View {
    VStack(alignment: .leading) {
      Text(title).pbFont(.caption)
      PBGrid(alignment: alignment, horizontalSpacing: hSpace, verticalSpacing: vSpace, fitContent: fitContent) {
        ForEach(users, id: \.name) { user in
          tagView("\(user.name)")
        }
      }
      .overlay {
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(Color.text(.light), lineWidth: 1)
      }
      .clipShape(RoundedRectangle(cornerRadius: BorderRadius.medium, style: .circular))
    }
  }
  func tagView(_ tag: String) -> some View {
    Text(tag)
      .pbFont(.title4, variant: .bold, color: .white)
      .foregroundColor(Color.white)
      .padding(.horizontal, CGFloat.random(in: 4...14))
      .padding(.vertical,  CGFloat.random(in: 4...14))
      .background(Color.text(.default))
      .cornerRadius(16)
  }

  struct TagModel: Identifiable {
    let id = UUID()
    let text: String
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let color: Color
  }
}

final class TagCache {
  static let shared = TagCache()
  private var tagsList: [GridCatalog.TagModel] = []
  var tags: [GridCatalog.TagModel] { return tagsList }

  func saveTagsList(_ tags: [GridCatalog.TagModel]) {
    tagsList = tags
  }
}

#Preview {
  registerFonts()
  return GridCatalog()
}
