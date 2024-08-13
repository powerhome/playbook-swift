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
  let pillHeight: CGFloat
  let steps: Int
  let variant: Variant
  let customLabel: [String]
  @Binding var progress: Int
  @State private var pillWidth: CGFloat?
  @State private var currentStep: Int = 1
  
  let circleSize: CGFloat = 18
  let padding: CGFloat = 4
  let lineWidth: CGFloat = 2
  
  public init(
    hasIcon: Bool = true,
    icon: FontAwesome = .check,
    iconSize: PBIcon.IconSize = .custom(9),
    label: String? = nil,
    showLabelIndex: Bool = false,
    //    pillWidth: CGFloat = 100,
    pillHeight: CGFloat = 4,
    steps: Int = 6,
    variant: Variant = .horizontal,
    customLabel: [String] = ["1", "2", "3"],
    progress: Binding<Int> = .constant(1)
  ) {
    self.hasIcon = hasIcon
    self.icon = icon
    self.iconSize = iconSize
    self.label = label
    self.showLabelIndex = showLabelIndex
    //    self.pillWidth = pillWidth
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
          pillWidth: variant == .horizontal ? .infinity : 4,
          pillHeight: pillHeight,
          progressBarColorTrue: step <= progress ? Color.pbPrimary : Color.text(.lighter),
          progressBarColorFalse:  step > progress ? Color.text(.lighter) : Color.pbPrimary,
          cornerRadius: 1
        )
      }
    }
  }
  
  func circleWidth(isActive: Bool) -> CGFloat {
    return isActive ? 14.5 : 18
  }
  
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    ZStack {
      circleIcon(
        icon: icon,
        iconSize: iconSize,
        strokeColor: isActive ? Color.pbPrimary : Color.white,
        lineWidth: lineWidth,
        background: isComplete ? Color.pbPrimary : !isActive ? Color.border : Color.clear,
        circleWidth: circleWidth(isActive: isActive),
        circleHeight: circleWidth(isActive: isActive),
        iconColor: isComplete || isActive ? Color.white : Color.border,
        offsetX: 0,
        offsetY: 0,
        opacity: isComplete && hasIcon ? 1 : 0
      )
      .padding(.horizontal, isActive ? 3 : 1)
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
    HStack(spacing: .infinity) {
      ForEach(customLabel, id: \.count) { label in
        Text(label)
          .pbFont(.subcaption, variant: .bold, color: .text(.default))
      }
    }
  }
}

extension PBProgressStep {
  var trackerView: some View {
    return ZStack(alignment: .leading) {
      HStack(spacing: 0) {
        ForEach(0..<steps, id: \.self) { step in
          
          
          Group {
          HStack(spacing: 0) {
            circleIcon(
              icon: .check,
              iconSize: .small,
              strokeColor: .border,
              lineWidth: lineWidth,
              background: step < progress ? .black : progress == step ? .border : .text(.lighter),
              circleWidth: circleSize,
              circleHeight: circleSize,
              iconColor: step < progress ? .white : step == progress ? .pbPrimary : .clear,
              offsetX: 0,
              offsetY: 0,
              opacity: 1
            )
            
            
            if step < steps - 1 {
              Spacer()
                
            }
          }
        }
          .padding(padding)
          .background(step < progress-1 ? .black : .text(.lighter))
        }
      }
//      .padding(padding)
//      .background(step < progress ? .black : .text(.lighter))
      .background(Color.gray)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      
    }
  }
  
//  func progressFrame(width: CGFloat) -> CGFloat {
//    return CGFloat(
//      ((Int(width)/steps) * progress) - (Int(circleSize)) + (Int(padding-2) * progress)
//    )
//  }
//  

//  ---------- 4 steps
//  func progressFrame(width: CGFloat) -> CGFloat {
//    return CGFloat(
//      ((Int(width)/steps) * progress) - ((steps-progress)*(Int(padding) + Int(circleSize))) + 2
//    )
//  }
  
//  func progressFrame(width: CGFloat) -> CGFloat {
//    if progress > steps {
//      return width
//    } else {
//      return CGFloat(
//        ((Int(width)/steps) * progress) - ((steps-progress)*(Int(padding) + Int(circleSize))) + 2
//      )
//    }
//  }
  
  func progressFrame(width: CGFloat) -> CGFloat {
    if progress > steps {
      return width
    } else {
      return CGFloat(
        ((Int(width)/steps))
      )
    }
  }
  
}

#Preview {
  registerFonts()
  @State var progress: Int = 2
  return VStack {
    PBProgressStep(variant: .horizontal)
    
//    PBProgressStep(variant: .vertical)
//    
    
    PBProgressStep(steps: 2, variant: .tracker, progress: $progress)
    PBProgressStep(steps: 3, variant: .tracker, progress: $progress)
    PBProgressStep(steps: 4, variant: .tracker, progress: $progress)
    PBProgressStep(steps: 5, variant: .tracker, progress: $progress)
    PBProgressStep(steps: 6, variant: .tracker, progress: $progress)
    PBProgressStep(steps: 7, variant: .tracker, progress: $progress)
    PBProgressStep(steps: 8, variant: .tracker, progress: $progress)
  }.padding()
}
