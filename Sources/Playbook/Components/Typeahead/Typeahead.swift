//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Typeahead.swift
//

import SwiftUI

public enum Typeahead {
    public struct Option: Identifiable, Equatable {
        public let id: String
        public let text: String?
        public let customView: (() -> AnyView?)?
        public static func == (lhs: Option, rhs: Option) -> Bool { lhs.id == rhs.id }
    }

    public enum OptionType: Identifiable {
        public var id: String {
            switch self {
                case .section(let str):
                    return str
                case .item(let item):
                    return item.id
            }
        }
        case section(String)
        case item(Option)
    }

    public enum Selection {
        case single, multiple(variant: GridInputField.Selection.Variant)

        func selectedOptions(options: [String], placeholder: String) -> GridInputField.Selection {
            switch self {
                case .single: return .single(options.first)
                case .multiple(let variant): return .multiple(variant, options)
            }
        }
    }
}

