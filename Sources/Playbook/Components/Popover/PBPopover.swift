//
//  PBPopover.swift
//
//
//  Created by Carlos Lima on 8/21/23.
//

import SwiftUI

public struct PBPopover<Content: View, Label: View>: View {
  let position: PopoverPosition
  let padding: CGFloat
  let content: Content
  let backgroundAlpha: CGFloat
  let label: Label
  let onClose: (() -> Void)?
  
  @State private var presentPopover: Bool = false
  @State private var labelPosition: CGRect = .zero
  @State private var popoverPosition: CGRect = .zero
  @State private var popoverSize: CGSize = .zero
  
  public init(
    position: PopoverPosition = .bottom,
    padding: CGFloat = Spacing.small,
    backgroundAlpha: CGFloat = 0,
    @ViewBuilder content: (() -> Content) = { EmptyView() },
    @ViewBuilder label: (() -> Label) = { EmptyView() },
    onClose: (() -> Void)? = nil
  ) {
    self.position = position
    self.padding = padding
    self.backgroundAlpha = backgroundAlpha
    self.content = content()
    self.label = label()
    self.onClose = onClose
  }

  public var body: some View {
    ZStack {
      label
        .disabled(true)
        .background(GeometryReader { proxy in
          Color.orange.onAppear {
            labelPosition = proxy.frame(in: .global)
          }
        })
        .onTapGesture {
          UIView.setAnimationsEnabled(false)
          presentPopover.toggle()
        }
        .fullScreenCover(isPresented: $presentPopover) {
          ZStack {
            content
              .opacity(0)
              .background(GeometryReader { proxy in
                Color.pink
                  .onAppear {
                    popoverSize = proxy.size
                    popoverPosition = proxy.frame(in: .global)
                  }
              })
              .zIndex(-2)
            PBCard(
              padding: padding, 
              shadow: .deeper, 
              width: popoverSize.width + padding*2
            ) { 
              content
                .frame(height: popoverSize.height)
            }
            .position(position.coordinates(labelPosition, popoverSize: popoverSize, padding: padding))
            .backgroundViewModifier(alpha: backgroundAlpha)
            .onTapGesture {
              if let onClose {
                print("labelPosition position \(labelPosition)")
                print("popover size \(popoverSize)")
                print("labelPosition mid Y \(labelPosition.midY)")
                print("labelPosition min Y \(labelPosition.minY)")
                print("labelPosition max Y \(labelPosition.maxY)")
                print("position \(popoverPosition)")
                print("popover size \(popoverSize)")
                print("popover size mid Y \(popoverPosition.midY)")
                print("popover size min Y \(popoverPosition.minY)")
                print("popover size max Y \(popoverPosition.maxY)")
                
              }
              presentPopover.toggle()
            }
          }
        }
    }
  }
}

public extension PBPopover {
  enum PopoverPosition {
    case top, bottom, right, left
    
    func coordinates(_ labelPosition: CGRect, popoverSize: CGSize, padding: CGFloat) -> CGPoint {
      switch self {
      case .top:
        return CGPoint(
          x: labelPosition.midX,
          y: labelPosition.minY - (popoverSize.height + padding)*2
        )
      case .bottom:
        return CGPoint(
          x: labelPosition.midX,
          y: labelPosition.midY + 16
        )
      case .right: return
        CGPoint(
          x: labelPosition.maxX + popoverSize.width/2 + padding + 16,
          y: labelPosition.minY - (popoverSize.height + padding)
        )
      case .left: return
        CGPoint(
          x: labelPosition.minX - popoverSize.width/2,
          y: labelPosition.midY
        )
      }
    }
  }
}

@available(macOS 13.0, *)
public struct PBPopover_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PopoverCatalog()
  }
}
