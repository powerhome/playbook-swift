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
  var progressStepsView: some View {
    HStack(spacing: Spacing.none) {
      ForEach(1...steps, id: \.hashValue) { step in
        circleIconView(isActive: progress == 0  || step != progress + 1 ? false : true, isComplete: progress >= step ? true : false)
          .globalPosition(alignment: .bottom, bottom: -30, isCard: false) {
            labelView(index: step - 1)
         }
        if step < steps {
                 PBProgressPill(steps: 1, pillWidth: 100, pillHeight: 4, progressBarColorTrue: step <= progress ? Color.pbPrimary : Color.text(.lighter), progressBarColorFalse:  step > progress ? Color.text(.lighter) : Color.pbPrimary)
       }
      }
    }
  }
  
  func circleView(isActive: Bool, isComplete: Bool) -> some View {
    ZStack {
      Circle()
        .strokeBorder(Color.white, lineWidth: 2)
        .frame(width: 20, height: 20)
        .background(Circle().fill(isComplete ? Color.pbPrimary : !isActive ? Color.border : Color.clear))
      
      if isActive {
        Circle()
          .strokeBorder(Color.pbPrimary, lineWidth: 2)
          .frame(width: 15, height: 15)
          .background(Circle().fill(Color.clear))
      }
    }
  }
  
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    VStack(spacing: Spacing.small) {
      circleView(isActive: isActive, isComplete: isComplete)
        .overlay {
          PBIcon(icon, size: iconSize)
            .foregroundStyle(isComplete || isActive ? Color.white : Color.border)
            .opacity(isComplete && hasIcon ? 1 : 0)
        }
    }
  }
  
  func labelView(index: Int) -> some View {
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
