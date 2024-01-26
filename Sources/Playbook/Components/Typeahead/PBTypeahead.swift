//
//  PBTypeahead.swift
//
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI
import CoreGraphics
import GameController

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
  @State private var hoveringItem: String = ""
  @State private var isDownArrowPressed: Bool = false
  @State private var isUpArrowPressed: Bool = false
  @State private var selectedIndex: Int = 0
  @State private var hoverIndex: Int = 0
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
    }
  }
}

private extension PBTypeahead {
  @ViewBuilder
  var listView: some View {
    if isPresented || !searchText.isEmpty {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
     //   ScrollView {
          List(searchResults, id: \.0, selection: $selectedIndex) { (result, value) in
            
         //   ForEach(searchResults, id: \.0) { (result, value) in
              HStack {
                if let value = value {
                  value
                } else {
                  Text(result)
                    .pbFont(.body)
                    .padding(.vertical, 4)
                    .tag(selectedIndex)
                }
                Spacer()
                
              }
              .padding(.horizontal, Spacing.xSmall + 4)
              .padding(.vertical, Spacing.xSmall)
              .background(listBackgroundColor(item: result))
              .onHover { _ in
                hoveringItem = result
                selectedIndex += 1
                print("Selected: \(selectedIndex)")
              }
              .frame(maxWidth: .infinity, alignment: .leading)
              .onTapGesture {
                onListSelection(selected: result)
              } .onAppear{
                keyboardControls()
              }
     ///       } // foreach end
        } // list end
          .listStyle(.plain)
     ///   } // scrollview end
  
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
#endif
#if os(macOS)
    return searchText.isEmpty ? options : options.filter {
      $0.0.localizedCaseInsensitiveContains(searchText)
    }
#endif
   
  }
  
  func listBackgroundColor(item: String) -> Color {
    hoveringItem == item ? .hover : .card
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
  func keyboardControls() {
    let keys: [CGKeyCode: String] = [
      .kVK_Tab: "Tab",
      .kVK_Space: "Space",
      .kVK_DownArrow: "DownArrow",
      .kVK_UpArrow: "UpArrow",
      .kVK_Return: "Return"
    ]

    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      
      if let keyMessage = keys[CGKeyCode(Int(event.keyCode))] {
        if keyMessage == "Tab" {
          isFocused = true
        }
        if keyMessage == "Space" || keyMessage == "Return" {
          onListSelection(selected: hoveringItem)
          isDownArrowPressed = false
        }
        if keyMessage == "DownArrow" {
          isDownArrowPressed = true
          
        // I NEED TO GET THE CURRENT COLOR ON DOWN ARROW PRESS/HOVER
        // AND MAKE IT LOOK LIKE THE BACKGROUND COLOR IS MOVING DOWN WITH THE ARROW
        // * OR *
        //  ACTUALLY MOVE THE MOUSE USING KEY CODES & CURRENT MOUSE POSITION
          
          
          // I need to be able to ->
          // Visual: move hover/background color down
          // Logical: select option by tapping, space bar, or enter
          // use shorcut to move mouse using keyboard?
          // Use game controller? pointer interactions?
          // Use tags in the scrollviewreader to jump to list item when down arrow is pressed
          
        }
      }
      hoveringItem = ""
      return event
    }
  }
  
//  @ViewBuilder
//  var valueListView: some View {
//    List(selection: $selectedIndex) {
//    ForEach(Array(zip(searchResults.map{$0.0}.indices, searchResults.map{$0.0})), id: \.0) { value, result in
//      HStack {
//        Text(result)
//         
//      }
//    }
//  }
//  }

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
