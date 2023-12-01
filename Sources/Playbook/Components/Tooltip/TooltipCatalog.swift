//
//  TooltipCatalog.swift
//
//
//  Created by Stephen Marshall on 11/30/23.
//

import SwiftUI

@available(macOS 13.3, *)
@available(iOS 16.4, *)
public struct TooltipCatalog: View {
  @State var canShowTooltip: Bool = true
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          defaultView
        }
        PBDoc(title: "Tooltip with Icon") {
          tooltipIconView
        }
        PBDoc(title: "Delays") {
          delayView
        }
        PBDoc(title: "Show Tooltip") {
          canPresentView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Tooltip")
  }
}

@available(macOS 13.3, *)
@available(iOS 16.4, *)
public extension TooltipCatalog {
  var defaultView: some View {
    HStack(spacing: Spacing.medium) {
      Text("Hover here (Top)")
        .pbFont(.body)
        .modifier(PBTooltip(placement: .top, text: "Whoa, I'm a tooltip"))
      Text("Hover here (Bottom)")
        .pbFont(.body)
        .modifier(PBTooltip(placement: .bottom, text: "Whoa, I'm a tooltip"))
      Text("Hover here (Right)")
        .pbFont(.body)
        .modifier(PBTooltip(placement: .trailing, text: "Whoa, I'm a tooltip"))
      Text("Hover here (Left)")
        .pbFont(.body)
        .modifier(PBTooltip(placement: .leading, text: "Whoa, I'm a tooltip"))
    }
  }
  var tooltipIconView: some View {
    HStack(spacing: Spacing.medium) {
      PBButton(title: "Tooltip With Icon")
        .pbFont(.body)
        .modifier(PBTooltip(icon: .paperPlane, placement: .top, text: "Send Email"))
      PBButton(title: "Tooltip With Icon")
        .pbFont(.body)
        .modifier(PBTooltip(icon: .paperPlane, placement: .bottom, text: "Send Email"))
      PBButton(title: "Tooltip With Icon")
        .pbFont(.body)
        .modifier(PBTooltip(icon: .paperPlane, placement: .trailing, text: "Send Email"))
      PBButton(title: "Tooltip With Icon")
        .pbFont(.body)
        .modifier(PBTooltip(icon: .paperPlane, placement: .leading, text: "Send Email"))
    }
  }
  var delayView: some View {
    HStack(spacing: Spacing.medium) {
      PBButton(title: "1s Delay")
        .pbFont(.body)
        .modifier(PBTooltip(delay: 1.0, text: "1s Open/Close Delay"))
      PBButton(title: "Open Only")
        .pbFont(.body)
        .modifier(PBTooltip(delay: 1.0, delayType: .open, text: "1s Open Delay"))
      PBButton(title: "Close Only")
        .pbFont(.body)
        .modifier(PBTooltip(delay: 1.0, delayType: .close, text: "1s Close Delay"))
    }
  }
  var canPresentView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBButton(title: "Toggle State", action: {
        print("tap")
        canShowTooltip.toggle()
      })
        .pbFont(.body)
      HStack(spacing: Spacing.none) {
        Text("Tooltip is: \(canShowTooltip == true ? "enabled" : "disabled")")
          .pbFont(.body)
      }
      Text("Hover me.")
        .pbFont(.body)
        .padding(.leading, Spacing.none)
        .modifier(PBTooltip(canPresent: canShowTooltip, placement: .top, text: "Whoa, I'm a tooltip"))
    }
  }
}
