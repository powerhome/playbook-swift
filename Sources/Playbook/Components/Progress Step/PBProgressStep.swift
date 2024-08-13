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
        icon: PBIcon(icon, size: iconSize, color: isComplete || isActive ? Color.white : Color.border),
        borderColor: isActive ? Color.pbPrimary : Color.white,
        borderWidth: lineWidth,
        backgroundColor: isComplete ? Color.pbPrimary : !isActive ? Color.border : Color.clear,
        diameter: circleWidth(isActive: isActive),
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
  
  
  func iconState(step: Int) -> TrackerCircleIcon.State {
    if step < progress-1 {
      return .active
    } else if step == progress-1 {
      return .complete
    } else {
      return .inactive
    }
  }
  
  func circleBackgroundColor(step: Int) -> Color {
    return step <= progress-1 ? Color.pbPrimary : .clear
  }
  
  func backgroundColor(step: Int) -> Color {
    return step < progress-1 ? Color.pbPrimary : .clear
  }
  
  
  var trackerView: some View {
    return ZStack(alignment: .leading) {
      HStack(spacing: 0) {
        ForEach(0..<steps, id: \.self) { step in
        
          HStack(spacing: 0) {
            TrackerCircleIcon(state: iconState(step: step))
            .padding(padding)
            .background(circleBackgroundColor(step: step))
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 12
                )
            )

            if step < steps - 1 {
              Spacer()
            }
          }
          .background(backgroundColor(step: step))
        }
      }
      .padding(.trailing, progress < steps ? padding : 0)
      .padding(.leading, progress == 0 ? padding : 0)
      .background(Color.border)
      .clipShape(RoundedRectangle(cornerRadius: 12))
    }
  }
}


struct TrackerCircleIcon: View {
  var state: State
  
  var body: some View {
    Circle()
      .stroke(state.border.0, lineWidth: state.border.1)
      .background(Circle().fill(state.background))
      .overlay { state.icon }
      .frame(width: state.size)
  }
  
  enum State {
    case inactive, active, complete
    
    var size: CGFloat {
      switch self {
        case .active, .complete: return 16
        case .inactive: return 12
      }
    }
    
    var background: Color {
      switch self {
        case .active: return .background(.dark)
        case .complete: return Color(hex: "#d1ddf6ff")
        case .inactive: return .status(.neutral)
      }
    }
    
    var icon: PBIcon? {
      switch self {
        case .active: return PBIcon(FontAwesome.check, size: .custom(8), color: .white)
        case .complete: return PBIcon(FontAwesome.check, size: .custom(8), color: .background(.dark))
        case .inactive: return nil
      }
    }
    
    var border: (Color, CGFloat) {
      return (.clear, 2)
    }
  }

}


#Preview {
  registerFonts()
  return ProgressTracker()
}
 
struct ProgressTracker: View {
  @State var progress: Int = 0
  
  var body: some View {
    VStack {
      
      Text("\(progress)")
      
      PBProgressStep(variant: .horizontal)
      PBProgressStep(steps: 2, variant: .tracker, progress: $progress)
      PBProgressStep(steps: 3, variant: .tracker, progress: $progress)
      PBProgressStep(steps: 4, variant: .tracker, progress: $progress)
      PBProgressStep(steps: 5, variant: .tracker, progress: $progress)
      PBProgressStep(steps: 6, variant: .tracker, progress: $progress)
      PBProgressStep(steps: 7, variant: .tracker, progress: $progress)
      PBProgressStep(steps: 8, variant: .tracker, progress: $progress)
      
      PBButton(title: "Increment") {
        progress += 1
      }
      
      PBButton(title: "Decrement") {
        progress -= 1
      }
    }
    .padding()
  }
}
