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
    public var body: some View {
        PBDocStack(title: "Dialog") {
            PBDoc(title: "Simple") { SimpleButton() }
            PBDoc(title: "Complex") { ComplexButton() }
            PBDoc(title: "Stacked") { StackedButton() }
            PBDoc(title: "Status") { StatusButtons() }
        }
    }
}

extension DialogCatalog {
    static func disableAnimation() {
        UIView.setAnimationsEnabled(false)
    }

    static let infoMessage = "This is a message for informational purposes only."
    
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
    
    struct SimpleButton: View {
        @State private var presentDialog: Bool = false
        @State private var isLoading: Bool = false
        func closeToast() {
            presentDialog = false
        }
        
        var body: some View {
            PBButton(title: "Simple") {
                DialogCatalog.disableAnimation()
                presentDialog.toggle()
            }
            .fullScreenCover(isPresented: $presentDialog) {
                PBDialog(
                    title: "This is some informative text",
                    message: infoMessage,
                    cancelButton: DialogCatalog().cancelButton {
                        isLoading = false
                        closeToast()
                    },
                    confirmButton: DialogCatalog().confirmationButton(isLoading: $isLoading) { isLoading = true }
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
                DialogCatalog.disableAnimation()
                presentDialog.toggle()
            }
            .fullScreenCover(isPresented: $presentDialog) {
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
            .fullScreenCover(isPresented: $presentDialog) {
                PBDialog(
                    title: "\(title) Dialog",
                    message: infoMessage,
                    cancelButton: DialogCatalog().cancelButton { closeToast() },
                    confirmButton: DialogCatalog().confirmationButton { closeToast() },
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
                    DialogCatalog.disableAnimation()
                    presentDialog1.toggle()
                }
                .fullScreenCover(isPresented: $presentDialog1) {
                    PBDialog(
                        title: "Are you sure?",
                        message: infoMessage,
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
                    presentDialog2.toggle()
                }
                .fullScreenCover(isPresented: $presentDialog2) {
                    PBDialog(
                        title: "Are you sure?",
                        message: infoMessage,
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
                    presentDialog3.toggle()
                }
                .fullScreenCover(isPresented: $presentDialog3) {
                    PBDialog(
                        title: "Delete?",
                        message: infoMessage,
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
                        DialogCatalog.disableAnimation()
                        presentDialog = status
                    }
                    .fullScreenCover(item: $presentDialog) { item in
                        PBDialog(
                            title: item.rawValue.capitalized,
                            message: infoMessage,
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
  @State private var presentDialog: Bool = false
  @State private var isLoading: Bool = false
  @State private var presentDialog1: Bool = false
  @State private var presentDialog2: Bool = false
  @State private var presentDialog3: Bool = false
  @State private var presentDialog4: Bool = false
  @State private var presentDialog5: DialogStatus?
  @State private var message = ""
  let infoMessage = """
                    This is a message for informational 
                    purposes only.
                    """
  
  public var body: some View {
    PBDocStack(title: "Dialog", spacing: Spacing.medium) {
      PBDoc(title: "Simple") {
        simpleView
      }
      PBDoc(title: "Complex") {
        complexView
      }
      PBDoc(title: "Stacked") {
        stackedView
      }
      PBDoc(title: "Status") {
        statusView
      }
    }
    
  }
}

extension DialogCatalog {
  var simpleView: some View {
    PBButton(title: "Simple") {
      DialogCatalog.disableAnimation()
      presentDialog.toggle()
    }
    .sheet(isPresented: $presentDialog) {
      PBDialog(
        title: "This is some informative text",
        message: infoMessage,
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
    .sheet(isPresented: $presentDialog1) {
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
  
  var stackedView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBButton(title: "Default Status") {
        DialogCatalog.disableAnimation()
        presentDialog2.toggle()
      }
      .sheet(isPresented: $presentDialog2) {
        PBDialog(
          title: "Are you sure?",
          message: infoMessage,
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
      .sheet(isPresented: $presentDialog3) {
        PBDialog(
          title: "Are you sure?",
          message: infoMessage,
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
      .sheet(isPresented: $presentDialog4) {
        PBDialog(
          title: "Delete?",
          message: infoMessage,
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
      ForEach(DialogStatus.allCases, id: \.self) { status in
        PBButton(title: status.rawValue.capitalized) {
          DialogCatalog.disableAnimation()
          presentDialog5 = status
        }
        .sheet(item: $presentDialog5) { item in
          PBDialog(
            title: item.rawValue.capitalized,
            message: infoMessage,
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
    presentDialog5 = nil
  }
  func cancelButton(_ closeToast: @escaping (() -> Void)) -> PBButton {
    PBButton(variant: .secondary, title: "Cancel") { closeToast() }
  }
  
  func cancelButtonFullWidth(_ closeToast: @escaping (() -> Void)) -> PBButton {
    PBButton(variant: .secondary, title: "Cancel", fullWidth: true) { closeToast() }
  }
  
  func confirmationButton(text: String = "Okay", isLoading: Binding<Bool> = .constant(false), _ closeToast: @escaping (() -> Void)) -> PBButton {
    PBButton(variant: .primary, title: text, isLoading: isLoading, fullWidth: false) {
      closeToast() }
  }
  
  func confirmationButtonFullWidth(_ closeToast: @escaping (() -> Void)) -> PBButton {
    PBButton(variant: .primary, title: "Okay", fullWidth: true) { closeToast() }
  }
  static func disableAnimation() {
    NSAnimationContext.runAnimationGroup({ context in
      context.duration = 0
    }, completionHandler:nil)
  }
}
#endif

#Preview {
  registerFonts()
  return DialogCatalog()
}
