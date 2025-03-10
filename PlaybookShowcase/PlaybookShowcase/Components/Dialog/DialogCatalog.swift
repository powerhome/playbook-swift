//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DialogCatalog.swift
//

import SwiftUI
import Playbook

public struct DialogCatalog: View {
    @State private var presentDialog: Bool = false
    @State private var isLoading: Bool = false
    @State private var presentDialog1: Bool = false
    @State private var presentDialog2: Bool = false
    @State private var presentDialog3: Bool = false
    @State private var presentDialog4: Bool = false
    @State private var presentDialogStatus: Status?
    @State private var message = ""
 
    public var body: some View {
        PBDocStack(title: "Dialog", spacing: Spacing.medium) {
            PBDoc(title: "Simple") { simpleView }
            PBDoc(title: "Complex") { complexView }
            #if os(macOS)
            PBDoc(title: "Sizes") { buttonSizesView }
            #endif
            PBDoc(title: "Stacked") { stackedView }
            PBDoc(title: "Status") { statusView }
        }
    }
}

extension DialogCatalog {
    var simpleView: some View {
        PBButton(title: "Simple") {
            DialogCatalog.disableAnimation()
            presentDialog.toggle()
        }
        .presentationMode(isPresented: $presentDialog) {
            PBDialog(
                title: "This is some informative text",
                message: DialogCatalog.infoMessage,
                cancelButton: DialogCatalog().cancelButton {
                    isLoading = false
                    closeToast()
                },
                confirmButton: DialogCatalog().confirmationButton(isLoading: $isLoading) { isLoading = true }
            )
            .backgroundViewModifier(alpha: 0.2)
        }
    }
    
    var complexView: some View {
        PBButton(title: "Complex") {
            DialogCatalog.disableAnimation()
            presentDialog1.toggle()
        }
        .presentationMode(isPresented: $presentDialog1) {
            VStack{
                PBDialog(
                    title: "Send us your thoughts!",
                    cancelButton: DialogCatalog().cancelButton { closeToast() },
                    confirmButton: DialogCatalog().confirmationButton(text: "Submit") { closeToast() },
                    content: ({
                        ScrollView {
                            complexTitle
                            complexLabel
                            Text(message)
                        }
                    }))
                .backgroundViewModifier(alpha: 0.2)
            }
        }
    }
    
    var buttonSizesView: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            DialogButtonSize(title: "Small", size: .small)
            DialogButtonSize(title: "Medium", size: .medium)
            DialogButtonSize(title: "Large", size: .large)
        }
    }
    
    var stackedView: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            PBButton(title: "Default Status") {
                DialogCatalog.disableAnimation()
                presentDialog2.toggle()
            }
            .presentationMode(isPresented: $presentDialog2) {
                PBDialog(
                    title: "Are you sure?",
                    message: DialogCatalog.infoMessage,
                    variant: .status(.default),
                    isStacked: true,
                    cancelButton: DialogCatalog().cancelButtonFullWidth { closeToast() },
                    confirmButton: DialogCatalog().confirmationButtonFullWidth { closeToast() },
                    size: .small
                )
                .backgroundViewModifier(alpha: 0.2)
            }
            
            PBButton(title: "Caution Status") {
              DialogCatalog.disableAnimation()
                presentDialog3.toggle()
            }
            .presentationMode(isPresented: $presentDialog3) {
                PBDialog(
                    title: "Are you sure?",
                    message: DialogCatalog.infoMessage,
                    variant: .status(.caution),
                    isStacked: true,
                    cancelButton: DialogCatalog().cancelButtonFullWidth { closeToast() },
                    confirmButton: DialogCatalog().confirmationButtonFullWidth { closeToast() },
                    size: .small
                )
                .backgroundViewModifier(alpha: 0.2)
            }
            
            PBButton(title: "Delete Status") {
                DialogCatalog.disableAnimation()
                presentDialog4.toggle()
            }
            .presentationMode(isPresented: $presentDialog4) {
                PBDialog(
                    title: "Delete?",
                    message: DialogCatalog.infoMessage,
                    variant: .status(.delete),
                    isStacked: true,
                    cancelButton: DialogCatalog().cancelButtonFullWidth { closeToast() },
                    confirmButton: DialogCatalog().confirmationButtonFullWidth { closeToast() },
                    size: .small
                )
                .backgroundViewModifier(alpha: 0.2)
            }
        }
    }
    
    var statusView: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            ForEach(Status.allCases, id: \.self) { status in
                PBButton(title: status.rawValue.capitalized) {
                    DialogCatalog.disableAnimation()
                    presentDialogStatus = status
                }
                .presentationMode(item: $presentDialogStatus) { item in
                    PBDialog(
                        title: item.rawValue.capitalized,
                        message: DialogCatalog.infoMessage,
                        variant: .status(item),
                        isStacked: false,
                        cancelButton: DialogCatalog().cancelButtonFullWidth { closeToast() },
                        confirmButton: DialogCatalog().confirmationButtonFullWidth { closeToast() }
                    )
                    .backgroundViewModifier(alpha: 0.2)
                }
            }
        }
    }
}
    
extension DialogCatalog {
    static let infoMessage = "This is a message for informational purposes only."
    
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
    
    func closeToast() {
        presentDialog = false
        presentDialog1 = false
        presentDialog2 = false
        presentDialog3 = false
        presentDialog4 = false
        presentDialogStatus = nil
    }
    
    func cancelButton(_ closeToast: @escaping (() -> Void)) -> PBButton {
        PBButton(fullWidth: false, variant: .secondary, title: "Cancel") { closeToast() }
    }
    
    func cancelButtonFullWidth(_ closeToast: @escaping (() -> Void)) -> PBButton {
        PBButton(fullWidth: true, variant: .secondary, title: "Cancel") { closeToast() }
    }
    
    func confirmationButton(text: String = "Okay", isLoading: Binding<Bool> = .constant(false), _ closeToast: @escaping (() -> Void)) -> PBButton {
        PBButton(fullWidth: false, variant: .primary, title: text, isLoading: isLoading) {
            closeToast() }
    }
    
    func confirmationButtonFullWidth(_ closeToast: @escaping (() -> Void)) -> PBButton {
        PBButton(fullWidth: true, variant: .primary, title: "Okay") { closeToast() }
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
                DialogCatalog.disableAnimation()
                presentDialog.toggle()
            }
            .presentationMode(isPresented: $presentDialog) {
                PBDialog(
                    title: "\(title) Dialog",
                    message: DialogCatalog.infoMessage,
                    cancelButton: DialogCatalog().cancelButton { closeToast() },
                    confirmButton: DialogCatalog().confirmationButton { closeToast() },
                    size: size
                )
                .backgroundViewModifier(alpha: 0.2)
                .frame(width: size.width)
            }
        }
    }
}

#Preview {
    registerFonts()
    return DialogCatalog()
}
