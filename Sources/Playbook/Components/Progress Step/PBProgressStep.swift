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
  let customLabel: [String]
  let overlap: CGFloat
  @Binding var progress: Int
  @Binding var active: Int
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
    customLabel: [String] = [""],
    overlap: CGFloat = 0,
    progress: Binding<Int> = .constant(0),
    active: Binding<Int> = .constant(0)
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
    self.customLabel = customLabel
    self.overlap = overlap
    self._progress = progress
    self._active = active
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
      VStack(spacing: Spacing.none) {
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
          labelView(index: Int(step) - 1)
            .padding(.leading, variant == .vertical ? 25 : 0)
            .padding(.trailing, 0)
        }
      if step < steps {
        PBProgressPill(
          steps: 1,
          pillWidth: variant == .horizontal ? frameReader(in: { _ in}) as? CGFloat : 4,
          pillHeight: pillHeight,
          progressBarColorTrue: step <= progress ? Color.pbPrimary : Color.text(.lighter),
          progressBarColorFalse:  step > progress ? Color.text(.lighter) : Color.pbPrimary,
          cornerRadius: 1
        )
      }
    }
  }
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    ZStack {
      circleIcon(
        icon: icon,
        iconSize: iconSize,
        strokeColor: Color.white,
        lineWidth: 2,
        background: isComplete ? Color.pbPrimary : !isActive ? Color.border : Color.clear,
        circleWidth: 18,
        circleHeight: 18,
        iconColor: isComplete ? Color.white : Color.border,
        offsetX: 0,
        offsetY: 0,
        opacity: isComplete && hasIcon ? 1 : 0
      )
        .padding(.horizontal, 1)
      if isActive {
        circleIcon(
          icon: icon,
          iconSize: iconSize, 
          strokeColor: Color.pbPrimary,
          lineWidth: 2,
          background: Color.clear,
          circleWidth: 14.5,
          circleHeight: 14.5,
          iconColor: isComplete || isActive ? Color.white : Color.border,
          offsetX: 0,
          offsetY: 0,
          opacity: isComplete && hasIcon ? 1 : 0
        )
        .padding(.horizontal, 3)
      }
    }
  }
  @ViewBuilder
  func labelView(index: Int? = 0) -> some View {
      if let label = self.label {
        Text(showLabelIndex ? "\(label) \((index ?? 0) + 1)" : "\(label)")
          .pbFont(.subcaption, variant: .bold, color: .text(.default))
      } else {
        customLabelView
      }
  }
  var customLabelView: some View {
    HStack(spacing: frameReader(in: { _ in}) as? CGFloat) {
        ForEach(customLabel, id: \.count) { label in
          Text(label)
            .pbFont(.subcaption, variant: .bold, color: .text(.default))
        }
      }
  }
}

extension PBProgressStep {

  var trackerView: some View {
      GeometryReader { geo in
        HStack {
          PBProgressStep(
            hasIcon: true,
            icon: .check,
            iconSize: .small,
            pillHeight: 28,
            steps: steps,
            progress: $progress,
            active: $active
          )
          .padding(.horizontal, 5)
        }
        .background(Color.pbPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 15))
      }
  }
}
#Preview {
  registerFonts()
  return PBProgressStep()
}
