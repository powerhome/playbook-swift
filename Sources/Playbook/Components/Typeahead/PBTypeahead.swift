//
//  PBTypeahead.swift
//
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI

public struct PBTypeahead<Content: View>: View {
  private let title: String
  private let placeholder: String
  private let variant: WrappedInputField.Variant
  private let clearAction: (() -> Void)?
  private let selection: Selection
  @Binding var searchText: String
  @State private var options: [(String, Content?)] = []
  @State private var selectedOptions: [(String, Content?)] = []
  @State private var isPresented: Bool = false
  @State private var isFocused: Bool = false
  @State private var isHovering: Bool = false
  @State private var selectedIndex: Int = 0
  @State private var hoverString: String = ""
  public init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    options: [(String, Content?)] = [],
    variant: WrappedInputField.Variant = .pill,
    clearAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.options = options
    self.variant = variant
    self.clearAction = clearAction
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text(title).pbFont(.caption)
        .padding(.bottom, Spacing.xxSmall)
      WrappedInputField(
        title: title,
        placeholder: placeholder,
        searchText: $searchText,
        selection: onSelection,
        variant: variant,
        isFocused: $isFocused,
        clearAction: { clearText },
        onItemTap: { removeSelected($0) }
      )
      
      listView
      
    }
    .background(Color.white.opacity(0.02))
    .onTapGesture {
      isPresented.toggle()
      isFocused.toggle()
    }
  }
}

private extension PBTypeahead {
  @ViewBuilder
  var listView: some View {
    if isPresented || !searchText.isEmpty {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
        ScrollView {
          ForEach(Array(zip(searchResults.indices, searchResults)), id: \.0) { index, result in
            HStack {
              if let customView = result.1 {
                customView
              } else {
                Text(result.0)
                  .pbFont(.body)
                  .padding(.vertical, 4)
              }
              Spacer()
            }
            .padding(.horizontal, Spacing.xSmall + 4)
            .padding(.vertical, Spacing.xSmall)
            .onHover { _ in
              selectedIndex = index
              hoverString = result.0
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
              onListSelection(selected: result.0)
            }
            .background(listBackgroundColor(index: index))
          }
        }
      }
        .onAppear{
         #if os(macOS)
         deleteKeyboardControl()
         keyboardControls()
         #endif
      }
    }
  }
  
  var optionsToShow: [String] {
    return selectedOptions.map { $0.0 }
  }
  
  var searchResults: [(String, Content?)] {
    #if os(iOS)
    return options.filter {
      $0.0.localizedCaseInsensitiveContains(searchText)
    }
    #elseif os(macOS)
    return searchText.isEmpty ? options : options.filter {
      $0.0.localizedCaseInsensitiveContains(searchText)
    }
    #endif
  }
  
  func listBackgroundColor(index: Int) -> Color {
    selectedIndex == index ? .hover : .card
  }
  
  var onSelection: WrappedInputField.Selection {
    if selectedOptions.isEmpty {
      return selection.selectedOptions(options: [], placeholder: placeholder)
    } else {
      return selection.selectedOptions(options: optionsToShow, placeholder: placeholder)
    }
  }
  
  func onListSelection(selected element: String) {
    selectedOptions = variantSelectedOptions(element)
    isPresented.toggle()
    searchText = ""
  }
  
  
  func variantSelectedOptions(_ result: String) -> [(String, Content?)] {
    if let index = options.firstIndex(where: { $0.0 == result }){
      selectedOptions.append(options.remove(at: index))
    }
    switch variant {
    case .text:
      guard let lastOption = selectedOptions.last else { return [] }
      options.append(contentsOf: selectedOptions.dropLast())
      selectedOptions = []
      selectedOptions.append(lastOption)
    default: break
    }
    return selectedOptions
  }
  
  
  var clearText: Void {
    if let action = clearAction {
      action()
    } else {
      searchText = ""
      options.append(contentsOf: selectedOptions)
      selectedOptions.removeAll()
      isPresented = false
    }
  }
  
  func removeSelected(_ element: String) {
    if let selectedElementIndex = selectedOptions.firstIndex(where: { $0.0 == element }) {
      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
      options.append(selectedElement)
    }
  }
}

public extension PBTypeahead {
  enum Selection {
    case single, multiple
    
    func selectedOptions(options: [String], placeholder: String) -> WrappedInputField.Selection {
      switch self {
      case .single: return .single(options.first)
      case .multiple: return .multiple(options)
      }
    }
  }
  
#if os(macOS)
  func deleteKeyboardControl() {
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      // if event.isARepeat == false {
      if event.keyCode == 51 { // delete
        if let lastElement = selectedOptions.indices.last {
          selectedOptions.remove(at: lastElement)
          
          print("lastElement: \(lastElement)")
        }
      }
      //   }
      return event
    }
  }
  func keyboardControls() {
    
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      
      if event.keyCode == 48  { // tab
        isFocused = true
      }
      if event.keyCode == 49 || event.keyCode == 36 { // space bar
        onListSelection(selected: hoverString)
        isPresented.toggle()
      }
//      if event.isARepeat == false {
//        if event.keyCode == 51 { // delete
//          if let lastElement = selectedOptions.indices.last {
//            selectedOptions.remove(at: lastElement)
//            print("selectedOptions.indices.last: \(String(describing: selectedOptions.indices.last))")
//            print("lastElement: \(lastElement)")
//          }
//        }
//      }

//        
//     }
//        if selection == .multiple {
//          if let selectedElementIndex = selectedOptions.lastIndex(where: { $0.0 == optionsToShow.last }) {
//            let selectedElement = selectedOptions.remove(at: selectedElementIndex)
//
//            options.append(selectedElement)
//          }
//        } 
////        else {
////                    if let selectedElementIndex = selectedOptions.lastIndex(where: { $0.0 == optionsToShow.last }) {
////                      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
////                      options.append(selectedElement)
////          
////                    }
////                    }
//          
//          
//        
//        
//        // If there is an option selected in both fields they both get deleted
////        if selection == .multiple {
////        if let selectedElementIndex = selectedOptions.lastIndex(where: { $0.0 == optionsToShow.last }) {
////          let selectedElement = selectedOptions.remove(at: selectedElementIndex)
////          options.append(selectedElement)
////          print("selectedOptions: \(selectedOptions)")
////          print("selectedElement: \(selectedElement)")
////          print("selectedElementIndex: \(selectedElementIndex)")
////        }
////     
//////            if optionsToShow.count >= 1 {
//////              selectedOptions.remove(at: )
//////
//////            }
//////            else {
//////              selectedOptions.removeAll()
//// //           }
////        }else {
////          if let selectedElementIndex = selectedOptions.lastIndex(where: { $0.0 == optionsToShow.last }) {
////            let selectedElement = selectedOptions.remove(at: selectedElementIndex)
////            options.append(selectedElement)
////            
////          }
////          }
 //       }
      if event.keyCode == 125 { // arrow down
        selectedIndex = selectedIndex < searchResults.count ? selectedIndex + 1 : 0
      }
      else {
        if event.keyCode == 126 { // arrow up
          selectedIndex = selectedIndex > 1 ? selectedIndex - 1 : 0
        }
      }
      return event
    }
    
  }
#endif
}

#Preview {
  registerFonts()
  if #available(iOS 16.0, *) {
    return TypeaheadCatalog()
  } else {
    return EmptyView()
  }
}
