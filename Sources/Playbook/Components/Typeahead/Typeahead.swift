//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Typeahead.swift
//

import SwiftUI

public extension PBTypeahead {
    struct Option: Identifiable, Equatable {
        public let id: String
        public let text: String?
        public let customView: (() -> AnyView?)?
        public static func == (lhs: Option, rhs: Option) -> Bool { lhs.id == rhs.id }
        public init(id: String, text: String?, customView: ( () -> AnyView?)? = nil) {
            self.id = id
            self.text = text
            self.customView = customView
        }
        public init(_ id: String, _ text: String? = nil, _ customView: ( () -> AnyView?)? = nil) {
            self.id = id
            self.text = text
            self.customView = customView
        }
    }
    
    enum OptionType: Identifiable {
        public var id: String {
            switch self {
                case .section(let str):
                    return str
                case .item(let item):
                    return item.id
                case .button(let button):
                    return button.title ?? ""
            }
        }
        case section(String)
        case item(Option)
        case button(PBButton)
    }
    
    enum Selection {
        case single, multiple(variant: GridInputField.Selection.Variant)
        
        func selectedOptions(options: [String], placeholder: String) -> GridInputField.Selection {
            switch self {
                case .single: return .single(options.first)
                case .multiple(let variant): return .multiple(variant, options)
            }
        }
    }
    
    struct SectionList: Identifiable {
        public let id: UUID
        let section: String?
        let items: [PBTypeahead.Option]
        let button: PBButton?
        static func == (lhs: SectionList, rhs: SectionList) -> Bool { lhs.id == rhs.id }
        
        public init(id: UUID = UUID(), section: String?, items: [PBTypeahead.Option], button: PBButton?) {
            self.id = id
            self.section = section
            self.items = items
            self.button = button
        }
    }
}

