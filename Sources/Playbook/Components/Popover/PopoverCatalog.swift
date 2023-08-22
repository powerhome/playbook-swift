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
          //GeometryReader { geo in
          PBButton(title: "Simple") {
            disableAnimation()
            presentPopover.toggle()
//              print("\(viewFrames.width)")
//              print("\(geo.frame(in: .global))")
          }
          .background {
            GeometryReader { geometry in
              let frame = geometry.frame(in: .global)
              //Color.black.onAppear {
              //viewFrames = frame.minX
              //viewFramesY = frame.minY
              //print("\(frame.minX), \(frame.minY), \(frame.size.width), \(frame.size.height)")
              //}
            }
          }
          .fullScreenCover(isPresented: $presentPopover) {
            PBPopover(
              content: ({
                Text("Testando o Popover. Vamo!!!!").pbFont(.body, color: .text(.light))
              })
            )
            .frame(width: 266)
            .offset(x: -50, y: -250)
            .backgroundViewModifier(alpha: 0.2)
          }
          //}
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
