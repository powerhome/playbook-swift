//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI

@MainActor
public extension PBTypeahead {
    var titleView: some View {
        Text(title).pbFont(.caption)
            .padding(.bottom, Spacing.xxSmall)
    }

    var inputField: some View {
        GridInputField(
            placeholder: placeholder,
            searchText: $searchText,
            selection: selectedInputOptions,
            isFocused: $isFocused,
            clearAction: { viewModel.clear() },
            onItemTap: { viewModel.removeSelected($0) },
            onViewTap: {
                isFocused = true
            }
        )
        .pbPopover(
            isPresented: $viewModel.showPopover,
            id: id,
            position: .bottom(listOffset.x, listOffset.y),
            variant: .dropdown,
            refreshView: $viewModel.isHovering
        ) {
            listView
        }
    }

    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.searchResults) { result in
                            listItemView(option: result.option, index: result.index)
                              .id(result.id)
                        }
                    }
                }
                .onAppear {
                    viewModel.hoveringIndex = 0
                    isFocused = true
                    viewModel.scrollProxy = { id in
                        proxy.scrollTo(id)
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .frame(maxHeight: dropdownMaxHeight)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    func listItemView(option: PBTypeahead.Option, index: Int) -> some View {
        HStack {
            if option.text == viewModel.noOptionsText {
                emptyView
            } else {
                Group {
                    if let customView = option.customView?() {
                        customView
                    } else {
                        Text(option.text ?? option.id)
                            .pbFont(.body, color: listTextolor(index))
                    }
                }
                .padding(.vertical, Spacing.xSmall)
                .padding(.horizontal, Spacing.xSmall + 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(listBackgroundColor(index))
                .onHover(disabled: false) { hover in
                    viewModel.isHovering = hover
                    viewModel.hoveringIndex = index
                }
                .onTapGesture {
                    viewModel.onListSelection(index: index, option: option)
                }
            }
        }
    }

    var emptyView: some View {
        HStack {
            Spacer()
            Text(viewModel.noOptionsText)
                .pbFont(.body, color: .text(.light))
            Spacer()
        }
        .padding(.horizontal, Spacing.xSmall + 4)
        .padding(.vertical, Spacing.xSmall + 4)
    }

    func listBackgroundColor(_ index: Int?) -> Color {
        switch viewModel.selection {
            case .single:
                if viewModel.selectedIndex != nil, viewModel.selectedIndex == index {
                    return .pbPrimary
                }
            default: break
        }
#if os(macOS)
        return viewModel.hoveringIndex == index ? .hover : .card
#elseif os(iOS)
        return .card
#endif
    }

    func listTextolor(_ index: Int?) -> Color {
        if viewModel.selectedIndex != nil, viewModel.selectedIndex == index {
            return .white
        } else {
            return .text(.default)
        }
    }
} 
