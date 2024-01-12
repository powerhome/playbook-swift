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
  private let keys: [CGKeyCode: String] = [
    .kVK_Tab: "Tab",
    .kVK_Space: "Space",
    .kVK_DownArrow: "DownArrow",
    .kVK_UpArrow: "UpArrow",
    .kVK_Return: "Return"
  ]
  @Binding var searchText: String
  @State private var options: [(String, Content?)] = []
  @State private var selectedOptions: [(String, Content?)] = []
  @State private var isPresented: Bool = false
  @State private var isFocused: Bool = false
  @State private var isHovering: Bool = false
  @State private var hoveringItem: String = ""
  
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
  
  var onSelection: WrappedInputField.Selection {
    if selectedOptions.isEmpty {
      return selection.selectedOptions(options: [], placeholder: placeholder)
    } else {
      return selection.selectedOptions(options: optionsToShow, placeholder: placeholder)
    }
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
  
  func removeSelected(_ element: String) {
    if let selectedElementIndex = selectedOptions.firstIndex(where: { $0.0 == element }) {
      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
      options.append(selectedElement)
    }
  }
  
  func onListSelection(selected element: String) {
    selectedOptions = variantSelectedOptions(element)
    isPresented.toggle()
    searchText = ""
  }
  
  func listBackgroundColor(item: String) -> Color {
    hoveringItem == item ? .hover : .card
  }
  
  @ViewBuilder
  var listView: some View {
    if isPresented || !searchText.isEmpty {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
        ScrollView {
          VStack(spacing: 0) {
            ForEach(searchResults, id: \.0) { (result, value) in
              HStack {
                if let value = value {
                  value
                } else {
                  Text(result).pbFont(.body)
                    .padding(.vertical, 4)
                }
                Spacer()
              }
              .padding(.horizontal, Spacing.xSmall + 4)
              .padding(.vertical, Spacing.xSmall)
              .background(listBackgroundColor(item: result))
              .onHover { _ in hoveringItem = result }
              .frame(maxWidth: .infinity, alignment: .leading)
              .onTapGesture {
                onListSelection(selected: result)
              } .onAppear{
                NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                 
                  if let keyMessage = keys[CGKeyCode(Int(event.keyCode))] {
                    if keyMessage == "Tab" {
                      isFocused = true
                    }
                    if keyMessage == "Space" || keyMessage == "Return" {
                      onListSelection(selected: result)
                    }
//                    if keyMessage = "DownArrow" {
//                      result -= 1
//                    }
//                    self.message = "You've hit the \(keyMessage) key"
//                    print("Event: \(keyMessage)")
                  }
                 return event
                }
              }
            }
          }
        }
      }
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
}

#Preview {
  registerFonts()
  if #available(iOS 16.0, *) {
    return TypeaheadCatalog()
  } else {
    return EmptyView()
  }
}
