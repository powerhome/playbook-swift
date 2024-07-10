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
  let hasIcon: Bool
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let label: String?
  let showLabelIndex: Bool
  let progressBarWidth: CGFloat
  let progressBarHeight: CGFloat
  let steps: Int
  @Binding var progress: Int
  
  public init(
    hasIcon: Bool = true,
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .custom(9),
    label: String? = nil,
    showLabelIndex: Bool = false,
    progressBarWidth: CGFloat = 100,
    progressBarHeight: CGFloat = 4,
    steps: Int = 3,
    progress: Binding<Int> = .constant(1)
  ) {
    self.hasIcon = hasIcon
    self.icon = icon
    self.iconSize = iconSize
    self.label = label
    self.showLabelIndex = showLabelIndex
    self.progressBarWidth = progressBarWidth
    self.progressBarHeight = progressBarHeight
    self.steps = steps
    self._progress = progress
  }
  
  public var body: some View {
    progressStepsView
  }
}

public extension PBProgressStep {
  @ViewBuilder
  var progressStepsView: some View {
    HStack(spacing: Spacing.none) {
      ForEach(1...steps, id: \.hashValue) { step in
        circleIconView(isActive: progress == 0  || step != progress + 1 ? false : true, isComplete: progress >= step ? true : false)
          .globalPosition(alignment: .bottom, bottom: -30, isCard: false) {
            labelView(index: step - 1, label: label)
          }
        if step < steps {
          progressView(isComplete: step <= progress ? true : false)
        }
      }
    }
  }
  
  func circleView(isActive: Bool, isComplete: Bool) -> some View {
    Circle()
      .strokeBorder(isActive ? Color.pbPrimary : Color.white, lineWidth: 2)
      .frame(width: isActive ? 15 : 20, height: isActive ? 15 : 20)
      .background(Circle().fill(isComplete ? Color.pbPrimary : isActive ? Color.clear : Color.border))
  }
  
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    VStack(spacing: Spacing.small) {
      circleView(isActive: isActive, isComplete: isComplete)
        .overlay {
          PBIcon(icon, size: iconSize)
            .foregroundStyle(isComplete || isActive ? Color.white : Color.border)
            .opacity(isComplete && hasIcon ? 1 : 0)
        }
        .padding(.horizontal, isActive ? 2 : 0)
    }
  }
  
  func progressView(isComplete: Bool) -> some View {
    HStack(spacing: 0) {
      RoundedRectangle(cornerRadius: 2)
        .frame(width: progressBarWidth, height: progressBarHeight)
        .foregroundStyle(isComplete ? Color.pbPrimary : Color.border)
    }
  }
  
  func labelView(index: Int, label: String?) -> some View {
    VStack {
      if let label = self.label  {
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
