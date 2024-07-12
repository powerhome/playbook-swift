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
    case horizontal, vertical, tracker
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
    case .tracker:
      VStack {
        trackerView
      }
    }
  }
  var progressStepsView: some View {
    ForEach(1...steps, id: \.hashValue) { step in
      circleIconView(
        isActive: progress == 0  || step != progress + 1 ? false : true,
        isComplete: progress >= step ? true : false
      )
      .globalPosition(alignment: variant == .horizontal ? .bottom : .leading, bottom: variant == .horizontal ? -30 : 0, isCard: false) {
        labelView(index: step - 1)
          .padding(.leading, variant == .vertical ? 25 : 0)
          .padding(.trailing, 0)
      }
      if step < steps {
        PBProgressPill(
          steps: 1,
          pillWidth: pillWidth ,
          pillHeight: pillHeight,
          progressBarColorTrue: step <= progress ? Color.pbPrimary : Color.text(.lighter),
          progressBarColorFalse:  step > progress ? Color.text(.lighter) : Color.pbPrimary
        )
      }
    }
  }
  
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    ZStack {
      circleIcon(
        icon: icon,
        iconSize: iconSize,
        strokeColor: .white,
        lineWidth: 2,
        background: isComplete ? Color.pbPrimary : !isActive ? Color.border : Color.clear,
        circleWidth: 20,
        circleHeight: 20,
        iconColor: isComplete && hasIcon ? Color.white : Color.clear,
        offsetX: 0,
        offsetY: 0,
        opacity: 1
      )
      
      if isActive {
        circleIcon(
          icon: icon,
          iconSize: iconSize,
          strokeColor: .pbPrimary,
          lineWidth: 2,
          background: Color.clear,
          circleWidth: 15,
          circleHeight: 15,
          iconColor:  .clear,
          offsetX: 0,
          offsetY: 0,
          opacity: 0
        )
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

extension PBProgressStep {
  var trackerView: some View {
    ZStack {
    PBProgressPill(
      steps: 1,
      pillWidth: 150,
      pillHeight: 28,
      progressBarColorTrue: Color.text(.lighter),
      progressBarColorFalse: Color.text(.lighter)
     
    )
    .clipShape(RoundedRectangle(cornerRadius: 15))
      PBProgressPill(
        steps: 1,
        pillWidth: 120,
        pillHeight: 28,
        progressBarColorTrue: Color.pbPrimary,
        progressBarColorFalse: Color.pbPrimary
      )
      .clipShape(RoundedRectangle(cornerRadius: 15))
      .padding(.trailing, 30)
     
    }
    .overlay {
      circleIcon(icon: icon, iconSize: iconSize, strokeColor: .clear, lineWidth: 2, background: Color.black, circleWidth: 20, circleHeight: 20, iconColor: .white, offsetX: 0, offsetY: 0, opacity: 1)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.trailing, 90)
        .frame(alignment: .leading)
    }
    .padding(.leading, 10)
    .overlay {
      circleIcon(icon: icon, iconSize: iconSize, strokeColor: .clear, lineWidth: 2, background: .text(.lighter), circleWidth: 20, circleHeight: 20, iconColor: .pbPrimary, offsetX: 0, offsetY: 0, opacity: 1)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.leading, 30)
    }
  
   
  }
}
#Preview {
  registerFonts()
  return PBProgressStep()
}
