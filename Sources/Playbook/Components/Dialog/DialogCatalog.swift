//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DialogCatalog.swift
//

import SwiftUI

#if os(iOS)
  public struct DialogCatalog: View {
    static let infoMessage = "This is a message for informational purposes only."

    static func disableAnimation() {
      UIView.setAnimationsEnabled(false)
    }

    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Simple") { SimpleButton() }
          PBDoc(title: "Complex") { ComplexButton() }
          PBDoc(title: "Size") { SizeButtons() }
          PBDoc(title: "Stacked") { StackedButton() }
          PBDoc(title: "Status") { StatusButtons() }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Dialog")
    }

    struct SimpleButton: View {
      @State private var presentDialog: Bool = false

      func closeToast() {
        presentDialog = false
      }

      var body: some View {
        PBButton(title: "Simple") {
          disableAnimation()
          presentDialog.toggle()
        }
        .fullScreenCover(isPresented: $presentDialog) {
          PBDialog(
            title: "This is some informative text",
            message: infoMessage,
            cancelButton: ("Cancel", closeToast),
            confirmButton: ("Okay", closeToast)
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }

    struct ComplexButton: View {
      @State private var presentDialog: Bool = false
      @State private var message = ""
     
      func closeToast() {
        presentDialog = false
      }

      
      var body: some View {
        PBButton(title: "Complex") {
          disableAnimation()
          presentDialog.toggle()
        }
        .fullScreenCover(isPresented: $presentDialog) {
          VStack{
            PBDialog(
              title: "Send us your thoughts!",
              cancelButton: ("Cancel", closeToast),
              confirmButton: ("Submit", closeToast),
              content: ({
                ScrollView {
                  complexTitle

                  complexLabel
                }
              }))
            .backgroundViewModifier(alpha: 0.2)
          }
        }
      }
    }
    
    struct DialogButtonSize: View {
      let title: String
      let size: DialogSize
      @State private var presentDialog: Bool = false

      func closeToast() {
        presentDialog = false
      }

      public init(
        title: String,
        size: DialogSize
      ) {
        self.title = title
        self.size = size
      }
      var body: some View {
        PBButton(title: title) {
          disableAnimation()
          presentDialog.toggle()
        }
        .fullScreenCover(isPresented: $presentDialog) {
          PBDialog(
            title: "\(title) Dialog",
            message: infoMessage,
            cancelButton: ("Cancel", closeToast),
            confirmButton: ("Okay", closeToast),
            size: size
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }

    struct SizeButtons: View {
      var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
          DialogButtonSize(title: "Small", size: .small)
          DialogButtonSize(title: "Medium", size: .medium)
          DialogButtonSize(title: "Large", size: .large)
        }
      }
    }

    struct StackedButton: View {
      @State private var presentDialog1: Bool = false
      @State private var presentDialog2: Bool = false
      @State private var presentDialog3: Bool = false

      func closeToast() {
        presentDialog1 = false
        presentDialog2 = false
        presentDialog3 = false
      }

      var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
          PBButton(title: "Default Status") {
            disableAnimation()
            presentDialog1.toggle()
          }
          .fullScreenCover(isPresented: $presentDialog1) {
            PBDialog(
              title: "Are you sure?",
              message: infoMessage,
              variant: .status(.default),
              isStacked: true,
              cancelButton: ("Cancel", closeToast),
              confirmButton: ("Okay", closeToast),
              size: .small
            )
            .backgroundViewModifier(alpha: 0.2)
          }

          PBButton(title: "Caution Status") {
            disableAnimation()
            presentDialog2.toggle()
          }
          .fullScreenCover(isPresented: $presentDialog2) {
            PBDialog(
              title: "Are you sure?",
              message: infoMessage,
              variant: .status(.caution),
              isStacked: true,
              cancelButton: ("Cancel", closeToast),
              confirmButton: ("Okay", closeToast),
              size: .small
            )
            .backgroundViewModifier(alpha: 0.2)
          }
          
          PBButton(title: "Delete Status") {
            disableAnimation()
            presentDialog3.toggle()
          }
          .fullScreenCover(isPresented: $presentDialog3) {
            PBDialog(
              title: "Delete?",
              message: infoMessage,
              variant: .status(.delete),
              isStacked: true,
              cancelButton: ("Cancel", closeToast),
              confirmButton: ("Okay", closeToast),
              size: .small
            )
            .backgroundViewModifier(alpha: 0.2)
          }
        }
      }
    }

    struct StatusButtons: View {
      @State private var presentDialog: DialogStatus?

      func closeToast() {
        presentDialog = nil
      }

      var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
          ForEach(DialogStatus.allCases, id: \.self) { status in
            PBButton(title: status.rawValue.capitalized) {
              disableAnimation()
              presentDialog = status
            }
            .fullScreenCover(item: $presentDialog) { item in
              PBDialog(
                title: item.rawValue.capitalized,
                message: infoMessage,
                variant: .status(item),
                isStacked: false,
                cancelButton: ("Cancel", closeToast),
                confirmButton: ("Okay", closeToast)
              )
              .backgroundViewModifier(alpha: 0.2)
            }
          }
        }
      }
    }
  }

extension DialogCatalog.ComplexButton {
  var complexTitle: some View {
    return Text("Complex Dialog!")
      .pbFont(.title3)
      .multilineTextAlignment(.leading)
      .padding(.top, 25)
  }
  var complexLabel: some View {
    return VStack(alignment: .leading, spacing: 5) {
      PBTextInput("Description", text: $message, placeholder: "Let us know how we can improve...")
    }
    .padding(.all)
  }
}
#elseif os(macOS)
  public struct DialogCatalog: View {
    @State private var presentSmallDialog: Bool = false
    @State private var presentMediumDialog: Bool = false
    @State private var presentLargeDialog: Bool = false

    let infoMessage = "This is a message for informational purposes only and requires no action."

    public var body: some View {
      VStack {
        PBButton(title: "Small") {
          presentSmallDialog = true
        }
        .popover(isPresented: $presentSmallDialog) {
          PBDialog(
            title: "Small",
            message: infoMessage,
            variant: .default,
            isStacked: false,
            cancelButton: ("Cancel", {}),
            confirmButton: ("Okay", {}),
            size: .small
          )
        }

        PBButton(title: "Medium") {
          presentMediumDialog = true
        }
        .popover(isPresented: $presentMediumDialog) {
          PBDialog(
            title: "Medium",
            message: infoMessage,
            variant: .default,
            isStacked: false,
            cancelButton: ("Cancel", {}),
            confirmButton: ("Okay", {}),
            size: .medium
          )
        }

        PBButton(title: "Large") {
          presentLargeDialog = true
        }
        .popover(isPresented: $presentLargeDialog) {
          PBDialog(
            title: "Large",
            message: infoMessage,
            variant: .default,
            isStacked: false,
            cancelButton: ("Cancel", {}),
            confirmButton: ("Okay", {}),
            size: .large
          )
        }
      }
    }
  }
#endif
