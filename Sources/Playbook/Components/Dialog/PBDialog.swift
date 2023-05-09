//
//  PBDialog.swift
//
//
//  Created by Michael Campbell on 7/15/21.
//

import SwiftUI

public struct PBDialog<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode
  let content: Content?
  let title: String?
  let message: String?
  let variant: DialogVariant
  let isStacked: Bool
  let cancelButton: (String, (() -> Void)?)?
  let confirmButton: (String, (() -> Void))?
  let onClose: (() -> Void)?
  let size: Size
  let shouldCloseOnOverlay: Bool
  
  public init(
    title: String? = nil,
    message: String? = nil,
    variant: DialogVariant = .default,
    isStacked: Bool = false,
    cancelButton: (String, (() -> Void)?)? = nil,
    confirmButton: (String, (() -> Void))? = nil,
    onClose: (() -> Void)? = nil,
    size: Size = .medium,
    shouldCloseOnOverlay: Bool = true,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.content = content()
    self.title = title
    self.message = message
    self.variant = variant
    self.isStacked = isStacked
    self.cancelButton = cancelButton
    self.confirmButton = confirmButton
    self.onClose = onClose
    self.size = size
    self.shouldCloseOnOverlay = shouldCloseOnOverlay
  }
  
  public var body: some View {
    dialogView()
      .frame(maxWidth: size.width)
      .padding(EdgeInsets(top: 0, leading: size.padding, bottom: 0, trailing: size.padding))
      .onTapGesture {
        if shouldCloseOnOverlay {
          if let onClose = onClose {
            onClose()
          } else {
            dismissDialog()
          }
        }
      }
  }
  
  private func dialogView() -> some View {
    return PBCard(alignment: .center, padding: .pbNone) {
      switch variant {
      case .default:
        if let title = title {
          PBDialogHeaderView(title: title) { dismissDialog() }
          PBSectionSeparator()
        }
        
        if let message = message {
          Text(message)
            .pbFont(.body())
            .padding()
        }
        
        content
        
      case .status(let status):
        PBStatusDialogView(status: status, title: title ?? "", description: message ?? "")
          .frame(maxWidth: Size.medium.width)
      }
      
      if let confirmButton = confirmButton {
        PBDialogActionView(
          isStacked: isStacked,
          confirmButton: confirmButton,
          cancelButton: cancelButtonAction(),
          variant: variant
        )
        .padding()
      }
    }
  }
  
  func cancelButtonAction() -> (String, (() -> Void))? {
    if let cancelButton = cancelButton {
      if let cancelButtonAction = cancelButton.1 {
        return (cancelButton.0, cancelButtonAction)
      } else {
        return (cancelButton.0, { dismissDialog() })
      }
    } else {
      return nil
    }
  }
  
  func dismissDialog() {
    presentationMode.wrappedValue.dismiss()
  }
}

public extension PBDialog {
  enum Size: String, CaseIterable, Identifiable {
    public var id: UUID { UUID() }
    
    case small
    case medium
    case large
    case statusSize
    
    var padding: CGFloat { 24 }
    
    var width: CGFloat {
      switch self {
      case .small: return 300
      case .medium: return 500
      case .large: return 800
      case .statusSize: return 375
      }
    }
  }
}

public enum DialogVariant: Equatable {
  case `default`
  case status(_ status: DialogStatus)
}

@available(macOS 13.0, *)
public struct PBDialog_Previews: PreviewProvider {
  static let infoMessage = "This is a message for informational purposes only and requires no action."
  
  public static var previews: some View {
    registerFonts()
    
    return List {
      Section("Simple") {
        SimpleButton()
      }
      
      Section("Complex") {
        ComplexButton()
      }
      
      Section("Size") {
        SizeButtons()
      }
      .listRowSeparator(.hidden)
      
      Section("Stacked") {
        StackedButton()
      }
      
      Section("Status") {
        StatusButtons()
      }
      .listRowSeparator(.hidden)
    }
    
  }
  
