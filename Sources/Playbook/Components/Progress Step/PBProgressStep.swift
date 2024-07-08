//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBProgressStep.swift
//

import SwiftUI

public struct PBProgressStep: View {
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let variant: Variant
  @Binding var isActive: [Bool]
  @Binding var isComplete: [Bool]
  @Binding var isInactive: [Bool]
  @Binding var isBarComplete: Bool
  let hasIcon: Bool
  
  public init(
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .xSmall,
    variant: Variant = .horizontal,
    isActive: Binding<[Bool]> = .constant([false, true, false]),
    isComplete: Binding<[Bool]> = .constant([true, false, false]),
    isInactive: Binding<[Bool]> = .constant([false, false, true]),
    isBarComplete: Binding<Bool> = .constant(false),
    hasIcon: Bool = false
  ) {
    self.icon = icon
    self.iconSize = iconSize
    self.variant = variant
    self._isActive = isActive
    self._isComplete = isComplete
    self._isInactive = isInactive
    self._isBarComplete = isBarComplete
    self.hasIcon = hasIcon
  }
    public var body: some View {
      progressStepView()
      
    }
}

public extension PBProgressStep {
  enum Variant {
    case vertical, horizontal
  }
  func progressStepView() -> some View {
      HStack(spacing: 0) {
        ForEach(isActive.indices, id: \.self) { index in
          iconView(
            isActive: isActive[index],
            isComplete: isComplete[index],
            isInactive: isInactive[index]
          )
          if index < isActive.count - 1 {
            progressView(isComplete: isComplete[index])
          }
        }
      }
    }
  func iconView(isActive: Bool, isComplete: Bool, isInactive: Bool) -> some View {
      Circle()
        .strokeBorder(isActive ? Color.pbPrimary : Color.white, lineWidth: 2.5)
        .background(Circle().fill(isComplete ? Color.pbPrimary : isActive ? Color.white : Color.border))
        .frame(width: 20, height: 20)
        .overlay {
          PBIcon(icon, size: iconSize)
            .foregroundStyle(isComplete || isActive ? Color.white : Color.border)
            .opacity(isComplete || hasIcon ? 1 : 0)
        }
        .padding(.horizontal, isActive ? 3 : 0)
    }

  func progressView(isComplete: Bool) -> some View {
      HStack(spacing: 0) {
        RoundedRectangle(cornerRadius: 2)
          .frame(width: 100, height: 5)
          .foregroundStyle(isComplete ? Color.pbPrimary : Color.border)
      }
    }
}
#Preview {
  registerFonts()
   return PBProgressStep()
}
