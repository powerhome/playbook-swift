//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+PresentationMode.swift
//

import SwiftUI

public extension View {
  func presentationMode<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping(() -> Content)) -> some View {
        #if os(macOS)
        self.sheet(isPresented: isPresented) { content() }
        #elseif os(iOS)
        self.fullScreenCover(isPresented: isPresented) { content() }
        #endif
    }
    
    func typeaheadPresentationMode<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping(() -> Content)) -> some View {
        self
          .overlay {
            if isPresented.wrappedValue {
              ZStack {
                Color.clear
                  .ignoresSafeArea()
                  .onTapGesture {
                    isPresented.wrappedValue = false
                  }

                content()
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                      .background(Color.clear)
                      .pbShadow(.deepest)
              }
            }
          }
      }

  func presentationMode<Item, Content>(item: Binding<Item?>, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View {
        #if os(macOS)
        self.sheet(item: item) { identifiable in content(identifiable)
        }
        #elseif os(iOS)
        self.fullScreenCover(item: item) { identifiable in content(identifiable) }
        #endif
    }
}

