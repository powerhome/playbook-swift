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
    customLabel: [String] = [""],
    progress: Binding<Int> = .constant(0)
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
      VStack(spacing: Spacing.none) {
          trackerView
        
      }
    }
  }
  
  var progressStepsView: some View {
    ForEach(1...steps, id: \.hashValue) { step in
      circleIconView(
        isActive: progress == 0  || step != progress + 1 ? false : true,
        isComplete: Int(progress) >= step ? true : false
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
      let width = geo.size.width
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.gray.opacity(0.2))
          .frame(width: width, height: 28, alignment: .leading)
          .clipShape(RoundedRectangle(cornerRadius: 15))
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.pbPrimary)
          .frame(width: Int(progress) >= steps ? width : progress == 0 ? 0 : ((width / CGFloat(steps)) / 2 + 12) * CGFloat(progress) , height: 28, alignment: .leading)
          .clipShape(RoundedRectangle(cornerRadius: 15))
       // HStack(spacing: (width - CGFloat(steps) * 20) / CGFloat(steps - 1)) {
        HStack(spacing: ((width - 18 ) / CGFloat(steps) - 2) - 18) {
          ForEach(0..<steps, id: \.self) { step in
            circleIcon(
              icon: .check,
              iconSize: .small,
              strokeColor: .clear,
              lineWidth: 2,
              background: step < progress ? .black : progress == step ? .border : .text(.lighter),
              circleWidth: 18,
              circleHeight: 18,
              iconColor: step < progress ? .white : step == progress ? .pbPrimary : .clear,
              offsetX: 0,
              offsetY: 0,
              opacity: 1
            )
          }
       //   .padding(.horizontal, 5)
         // .padding(.trailing, -13)
        }
        .background(Color.pink)
       
       
      }
     
    }
  }
}

#Preview {
  registerFonts()
  return PBProgressStep()
}