  struct SimpleButton: View {
    @State var presentDialog: Bool = false
    
    func foo() {
      print("Hello World")
    }
    
    var body: some View {
      PBButton(title: "Simple") {
        UIView.setAnimationsEnabled(false)
        presentDialog.toggle()
      }
      .fullScreenCover(isPresented: $presentDialog) {
        PBDialog(
          title: "This is some informative text",
          message: infoMessage,
          cancelButton: ("Cancel", foo),
          confirmButton: ("Okay", foo)
        )
        .backgroundViewModifier(alpha: 0.2)
      }
    }
  }
  
  struct ComplexButton: View {
    @State var presentDialog: Bool = false
    
    func foo() {
      presentDialog = false
    }
    
    var body: some View {
      PBButton(title: "Complex") {
        UIView.setAnimationsEnabled(false)
        presentDialog.toggle()
      }
      .fullScreenCover(isPresented: $presentDialog) {
        PBDialog(
          title: "Header header",
          cancelButton: ("Back", foo),
          confirmButton: ("Send My Issue", foo),
          content: ({
            ScrollView {
              Text("Hello Complex Dialog!\nAnything can be placed here")
                .pbFont(.title2)
                .multilineTextAlignment(.leading)
              
              TextField("", text: .constant("text"))
                .textFieldStyle(PBTextInputStyle("default"))
                .padding()
            }
            .padding()
          }))
        .backgroundViewModifier(alpha: 0.2)
      }
    }
  }
  
  struct SizeButtons: View {
    @State var presentDialog: PBDialog<EmptyView>.Size? = nil
    
    func foo() {
      presentDialog = nil
    }
    
    var body: some View {
      ForEach(PBDialog<EmptyView>.Size.allCases, id: \.self) { size in
        PBButton(title: size.rawValue.capitalized) {
          UIView.setAnimationsEnabled(false)
          presentDialog = size
        }
        .fullScreenCover(item: $presentDialog) { item in
          PBDialog(
            title: "\(item.rawValue.capitalized) Dialog",
            message: infoMessage,
            cancelButton: ("Cancel", foo),
            confirmButton: ("Okay", foo),
            size: size
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }
  }
  
  struct StackedButton: View {
    @State var presentDialog1: Bool = false
    @State var presentDialog2: Bool = false
    
    func foo() {
      presentDialog1 = false
      presentDialog2 = false
    }
    
    var body: some View {
      HStack {
        PBButton(title: "Stacked") {
          UIView.setAnimationsEnabled(false)
          presentDialog1.toggle()
        }
        .fullScreenCover(isPresented: $presentDialog1) {
          PBDialog(
            title: "Success!",
            message: infoMessage,
            variant: .status(.success),
            isStacked: true,
            cancelButton: ("Cancel", foo),
            confirmButton: ("Okay", foo),
            size: .small
          )
          .backgroundViewModifier(alpha: 0.2)
        }
        
        PBButton(title: "Stacked Simple") {
          UIView.setAnimationsEnabled(false)
          presentDialog2.toggle()
        }
        .fullScreenCover(isPresented: $presentDialog2) {
          PBDialog(
            title: "Error!",
            message: infoMessage,
            variant: .status(.error),
            isStacked: true,
            confirmButton: ("Okay", foo),
            size: .small
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }
  }
  
  struct StatusButtons: View {
    @State var presentDialog: DialogStatus? = nil
    
    func foo() {
      presentDialog = nil
    }
    
    var body: some View {
      ForEach(DialogStatus.allCases, id: \.self) { status in
        PBButton(title: status.rawValue.capitalized) {
          UIView.setAnimationsEnabled(false)
          presentDialog = status
        }
        .fullScreenCover(item: $presentDialog) { item in
          PBDialog(
            title: item.rawValue.capitalized,
            message: infoMessage,
            variant: .status(item),
            isStacked: false,
            cancelButton: ("Cancel", foo),
            confirmButton: ("Okay", foo),
            size: .statusSize
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }
  }
}
