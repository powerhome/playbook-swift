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
  let label: String?
  let showLabelIndex: Bool
  let progressBarWidth: CGFloat
  let progressBarHeight: CGFloat
  @Binding var hasIcon: Bool
  @Binding var isActive: [Bool]
  @Binding var isComplete: [Bool]
  @Binding var active: Int
  
  public init(
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .custom(9),
    label: String? = nil,
    showLabelIndex: Bool = false,
    progressBarWidth: CGFloat = 125,
    progressBarHeight: CGFloat = 4,
    active: Binding<Int> = .constant(9),
    hasIcon: Binding<Bool> = .constant(true),
    isActive: Binding<[Bool]> = .constant([false, true, false]),
    isComplete: Binding<[Bool]> = .constant([true, false, false])
  ) {
    self.icon = icon
    self.iconSize = iconSize
    self.label = label
    self.showLabelIndex = showLabelIndex
    self.progressBarWidth = progressBarWidth
    self.progressBarHeight = progressBarHeight
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
  func progressStepView() -> some View {
    HStack(spacing: Spacing.none) {
      ForEach(isActive.indices, id: \.self) { index in
        circleIconView(
          isActive: isActive[index],
          isComplete: isComplete[index]
        )
        .globalPosition(alignment: .bottom, bottom: -30, isCard: false) {
          labelView(index: index, label: label)
            .padding(.top, 5)
        }
        if index < isActive.count - 1 {
          progressView(isComplete: isComplete[index])
        }
      }
    }
  }
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    Circle()
      .strokeBorder(isActive ? Color.pbPrimary : Color.white, lineWidth: 2)
      .background(Circle().fill(isComplete ? Color.pbPrimary : isActive ? Color.clear : Color.border))
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
        .frame(width: progressBarWidth, height: progressBarHeight)
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
