//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverManager.swift
//

import SwiftUI

public class PopoverManager: ObservableObject {
  @Published var isPresented: Bool = false
  @Published var view: AnyView?
  @Published var position: CGPoint = .zero
  @Published var close: (Close, action: (() -> Void)?) = (.anywhere, nil)
  private let id = UUID()
  static let shared = PopoverManager()

  public enum Close {
    case inside, outside, anywhere
  }
}
