//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDialogActionView.swift
//

import SwiftUI

struct PBDialogActionView: View {
    let isStacked: Bool
    let confirmButton: (PBButton, (() -> Void)?)?
    let cancelButton: (PBButton, (() -> Void)?)?
    let variant: DialogVariant?
    
    public init(
        isStacked: Bool = false,
        confirmButton: (PBButton, (() -> Void)?)? = nil,
        cancelButton: (PBButton, (() -> Void)?)? = nil,
        variant: DialogVariant? = nil
    ) {
        self.isStacked = isStacked
        self.confirmButton = confirmButton
        self.cancelButton = cancelButton
        self.variant = variant
    }
    
    var body: some View {
        AdaptiveStack(isStacked: isStacked) {
            if let confirmButton = confirmButton {
                PBButton(
                    fullWidth: confirmButton.0.fullWidth,
                    variant: confirmButton.0.variant,
                    size: confirmButton.0.size,
                    title: confirmButton.0.title,
                    icon: confirmButton.0.icon,
                    iconPosition: confirmButton.0.iconPosition,
                    isLoading: confirmButton.0.$isLoading,
                    action: confirmButton.1
                )
                .padding(.bottom, Spacing.xxSmall)
            }
            
            if let cancelButton = cancelButton {
                if !isStacked {
                    Spacer()
                }
                
                PBButton(
                    fullWidth: cancelButton.0.fullWidth,
                    variant: cancelButton.0.variant,
                    size: cancelButton.0.size,
                    title: cancelButton.0.title,
                    icon: cancelButton.0.icon,
                    iconPosition: cancelButton.0.iconPosition,
                    isLoading: cancelButton.0.$isLoading,
                    action: cancelButton.1
                )
                .padding(.top, isStacked ? 5 : 0)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, Spacing.small)
        .padding(.leading, Spacing.small)
        .padding(.trailing, Spacing.small)
    }
}

#Preview {
    registerFonts()
    
    return List {
        PBDialogActionView(
            confirmButton: (PBButton(title: "Okay") { print("ola") }, nil),
            cancelButton: (PBButton(title: "Cancel"), { print("cancel") })
        )
        .listRowSeparator(.hidden)
        
        PBDialogActionView(
            isStacked: true,
            confirmButton: (PBButton(title: "Okay"), nil),
            cancelButton: (PBButton(title: "No, Cancel"), {})
        )
        .listRowSeparator(.hidden)
        
        PBDialogActionView(
            confirmButton: (PBButton(title: "Okay"), nil)
        )
    }
}
