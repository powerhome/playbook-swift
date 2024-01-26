//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TupleView.swift
//

import SwiftUI

extension TupleView {
  var getViews: [AnyView] {
    makeArray(from: value)
  }

  private struct GenericView {
    let body: Any

    var anyView: AnyView? {
      AnyView(_fromValue: body)
    }
  }

  private func makeArray<Tuple>(from tuple: Tuple) -> [AnyView] {
    func convert(child: Mirror.Child) -> AnyView? {
      withUnsafeBytes(of: child.value) { ptr -> AnyView? in
        let binded = ptr.bindMemory(to: GenericView.self)
        return binded.first?.anyView
      }
    }

    let tupleMirror = Mirror(reflecting: tuple)
    return tupleMirror.children.compactMap(convert)
  }
}
