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
    progress: Binding<Int> = .constant(1),
    active: Binding<Int> = .constant(1)
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
      circleIconView(isActive: progress == 0  || step != progress + 1 ? false : true, isComplete: progress >= step ? true : false)
        .globalPosition(alignment: variant == .horizontal ? .bottom : .leading, bottom: variant == .horizontal ? -30 : 0, isCard: false) {
          labelView(index: Int(step) - 1)
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
      ZStack(alignment: .leading) {
        PBProgressPill(
          steps: 1,
          pillWidth: geo.size.width,
          pillHeight: 28,
          progressBarColorTrue: progress < 0 ? .pbPrimary : .text(.lighter).opacity(0.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        PBProgressPill(
          active: $active,
          steps: 1,
          pillWidth: progress > steps ? geo.size.width : (geo.size.width / CGFloat(steps) * CGFloat(progress)),
          pillHeight: 28
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        HStack(spacing: Spacing.none) {
            ForEach(1...steps, id: \.hashValue) { step in
//              if step >= 1 {
              //  Spacer(minLength: 2)
//              }
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
            }
            .frame(width: geo.size.width / CGFloat(steps) + 23)
            .padding(.leading, -19)
            .padding(.trailing, -1)
        }
      }
    }
  }
//  var trackerSpacing: CGFloat {
//    switch steps {
//    case 0, 1: return 0
//    case 2: return Spacing.xLarge + 46
//    case 3: return Spacing.xLarge
//    case 4: return Spacing.medium + 0.5
//    case 5: return Spacing.small + 0.5
//    case 6: return Spacing.xSmall + 4
//    case 7: return Spacing.xxSmall + 4
//    case 8: return Spacing.xxSmall
//    default:
//      return Spacing.none
//    }
//  }
//  var progressSpacing: CGFloat {
//    switch steps {
//    case 0, 1, 2: return 0
//    case 3: return 65
//    case 4: return 45
//    case 5: return 40
//    case 6: return 40
//    default: return 0
//    }
//  }
}
#Preview {
  registerFonts()
  return PBProgressStep()
}
