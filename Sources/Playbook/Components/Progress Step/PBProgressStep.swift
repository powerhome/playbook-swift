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
  let icon: PBIcon?
  let label: String?
  let showLabelIndex: Bool
  let pillHeight: CGFloat
  let steps: Int
  let variant: Variant
  let customLabel: [String]?
  let labelOffset: CGFloat
  let lineWidth: CGFloat = 2
  let borderRadius: CGFloat = 12
  @Binding var progress: Int
  
  public init(
    steps: Int = 3,
    progress: Binding<Int> = .constant(1),
    icon: PBIcon? = PBIcon(FontAwesome.check, size: .custom(9)),
    label: String? = nil,
    showLabelIndex: Bool = false,
    pillHeight: CGFloat = 4,
    variant: Variant = .horizontal,
    customLabel: [String]? = nil,
    labelOffset: CGFloat = 0
  ) {
    self.icon = icon
    self.label = label
    self.showLabelIndex = showLabelIndex
    self.pillHeight = pillHeight
    self.steps = steps
    self.variant = variant
    self.customLabel = customLabel
    self.labelOffset = labelOffset
    self._progress = progress
  }
  
  public var body: some View {
    progressVariantView
      .onChange(of: progress) { newValue in
        if newValue >= steps {
          progress = steps
        }
        if newValue <= 0 {
          progress = 0
        }
      }
  }
}

public extension PBProgressStep {
  enum Variant {
    case horizontal, vertical, tracker
  }
}

private extension PBProgressStep {
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
        isActive: isActive(step: step),
        isComplete: isComplete(step: step)
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
          progressBarColorTrue: step <= progress ? Color.pbPrimary : Color.border,
          progressBarColorFalse:  step > progress ? Color.text(.lighter) : Color.pbPrimary,
          cornerRadius: 1
        )
      }
    }
  }
  
  func circleIconView(isActive: Bool, isComplete: Bool) -> some View {
    Group {
      circleIcon(
        icon: icon,
        iconColor: (isComplete || isActive ? Color.white : Color.border),
        borderColor: borderColor(isActive: isActive, isComplete: isComplete),
        borderWidth: lineWidth,
        backgroundColor: backgroundColor(isActive: isActive, isComplete: isComplete),
        diameter: 12,
        opacity: isComplete ? 1 : 0
      )
      .padding(3)
    }
  }
  
  func isActive(step: Int) -> Bool {
    return progress == 0  || step != progress + 1 ? false : true
  }
  
  func isComplete(step: Int) -> Bool {
    return Int(progress) >= step ? true : false
  }
  
  func borderColor(isActive: Bool, isComplete: Bool) -> Color {
    return !isActive && !isComplete ? .border : .pbPrimary
  }
  
  func backgroundColor(isActive: Bool, isComplete: Bool) -> Color {
    if isActive {
      return Color.clear
    } else if isComplete {
      return Color.pbPrimary
    } else {
      return Color.border
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
      if let customLabel = customLabel, steps == customLabel.count {
        ForEach(customLabel, id: \.count) { label in
          Text(label)
            .pbFont(.subcaption, variant: .bold, color: .text(.default))
        }
      }
    }
  }
}

private extension PBProgressStep {
  var trackerView: some View {
    return VStack(alignment: .center, spacing: Spacing.xxSmall) {
      if let customLabel = customLabel, steps == customLabel.count {
      HStack {
        ForEach(Array(customLabel.enumerated()), id: \.offset) { index, label in
          Text(label).pbFont(.caption)
          if index < steps - 1 {
            Spacer()
          }
        }
        .padding(.horizontal, labelOffset)
      }
    }
      HStack(spacing: 0) {
        ForEach(0..<steps, id: \.self) { step in
          HStack(spacing: 0) {
            TrackerIconCircle(state: iconState(step: step))
              .background(circleBackgroundColor(step: step))
              .clipShape(
                .rect(
                  topLeadingRadius: 0,
                  bottomLeadingRadius: 0,
                  bottomTrailingRadius: borderRadius,
                  topTrailingRadius: borderRadius
                )
              )
            if step < steps - 1 {
              Spacer()
            }
          }
          .background(backgroundColor(step: step))
        }
      }
      .background(Color.border)
      .frame(height: 24)
      .clipShape(RoundedRectangle(cornerRadius: borderRadius))
    }
  }
  
  func iconState(step: Int) -> TrackerIconCircle.State {
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

  struct TrackerIconCircle: View {
    var state: State
    
    var body: some View {
      Circle()
        .stroke(state.border.0, lineWidth: state.border.1)
        .background(Circle().fill(state.background))
        .overlay { state.icon.foregroundStyle(state.iconColor) }
        .frame(width: state.size)
        .padding(state.padding)
    }
    
    enum State {
      case inactive, active, complete
      
      var size: CGFloat {
        switch self {
          case .active, .complete: return 16
          case .inactive: return 12
        }
      }
      
      var padding: CGFloat {
        switch self {
          case .active, .complete: return 4
          case .inactive: return 6
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
          case .active, .complete: return PBIcon(FontAwesome.check, size: .custom(8))
          case .inactive: return nil
        }
      }
      
      var iconColor: Color {
        switch self {
          case .active: return .white
          case .complete: return .background(.dark)
          case .inactive: return .clear
        }
      }
      
      var border: (Color, CGFloat) {
        return (.clear, 0)
      }
    }
  }
}

#Preview {
  registerFonts()
  return ProgressTracker()
}
 
struct ProgressTracker: View {
  @State var progress2: Int = 0
  @State var progress3: Int = 0
  @State var progress4: Int = 0
  @State var progress5: Int = 0
  
  var body: some View {
    VStack(spacing: Spacing.medium) {
      Text("\(progress5)")
      PBProgressStep(progress: $progress5, variant: .horizontal)
      PBProgressStep(steps: 3, progress: $progress2, variant: .tracker)
      PBProgressStep(steps: 4, progress: $progress3, variant: .tracker)
      PBProgressStep(steps: 5, progress: $progress4, variant: .tracker)
      PBProgressStep(
        steps: 3,
        progress: .constant(2),
        variant: .tracker,
        customLabel: ["Ordered", "Shipped", "Delivered"]
      )
      
      PBButton(title: "Increment") {
        progress2 += 1
        progress3 += 1
        progress4 += 1
        progress5 += 1
      }
      
      PBButton(title: "Decrement") {
        progress2 -= 1
        progress3 -= 1
        progress4 -= 1
        progress5 -= 1
      }
    }
    .padding()
  }
}
