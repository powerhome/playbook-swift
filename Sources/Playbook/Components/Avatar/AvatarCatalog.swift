//
//  AvatarCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct AvatarCatalog: View {

  public init() {}

  public var body: some View {
    List {
      Section("Default") {
        defaultAvatars
      }

      Section("Monogram") {
        monograms
      }
    }
    .navigationTitle("Avatar")
  }

  var defaultAvatars: some View {
    VStack(alignment: .leading) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .xxSmall, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xLarge, status: .offline)
    }
  }

  var monograms: some View {
    VStack(alignment: .leading) {
      PBAvatar(name: "Tim Wenhold", size: .xxSmall, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .xSmall, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .small, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .medium, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .large, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .xLarge, status: .offline)
    }
  }
}
