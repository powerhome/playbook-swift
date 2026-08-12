//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  LabelValueCatalog.swift
//

import SwiftUI
import Playbook

public struct LabelValueCatalog: View {
  private let longText = "Proin pulvinar feugiat massa in luctus. Donec urna nulla, elementum sit"

  public var body: some View {
    PBDocStack(title: "Label Value") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Details") {
        detailsView
      }
      PBDoc(title: "Other Examples") {
        otherExamplesView
      }
    }
  }
}

extension LabelValueCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBLabelValue("Role", "Administrator, Moderator")
      PBLabelValue("Email", "anna.black@powerhrg.com")
      PBLabelValue("Bio", longText)
    }
  }
  var detailsView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBLabelValue(
        "Installer",
        variant: .details,
        icon: Icon.truck,
        title: "JD Installations LLC"
      )

      PBLabelValue(
        "Project",
        variant: .details,
        icon: Icon.home,
        description: "33-12345",
        title: "Jefferson-Smith"
      )

      PBLabelValue(
        "Project",
        variant: .details,
        icon: Icon.home,
        description: "33-12345",
        title: "Jefferson-Smith",
        date: Date()
      )

      PBLabelValue(
        "Project",
        variant: .details,
        icon: Icon.home,
        description: "33-12345",
        title: "Jefferson-Smith",
        date: Date(),
        active: true
      )
    }
  }
  var otherExamplesView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      Text("Patient Profile")
        .pbFont(.title4)
        .padding(.bottom, Spacing.xSmall)

      PBLabelValue(
        "Age",
        variant: .details,
        icon: Icon.user,
        title: "24 yrs old"
      )

      PBLabelValue(
        "Blood",
        variant: .details,
        icon: Icon.tint,
        title: "A +"
      )

      PBLabelValue(
        "Weight",
        variant: .details,
        icon: Icon.weight,
        title: "91 kg"
      )

      PBLabelValue(
        "Height",
        variant: .details,
        icon: Icon.arrowsAltV,
        title: "187 cm"
      )

      Text("Workout Schedule")
        .pbFont(.title4)
        .padding(.top, Spacing.large)
        .padding(.bottom, Spacing.xSmall)

      PBLabelValue(
        "Chest",
        variant: .details,
        icon: Icon.dumbbell,
        description: "6 sets • 8 reps • 40-100 kg",
        title: "Bench Press",
        active: true
      )

      PBLabelValue(
        "Biceps",
        variant: .details,
        icon: Icon.dumbbell,
        description: "5 sets • 12 reps • 20-40 kg",
        title: "Barbell Curl",
        active: true
      )

      PBLabelValue(
        "Back",
        variant: .details,
        icon: Icon.dumbbell,
        description: "8 sets • 8 reps • 40-120 kg",
        title: "Back Squat",
        active: true
      )
    }
  }
}
