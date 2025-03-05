//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CollapsibleCatalog.swift
//

import SwiftUI
import Playbook

public struct CollapsibleCatalog: View {


  public var body: some View {
    PBDocStack(title: "Collapsible") {
      PBDoc(title: "Default") {
        CollapsibleDoc(text: "Main Section")
      }

      PBDoc(title: "Size") {
        VStack(spacing: Spacing.medium) {
          CollapsibleDoc(iconSize: .xSmall, text: "Extra Small Section")
          CollapsibleDoc(iconSize: .small, text: "Small Section")
          CollapsibleDoc(text: "Default Section")
          CollapsibleDoc(iconSize: .large, text: "Large Section")
        }
      }

      PBDoc(title: "Color") {
        VStack(spacing: Spacing.medium) {
          CollapsibleDoc(iconColor: .default, text: "Default Section")
          CollapsibleDoc(iconColor: .light, text: "Light Section")
          CollapsibleDoc(iconColor: .lighter, text: "Lighter Section")
          CollapsibleDoc(iconColor: .link, text: "Link Section")
          CollapsibleDoc(iconColor: .error, text: "Error Section")
          CollapsibleDoc(iconColor: .success, text: "Success Section")
        }
      }
      PBDoc(title: "Collapsible with Action") {
        CollapsibleDoc(text: "Main Section", hasAction: true)
      }
    }
  }
}

struct CollapsibleDoc: View {
  let iconSize: PBIcon.IconSize
  let iconColor: CollapsibleIconColor
  let text: String
  var hasAction: Bool
  @State private var isCollapsed = true
  @State private var isCollapsed1 = true
  @State private var presentDialog = false
  var content: some View {
    Text(lorem).pbFont(.body)
  }

  let lorem =
      """
      Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.
      
      Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.
      
      Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
      """

  public init(
    iconSize: PBIcon.IconSize = .small,
    iconColor: CollapsibleIconColor = .default,
    text: String,
    hasAction: Bool = false
  ) {
    self.iconSize = iconSize
    self.iconColor = iconColor
    self.text = text
    self.hasAction = hasAction
  }

  var body: some View {
    if hasAction {
      collapsibleAction
    } else {
      collapsibleView
    }
  }
}

extension CollapsibleDoc {
  var collapsibleView: some View {
    PBCollapsible(isCollapsed: $isCollapsed, iconSize: iconSize, iconColor: iconColor) {
      Text(text).pbFont(.body)
    } content: {
      content
    }
  }

  var collapsibleAction: some View {
    PBCollapsible(isCollapsed: $isCollapsed1, iconSize: iconSize, iconColor: iconColor, actionButton:
                    PBButton(
                      variant: .link,
                      shape: .circle,
                      icon: PBIcon.fontAwesome(.plus, size: .small),
                      action: {
                        presentDialog.toggle()
                      }
                    )) {
                      Text(text).pbFont(.body)
                    } content: {
                      content
                    }
                    .presentationMode(isPresented: $presentDialog) {
                      PBDialog(
                        title: "This is some informative text",
                        message: DialogCatalog.infoMessage,
                        cancelButton: DialogCatalog().cancelButton { closeToast() },
                        confirmButton: DialogCatalog().confirmationButton { closeToast() },
                        size: .small
                      )
                      .backgroundViewModifier(alpha: 0.2)
                    }
  }

  func closeToast() {
    presentDialog = false
  }
}
