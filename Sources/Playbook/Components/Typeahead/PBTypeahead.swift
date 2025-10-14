//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI

public struct PBTypeahead: View {
  @StateObject var viewModel = PBTypeaheadViewModel()

  internal let id: Int
  internal let title: String
  internal let placeholder: String
  internal let dropdownMaxHeight: CGFloat?
  internal let listOffset: (x: CGFloat, y: CGFloat)
  internal let clearAction: (() -> Void)?
  internal let options: [PBTypeahead.Option]
  internal let selection: PBTypeahead.Selection
  internal let debounce: (time: TimeInterval, numberOfCharacters: Int)
  internal let disableFiltering: Bool
  internal let disableKeyboardHandler: Bool

  @State internal var selectedInputOptions: GridInputField.Selection
  @Binding internal var selectedOptions: [PBTypeahead.Option]
  @Binding internal var deselectedOptions: [PBTypeahead.Option]
  @Binding internal var searchText: String
  @FocusState.Binding internal var isFocused: Bool
  var noOptionsView: () -> AnyView?

  #if os(macOS)
  @StateObject private var keyboardHandler = TypeaheadKeyboardHandler()
  #endif

  public init(
    id: Int,
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    options: [PBTypeahead.Option],
    selection: PBTypeahead.Selection,
    debounce: (time: TimeInterval, numberOfCharacters: Int) = (0, 0),
    dropdownMaxHeight: CGFloat? = nil,
    listOffset: (x: CGFloat, y: CGFloat) = (0, 0),
    isFocused: FocusState<Bool>.Binding,
    selectedOptions: Binding<[PBTypeahead.Option]>,
    deselectedOptions: Binding<[PBTypeahead.Option]> = .constant([]),
    clearAction: (() -> Void)? = nil,
    disableFiltering: Bool = false,
    disableKeyboardHandler: Bool = false,
    @ViewBuilder noOptionsView: @escaping () -> some View = {
         Text("No Options")
           .pbFont(.body, color: .text(.light))
       }
  ) {
    self.id = id
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.options = options
    self.selection = selection
    self.debounce = debounce
    self.dropdownMaxHeight = dropdownMaxHeight
    self.listOffset = listOffset
    self._isFocused = isFocused
    self.clearAction = clearAction
    self._selectedOptions = selectedOptions
    self.disableFiltering = disableFiltering
    self._selectedInputOptions = State(initialValue: selection.selectedOptions(
      options: selectedOptions.wrappedValue.map { $0.text ?? $0.id },
      placeholder: placeholder
    ))
    self._deselectedOptions = deselectedOptions
    self.disableKeyboardHandler = disableKeyboardHandler
    self.noOptionsView = { AnyView(noOptionsView()) }
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      titleView
      inputField
    }
    .onTapGesture { isFocused = false }
    .onAppear {
      viewModel.configure(
        selection: selection,
        options: options,
        debounce: debounce,
        placeholder: placeholder,
        selectedOptionsBinding: $selectedOptions,
        deselectedOptionsBinding: $deselectedOptions,
        searchTextBinding: $searchText,
        isFocused: isFocused,
        clearAction: clearAction,
        disableFiltering: disableFiltering
      )
      
      #if os(macOS)
      if !disableKeyboardHandler {
        keyboardHandler.delegate = viewModel
      }
      #endif
    }
    .onDisappear {
      #if os(macOS)
      if !disableKeyboardHandler {
        keyboardHandler.cleanup()
      }
      #endif
    }
    .onChange(of: options) { _, newOptions in
      viewModel.optionsChanged(newOptions)
    }
    .onChange(of: isFocused) { _, newValue in
      viewModel.isFocused = newValue
      if newValue {
        Task {
          await PopoverManager.shared.dismissPopovers()
            DispatchQueue.main.async {
                viewModel.showPopover = true
            }
        }
      }
    }
    .onChange(of: selectedOptions.count) { _, _ in
      viewModel.reloadList()
    }
    .onChange(of: viewModel.hoveringIndex) { _, _ in
      viewModel.reloadList()
    }
    .onChange(of: searchText) { _, newValue in
      viewModel.searchTermChanged(newValue)
    }
    .onChange(of: selectedOptions) { _, newOptions in
      selectedInputOptions = selection.selectedOptions(
        options: newOptions.map { $0.text ?? $0.id },
        placeholder: placeholder
      )
    }
  }
}

//#Preview {
//  registerFonts()
//  return TypeaheadCatalog()
//}
