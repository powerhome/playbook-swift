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
  //  trackerView
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
      circleIconView(isActive: progress == 0  || step != progress + 1 ? false : true, isComplete: progress >= step ? true : false)
        .globalPosition(alignment: variant == .horizontal ? .bottom : .leading, bottom: variant == .horizontal ? -30 : 0, isCard: false) {
          labelView(index: step - 1)
            .padding(.leading, variant == .vertical ? 25 : 0)
            .padding(.trailing, 0)
        }
      if step < steps {
        PBProgressPill(
          steps: 1,
          pillWidth: variant == .horizontal ? frameReader(in: { _ in}) as? CGFloat : 4,
          pillHeight: variant == .horizontal ? 4 : 40,
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
      VStack {
        ZStack {
          PBProgressPill(
            steps: 1,
            pillWidth: frameReader(in: { _ in}) as? CGFloat,
            pillHeight: 28,
            progressBarColorTrue: progress < 0 ? .pbPrimary : .text(.lighter).opacity(0.5),
            progressBarColorFalse: .text(.lighter).opacity(0.5)
          )
          .clipShape(RoundedRectangle(cornerRadius: 15))
          HStack {
            GeometryReader { geo in
              PBProgressPill(
                steps: 1,
//                pillWidth: progress + 1 >= (steps.words.last ?? 0) ? frameReader(in: { _ in}) as? CGFloat : (geo.size.width / CGFloat(steps) * CGFloat(progress) * 1.5),
                pillWidth: progress + 1 >= (steps.words.last ?? 0) ? frameReader(in: { _ in}) as? CGFloat : (geo.size.width / CGFloat(steps) * CGFloat(progress) + 40.5),
                pillHeight: 28,
                progressBarColorTrue: progress > 0 ? .pbPrimary : .pbPrimary
              )
              .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .overlay {
              HStack(spacing: Spacing.none) {
                ForEach(1...steps, id: \.hashValue) { step in
                  Spacer(minLength: steps <= 4 ? Spacing.xLarge + 5 : steps >= 5 ?  Spacing.xSmall + 4 : Spacing.small)
                  Spacer(minLength: steps == 2 ? 55 : -10)
                  circleIcon(
                    icon: icon,
                    iconSize: iconSize,
                    strokeColor: .clear,
                    lineWidth: 2,
                    background: progress >= step ? .black : progress == step ? .border : .text(.lighter),
                    circleWidth: 20,
                    circleHeight: 20,
                    iconColor: step <= progress ? .white : step == 1 ? .clear : step == progress + 1 ? .pbPrimary : .clear,
                    offsetX: 0,
                    offsetY: 0,
                    opacity: 1
                  )
                  
                  Spacer(minLength: steps <= 4 ? Spacing.xLarge + 5 : steps >= 5 ?  Spacing.xSmall + 4 : Spacing.small)
                  Spacer(minLength: steps == 2 ? 55 : -10)
  
                }
              }
              .frame(width: frameReader(in: { _ in}) as? CGFloat)
            }
          }
        }
      }
      .padding(30)
  }
}
#Preview {
  registerFonts()
  return PBProgressStep()
}
