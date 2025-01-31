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

  @Binding internal var selectedOptions: [PBTypeahead.Option]
  @Binding internal var searchText: String
  @FocusState.Binding internal var isFocused: Bool

  #if os(macOS)
  private var keyboardHandler: TypeaheadKeyboardHandler?
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
    clearAction: (() -> Void)? = nil
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
        searchTextBinding: $searchText,
        isFocused: isFocused,
        clearAction: clearAction
      )
      
      #if os(macOS)
      keyboardHandler = TypeaheadKeyboardHandler(
        viewModel: viewModel,
        isFocused: _isFocused
      )
      keyboardHandler?.setupKeyboardMonitoring()
      #endif
    }
    .onDisappear {
      #if os(macOS)
      keyboardHandler?.cleanup()
      keyboardHandler = nil
      #endif
    }
    .onChange(of: options) { _, newOptions in
      viewModel.optionsChanged(newOptions)
    }
    .onChange(of: isFocused) { _, newValue in
      if newValue {
        Task {
          await PopoverManager.shared.dismissPopovers()
          viewModel.showPopover = true
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
  }
}

#Preview {
  registerFonts()
  return TypeaheadCatalog()
}

