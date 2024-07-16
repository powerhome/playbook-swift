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
  let pillWidth: CGFloat
  let pillHeight: CGFloat
  let steps: Int
  let variant: Variant
  @Binding var progress: Int
  
  public init(
    hasIcon: Bool = true,
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .custom(9),
    label: String? = nil,
    showLabelIndex: Bool = false,
    pillWidth: CGFloat = 100,
    pillHeight: CGFloat = 4,
    steps: Int = 3,
    variant: Variant = .horizontal,
    progress: Binding<Int> = .constant(1)
  ) {
    self.hasIcon = hasIcon
    self.icon = icon
    self.iconSize = iconSize
    self.label = label
    self.showLabelIndex = showLabelIndex
    self.pillWidth = pillWidth
    self.pillHeight = pillHeight
    self.steps = steps
    self.variant = variant
    self._progress = progress
  }
  
  public var body: some View {
    progressVariantView
  }
}

public extension PBProgressStep {
  enum Variant {
    case horizontal, vertical
  }
  @ViewBuilder
  var progressVariantView: some View {
    switch variant {
    case .horizontal:
      HStack(spacing: Spacing.none) {
        progressStepsView
      }
    case .vertical:
      VStack(spacing: Spacing.none) {
        progressStepsView
      }
      
    }
  }
  var progressStepsView: some View {
    HStack(spacing: Spacing.none) {
      ForEach(1...steps, id: \.hashValue) { step in
        circleIconView(isActive: progress == 0  || step != progress + 1 ? false : true, isComplete: progress >= step ? true : false)
          .globalPosition(alignment: .bottom, bottom: -30, isCard: false) {
            labelView(index: step - 1)
              .padding(.leading)
              .padding(.trailing)
          }
        if step < steps {
          PBProgressPill(steps: 1, pillWidth: frameReader(in: { _ in}) as? CGFloat, pillHeight: 4, progressBarColorTrue: step <= progress ? Color.pbPrimary : Color.text(.lighter), progressBarColorFalse:  step > progress ? Color.text(.lighter) : Color.pbPrimary, cornerRadius: 1)
        }
      }
    }
  }
  
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    ZStack {
      if isActive {
        Circle()
          .stroke(Color.pbPrimary, lineWidth: 2)
          .frame(width: 14.5, height: 14.5)
          .background(Circle().fill(Color.clear))
          .overlay {
            PBIcon(icon, size: iconSize)
              .foregroundStyle(isComplete || isActive ? Color.white : Color.border)
              .opacity(isComplete && hasIcon ? 1 : 0)
          }
          .padding(.horizontal, 3)
      }
        Circle()
          .stroke(Color.white, lineWidth: 2)
          .frame(width: 18, height: 18)
          .background(Circle().fill(isComplete ? Color.pbPrimary : !isActive ? Color.border : Color.clear))
        
          .overlay {
            PBIcon(icon, size: iconSize)
              .foregroundStyle(isComplete ? Color.white : Color.border)
              .opacity(isComplete && hasIcon ? 1 : 0)
          }
          .padding(.horizontal, 1)
      
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
