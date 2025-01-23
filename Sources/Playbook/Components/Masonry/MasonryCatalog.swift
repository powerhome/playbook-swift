//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MasonryCatalog.swift
//

import SwiftUI

public struct MasonryCatalog: View {

  let imageData = [
     ImageModel(image: Image(.andrew)),
     ImageModel(image: Image(.anna)),
     ImageModel(image: Image(.lu)),
     ImageModel(image: Image(.pat)),
     ImageModel(image: Image(.julie)),
     ImageModel(image: Image(.anna)),
     ImageModel(image: Image(.pat)),
     ImageModel(image: Image(.ronnie)),
     ImageModel(image: Image(.andrew)),
     ImageModel(image: Image(.anna)),
     ImageModel(image: Image(.lu)),
     ImageModel(image: Image(.julie)),
     ImageModel(image: Image(.ronnie)),
     ImageModel(image: Image(.julie)),
     ImageModel(image: Image(.anna)),
     ImageModel(image: Image(.lu)),
     ImageModel(image: Image(.ronnie)),
     ImageModel(image: Image(.andrew))
   ]



  public var body: some View {

      imageMasonryView
    }
}

extension MasonryCatalog {

  var imageMasonryView: some View {

    PBMasonry(numOfColumns: 3, horizontalSpacing: 10, verticalSpacing: 10, items: imageData) { item in
      
      item.image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipped()
    }
    .padding(.horizontal, 5)
  }

}
#Preview {
    MasonryCatalog()
}
