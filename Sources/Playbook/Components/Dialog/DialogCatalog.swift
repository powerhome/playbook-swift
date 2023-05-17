//
//  DialogCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

#if os(iOS)
public struct DialogCatalog: View {
  
  public init() {}
  
  static let infoMessage = "This is a message for informational purposes only and requires no action."

  static func disableAnimation() {
    UIView.setAnimationsEnabled(false)
  }
  
  public var body: some View {
    List {
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
        disableAnimation()
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
        disableAnimation()
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
          }))
        .backgroundViewModifier(alpha: 0.2)
      }
    }
  }
  
  struct SizeButtons: View {
    @State var presentDialog: DialogSize?
    
    func foo() {
      presentDialog = nil
    }
    
    var body: some View {
      ForEach(DialogSize.allCases, id: \.self) { size in
        PBButton(title: size.rawValue.capitalized) {
          disableAnimation()
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
          disableAnimation()
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
          disableAnimation()
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
    @State var presentDialog: DialogStatus?
    
    func foo() {
      presentDialog = nil
    }
    
    var body: some View {
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
            cancelButton: ("Cancel", foo),
            confirmButton: ("Okay", foo)
          )
          .backgroundViewModifier(alpha: 0.2)
        }
      }
    }
  }
}
#elseif os(macOS)
public struct DialogCatalog: View {
  @State var presentSmallDialog: Bool = false
  @State var presentMediumDialog: Bool = false
  @State var presentLargeDialog: Bool = false
  public init() {}

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
