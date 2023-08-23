//
//  DialogCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

#if os(iOS)
  public struct DialogCatalog: View {
    static let infoMessage = "This is a message for informational purposes only and requires no action."

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

      func closeDialog() {
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
            cancelButton: ("Cancel", closeDialog),
            confirmButton: ("Okay", closeDialog)
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }

    struct ComplexButton: View {
      @State private var presentDialog: Bool = false
      @State private var message = ""

      func closeDialog() {
        presentDialog = false
      }

      var body: some View {
        PBButton(title: "Complex") {
          disableAnimation()
          presentDialog.toggle()
        }
        .fullScreenCover(isPresented: $presentDialog) {
          PBDialog(
            title: "Send us your thoughts!",
            cancelButton: ("Cancel", closeDialog),
            confirmButton: ("Submit", closeDialog),
            content: ({
              ScrollView {
                Text("Hello Complex Dialog!\nAnything can be placed here")
                  .pbFont(.title2)
                  .multilineTextAlignment(.leading)

                PBTextInput("text", text: .constant("Some text"))
                  .padding()
              }
            }))
            .backgroundViewModifier(alpha: 0.2)
        }
      }
    }

    struct DialogButtonSize: View {
      let title: String
      let size: DialogSize
      @State private var presentDialog: Bool = false

      func closeDialog() {
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
            cancelButton: ("Cancel", closeDialog),
            confirmButton: ("Okay", closeDialog),
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

      func closeDialog() {
        presentDialog1 = false
        presentDialog2 = false
      }

      var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
          PBButton(title: "Stacked") {
            disableAnimation()
            presentDialog1.toggle()
          }
          .fullScreenCover(isPresented: $presentDialog1) {
            PBDialog(
              title: "Success!",
              message: infoMessage,
              variant: .status(.success),
              isStacked: true,
              cancelButton: ("Cancel", closeDialog),
              confirmButton: ("Okay", closeDialog),
              size: .small
            )
            .backgroundViewModifier(alpha: 0.2)
          }

          PBButton(title: "Stacked Simple") {
            disableAnimation()
            presentDialog2.toggle()
          }
          .fullScreenCover(isPresented: $presentDialog2) {
            PBDialog(
              title: "Error!",
              message: infoMessage,
              variant: .status(.error),
              isStacked: true,
              confirmButton: ("Okay", closeDialog),
              size: .small
            )
            .backgroundViewModifier(alpha: 0.2)
          }
        }
      }
    }

    struct StatusButtons: View {
      @State private var presentDialog: DialogStatus?

      func closeDialog() {
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
                cancelButton: ("Cancel", closeDialog),
                confirmButton: ("Okay", closeDialog)
              )
              .backgroundViewModifier(alpha: 0.2)
            }
          }
        }
      }
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
