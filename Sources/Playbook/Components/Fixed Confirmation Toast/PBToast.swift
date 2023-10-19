//
//  PBToast.swift
//
//
//  Created by Isis Silva on 16/10/23.
//

import SwiftUI

public struct PBToast: View {
  let text: String
  let variant: Variant
  let actionIcon: (FontAwesome, (() -> Void))?

  public init(
    text: String,
    variant: Variant,
    actionIcon: (FontAwesome, (() -> Void))? = nil
  ) {
    self.text = text
    self.variant = variant
    self.actionIcon = actionIcon
  }
  
  public var body: some View {
    HStack {
      if let icon = variant.icon {
        PBIcon.fontAwesome(icon)
      }
      Text(text)
        .pbFont(.title4, color: .white)
        .padding(.horizontal, 24)
      
      Button(action: {}) {
        PBIcon.fontAwesome(.times)
      }
      }
      .foregroundColor(.white)
      .padding(7)
      .padding(.horizontal)
      .background(
        Capsule().fill(variant.color())
      )
    }
  
  public enum Variant {
    case error, success, neutral, custom(FontAwesome? = nil, Color)
    
    func color(_ custom: Color = .pbPrimary) -> Color {
      switch self {
        
      case .error: .status(.error)
      case .success: .status(.success)
      case .neutral: .status(.neutral)
      case .custom(_, let color): color
      }
    }
    
    var icon: FontAwesome? {
      switch self {
      case .error: .exclamationTriangle
      case .success: .check
      case .neutral: .infoCircle
      case .custom(let icon, _): icon
      }
    }
  }
}

#Preview {
  registerFonts()
  @State var presentToast: Bool = false
  return ToastCatalog()
}
