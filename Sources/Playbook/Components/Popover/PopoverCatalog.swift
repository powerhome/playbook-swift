//
//  PopoverCatalog.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

#if os(iOS)
  public struct PopoverCatalog: View {
    public var body: some View {
      func disableAnimation() {
        UIView.setAnimationsEnabled(false)
      }

      struct SimplePopover: View {
        @State private var viewFrames: CGFloat = .zero
        @State private var viewFramesY: CGFloat = .zero
        @State private var presentPopover: Bool = false

        func closePopover() {
          presentPopover = false
        }

        var body: some View {
          PBPopover(
            content: ({
              Text("Testando o Popover. Vamo!!!!").pbFont(.body, color: .text(.light))
            }),
            label: ({
              Text("Simple")
              //{
//                disableAnimation()
//                presentPopover.toggle()
              //}
            })
          )
        }
      }

      return ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Simple") { SimplePopover() }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Popover")
    }
  }
#elseif os(macOS)
  public struct PopoverCatalog: View {

  }
#endif
