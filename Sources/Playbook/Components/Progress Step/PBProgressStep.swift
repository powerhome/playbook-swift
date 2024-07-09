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
  let label: String?
  let showLabelIndex: Bool
  @Binding var hasIcon: Bool
  @Binding var isActive: [Bool]
  @Binding var isComplete: [Bool]
  @Binding var active: Int
  
  public init(
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .xSmall,
    variant: Variant = .horizontal,
    label: String? = nil,
    showLabelIndex: Bool = false,
    active: Binding<Int> = .constant(2),
    hasIcon: Binding<Bool> = .constant(true),
    isActive: Binding<[Bool]> = .constant([false, true, false]),
    isComplete: Binding<[Bool]> = .constant([true, false, false])
  ) {
    self.icon = icon
    self.iconSize = iconSize
    self.variant = variant
    self.label = label
    self.showLabelIndex = showLabelIndex
    self._active = active
    self._hasIcon = hasIcon
    self._isActive = isActive
    self._isComplete = isComplete
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
    HStack(spacing: Spacing.none) {
      ForEach(isActive.indices, id: \.self) { index in
        iconView(
          isActive: isActive[index],
          isComplete: isComplete[index]
        )
        .globalPosition(alignment: .bottom, bottom: -100, isCard: false) {
          labelView(index: index, label: label)
        }
        if index < isActive.count - 1 {
          progressView(isComplete: isComplete[index])
        }
      }
    }
  }
  func iconView(isActive: Bool, isComplete: Bool) -> some View {
    Circle()
      .strokeBorder(isActive ? Color.pbPrimary : Color.white, lineWidth: 2)
      .background(Circle().fill(isComplete ? Color.pbPrimary : isActive ? Color.white : Color.border))
      .frame(width: isActive ? 15 : 20, height: isActive ? 15 : 20)
      .overlay {
        PBIcon(icon, size: iconSize)
          .foregroundStyle(isComplete || isActive ? Color.white : Color.border)
          .opacity(isComplete && hasIcon ? 1 : 0)
      }
      .padding(.horizontal, isActive ? 2 : 0)
  }
  func progressView(isComplete: Bool) -> some View {
    HStack(spacing: 0) {
      RoundedRectangle(cornerRadius: 2)
        .frame(width: 125, height: 5)
        .foregroundStyle(isComplete ? Color.pbPrimary : Color.border)
    }
  }
  func labelView(index: Int, label: String?) -> some View {
    HStack {
      if let label = self.label {
        
        
        Text(showLabelIndex ? "\(label) \(index + 1)" : "\(label)")
          .pbFont(.subcaption, variant: .bold, color: .text(.default))
        
      }
    }
  }
}

#Preview {
  registerFonts()
  return PBProgressStep()
}
