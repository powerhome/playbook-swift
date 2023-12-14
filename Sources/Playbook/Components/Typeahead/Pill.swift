//
//  Pill.swift
//  
//
//  Created by Isis Silva on 13/11/23.
//

import SwiftUI

struct Pill: View {
  @Environment (\.active) var isActive: Bool
  @Environment (\.focus) var isFocus: Bool
  @Environment(\.hovering) var hovering: Bool
  @State private var isHovering: Bool = false
  private var shape =  Capsule()
  let icon: FontAwesome?
  let text: String
  let closeAction: (() -> Void)?

  init(_ text: String, icon: FontAwesome? = nil, closeAction: (() -> Void)? = nil) {
    self.text = text
    self.icon = icon
    self.closeAction = closeAction
  }

    var body: some View {
      HStack(spacing: Spacing.xSmall) {
        if let icon = icon {
          PBIcon.fontAwesome(icon)
        }
        Text(text)
          .font(.custom(ProximaNova.bold.rawValue, size: 14))
          .foregroundStyle(Color.text(.default))
        PBIcon(FontAwesome.times)
//          .onTapGesture {
//            closeAction?()
//          }
      }
      .padding(.vertical, Spacing.xSmall)
      .padding(.horizontal, Spacing.small )
      .background(backgroundColor)
      .clipShape(shape)
      .background(
        shape
          .stroke(lineWidth: borderWidth)
          .foregroundStyle(borderColor)
      )
      .onHover { hovering in
        isHovering = hovering
      }
      .frame(height: 27)
    }
}

private extension Pill {
  var backgroundColor: Color {
    if isActive {
      return .active
    } else if isHovering {
      return .hover
    } else {
      return .white
    }
  }

  var borderWidth: CGFloat {
    isFocus ? 2 : 1
  }

  var borderColor: Color {
    isFocus ? .pbPrimary : .border
  }
}

#Preview {
  registerFonts()
  return ScrollView {
    VStack(spacing: Spacing.medium) {
      
      
      PBDoc(title: "Default", spacing: Spacing.small) {
        HStack {
          Pill("Default")
          
          Pill("Default")
            .environment(\.focus, true)
          
          Pill("Default")
            .environment(\.active, true)
        }
        
        HStack {
          Pill("Default")
            .environment(\.hovering, true)
          
          Pill("Default")
            .environment(\.hovering, true)
            .environment(\.focus, true)
          
          Pill("Default")
            .environment(\.hovering, true)
            .environment(\.active, true)
            .environment(\.focus, true)
        }
      }

      PBDoc(title: "With icons") {
        Pill("Default", icon: .desktop)
      }
    }
    .padding(Spacing.medium)
  }
  .scrollDismissesKeyboard(.immediately)
  .background(Color.background(.light))
  .navigationTitle("Pill")
}
